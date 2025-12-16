#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/fractusist:0.3.2": *
#import "@preview/cetz:0.3.2" as cetz: *
#show figure.caption: emph


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



