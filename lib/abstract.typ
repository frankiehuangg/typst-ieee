#let preview(
  abstract: none, 
  index-terms: ()
) = [
  #if abstract != none [
    #set text(weight: 700)
    #h(1em) _Abstract_---#abstract
  ]

  #if index-terms != () [
    #set text(weight: 700)
    #h(1em)_Index terms_---#index-terms.join(", ")
    #v(2pt)
  ]
]