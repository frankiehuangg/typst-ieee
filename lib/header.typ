#let header(
  title: [Paper Title], 
  authors: ()
) = [
  #place(top, float: true, scope: "parent", clearance: 30pt, {
    v(3pt, weak: true)
    
    align(
      center, 
      par(
        leading: 0.5em, 
        text(size: 24pt, title)
      )
    )
    
    v(8.35mm, weak: true)

    set par(leading: 0.6em)

    for i in range(calc.ceil(authors.len() / 3)) {
      let end = calc.min((i + 1) * 3, authors.len())
      let is-last = authors.len() == end
      let slice = authors.slice(i * 3, end)

      grid(
        columns: slice.len() * (1fr,),
        gutter: 12pt,
        ..slice.map(author => align(center, 
          {
            text(size: 11pt, author.name)

            if "department" in author [
              \ #emph(author.department)
            ]

            if "organization" in author [
              \ #emph(author.organization)
            ]

            if "location" in author [
              \ #author.location
            ]
            
            if "email" in author {
              if type(author.email) == str [
                \ #link("mailto:" + author.email)
              ] else [
                \ #author.email
              ]
            }
          }
        ))
      )

      if not is-last {
        v(16pt, weak: true)
      }
    }
  })
]