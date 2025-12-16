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



#let max-iter = 50
#let resolution = 100 // Number of pixels (higher is slower)
#let size = 100pt / resolution

#let mandelbrot(cx, cy) = {
  let x = 0.0
  let y = 0.0
  let i = 0
  while i < max-iter and (x*x + y*y) < 4.0 {
    let xtemp = x*x - y*y + cx
    y = 2*x*y + cy
    x = xtemp
    i += 1
  }
  return i
}

#let get-color(it) = {
  if it == max-iter { return black }
  // Simple gradient: blue to white
  return rgb(50, 50, 100 + int(it / max-iter * 155))
}

#block(
  width: 100%,
  height: 100%,
  {
    for py in range(resolution) {
      for px in range(resolution) {
        // Map pixel grid to complex plane (-2 to 0.5, -1.25 to 1.25)
        let cx = -2.0 + (px / resolution) * 2.5
        let cy = -1.25 + (py / resolution) * 2.5
        
        let it = mandelbrot(cx, cy)
        place(
          top + left,
          dx: px * size,
          dy: py * size,
          square(size: size + 0.1pt, fill: get-color(it), stroke: none)
        )
      }
    }
  }
)

#diagram(cell-size: 15mm, $
	G edge(f, ->) edge("d", pi, ->>) & im(f) \
	G slash ker(f) edge("ur", tilde(f), "hook-->")
$)

A Physics Diagram

#diagram(
	mark-scale:130%,
$
	edge("rdr", overline(q), "-<|-")
	edge(#(4, 0), #(3.5, 0.5), b, "-<|-")
	edge(#(4, 1), #(3.5, 0.5), overline(b), "-<|-", label-side:#left) \
	& & edge("d", "-<|-") & & edge(#(3.5, 0.5), #(2, 1), Z', "wave") \
	& & edge(#(3.5, 2.5), #(2, 2), gamma, "wave") \
	edge("rru", q, "-|>-") & \
$)

#diagram(
	node-corner-radius: 4pt,
	node((0,0), $S a$),
	node((1,0), $T b$),
	node((0,1), $S a'$),
	node((1,1), $T b'$),
	edge((0,0), (1,0), "->", $f$),
	edge((0,1), (1,1), "->", $f'$),
	edge((0,0), (0,1), "->", $alpha$),
	edge((1,0), (1,1), "->", $beta$),

	node((2,0), $(a, b, f)$),
	edge("->", text(0.8em, $(alpha, beta)$)),
	node((2,1), $(a', b', f')$),

	node((0,2), $S a$),
	edge("->", $f$),
	node((1,2), $T b$),

	node((2,2), $(a, b, f)$),

	{
		let tint(c) = (stroke: c, fill: rgb(..c.components().slice(0,3), 5%), inset: 8pt)
		node(enclose: ((0,0), (1,1)), ..tint(teal), name: <big>)
		node(enclose: ((2,0), (2,1)), ..tint(teal), name: <tall>)
		node(enclose: ((0,2), (1,2)), ..tint(green), name: <wide>)
		node(enclose: ((2,2),), ..tint(green), name: <small>)
	},

	edge(<big>, <tall>, "<==>", stroke: teal + .75pt),
	edge(<wide>, <small>, "<==>", stroke: green + .75pt),
	edge(<big>, <wide>, "<=>", stroke: .75pt),
	edge(<tall>, <small>, "<=>", stroke: .75pt),
)


