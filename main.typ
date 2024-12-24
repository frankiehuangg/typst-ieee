#import "lib/config.typ": config
#import "lib/header.typ": header
#import "lib/abstract.typ": preview

/***************************************************/
/*                    Constants                    */
/***************************************************/

#let title = "My IEEE Paper Title"
#let authors = (
  (
    name: "First Author", 
    department: "First Department", 
    organization: "First Organization", 
    location: "First Location", 
    email: "first@email.com"
  ),
  (
    name: "First Author", 
    department: "First Department", 
    organization: "First Organization", 
    location: "First Location", 
    email: "first@email.com"
  ),
  (
    name: "First Author", 
    department: "First Department", 
    organization: "First Organization", 
    location: "First Location", 
    email: "first@email.com"
  ),
)

#let paper-size = "us-letter"

#let abstract = lorem(40)

#let index-terms = ("Term 1", "Term 2", "Term 3")

/***************************************************/
/*                      Render                     */
/***************************************************/

#show: config.with(
  title: title,
  authors: authors.map(author => author.name),
  paper-size: paper-size
)

#header(
    title: title,
    authors: authors
)

#preview(
    abstract: abstract,
    index-terms: index-terms
)

#include "src/introduction.typ"
