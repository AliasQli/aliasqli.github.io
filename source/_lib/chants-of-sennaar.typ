#let baseDir = "../_assets/Runes/"

#let makeLangGlyphs(lang) = {
  let glyphs = json(baseDir + lang + "/index.json")
  let ret = (:)
  for glyph in glyphs {
    ret.insert(glyph, image(baseDir + lang + "/" + glyph + ".png"))
  }
  ret
}

#let glyphs = (
  Devots: makeLangGlyphs("Devots"),
  Guerriers: makeLangGlyphs("Guerriers"),
  Bardes: makeLangGlyphs("Bardes"),
  Alchimistes: makeLangGlyphs("Alchimistes"),
  Reclus: makeLangGlyphs("Reclus"),
)

#let makeTranslation(name) = {
  let trans = json(baseDir + "translations/" + name + ".json")
  let reverse(dict) = {
    let ret = (:)
    for (k, v) in dict {
      ret.insert(v, k)
    }
    ret
  }
  (
    meta: reverse(trans.meta),
    Devots: reverse(trans.Devots),
    Guerriers: reverse(trans.Guerriers),
    Bardes: reverse(trans.Bardes),
    Alchimistes: reverse(trans.Alchimistes),
    Reclus: reverse(trans.Reclus),
  )
}

#let english = makeTranslation("english")

#let makeSay(translation: none, lang: none, height: 1.5em, baseline: 25%, ..words) = {
  let Lang = if translation != none { translation.meta.at(default: lang, lang) } else { lang }
  let translate(word) = if translation != none { translation.at(Lang).at(default: word, word) } else { word }

  let b(body) = box(baseline: baseline, height: height, body)

  if Lang == "Bardes" {
    b(glyphs.Bardes.boutGauche)
    words.pos().map(word => b(glyphs.Bardes.at(translate(word)))).join()
    b(glyphs.Bardes.boutDroite)
  } else {
    words.pos().map(word => b(glyphs.at(Lang).at(translate(word)))).join(h(height / 10)) 
  }
}