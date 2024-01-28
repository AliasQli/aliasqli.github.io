#import "../_lib/template.typ": template
#import "../_lib/chants-of-sennaar.typ": say

#let meta = (
  title: "巴别塔圣歌：语言、美与童话",
  abstract: "警告：本评测包含严重剧透。若您不想错过本游戏，请在通关之后继续阅读。",
  date: datetime(year: 2024, month: 01, day: 26),
)

#let (devots, guerriers, bardes, alchimistes, reclus) = ("Devots", "Guerriers", "Bardes", "Alchimistes", "Reclus").map(say)
#let linkedImage(..args, path) = link("/assets/images/" + path, image("../assets/images/" + path, ..args))

#show: template.with(meta: meta)
 
#pad(y: 0.5em, block(fill: rgb("#fff7f7"), inset: 1.2em, radius: 0.3em)[
  #set text(font: "Source Han Sans SC", fill: red)
  警告：本评测包含严重剧透。若您不想错过本游戏，请在通关之后继续阅读。
])

《巴别塔圣歌》（Chants of Sennaar）是一款以破译语言为核心玩法的游戏。游戏很明显参考了巴别塔的故事：故事发生在一座高塔中，玩家要破译其中各族的语言，使他们恢复交流，高塔才能重获生机。游戏英文名中的Sennaar（一般作Shinar，示拿#footnote(link("https://en.wikipedia.org/wiki/Shinar"))）也与此有关：禧年书10:18-26记载人们正是在示拿建造一座城和一座塔，而上帝变乱了他们的口音，他们就停工了。因此示拿全地被称作巴别，因为上帝在那里变乱天下人的言语。

信徒语是玩家在游戏中第一个接触的语言。在这个阶段，玩家尚只能通过文字与事物的对应关系来学习这门语言：通过标示牌上的文字与门的状态理解 #devots("open")#footnote[游戏中的文字均使用项目#link("https://github.com/AliasQli/Chants-of-Sennaar.typst", "Chants-of-Sennaars.typst")排版。] 和 #devots("close")，通过信徒的指示理解 #devots("you") 和 #devots("me")，通过玩牌理解 #devots("god") #devots("warrior") #devots("devotee") #devots("man") 之间的等级。

巴别塔圣歌中的所有语言中，同类的词都具有一定的形态学相似性，但是只有信徒语具有明显的象形特征。一个信徒语字符中，外围部分有一个“偏旁”表示其种类，剩下的部分则是一个与其具体意义有关联的符号，并且这个符号可以加上不同的偏旁表示不同但有联系的含义。相较而言，其余的语言基本上到偏旁这一步就为止了。在第三层有一块石碑#footnote[截图均来自 #link("https://www.bilibili.com/video/av660748736")。]：

#figure(caption: {
  devots("man", "man", "abbey", "free")
  h(0.5em)
  devots("man", "man")
  [?]
  }, 
  linkedImage("chants-of-sennaar/fortress.jpg", width: 50%)
) <abbey>

即使不看其它两种语言的翻译，玩家也很容易猜到右下角的残缺字符的含义，这说明玩家已经完全理解了信徒语的构词法。

到了战士这一层，玩家们就有了另一个破译语言的利器：罗塞塔石碑。这和真实语言学类似：很多古代语言都是要用另一门语言作为“跳板”进行研究的。

#figure(caption: {
    [第二层的罗塞塔石碑]
    set align(center)
    guerriers("plural", "warrior", "not", "love", "death")
    h(0.5em)
    guerriers("death", "love", "plural", "warrior")
    linebreak()
    devots("warrior", "warrior", "not", "love", "death")
    h(0.5em)
    devots("death", "love", "warrior", "warrior")
  },
  linkedImage("chants-of-sennaar/rosetta.jpg", width: 50%)
) <rosetta>

与之前的信徒语不同，战士语中明确出现了复数。复数是这个游戏被诟病的地方之一：游戏中的五门语言里有四门都是SVO语序，复数系统几乎成为了这些语言唯一的语法区别。信徒语的复数是重复，战士语的复数记号 #guerriers("plural") 在名词之前，诗人语的#bardes("plural")和学者语的 #alchimistes("plural") 在名词之后，隐士语的 #reclus("plural") 叠在名词上方。这个游戏的制作组是法国人，只能注意到语言的这些语法特征，可能还是视野局限于欧洲了。并且，印欧语系都是屈折语，复数是名词内部的屈折变化，这没有什么奇怪的。但是在名词前后加上一个表示复数的符号，就好像中文说每个复数名词的时候都在后面加一个“们”，这毫无疑问过于累赘了。

