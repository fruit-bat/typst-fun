#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/fractusist:0.3.2": *
#import "@preview/cetz:0.4.2" as cetz: *
#show figure.caption: emph

== Sierpinski Triangle (L-system)
#{
  let ss = 32
  for n in (1, 2, 3, 4, 5, 6) [
    #lsystem(
      ..lsystem-use("Sierpinski Triangle"),
      order: n,
      step-size: ss,
      start-angle: 1,
      padding: 2,
      fill: gradient.linear(..color.map.crest, angle: 45deg),
      stroke: none
    )
    #{ ss = ss / 2 }
  ]
}


#let sierpinski(n, p1, p2, p3) = {
  // Use CeTZ's drawing functions explicitly
  import cetz.draw: polygon, line
  
  if n == 0 {
    // CeTZ polygon accepts (x, y) tuples as unitless numbers
    //polygon(p1, p2, p3, fill: blue)
    line(p1, p2, p3, close: true, fill: blue, stroke: none)
  } else {
    let m1 = ((p1.at(0) + p2.at(0)) / 2, (p1.at(1) + p2.at(1)) / 2)
    let m2 = ((p2.at(0) + p3.at(0)) / 2, (p2.at(1) + p3.at(1)) / 2)
    let m3 = ((p1.at(0) + p3.at(0)) / 2, (p1.at(1) + p3.at(1)) / 2)
    
    sierpinski(n - 1, p1, m1, m3)
    sierpinski(n - 1, m1, p2, m2)
    sierpinski(n - 1, m3, m2, p3)
  }
}

== Sierpinski Triangle (cetz)
#canvas(length: 1cm, {
  sierpinski(4, (0, 0), (4, 0), (2, 3.46))
})

#stack(
  dir: ltr, // Arrange items from left to right
  spacing: .2cm, // Add space between canvases
  ..range(6) // 0..5
    .map((n) => (n+1)) // 1..6
    .map((n) => figure(
        canvas(length: 2.5cm, {
          sierpinski(n, (0, 0), (1, 0), (0.5, (3.46/4)))
        }),
        caption: []
    )
  )
)

#let is-in-triangle(i, j) = {
  if j < 0 { j = -j; }
  if i < j { return false }
  let d = i - j;
  if calc.odd(d) { return false }
  return calc.odd(calc.binom(i, calc.trunc((i - j) / 2 )))
}

#let triangle-data(
    image-width,  // The width of the image in pixels
    image-height, // The height of the image in pixels
    offset-x
) = {

  let pixels = ()
  let (fgr, fgg, fgb) = (180, 80, 180);
  let (bgr, bgg, bgb) = (200, 200, 200);
  let i = 0
  while (i < image-height) {
    let j = 0
    while (j < image-width) {
     if (is-in-triangle(i, j - offset-x)) {
       pixels.push(fgr); pixels.push(fgg); pixels.push(fgb);    
     }
     else {
       pixels.push(bgr); pixels.push(bgg); pixels.push(bgb);    
     }
      j = j + 1;
    }
    i = i + 1;
  }
  return bytes(pixels) 
}

#let make-image(
    image-width: 4,
    image-height: 1,
    offset-x: 0,
    width: 100%,
    brightness: 1.0
) = {
    image(
      triangle-data(
        image-width,
        image-height,
        offset-x
      ),
      format: (
        encoding: "rgb8", // REQUIRED: Must be "luma8", "lumaa8", "rgb8", or "rgba8"
        width: image-width,
        height: image-height,
      ),
      width: width,
      scaling: "pixelated"
    )
}

== Sierpinski Triangle (Harlow's method)
#figure(
  $ attach(
    C,
    tl: i,
    br: ( (1 - j) / 2),
  ) $,
  caption: [Point test],
)

#make-image(
    image-width: 200,
    image-height: 60,
    offset-x: 100,
    width: 10cm
  );

