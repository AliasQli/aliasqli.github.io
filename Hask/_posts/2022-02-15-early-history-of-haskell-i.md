---
title: Early History of Haskell, 1990 To 1992
toc_label: Early History of Haskell I
tags: Writing
---

> 1987年9月，在美国俄勒冈州波特兰的函数式编程语言与计算机架构大会上，召开了一场会议以讨论函数式语言社区的不幸处境：已经有了超过一打的非严格纯函数式语言，每一个都拥有相似的表达能力和基础语义。会上达成了一个强烈的共识，是因为一种共同语言的缺乏导致了这些语言的广泛使用。会议决定，应当组建一个委员会来设计这样一门语言，以提供一个快速交流新想法的工具，一个开发实际应用的稳定基础，以及一个鼓励他人使用函数式语言的媒介。这篇文档描述了这个委员会努力的成果：一门名叫Haskell的纯函数语言，以逻辑学家Haskell B. Curry命名，他的工作为我们的提供了逻辑基础。
>
> 委员会的主要目标是设计一门满足如下条件的语言：
>
>   1. 它应当适合教学、研究和开发应用，包括构建大型的软件系统。
>
>   2. 它应当完全由公布的形式化语法和语义所描述。
>
>   3. 它应当可以免费获取。任何人都应当被允许实现这门语言，并分发给任何他希望的人。
>
>   4. 它应当建立在具有广泛共识的想法之上。
>
>   5. 它应当减少函数式语言社区中不必要的多样性。
>
> 委员会希望Haskell能够成为将来研究语言设计的基础。我们希望能够出现这门语言的扩展或者变种，以兼容实验性的特性。

上面这段话，和一段来自Haskell B. Curry和Robert Feys的《组合子逻辑》的引用一起，贯穿了Haskell Language Report每一个版本的序言部分。

阅读本文的读者最好能够熟悉Haskell 2010标准。本文中所有的“现在”均指Haskell 2010标准。

## Version 1.0, April 1990

时隔三年，第一版的报告终于（在愚人节）问世了，全名*Report on the Programming Language, Haskell, A non-strict, Purely Functional Language, Version 1.0*。令人意想不到的是，这时的Haskell就已经具有了Haskell 2010的几乎全部语法，甚至包括arithmetic sequence（即`[1,2..10]`）和list comprehension（相较而言，Python晚了10年）这样的“高级语法”，只有很小的差别（并非全部）：

首先自然是广为人知的n+k pattern。这个语法说的是，可以构建形如`n + k`的pattern，其中`n`是变量名，`k`是大于0的整数字面量。当使用一个具有非底值的变量`x`去匹配这个pattern时，如果`x >= k`则匹配成功，然后`n`被绑定到`x - k`。在Haskell 1.0，我们可以写：

```haskell
fib 0 = 1
fib 1 = 1
fib (n+2) = fib (n+1) + fib n
```

这个语法一直保留到了Haskell 98。直到Haskell 2010，n+k pattern才被删除。

然而，Haskell 1.0还有另一个少有人知的语法：可以在lambda表达式中pattern guard：`\ x | x > 0 -> 2 * x`。由于这个语法只能导致部分函数，这显然是一个设计失当，并且最晚（原因见后文）在Haskell 1.2中这个语法就被删除了。

另一个差别较大的地方是module相关语法。这个时候的Haskell还没有`qualified`/`as`关键字，取而代之的是renaming：`import M renaming (T1 to T2, a1 to a2)`，现在Agda还保留了这个语法。另一个细小的差别是在这时候的export list中导出整个module时，不是写`module M`而是`M..`。

不过最让人惊异的，还是这个时候的Haskell module，就像C语言的头文件一样，是有配套的interface的，而具体的实现则称为implementation。这里不详述interface的语法，而是直接引用report中的例子：

```haskell
-- interface
interface A where
infixr 4 `sameShape`
data BinTree a = Empty | Branch a (BinTree a) (BinTree a)
class Tree a where
        sameShape :: a -> a -> Bool
instance Tree (BinTree a)
sum :: Num a => BinTree a -> a

-- implementation
module A( BinTree(..), Tree(..), sum ) where
infixr 4 `sameShape`

data BinTree a = Empty | Branch a (BinTree a) (BinTree a)

class Tree a where
        sameShape :: a -> a -> Bool
        t1 `sameShape` t2 = False

instance Tree (BinTree a) where
        Empty `sameShape` Empty = True
        (Branch _ t1 t2) `sameShape` (Branch t1' t2') 
          = (t1 `sameShape` t1') && (t2 `sameShape` t2')
        t1 `sameShape` t2 = False
sum Empty            = 0
sum (Branch n t1 t2) = n + sum t1 + sum t2
```

不过，标准并没有限制module和文件之间的对应关系，甚至还暗示一个文件可能包含多个module（可惜！）。标准同样没有规定interface是应该由程序员手写，还是由编译器生成。

当然，这里同样有设计上的失误，比如此时的export list允许只暴露一个类型的构造器而不暴露类型本身。这些行为在Haskell 1.2中被修正了。

说完语法再说说语义。这时的Haskell有一个奇特的限制，称为single overloading，概括而言就是不允许多次重载常量（原文：*the type of a variable not bound directly to a lambda abstraction is monomorphic in any type variables constrained by a context*）。据标准说，这主要并非一个技术限制，而是为了避免重复计算：

```haskell
f _ = (y, y)
  where
    y = factorial 1000
```

