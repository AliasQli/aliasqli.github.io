#import "../_lib/template.typ": template, linkedImage

#let meta = (
  title: "星际拓荒与其命定的失败",
  abstract: [星际拓荒已经足够成功，因此这篇评论不论其成功，而专注于星际拓荒为数不多的失败。警告：本游戏评论包含严重剧透。若您不想错过本游戏，请在通关之后继续阅读。],
  date: datetime(year: 2024, month: 01, day: 28),
)

#show: template.with(meta: meta)

#pad(top: 0.5em, block(fill: rgb("#fff7f7"), inset: 1.2em, radius: 0.3em)[
  #set text(font: "Source Han Sans SC", fill: red)
  警告：本游戏评论包含严重剧透。若您不想错过本游戏，请在通关之后继续阅读。#h(1fr)
])
#block(fill: rgb("#fff7f7"), inset: 1.2em, radius: 0.3em)[
  #set text(font: "Source Han Sans SC", fill: red)
  再次警告：剧透会严重破坏您的游戏体验。请在游戏通关之后继续阅读。#h(1fr)
]
#pad(bottom: 0.5em, block(fill: rgb("#fff7f7"), inset: 1.2em, radius: 0.3em)[
  #set text(font: "Source Han Sans SC", fill: red)
  再三警告：您一定不想错过本游戏。若您还未通关，请在游戏通关之后继续阅读。#h(1fr)
])

《星际拓荒》（Outer Wilds）是一款在10分的满分下能打到11分的好游戏。其好奇心驱动的游戏机制，无论是前无古人后无来者的独创性，还是令无数玩家赞不绝口的游戏性，都让这个游戏配得上这个评价。对这个游戏的赞誉已经屡见不鲜，以至于已经无需另一篇文章重复这些内容。相反，我决定讲一讲这个游戏为数不多的失败。毕竟若批评不允许，则赞美无意义。

当玩家尚在新手教程，星际拓荒好奇心驱动的游戏机制便已经初现雏形。玩家是一个将要首次升空的宇航员，他可以自由地漫游整个村庄，可选地学习对他日后的探索有益的知识，唯一强制性的任务就是前往天文台从霍恩费斯处获得发射密码。而正是霍恩菲斯，在这个新手教程即将结束之处，将整个游戏的核心问题包装一下抛了出来：

#{
  set align(horizon)
  set text(fill: luma(20%))
  grid(
    columns: 2,
    column-gutter: 0.75em,
    rect(width: 0.25em, fill: luma(80%), height: 2em),
    [“跟我说说，到太空后你有什么计划？”]
  )
}

在一个传统的RPG游戏中，这不构成一个问题：玩家已经学会了把通过等级、技能、武器、道具变强作为自己的目标，就好像没有明确目标的大学生会把主要的精力用在GPA上，现代人也可以不假思索地将一般等价物作为自己的信仰。但是在星际拓荒，玩家几乎是立即遭逢了这个经典的存在主义之问：你有什么计划？你打算在游戏里做什么？你为什么打开这个游戏？*你想在这个游戏里追寻什么样的意义？*而头顶漫漫繁星的玩家，也正如掉入井里的泰勒斯一样，将回答那个哲学的基本问题作为了自己的目标：认识这个宇宙。好在泰勒斯终其一生都生活在米利都，而玩家，由于拥有哈斯人的木头航天飞船，能够轻易触及宇宙。

星际拓荒拥有一个由游戏内的物理规律支配着的，直到结局之前都不以玩家行为和意志为转移的宇宙。即使玩家放下手柄，行星仍会在既定的轨道上旋转，宇宙也会以22分钟为周期重启。而不仅玩家无法跨越循环留下自己存在的痕迹，甚至在同一个循环之内玩家都无法使用道具对环境进行任何的改变。玩家所控制的角色基本上就是一台移动摄像机。可以说，这个宇宙是*坚硬*的，它不仅以既定的步伐运行，而且丝毫不受玩家的打扰。事实上，这个宇宙是以一个在场形而上学的方式建构的，天生拒斥主体性，玩家的存在才被如此抑制，而这反过来又成就了宇宙的宏大，就像中世纪的基督教需要贬抑人的存在来体现最高存在者的崇高。宇宙的浩瀚和玩家的渺小，相对立构成了这个游戏的美学特征之一。而当玩家失去了改变世界的手段，他也就只剩下认识世界一条路可以选择。

幸运的是，玩家并不孤独。玩家最初追寻着前辈的脚步，而后穿行在挪麦人的遗迹中，阅读着这些无言的前辈留下的痕迹。玩家认识世界的工作也并非独立，而是沿着挪麦人的脚步进行的：当玩家从白洞站跃迁回碎空星时，是挪麦人的设备记录了时间差；玩家要前往深巨星的海底，也是从挪麦人在天文台中的研究获得了方法。可以说玩家对宇宙的认识，基本上就是通过挪麦人完成的，因此也和挪麦人经由了一样的认识过程。不过，挪麦人并不是被动地认知到宇宙规律，而是主动去认识它们，并且为它们找到了作用，或者说，赋予了*意义*。就像历史上科学和工程学总是同步发展，挪麦人对宇宙规律的认识过程和对它们的意义赋予也是同步的，最终他们将这些认识构建成了他们生产（余烬双星计划）和文化（量子卫星朝圣）的一部分。而当玩家登上量子卫星，与挪麦人之间形成了最终的文化认同，他也就全盘接受了挪麦人所构建的意义。挪麦人未竟的夙愿，探索宇宙之眼，也就成为了玩家在这个游戏中的最终意义。

而游戏结局的问题就出在此处。设想一个勇者斗恶龙式的经典RPG游戏：勇者接受了国王的请求，跨越艰难险阻，斩杀恶龙救出了公主。这时候游戏有两个结局：
  + 勇者带着公主回到了城堡，获得了国王和人民的感谢
  + 勇者在恶龙的宝库中获得了一把攻击力高达1000点的宝剑
然后游戏结束。显然第一个结局更为合理：国王的感谢会让玩家感到他的努力有意义，而宝剑无法成为其自身的意义。只有当玩家使用这把宝剑斩杀怪物，他才能体会到宝剑的锋利：意义永远在事物之外。

而星际拓荒的结局正是在用一个物理实在回应玩家的最终意义。其实游戏结局与基督教最后审判的结构非常相似：结束循环前往宇宙之眼就是玩家游戏生命的死亡，新宇宙就是审判之后的复活，新宇宙中依据玩家的经历而诞生不同的种族对应上帝依据人在其第一次生命中的作为进行的审判，而宇宙之眼，或者说宇宙规律本身，就是这里的上帝。新宇宙是神的国度中的福乐，它的意义是由宇宙规律担保的，然而正如之前所说，事物，即使是作为至高存在的宇宙本身，都无法成为其自身的意义。宇宙之眼穿越了挪麦人的认识过程，直接以物理实在的形式呈现在玩家眼前，除了让玩家感到夙愿已竟之外（真正进入眼之前的火堆合奏正是对应这一部分），其自身无法构建起任何额外的意义——因为此岸的意义只能在此岸之内建构，但是再也不可能有一群挪麦人围着它进行阐释，赋予意义了。由是，这项工作被交托给了玩家自身，但他此时产生的情感共鸣只能弥合，而不可能完全填补一个物理实在和意义之问之间的断裂。在此基础上，结局本身的内容不过相当于宝剑的攻击力数值，这个失败是结构性的。在结局处，星际拓荒遭遇了其命定的失败。
