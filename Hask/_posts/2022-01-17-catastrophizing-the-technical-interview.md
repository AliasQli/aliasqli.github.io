---
title: Catastrophizing the technical interview
toc: false
tags: Writing Technical
---

自幼时起，我就听闻世界以两千年为一纪，总共经过三纪的更迭。相传，每一次世界面临纪元的更替，都会有一名巫师在神的启示下，使用无限的力量，将世界毁灭而后重造。但是同样也有失败的巫师，他们的无限魔法不受控制地爆炸，魔法占据了他们的全部心智，他们的余生像行尸走肉一般，再也无法对外界做出应答。

和现代的许多巫师一样，我也曾憧憬那用将奥西里斯纪焚烧殆尽的荷鲁斯之火。而当我真正将无限玩弄于指尖时，才发现这也不过是自欺欺人的小把戏。高深的魔法不能当饭吃，这也是我在这里参加技术面试的原因。

---

“能让我看看你是怎么写代码的吗？”面试官问道。他是一个已经步入中年的男子，看起来已经脱离了繁重的前线技术岗位。他告诉你，他名叫塞里斯，“一点简单的代码就可以。就写一个计算质数的程序吧。”

简单吗？许多巫师在简单的魔法上失误。即使是太阳神拉，也会在冥河中沉船。

“我可以使用任何语言吗？”

“是的。”

在塞里斯希望知道我是vim用户还是emacs党的迫切目光中，我打开了vs code。不顾塞里斯几乎可察的失望，我使出了一个平常的起手式。

```haskell
{-# LANGUAGE DeriveFunctor     #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase        #-}
```

“Haskell？”塞里斯倒是很会隐藏他的惊讶。“嗯，我会这门语言，虽然算不上精通。请继续吧。”

“我想，我们首先需要自然数，是这样吗？”

```haskell
data Nat a = Z | S a deriving Functor
```

我从虚空中召唤了一个结构，它具有钢琴一般的旋律。

塞里斯盯着它看了一会儿，“可是，这是自然数吗？”

“哦，稍等。”我不动声色地施展着无限的魔法，“你应该知道，ADT是一个多项式函子的最小或最大不动点吧？”

```haskell
newtype Fix f = Fix { unFix :: f (Fix f) }

type Nat' = Fix Nat
```

塞里斯默不作声。我默认他理解了这句话，于是继续说，“我想我们还需要几个基本操作和自然数。”

```haskell
suc, pre :: Fix Nat -> Fix Nat
suc = Fix . S
pre (Fix (S n)) = n
pre (Fix Z)     = zero

zero, one, two :: Fix Nat
zero = Fix Z
one = suc zero
two = suc one
```

“嗯，嗯。”他似乎从例子中理解了个中含义，并为自己感到骄傲。然而他并不知道，灾难正要降临。

我默念着毁灭的咒文，那是从无限的结构中引出的唯一的魔法。

```haskell
fold, cata :: Functor f => (f a -> a) -> Fix f -> a
fold alg = alg . fmap (cata alg) . unFix

cata = fold
```

正像太阳神有复数个名字，毁灭的魔法也有复数的称呼。我解释道，“这是catamorphism。在F-algebra的范畴中，catamorphism是从始对象出发到每个对象唯一的态射。”

塞里斯半张着嘴。我故意忽视了他，“作为小的练习，我们先来定义一下加法和乘法。”

```haskell
plus, mult :: Fix Nat -> Fix Nat -> Fix Nat
plus a = cata $ \case
  Z   -> a
  S n -> suc n
mult a = cata $ \case
  Z   -> zero
  S n -> plus a n
```

“我想，我们还需要一个Show instance来验证结果的正确性。”

```haskell
instance Show (Fix Nat) where
  show = show . cata (\case Z -> 0; S n -> n + 1)
```

```haskell
*Main> mult two (plus one two)
6
```

“很好！看起来一切正常。”然而一想到接下来的工作，我就好像荷鲁斯被夺走了左眼。“然而，我们没有办法为自然数定义完整的减法。”

```haskell
monus :: Fix Nat -> Fix Nat -> Fix Nat
monus a = cata $ \case
  Z   -> a
  S n -> pre n
```

