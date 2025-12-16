#import "./mandelbrot.typ" as mandelbrot: *
#import "@preview/cetz:0.3.2" as cetz: *

= Some Mandelbrot renders

#let nice = (
  (
    x: -2.1 + 1.5,
    y: -1.3 + 1.3,
    w: 2.6,
    h: 2.6,
    caption: [ Mandelbrot Set ]
  ),
  (
    x: -0.743643887037,
    y: -0.131825904205,
    w: 0.0012,
    h: 0.0012,
    caption: [ Seahorse Valley ]
  ), 
  (
    x: 0.282,
    y: 0.01,
    w: 0.01,
    h: 0.01,
    caption: [ Elephant Valley (bulb chains & filaments) ]
  ), 
  (
    x: -0.088,
    y: -0.654,
    w: 0.008,
    h: 0.008,
    caption: [ Triple Spiral Valley (deep symmetry) ]
  ),
  (
    x: -1.25066,
    y: 0.02012,
    w: 0.0015,
    h: 0.0015,
    caption: [ Mini Mandelbrot (“satellite”) with structure ]
  ), 
  (
    x: -0.761574,
    y: -0.0847596,
    w: 0.00008,
    h: 0.00008,
    caption: [ Spiral Galaxy (very deep zoom) ]
  ), 
  (
    x: -0.75,
    y: 0.0,
    w: 0.1,
    h: 0.1,
    caption: [ The “Cauliflower” Boundary ]
  ), 
  (
    x: -0.1011,
    y: 0.9563,
    w: 0.002,
    h: 0.002,
    caption: [ Dendrites (branching lightning) ]
  ),
  (
    x: -0.122561,
    y: 0.744862,
    w: 0.4,
    h: 0.4,
    caption: [ DendPeriod-3 Bulb Wake (famous theorem region) ]
  ), 
).map((d) => {
    d.x = d.x - (0.5 * d.w)
    d.y = d.y - (0.5 * d.h)
  return d;
});
#let msize = 800
#for d in nice {
    figure(
        mandelbrot.make-image(
            image-width: msize,
            image-height: msize,
            x: d.x,
            y: d.y,
            w: d.w,
            h: d.h,
            width: 10cm
        ),
        caption: [ #d.caption ]
    )
}