制作组的法语思维还有一个体现：他们自动把法语的一词多义带入到游戏中了。#bardes("play")的法语翻译是jouer，但是中文翻译是玩/演奏，这无疑是一件非常不合理的事情：诗人语为什么会有发展出和法语一样的一词多义呢？如果要更进一步，这些语言甚至可以有自己的一词多义，当然这就有些超纲了。

战士语的原型可能是卢恩字母#footnote(link("https://zh.wikipedia.org/wiki/卢恩字母"))，其特点是有很多直笔画。但是，卢恩字母大多结构简单，和战士语还是有很大的区别的。

塔的第三层就是全游戏难度最高的语言：诗人语，而我也是在这里遇到了真正的奇遇。第三层有一块罗塞塔石碑，然而我幸运的直到通关都没有发现它。不巧，诗人语又是游戏中唯一不是SVO语序的语言，导致我几乎完全无法理解诗人在说什么。最后，我几乎完全靠字符的形态学特征和对诗人的对话猜出了#bardes("me")和#bardes("you")的含义以及这门语言的语序（#bardes("not", "idiot", "me", "be", "not")!），这段难度极高的经历也成为了我最精彩的一段游戏体验，我同样因为这段经历牢牢掌握了诗人语。我觉得这个游戏应该加入一个硬核模式，只保留笔记本给字符备注含义，而去掉字符验证以及完全破译后显示完整翻译的功能。不是这样，玩家只要一个劲读翻译就行了，又怎么学得好语言呢？

#figure(caption: {
    [第三层的罗塞塔石碑]
    set align(center)
    devots("me", "seek", "you")
    h(0.5em)
    devots("you", "find", "me")
    linebreak()
    bardes("you", "me", "seek")
    bardes("me", "you", "find")
  },
  linkedImage("chants-of-sennaar/rosetta3.jpg", width: 50%)
) <rosetta3>

诗人语的原型可以确定是天城文#footnote(link("https://zh.wikipedia.org/wiki/天城文"))，这是梵语等印度语言语言现行的主要文字#footnote[梵语有不止一种书写系统，如笈多文、悉昙文，兰札文甚至藏文也可以用来书写梵语。天城文同样可以用来书写印地语和尼泊尔语等。]。天城文在连续书写时，上方的顶杠和诗人语一样是连续的（例：天城文 देवनागरी），并且还有一些相似的字符：

#figure(
  caption: [一些相似的字符],
  table(
    columns: 3,
    [*诗人语*], [*天城文*], [*罗马化*],
    bardes("east"), [क], [ka],
    bardes("ascend"), [प], [pa],
    bardes("go"), [ग], [ga],
    bardes("north"), [ज], [ja],
    bardes("seek"), [ञ], [ña],
    bardes("south"), [ह], [ha],
    bardes("question"), [ः], [h],
  )
)

从诗人语往后，这个游戏的语言就在走下坡路了。学者语言的特点是圆圆的，其灵感可能来自炼金术符号#footnote(link("https://zh.wikipedia.org/wiki/炼金术符号"))，但或许是由于过于广为人知，它们和学者语中几乎没有相似的符号。这个语言的特点是数字系统，然而游戏中唯一涉及数字的解谜是把一个重量分解成若干砝码。这个游戏完全可以拓展数字相关的解谜（比大小，加减法），做成现在这个样子只能说是乏善可陈。

第五层的隐士语有可以深入挖掘的文字复合设计，然而只要转动罗塞塔机就能得到一切的答案。第五层已经几乎失去了语言要素，基本上都是为剧情在服务。看看隐士的对话和长度不成正比的翻译，就能知道制作组几乎是在撇开语言在表达剧情了。

#figure(
  caption: [隐士的几句对话],
  table(
    columns: 2,
    align: left + horizon,
    pad(x: 0.5em, reclus("you", "help", "myPeople")), pad(x: 0.5em)[你救了我的族人。],
    pad(x: 0.5em, reclus("myPeople", "help", "tower")), pad(x: 0.5em)[我的族人将拯救高塔。],
    pad(x: 0.5em, reclus("us", "talk", "peoples")), pad(x: 0.5em)[我们将与各个民族商谈。],
  )
)

