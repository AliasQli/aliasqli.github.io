---
title: Lambda Calculus
toc: false
tags: Technical
page_js: 
  - mathjax_dollar
---

本文向有一定逻辑基础（命题逻辑）的读者介绍lambda calculus（主要是STLC）。

## 直觉

Lambda calculus是一套颇为类似数学函数的系统。因此我们首先从数学上的函数开始，力图为读者提供一些直觉。

考虑函数$f(x) = M$，$M$是一个包含变量$x$的项。我们首先做最简单的语法上的变换，将这个函数改写为一个lambda term：$\lambda x. M$，表示这是一个接受参数$x$，返回$M$的函数。仿照逻辑中的量词，我们可以为$\lambda $定义辖域的概念。$\lambda$的辖域为向右尽可能地延伸。

当我们计算某个具体的函数值，例如$f(3)$时，我们把$M$中所有的$x$替换为$3$（记为$M[x := 3]$）。lambda calculus中的函数应用不打括号：$(\lambda x. M) 3$。我们还要给lambda calculus一条函数应用的规则：$(\lambda x. M) N \Rightarrow M[x := N]$。这里记号$\Rightarrow$表示“规约到（reduce to)”，这条规则称为β-reduction。可以相互规约的项被认为是等价的。

在某些情况下，我们希望改变函数自变量的名称。用lambda calculus的语言写出来，就是$\lambda x. M \Rightarrow \lambda y. M[x := y]$，这条规则称为α-conversion。

可选地，我们还可以捕捉函数外延相等的概念。考虑$\lambda x. f x$和$f$两个lambda term。对于任意的参数$x$，在β-reduction下都有这两个term外延相等：$(\lambda x. f x) x \Rightarrow f x$。我们添加新的规则使它们之间能够直接规约：$\lambda x. f x \Rightarrow f$。这条规则的正向称为η-reduction，反向称为η-expansion。

最后，lambda term和一般函数不同的一点是，它的参数和函数值也是lambda term。这就使得lambda calculus无需定义多元函数：一个lambda term可以接受一个参数，返回一个接受另一个参数的lambda term，这样总体上它就可以接受两个参数：$\lambda x. \lambda y. M$（$\lambda$是右结合的）。这种通过返回另一个函数来模拟多元函数的技巧称为柯里化。

## 形式化定义：自由变量与替换

> 符号约定：我们用小写字母代表变量，大写字母代表lambda term。

我们递归地定义一个合法的lambda term：

  1. 变量是一个lambda term。
  2. 如果$x$是一个变量，$E$是一个lambda term，则$\lambda x. E$是一个lambda term。
  3. 如果$E_1$和$E_2$是两个lambda term，则$E_1 E_2$是一个lambda term。

定义也可以由BNF文法直接给出：$E ::= x \| \lambda x. E \| E_1 E_2$。

为了定义我们上述的三条规则，我们还要形式化替换（substitution）的概念。

在$\lambda x. E$中，我们称$x$为绑定变量，$E$为$\lambda x$的*辖域*\*。称除了形如$\lambda x$外所有对变量$x$的使⽤称为$x$的出现。如果在⼀个项中某个变量$x$的⼀个出现在某个$\lambda x$的辖域中，则称$x$的这个出现为绑定出现，反之称为⾃由出现。如果一个lambda term中没有自由出现，则这个term称为闭合的（closed）。

（*辖域：类比逻辑中的量词，非正式定义。）

然后我们定义替换：一个替换$M[x := N]$将$M$中所有的变量$x$的自由出现替换为$N$，前提是替换后$N$中所有的自由出现不会成为绑定出现，否则需要先做α-conversion。因此，替换也称为capture-avoiding substitution。例如，

$$
\begin{aligned}
            & (\lambda x. \lambda y. x) y \\
\Rightarrow & (\lambda x. \lambda z. x) y   & (α-conversion) \\
\Rightarrow & \lambda z. y                  & (β-reduction)
\end{aligned}
$$

就是一个典型的需要先做α-conversion的例子。这里的定义加上上面的三条规则，就组成了完整的lambda calculus的定义。这样定义的lambda calculus也叫UTLC（UnTyped Lambda Calculus）。在UTLC中能够构造无限制递归，因此UTLC的计算能力和图灵机是等价的。

## 类型化

> 符号约定：我们用小写希腊字母代表类型变量，大写字母代表上下文。

上述的lambda calculus是无类型的。实际使用的更多是有类型的lambda calculus，这之中最简单的称为STLC（Simply Typed Lambda Calculus）。

在STLC的语境下，类型可以简单理解为一些这样的集合，任何lambda term都必须唯一地属于某一个类型，不同类型的term不能混用。“项$E$具有类型$\tau$”记作$E : \tau$。

要定义STLC的类型，我们首先给出一个基础类型的集合$B$，然后递归地定义类型：

  1. 如果$T \in B$，那么$T$是类型。
  2. 如果$\tau_1$和$\tau_2$是类型，那么$\tau_1 \to \tau_2$是类型。$\to$表示“映射到”。习惯上，$\to$是右结合的。

> BNF: $\tau ::= T \| \tau_1 \to \tau_2 \quad \text{where } T \in B$

