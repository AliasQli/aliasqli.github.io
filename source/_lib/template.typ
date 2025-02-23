#let elem(name, content, ..args) = html.elem(name, content, attrs: args.named())

#let div(content, ..args) = elem("div", content, ..args)
#let p(content, ..args) = elem("p", content, ..args)
#let span(content, ..args) = elem("span", content, ..args)
#let img(path, ..args) = elem("img", none, src: path, ..args)

#let smallcaps(s) = {
  let a = s.at(0)
  let b = s.slice(1)
  [#a#span(class: "smallcaps", b)]
}
#let attach(name, e) = {
  let key = label(name)
  div(id: repr(key), class: "snap-center")[#e#key]
}

#let template(it) = {
  set text(lang: "zh")
  show math.equation.where(block: true): it => div(html.frame(it), class: "frame-wrapper align-center")
  show math.equation.where(block: false): it => span(class: "frame-wrapper", html.frame(it))

  show ref: it => elem("a", href: "#" + repr(it.target), class: "no-underline", it)
  show footnote: it => context {
    let i = str(counter(footnote).get().at(0))
    elem("a", id: "footnote_" + i, href: "#footnote_entry_" + i, class: "no-underline snap-center", it)
  }

  it

  context {
    let footnotes = query(footnote)
    if footnotes.len() > 0 {
      elem("hr", class: "footnote", none)
      div(class: "footnote", {
        for (i, footnote) in footnotes.enumerate(start: 1) {
          p[
            #elem(
              "a",
              super(str(i)),
              id: "footnote_entry_" + str(i),
              href: "#footnote_" + str(i),
              class: "no-underline"
            ) #footnote.body
          ]
        }
      })
    }
  }
}