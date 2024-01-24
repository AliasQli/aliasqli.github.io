#import "../_lib/template.typ": template
#import "../_lib/chants-of-sennaar.typ": makeSay, english

#let meta = (
  title: "巴别塔圣歌", 
  abstract: "1。", 
  date: datetime(year: 2024, month: 01, day: 24),
)

#let say = makeSay.with(translation: english)

#show: template.with(meta: meta)

#say(lang: "bards", "not", "go", "warrior", "plural", "not")