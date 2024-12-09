#import "../_lib/template.typ": template

#show: template

#let posts = (
  "on-crud-in-haskell",
  "drum",
  "stlc",
  "chants-of-sennaar",
  "outer-wilds",
)

#v(1cm)

#{
  let metas = ()
  for file in posts {
    import ("../_posts/" + file + ".typ"): meta
    meta.insert("file", file)
    metas.push(meta)
  }

  metas = metas
    .filter(meta => meta.at("hide", default: none) != true and "date" in meta)
    .sorted(key: meta => meta.date)
    .rev()
  
  for meta in metas [
    #set text(size: 20pt)
    #link("/post/" + meta.file, strong(meta.title))

    #(if "abstract" in meta {
      set text(size: 14pt)
      meta.abstract
    })

    #v(1em)
  ]
}