“然后借由monus，我们可以定义自然数相等。”

```haskell
is, isNot :: Fix Nat -> Fix Nat -> Bool
a `is` b = case (a `monus` b, b `monus` a) of
  (Fix Z, Fix Z) -> True
  _              -> False

a `isNot` b = not (a `is` b)
```

看到一段“正常的”代码，塞里斯的面色似乎缓和了几分。借此机会，我几乎是建议般地向他提出，“我觉得，可能我们还需要一个列表？”

```haskell
data List a b = Nil | Cons a b deriving Functor
```

看到塞里斯用和`Nat`同样的方式理解了`List`，我发觉是时候引入创造的魔法了。无限既是起始，又是终结。因此无限当中既产生毁灭，也同样蕴含创造。

```haskell
unfold, ana :: Functor f => (a -> f a) -> a -> Fix f
unfold coalg = Fix . fmap (ana coalg) . coalg

ana = unfold
```

“Anamorphism，catamorphism的对偶。”我已经懒得多作解释了，“这是从2开始的List。”

```haskell
-- [2..]
from2 :: Fix (List (Fix Nat))
from2 = ana (\n -> Cons n (suc n)) two
```

有了`List`，最后的魔法也能够派上用场了。那是创造和毁灭的统一，其中造物如同孔苏的光芒。

```haskell
refold, hylo :: Functor f => (f b -> b) -> (a -> f a) -> a -> b
refold alg coalg = fold alg . unfold coalg

hylo = refold
```

“是时候了。”我喃喃道。

```haskell
-- quotRem
qR :: Fix Nat -> Fix Nat -> (Fix Nat, Fix Nat)
qR a b = hylo alg coalg a & \(q, r) -> 
    if r `is` zero || r `is` b 
      then (suc q, zero) 
      else (q, r)
  where
    (&) = flip ($)
    coalg :: Fix Nat -> List (Fix Nat) (Fix Nat)
    coalg (Fix Z) = Nil
    coalg n       = Cons n (n `monus` b)
    alg :: List (Fix Nat) (Fix Nat, Fix Nat) -> (Fix Nat, Fix Nat)
    alg Nil                 = (zero, zero)
    alg (Cons n (q, Fix Z)) = (zero, n)
    alg (Cons _ (q, r))     = (suc q, r)
```

我发现自己差点也犯了一个off by one错误。果然，简单的东西不可轻视。不过，我们终于可以定义除法和模。

```haskell
-- div and mod
(/-), (%) :: Fix Nat -> Fix Nat -> Fix Nat
a /- b = fst (qR a b)
a % b  = snd (qR a b)
```

“这是最后的准备了。”我的声音似乎将塞里斯从某个遥远的地方拉回了这间办公室。“我们还需要能够过滤`List`。”

```haskell
filter_ :: (a -> Bool) -> Fix (List a) -> Fix (List a)
filter_ p = cata $ \case
  Nil      -> Fix Nil
  Cons a b -> if p a then Fix (Cons a (filter_ p b)) else filter_ p b
```

我想起胡狼头的神祇，他的天平称量灵魂的质量。我又想起受荷鲁斯守护者的金字塔，当正确的时刻来临，星光将穿过其中缝隙，引导法老的灵魂走向永生。那个时刻已经来到，最后的答案将借由创造之力显现。

```haskell
primes :: Fix (List (Fix Nat))
primes = ana (\(Fix (Cons p ps)) -> Cons p (filter_ (\x -> x % p `isNot` zero) ps)) from2
```

“结束了。要看看吗？”我热情地招呼塞里斯，后者面色惨白，几近不省人事。

```haskell
instance Show a => Show (Fix (List a)) where
  show = show . cata (\case Nil -> []; Cons x xs -> x:xs)
```

```haskell
*Main> primes
[2,3,5,7,11,13,17,19,23...
```

“很好，很好，”塞里斯双眼无神地回答到，“你被录取了。但是这场面试，简直…简直是场灾难。”

> 灵感来源：[Typing the technical interview](https://aphyr.com/posts/342-typing-the-technical-interview)
> 
> 中文翻译：[如何类型化一场技术面试](https://zhuanlan.zhihu.com/p/84634204)