然而这个游戏的美学特征之一，就是一种“说不清”，就是仿佛有丰富的含义被文字贫瘠的表达力阻碍，而产生想象力的翩飞，以及一种超越语言的美感。#bardes("idiot", "bard")中的最后两句 #bardes("path", "idiot", "bard", "find") #bardes("idiot", "bard", "monster", "find") 的对仗，配合喜剧中恰到好处的表演，无疑产生了奇妙的诙谐感。第二层战士每个面只有三个字符的雕像，@rosetta 中战士面对死亡的态度，都是这样的例子。而隐士无疑完全破坏了这种美学特征。不过，这样的美学特征最好的例子还会在后文的剧情中谈到。

#figure(caption: bardes("idiot", "bard", "monster", "find"),
  linkedImage("chants-of-sennaar/idiot.jpg", width: 75%)
)

这个游戏大体上的剧情是明确的：玩家沟通各族，使不同的民族相互理解，互相帮助，就像上帝所说的：“众人团结一起...以后他们所要做的事就没有不成就的了。”结尾处的正八面体投影出不同语言的文字，同样不代表某些具体的含义，而是代表了各民族之间的沟通。然而，对于剧情的具体含义，还是有许多不同的说法。有观点认为，塔的五层分别对应埃及、苏联、希腊、英国、美国五个国家。也有观点认为，它们对应文明发展的不同阶段：从太阳崇拜到帝国时代，然后是文艺复兴（殖民主义），工业革命，一直到现代化。第一层的透镜对应阿基米德，第二层的日心说对应哥白尼，第三层的罗盘对应大航海时代。但是，这些观点都是碎片化的，很难说与游戏的主线剧情有很大的关联。但是游戏中确实有这么一幕，让我产生了与主线剧情截然不同的联想。

在第三层坐着工匠修好的船到了河对面，会看到有几个#bardes("bard", "plural")正在享受扇风，然而进入下水道，居然发现风扇是两个#bardes("man", "plural")手摇的。这时候我心里就有点不是滋味了，然而当我走进了#bardes("windmill")，发现了这一幕：

#figure(caption: bardes("windmill"),
  linkedImage("chants-of-sennaar/windmill.jpg", width: 75%)
)

#figure(caption: bardes("be", "free", "me", "plural", "seek"),
  linkedImage("chants-of-sennaar/poster.jpg", width: 75%)
)

言语不足以表达我看到这幅画面时的震撼：#bardes("windmill")的符号被一个红色的#bardes("free")覆盖，桌上是画着挣脱镣铐的传单，反抗的力量仿佛透过文字而来。再看看#bardes("man", "plural")过的是什么生活吧：#bardes("bard", "plural")在喝水的时候，#bardes("man", "plural")要给他们端上来；#bardes("bard", "plural")在看喜剧的时候，#bardes("man", "plural")在扫地；#bardes("bard", "plural")在乘凉的时候，#bardes("man", "plural")在有老鼠的下水道里劳作。都已经在地下印发传单了，这无疑是积怨已久的表现。不知道这矛盾会怎样爆发出来呢？

结局却让我大跌眼镜：#bardes("man", "plural")和 #devots("devotee", "devotee") 取得了联系，#devots("man", "man", "abbey", "free")（@abbey），然后#bardes("bard", "plural")过上了没有人服侍的生活：一群#bardes("bard", "plural")在疑惑为什么没有人给他们扇风/倒水喝。找到了应许之地的#bardes("man", "plural")仿佛就可以免遭一切苦难，而作为既得利益者的#bardes("bard", "plural")也没有丝毫阻拦。这真的是只靠交流就能解决的问题吗？

我知道这个游戏是一个童话故事，既然如此，那它就不应该涉及这样深入的，甚至会导致游戏偏离主题的话题。*童话故事没有问题，有问题的是在童话故事中加入与主题不相称的内容。*

不过无论如何，巴别塔圣歌是一款具有开创性玩法的独特游戏，独特的核心玩法使其自成一类。将某些专业性知识与解谜游戏结合起来已经屡见不鲜，例如Zach-like游戏中就有很多以编程为主题。但与这些游戏的玩法和故事几乎无关不同（SHENZHEN I/O和EXAPUNKS的玩法完全可以对换），巴别塔圣歌中的语言和这五个民族本身，以及整个游戏的叙事都是紧密结合的。语言的谜题，简朴文字背后的#bardes("beauty")，以及一个童话，共同构成了巴别塔圣歌的成功。
