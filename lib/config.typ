#let config(
  title: [Paper Title], 
  authors: (),
  paper-size: "us-letter",
  figure-supplement: [Figure],
  bib-file: "refs.bib", 
  content
) = [
  #set document(
    title: title,
    author: authors
  )

  #set columns(gutter: 12pt)
  #set page(
    paper: paper-size,
    columns: 2,
    margin: if paper-size == "a4" {
      (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
    } else {
      (
        x: (50pt / 216mm) * 100%,
        top: (55pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    }
  )

  #set text(
    font: "Times New Roman",
    size: 10pt
  )

  #set par(
    spacing: 0.45em, 
    leading: 0.45em,
    justify: true, 
    first-line-indent: 1em
  )

  #set heading(numbering: "I.A.a)")
  #show heading: it => {
    let levels = counter(heading).get()
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    set text(10pt, weight: 400)
    if it.level == 1 {
      let is-ack = it.body in ([Acknowledgment], [Acknowledgement], [Acknowledgments], [Acknowledgements])

      set align(center)
      set text(if is-ack { 10pt } else { 11pt })

      show: block.with(above: 15pt, below: 13.75pt, sticky: true)
      show: smallcaps

      if it.numbering != none and not is-ack {
        numbering("I.", deepest)
        h(7pt, weak: true)
      }

      it.body
    } else if it.level == 2 {
      set par(first-line-indent: 0pt)
      set text(style: "italic")

      show: block.with(spacing: 10pt, sticky: true)

      if it.numbering != none {
        numbering("A.", deepest)
        h(7pt, weak: true)
      }

      it.body
    } else [
      #if it.level == 3 {
        numbering("a)", deepest)
        [ ]
      }

      _#(it.body):_
    ]
  }

  #show raw: set text(
    font: "Courier New",
    ligatures: false,
    size: 1em / 0.8,
    spacing: 100%,
  )

  #set math.equation(numbering: "(1)")
  #show math.equation: set block(spacing: 0.65em)

  #show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location())
      ))
    } else {
      it
    }
  }

  #set enum(numbering: "1)a)i)")

  #set enum(indent: 10pt, body-indent: 9pt)
  #set list(indent: 10pt, body-indent: 9pt)

  #show figure: set block(spacing: 15.5pt)
  #show figure: set place(clearance: 15.5pt)
  #show figure.where(kind: table): set figure.caption(position: top)
  #show figure.where(kind: table): set text(size: 8pt)
  #show figure.where(kind: table): set figure(numbering: "I")
  #show figure.where(kind: image): set figure(supplement: figure-supplement, numbering: "1")
  #show figure.caption: set text(size: 8pt)
  #show figure.caption: set align(start)
  #show figure.caption.where(kind: table): set align(center)

  #show figure: fig => {
    let prefix = (
      if fig.kind == table [TABLE]
      else if fig.kind == image [Figure]
      else [#fig.supplement]
    )
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
    show figure.caption: it => [#prefix~#numbers: #it.body]
    show figure.caption.where(kind: table): smallcaps
    fig
  }

  #set par(leading: 0.5em)
  
  #content

  #if bib-file != none {
    show std.bibliography: set text(8pt)
    show std.bibliography: set block(spacing: 0.5em)

    bibliography(bib-file, title: text(10pt)[References], style: "ieee")
  }
]
