
#let mandelbrot-data(
    image-width,  // The width of the image in pixels
    image-height, // The height of the image in pixels
    mx, // The real component in the complex plane
    my, // The imaginary component in the complex plane
    mw, // The width (real)
    mh, // The height (imaginary)
    max-iter  // The maximum number of iterations
) = {
  import calc.log
  import calc.clamp

  let pixels = ()
  let sx = mw / image-width;
  let sy = mh / image-height;
  let log2 = log(2.0)
  let log2r = 1.0 / log2
  for py in range(image-height) {
    for px in range(image-width) {
      // Map grid to complex plane
      let cx = mx + (px * sx)
      let cy = my + (py * sy)
      let (x, y, rr) = (0.0, 0.0, 0.0)
      let i = 0
      while i < max-iter and rr < 4.0 {
        let xtemp = x*x - y*y + cx
        y = 2*x*y + cy
        x = xtemp
        i += 1
        rr = x*x + y*y;
      }
            
      if i == max-iter {
        // Inside the set: solid black
        pixels.push(8); pixels.push(12); pixels.push(24);
      } else {
        // Outside the set: map iteration count to an RGB gradient
        let log_zn = log(rr) * 0.5;
        let nu = log(log_zn * log2r) * log2r;
        let smooth = i + 1 - nu;
        let t = clamp(smooth / max-iter, 0.0, 1.0);
        let t2 = t * t
        let tn = 1-t
        let tn2 = tn * tn;
        let r = clamp(int(9.0  * tn * t2 * t * 255), 0, 255)
        let g = clamp(int(15.0 * tn2 * t2 * 255), 0, 255)
        let b = clamp(int(8.5  * tn2 * tn * t * 255), 0, 255)
        pixels.push(r); pixels.push(g); pixels.push(b);
      }
    }
  }
  bytes(pixels) 
}

#let make-image(
    image-width: 100,
    image-height: 100,
    x: -2.1,
    y: -1.3,
    w: 2.6,
    h: 2.6,
    width: 100%,
    max-iter: 1024
) = {
    image(
      mandelbrot-data(
        image-width,
        image-height,
        x,
        y,
        w,
        h,
        max-iter
      ),
      format: (
        encoding: "rgb8", // REQUIRED: Must be "luma8", "lumaa8", "rgb8", or "rgba8"
        width: image-width,
        height: image-height,
      ),
      width: width
    )
}

