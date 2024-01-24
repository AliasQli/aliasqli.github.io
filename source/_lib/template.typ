#import "@preview/typst-ts-variables:0.1.0": page-width, target

#let header = [
  #set text(size: 24pt)
  #v(1cm)
  #block({
    let dy = 0.2em
    let textLogo = box[
      #box(move(dy: dy, text(size: 16pt)[Qliphoth Tech]))\
      #text(size: 12pt)[1492 A.A.]
    ]

    style(styles => {
      let size = measure(textLogo, styles)
      box(height: size.height - dy, stroke: 1pt + rgb("f2f3f3"), radius: 1pt, outset: 1pt, link("/", image("../_assets/AliasQli.jpg")))
    })

    h(0.3em)

    textLogo

    h(1fr)

    show link: underline

    box[
      #link("/")[Home] #h(1em) #link("/about")[About]\
      #v(0.125em)
    ]
  })
  #v(0.5cm)
]

#let footer = [
  #set text(size: 18pt)
  #v(1cm)
  #link("https://github.com/AliasQli")[#smallcaps[Github]] #h(1em) #link("https:/functional.cafe/@AliasQli")[#smallcaps[Mastodon]] #h(1em) #link("mailto:aliasqli@qq.com")[#smallcaps[Email]]
  #v(1cm)
]

#let template(meta: none, it) = {
  set page(margin: (top: 0pt, bottom: 0pt, left: 1cm, right: 1cm), height: auto)
  set text(
    size: 14pt, 
    font: (
      "Linux Libertine",
      "Source Han Serif SC",
      "Source Han Serif",
  ))

  header

  pagebreak()

  show link: underline

  if meta != none {
    if not (type(meta.title) == dictionary and meta.title.show == false) {
      v(1cm)
      align(center, heading(level: 1, numbering: none, outlined: false, meta.title))
      v(1em)
      if meta.date != none {
        align(center, text(size: 14pt)[#meta.date.display("[year]-[month]-[day]")])
        v(1em)
      }
    }
  }

  it

  pagebreak()

  align(bottom)[#footer]
}