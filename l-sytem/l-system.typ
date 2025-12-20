#import "@preview/fractusist:0.3.2": *
#import "@preview/cetz:0.4.2" as cetz: canvas
#show figure.caption: emph;


#let fract-row(title, f) = {
  [ == #title 
    #lorem(24)
  ]
  figure(
    grid(
      ..range(6) // 0..5
        .map((n) => (n+1)) // 1..6
        .map((n) => figure(
            f(n, title),
            caption: [n = #n],
            outlined: false,
            supplement: none,
            numbering: none
        )
      ),
      columns: 6,
      align: bottom
    ),
    caption: [ #title ]
  )
}

#fract-row("Sierpinski Triangle", (n, title) => {
		let ss = 64/calc.pow(2, n)
    lsystem(
      ..lsystem-use("Sierpinski Triangle"),
      order: n,
      step-size: ss,
      start-angle: 1,
      padding: 6,
      fill: gradient.linear(..color.map.crest, angle: 45deg),
      stroke: none
    )
});

#fract-row("Koch Snowflake", (n, title) => {
		let ss = 64/calc.pow(3, n)
    lsystem(
      ..lsystem-use("Koch Snowflake"),
      order: n,
      step-size: ss,
      start-angle: 1,
      padding: 6,
      fill: gradient.linear(..color.map.crest, angle: 45deg),
      stroke: none
    )
});

#fract-row("Dragon Curve", (n, title) => {
    lsystem(
      ..lsystem-use("Dragon Curve"),
      order: n,
      step-size: 4,
      start-angle: 1,
      padding: 20
    )
});
Eventually, this process forms a pattern shown below.
#figure(
    lsystem(
      ..lsystem-use("Dragon Curve"),
      order: 16,
      step-size: .5,
      start-angle: 1,
      padding: 20,
      stroke: color.gray
    ),
    caption: [ Dragon curve, order 16]
  )
  
#fract-row("Random fractal tree", (n, title) => {
  random-fractal-tree(
    n,
    seed: 3,
    leaf-color: rgb("#FFFF33C0"),
    trunk-len: 20,
    angle: 0.22,
    ratio: 0.82,
    padding: 20
  )
});