然后我们给定一个常量项的集合$C$，使得$C$中的每一个项都具有一个基础类型。比如我们可以取$B = \{\top, \bot\}$，$C = \{tt\}$，$tt : \top$，这时合法的类型可以有$\top, \bot, \top \to \bot, \top \to \top \to \top, (\top \to \top) \to \bot$...。注意，与UTLC不同，STLC不是唯一的。取不同的$B$和$C$可以得到不同的STLC。在本文中，我们都以上述取法为例。

我们还要对UTLC的语法稍作修改：

  - 常量也是lambda term。
  - $\lambda x. E$改为$\lambda x : \tau. E$，$\tau$是这个lambda term接受的参数的类型。

为了给出STLC的类型规则，我们还需要一个称为上下文（context）的东西。形式上，它是形如$x : \tau$的类型判断的列表：

  1. $\emptyset$是上下文。
  2. 如果$\Gamma$是上下文，那么$\Gamma, x : \tau$是上下文。

> BNF: $\Gamma ::= \emptyset \| \Gamma, x : \tau $

STLC的类型规则一般使用一种称为sequent calculus的形式写出：

$$
\begin{array}{ll}

\displaystyle \frac
  {x : \tau \in \Gamma}
  {\Gamma \vdash x : \tau}
\text{Var Intro}

& \qquad

\displaystyle \frac
  {c \in C, c : \tau}
  {\Gamma \vdash c : \tau}
\text{Const}

\\ \\

\displaystyle \frac
  {\Gamma, x : \tau \vdash E : \sigma}
  {\Gamma \vdash (\lambda x : \tau. E) : \tau \to \sigma}
\text{Abs}

& \qquad

\displaystyle \frac
  {\Gamma \vdash E_1 : \tau \to \sigma \qquad \Gamma \vdash E_2 : \tau}
  {\Gamma \vdash E_1 E_2 : \sigma}
\text{App}

\end{array}
$$

熟悉逻辑的读者可能会对上面的规则感到眼熟，事实上，二者确实是有联系的，如果把表示“映射到”的$\to$看作逻辑蕴含，那么类型就可以看作命题，逻辑中的deduction theorem和modus ponens正好对应上面规则的Abs和App。

$$
\frac
  {\Gamma, \phi \vdash \psi}
  {\Gamma \vdash \phi \to \psi}
\text{Deduction Theorem}

\qquad

\frac
  {\Gamma \vdash \phi \to \psi \qquad \Gamma \vdash \phi}
  {\Gamma \vdash \psi}
\text{Modus Ponens}
$$

如果一个项$E$是闭合的，则总可以根据上面4条类型规则推出$\emptyset \vdash E : \tau$，这时我们称项$E$具有类型$\tau$，或者直接简写作$E : \tau$。逻辑上$\emptyset \vdash \tau$代表$\tau$是重言式，也就是说，任何闭合项的类型都对应一个重言式。

我们还剩下一个问题：项是什么？答：项是证明。一个类型为$\tau$的闭合项对应命题$\tau$的证明。由此，$\top$对应真命题，它有证明$tt$；$\bot$对应假命题，它没有证明（不能构造类型为$\bot$的项）。

这就是CH同构（Curry-Howard Correspondence）所谓的“类型即命题，过程（项）即证明”。

（注：这里介绍的这个版本的STLC很弱。要让lambda calculus对应直觉主义命题逻辑，还要加入积类型、和类型与谎言爆炸原理。）

关于STLC还有一些重要的定理。对任意的lambda term，如果对它不能做任何的β-reduction和η-reduction，则称这个项是βη范式。首先，对任何STLC闭合项进行规约，都会在有限步后规约到βη范式（Tait）。这就是说，STLC的规约过程总是停机的，因而不是图灵完备的。其次，STLC规约所得的βη范式与规约顺序无关。这条定理称为Church-Rosser Theorem，它为STLC提供了并行计算的支持。

## SKI组合子

虽然SKI组合子提出的时间早于lambda calculus，但这里还是以UTLC的形式给出SKI组合子的定义。

$$
\begin{aligned}
& S = \lambda x. \lambda y. \lambda z. x z (y z) \\
& K = \lambda x. \lambda y. x \\
& I = \lambda x. x
\end{aligned}
$$

其中，$I = S K K$，因而不是必要的。巧合的是，SKI组合子虽然只有三个（两个）函数，但它的计算能力和STLC一样强：对任何STLC闭合项，都存在仅由SKI构成的项（不一定唯一），它们外延相等。

虽然本文没有讲到类型变量，但还请读者短暂地接受如下规则：我们在这里用希腊字母代表*任意的*类型。这样我们尝试给出SKI的类型：

$$
\begin{aligned}
& S = \lambda x. \lambda y. \lambda z. x z (y z) & : (\phi \to \psi \to \xi) \to (\phi \to \psi) \to \phi \to \xi \\
& K = \lambda x. \lambda y. x & : \phi \to \psi \to \phi \\
& I = \lambda x. x & : \phi \to \phi
\end{aligned}
$$

这刚好是希尔伯特推理系统中的三个公理模式。之所以没有希尔伯特第四公理，是因为STLC/SKI对应的是无排中律的系统，称为直觉主义逻辑。（当然这里连谎言爆炸都没有，得到的实际是minimal logic。）

> 这篇关于Lambda Calculus的介绍性文章其实是专为某名读者写的。明明不久之前还说不写入门级别的文章了。