考虑如上的代码。今天的ghc会推出`f`的类型为`(Num b, Num c) => a -> (b, c)`，但Haskell 1.0则认为是`Num b => a -> (b, b)`：两个`y`的类型必须相同。如果想要改变这一行为，可以将代码改为`y () = factorial 1000`，但是，这同样意味着这时的Haskell没有真正做到“函数即是值”。在之后，这个限制就被著名的monomorphism restriction替代了。

Haskell 1.0中的预定义类型和类型类和今天也有所不同。今天的`Show`和`Read`在当时被合成了一个，称为`Text`；出于快速读写文件的目的，设计了一个内置类型`Bin`代表二进制数据以及`nullBin`, `appendBin`, `isNullBin`三个操作。同样，有一个`Binary`类型类，大致就是把`Text`中的`String`换成了`Bin`。虽然`Functor`之类还没有加入Haskell，数字相关的类型类在这时就已经齐全了，唯一的区别是继承关系：这时的`Enum`继承自`Ix`，`Integral`不继承`Enum`。

![Haskell 1.0的内置类型类](/assets/images/early-history-of-haskell-i/haskell-1.0-classes.jpg)

然而，Haskell 1.0与现在最大的不同还是在于I/O系统。标准定义一个Haskell程序通过*消息流*与外界交流，而消息流在Haskell中就是lazy list，因此一个Haskell程序主函数的类型是：

```haskell
type Dialogue = [Response] -> [Request]
```

其中，第n个`Response`是操作系统对第n个`Request`的回应。相关类型定义如下：

```haskell
data Request
  = ReadFile     Name
  | WriteFile    Name String
  | ReadBinFile  Name
  | WriteBinFile Name String
  | ReadChan     Name
  | AppendChan   Name String
  -- ...

type Name = String
stdin  = "stdin"
stdout = "stdout"

data Response
  = Success
  | Str String
  | Bn  Bin
  | Failure IOError
```

比如，如果第一个`Request`是`ReadFile "a.txt"`，第一个`Response`就会是`Str "content_of_the_file"`（或者一个`Failure`）。为了控制对第n个`Response`的求值时间不早于第n个`Request`的发送时间，常常采用irrefutable pattern，比如report中的例程：

```haskell
main :: Dialogue
main ~(Success: ~((Str userInput) : ~(Success : ~(r4 : _)))) =
  [ AppendChan stdout "please type a filename\n",
    ReadChan stdin,
    AppendChan stdout name,
    ReadFile name,
    AppendChan stdout (case r4 of Str contents    -> contents
                                  Failure ioerror -> "can't open file")
    AppendChan stdout "\nfinished"
  ] where (name : _) = lines userInput
```

这里的`Chan`是channel的简写，相当于今天的handle。非常特别的，标准规定一个channel最多只能读一次，读到的lazy string就包含了现在和将来这个channel的所有内容。这不禁让我联想到`hGetContent`，原来Haskell正是在IO语义还没有确立的时候，为lazy IO打好的基础啊！

Haskell还支持另一种风格的I/O，基于continuation。操作上，大致就是把`Request`的每个构造器封装成了一个接受回调的函数。在构建稍微复杂的程序的时候，这种风格几乎就是唯一可取的方法了。使用这种风格重写的例程如下（严格的说，此时`let...in`语法还不可用）：

```haskell
main :: Dialogue
main =
  appendChan stdout "please type a filename\n" exit (
  readChan stdin exit (\userInput ->
  let (name : _) = lines userInput in
  appendChan stdout name exit (
  readFile name (\ioerror -> appendChan stdout
                             "can't open file" exit done)
                (\contents ->
  appendChan stdout contents exit done))))
```

最后，如果你想要体验这样的Haskell I/O，可以试一试笔者的一个实现了1.2版本标准（差别很小）定义的I/O的库：[dialogue](https://hackage.haskell.org/package/dialogue)。

## Version 1.1, August 1991

与其它所有版本不同，1.1版本的报告是以压缩包的形式给出的，然后里面有个Makefile……然后这份三十年前的Makefile不负众望地在笔者的电脑上运行失败了。所幸Haskell 1.2版本的报告收录了之前版本的序言，其中列出了1.1中主要的改动。

1.1版本是Haskell首个标准在发布之后，根据各路用户的建议而作出的轻微修改，修正了几个设计失误并增添了几个新语法。

首先，在`type`中加入context的能力被移除了。这里要注意的一点是，和现行的ghc不同，一直到Haskell 2010，context都不是写在构造器中，而是写在类型中的。（在ghc中打开已经被废弃的扩展`DatatypeContexts`可以恢复这一行为。）所以在Haskell 1.1及以后，`type Num a => Point a = (a, a)`的写法被移除，只有`data Show a => Car a = Car a`才是合法的写法了。

另外，1.1修改了`deriving`的默认行为。在1.0中，当省略`deriving`语句时，会自动派生所有可能的实例；必须显式使用`deriving ()`来阻止这一行为。在1.1中，这个行为就被改为与现在相同了。

1.1中引入的新语法包括`let`-expression和中缀表达式的部分应用（`(2 +)`和`(+ 2)`）。这些在今天都已经成为基础语法了。

## Version 1.2, March 1992

在语法上，1.2相较于1.1只修改了一些小的细节，主要的变化在于Prelude和内置类型类：我们熟悉的`id`，`const`，`($)`和`unzip`系列就是这时候加入Prelude的。同时，`Enum`不知为什么成为了`Real`的父类，实数什么时候可数了？

![Haskell 1.2的内置类型类](/assets/images/early-history-of-haskell-i/haskell-1.2-classes.jpg)

1.1和1.2的变化都相对较小。下一个版本，1.3，要等到整整四年之后，这可能是整个Haskell历史上最大的改动。届时我们将迎来无数Haskell初学者的噩梦：`Monad`。

> Next: `undefined`
