#import "theorems.typ": *

#let project(title: "", subtitle: "", authors: (), date: datetime.today(), body) = {
  // Set the document's basic properties.
  // set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center, height: 841.89pt, margin: 1cm)
  set text(font: (
    "Linux Libertine",
    "Source Han Serif SC",
    "Source Han Serif",
    // "Twitter Color Emoji Regular"
  ), lang: "en")
  // show math.equation: set text(font: (
  // ))

  // Title row.
  align(center)[ #block(text(weight: 700, 1.75em, title)) ]
  if subtitle != "" {
    align(center)[ #block(text(1.25em, subtitle)) ]
  }
  align(center)[
    #v(1em, weak: true)
    #date.display("[month repr:short] [day], [year]")
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.email
      ]),
    ),
  )

  // Main body.
  set par(justify: true)

  body
}

#let theorem = thmbox("Theorem").with(fill: rgb("#eeffee"))
#let 定理 = thmbox("定理").with(fill: rgb("#eeffee"))

#let lemma = thmbox("Lemma").with(fill: rgb("#eeffee"))
#let 引理 = thmbox("引理").with(fill: rgb("#eeffee"))

#let prop = thmbox("Proposition").with(fill: rgb("#eeffee"))
#let 命题 = thmbox("命题").with(fill: rgb("#eeffee"))

#let corollary = thmbox("Corollary").with(fill: rgb("#eeffee"))
#let 推论 = thmbox("推论").with(fill: rgb("#eeffee"))

#let question = thmbox("Question").with(fill: rgb("#eeffee"))
#let 问题 = thmbox("问题").with(fill: rgb("#eeffee"))

#let definition = thmbox("Definition").with(fill: rgb("#f1f8f6"))
#let 定义 = thmbox("定义").with(fill: rgb("#f1f8f6"))

#let example = thmbox("Example").with(fill: rgb("#f7f7fd"))
#let 例子 = thmbox("例子").with(fill: rgb("#f7f7fd"))

#let counterexample = thmbox("Counterexample").with(fill: rgb("#fff7f7"))
#let 反例 = thmbox("反例").with(fill: rgb("#fff7f7"))

#let clarification = thmbox("clarification").with(fill: rgb("#fff7f7"))
#let 澄清 = thmbox("澄清").with(fill: rgb("#fff7f7"))

#let exercise = thmbox("Exercise").with(fill: rgb("#fdeee2"))
#let 练习 = thmbox("练习").with(fill: rgb("#fdeee2"))

#let mybot = box(sym.bot)
#let myat = box($@$)
#let emsp = h(2em)

#let proof = thmplain("Proof").with(
  base: "theorem",
  bodyfmt: body => [#body #h(1fr) $square$],
  numbering: none
)
#let 证明 = thmplain("证明").with(
  base: "定理",
  bodyfmt: body => [#body #h(1fr) $square$],
  numbering: none
)

#let aliasqli = (
  name: "Alias Qli",
  email: "alias@qliphoth.tech"
)