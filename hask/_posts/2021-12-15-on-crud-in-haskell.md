---
title: On CRUD in Haskell
toc_label: On Crud in Haskell
permalink: /hask/on-crud-in-haskell/
---

即使用上了优雅的Haskell，我做的仍然是CRUD这种搬砖活。然而不幸的是，即使是Haskell强大的类型系统，也不能避免开发中产生的许多错误。比如说，就在动笔之前，我还刚刚修了个bug——在Postgres中，多维数组的子数组不能用有不同的长度，因此，在使用`array_agg`将数组聚合起来的时候，是极有可能报错的——而再强大的SQL eDSL都不能在编译期发现这样的错误。算起来，这已经是我第三次被这个bug坑害了。虽然如此，Haskell还是写得我心情愉快，所以还是忍不住想写这篇文章。

## 1. 项目架构

这里所谓的“项目架构”是个狭义概念。谈到API server，那肯定是由Model和Controller两大部分构成。其中，Model的实质是在造/解释一个eDSL，而Controller是在使用这个eDSL。那么我们就有两种选择构造eDSL：Free Functor和Tagless Final。本来我是想用[free](https://hackage.haskell.org/package/free)的，但是这个库实在是太简陋，不适合工程，而[polysemy](https://hackage.haskell.org/package/polysemy)的example里面充斥着各种类型和不知道功能的Template Haskell，我甚至都没有看明白... 而众所周知，由于n^2^实例的原因，[mtl](https://hackage.haskell.org/package/mtl)对于自定义新的Monad Transformer非常不友好。最后我选择了[fused-effects](https://hackage.haskell.org/package/fused-effects)这个号称拥有Algebraic Effects的库。

直接使用上，除了有些时候需要手动注明类型之外，fused-effects的使用体验和mtl类似；而当你想要手动定义新的effect（相当于Monad Transformer）时，除了需要写一些Boilerplate之外，只需要线性代码量的体验还是极好的。fused-effects将Effect和Carrier分开来了——Effect描述效果，Carrier描述解释一个效果的方式，用一个instance表明Carrier能解释对应Effect。fused-effects还允许一个Effect拥有多个Carrier，比如Trace（打log）这个Effect就有“忽略输出”和“输出到stdout”等多种Carrier。由于听祖与占上仙说粗粒度的效果有违Haskell强类型的原则，我把数据库中的每张表封装成一个Effect（比如`DBUser`，`DBComment`），使用对应效果时，可以分开来写：`Has DBUser sig m => m a`。（话说这个`Has`很帅有木有？）

另外，对于Effect里的每一个值构造子，通常都要手写一个`send`的版本；可以写一个Template Haskell函数，一次性`send`所有的值构造子。

另外，虽然我不怎么关心这里的性能问题，但是在fused-effects的README里面有一个Benchmark，其中唯二比fused-effects快的库是mtl和[eff](https://github.com/hasura/eff)，而后者甚至还未完工，并且最近更新还在去年... emm...

## 2. 服务器框架

至少在我有限的见识里，Haskell中所有的服务器框架都是基于[WAI](https://hackage.haskell.org/package/wai)/[Warp](https://hackage.haskell.org/package/warp)的（经上仙指点，snap不是），在此之上进入我的考虑范围的有[yesod](https://hackage.haskell.org/package/yesod)和[servant](https://hackage.haskell.org/package/servant)（其实是别的没怎么听人说过）。然而算是有些主观原因吧，在我的英语和Haskell都不好的时候去看yesod的文档，把我看了个云里雾里，对yesod留下了不好的印象。然而公正的说，yesod由于历史局限性，搞了一套莎翁全家桶出来，然而现在已经是前后端分离的时代了。相比之下，servant则是专门的API server框架，于是我几乎毫不犹豫地选择了后者。Snoyman大失败！

实际使用起来，首先一个字，酷。虽然我不知道实现原理（感觉Haskell里type的quantity应该都是0，并且servant似乎也没有用什么Template Haskell在编译时取类型信息），但是type-level的路由实在是非常炫酷，type safety自然也是杠杠的（对比一下，go的echo对请求体要手动Bind）。 其次，servant对各种Authentication的支持也比较好，并且还能够和type-level API很好地集成。然后，servant能够很方便地和上面的fused-effects库一起使用。Servant有个`hoistServer`，接收一个Natural Transformation作参数，这个参数刚好就是fused-effects中各个Carrier的runner。

优点谈完了谈缺点：

1. servant没有自定义返回的错误类型的能力。比如说，如果我想让我的错误返回值是JSON格式：`{"status": 500, "error": "Something went wrong."}`，那servant是做不到的。虽然有个库[servant-errors](https://hackage.haskell.org/package/servant-errors)可以做这个事情，然而如果我想要在Debug模式下多输出一个`errHint`字段，那唯一的解决办法恐怕只有把`(error, errHint)` serialize成`ByteString`放在`ServerError`里，再自己写个中间件来格式化错误信息了吧。最后我还是放弃了`errHint`字段。

2. 然后这个其实不是servant的问题，是WAI/Warp的问题。在WAI中，Response的底层表示是一个流，也就是说，当WAI拿到一个Response的时候，它是没有被完全求值的。一方面，这是Haskell惰性求值优越性的体现；但是另一方面，我们也无法预先得知这个流之中是否有bottom。当然，可以写一个中间件把整个流`deepseq`一遍，但是我在中间件里同样不能知道这个Response是只有100个字符，还是长达1GB，将其求值到Normal Form需要占用我多少内存。这在别的语言中是不会出现的问题：异常不会在求值时产生。于是，可能在别的语言中，能够正确报出500 server error；但是在Haskell中，我却无法抓到Response里的error。

3. 配custom ErrorFormatters有点麻烦（？）

总的来说，servant还是相当好用的，至少大部分的地方还是保持了相当的简洁，尤其是API type和function type的一一对应，实在是让人写得非常舒爽。最高にハイってやつだ！

## 3. 数据库框架

在选择数据库之前，我首先参考了[这篇文章](https://williamyaoh.com/posts/2019-12-14-typesafe-db-libraries.html)。由于我对各种抽象不但没有抗拒心理，反而十分欢迎（否则我写Haskell干什么），因此我首先是毫不犹豫地选择了[Opaleye](https://hackage.haskell.org/package/opaleye)。然而不久之后，我却放弃了已经写了一般的Model部分，转而改用了[beam](https://hackage.haskell.org/package/beam-core)。

实话实说，Opaleye确实是相当优秀的数据库框架，它几乎做到了一个轻量级框架的极致。如果不是非常复杂的数据库业务，我是十分推荐Opaleye的。Opaleye将每张表实现为`ProductProfunctor`的实例，这就奠定了它强类型的基础——即使是aggregate，Opaleye也用`ProductProfunctor`进行了优雅的实现，相较而言，beam的aggregate就相当丑陋了，无怪乎Opaleye在文档中说"Type safe aggregation is the jewel in the crown of Opaleye." 我还专门为Opaleye写了一套TH，拿来生成一些boilerplate。不过我在Opaleye写双层aggregate的时候，总是通不过类型检查，也不知道是我自己还是Opaleye的问题。

到此为止Opaleye都可以说是出众的，然而越过了这个类型安全的极限，就可以感到Opaleye在摆烂。Opaleye不能insert selected result，没有on conflict update，更关键的是这些缺失的功能还难以自己实现。无奈我只好转向beam。不过Opaleye在0.8版本把原本的`DoNothing`构造器隐藏了，可能是准备开始做on conflict update的支持了，对此我表示十分期待。

相较于Opaleye，beam唯二的好处就是功能全面，以及生成的SQL比较简单，而后者几乎可以忽略不计。beam几乎可以说是最重的数据库框架，比Opaleye是高出两个重量级，凡是一切SQL有的功能，它几乎都用类型描述了一遍；而即使是缺失的功能，也能方便地用`customExpr_`自己加上。但是缺点可以说是只多不少：

- beam是反对Template Haskell，支持`Generic`的，而刚好我又favour Template Haskell more than `Generic`，觉得`Generic`会拖慢运行速度。
- beam对Postgres的`array_agg`很不友好。假设有`data SomeT f = ... deriving (Generic, Beamable)`，然后有一个`AnotherT f`包含`SomeT f`的一个`Vector`（或者`List`），那`AnotherT f`是无法`derive`为`Beamable`的实例的。
- 不像Opaleye能直接用表的结构来做aggregate，beam的aggregate只能使用元组，这就导致beam的aggreagte可以极其丑陋，实在不应该是一门强类型语言所为，并且aggregate完成之后，还得再用丑陋的zipWithN处理一下结果（定义一个`ZipVector`可以部分解决这个问题）。并且，beam只支持长度不超过8的元组，然而稍微复杂的aggregate，涉及的字段数都可以随便超过8。（对比一下，Opaleye支持长达62的元组！）更要命的是，如果你想手动为更长的元组定义实例，你会发现定义所用到的一个方法是被隐藏起来的！（虽然我还是用了[这里](https://www.tweag.io/blog/2021-01-07-haskell-dark-arts-part-i/)的方法成功hack出了这个方法。）
- 虽然Opaleye是完全没有migration，可是beam的migration表现同样不怎么样。虽然不排除是我不会用的原因，但是beam migration的能力似乎仅限于从一个空的数据库中创建表，且不论自动增删字段，就是数据库中少了一个表，beam都不能自己加上。并且，beam的migration没有对外键的支持（虽然可以根据[这里](https://github.com/haskell-beam/beam/issues/502#issuecomment-913203494)的方法手动加上）。我本来还想用用[beam-automigrate](https://hackage.haskell.org/package/beam-automigrate)的，可是这玩意居然还在依赖aeson < 1.5，果断放弃。

总的来说，虽然我自己是在用beam，但我的建议是能用Opaleye就尽量用Opaleye。并且，我十分期待Opaleye今后的能够补上欠缺的功能。只有当Opaleye力所不能及的时候，我才建议使用beam。

说到这里就顺便提一提[persistent](https://hackage.haskell.org/package/persistent)+[esqueleto](https://hackage.haskell.org/package/esqueleto)吧。作为我同样了解过的数据库框架，我的评价是beam都不如。首先是类型定义都得写在TH里面，未免过于繁琐；其次是在persistent里面可以写出没有on的join来，类型安全没有保障；最后，功能没有beam全面，语法还没有beam简洁（至少我主观上觉得如此）。Snoyman大失败 x 2！（虽然我还是爱用他的stack就是了。）

## 4. 杂项

顺便讲讲开发遇到的一些小问题的解决吧。

Servant的basic auth是和类型绑定的。这就是说，每一种basic auth scheme只能对应一种结果类型。如果想让两种basic auth scheme得到相同的结果类型的话，可以用phantom type。

[Aeson](https://hackage.haskell.org/package/aeson)序列化的方式同样是和类型绑定的，一种类型只能有一个`ToJSON`/`FromJSON`实例。如果想要从`ToJSON`的结果中除去某个字段，可以定义`newtype`；如果想在`ToJSON`的结果中加上某个字段，可以定义一个类型乘法，并且手写这个乘法类型的`ToJSON`实例。另外，aeson的TH不能为type synonym生成实例，但是`Generic`可以。

如果让代码在docker容器里编译，会导致一旦依赖改变，所有的依赖都要重新编译。不如先在本机编译好，再把二进制文件拷到docker镜像中（逃）。

