{-
Algebra: one or more operations and the set they operate on.

Study of algebras regards mathematical symbols and the rules regarding their manipulation.

This differs from arithmetic in that the symbols are not limited to those representing numbers or operations only on numbers.

In Haskell, algebras can be implemented through the definition of typeclasses and the operations instantiated for those classes.

In Haskell,
- typeclass: set of operations
- type: set over which those operations operate
- instance: rule as to how an operation works with regard to a type (not a typeclass)

A monoid is a sort of algebra used in Haskell.

A monoid is:
- a binary, associative operation (operation can be 'function')
- an identity value 

An identity value is one that, when combined with any other value, results in that same value.

For instance,
- (addition, zero) form a monoid over numbers.
- (concatenation, empty string) form a monoid over strings.
- (multiplication, one) form a monoid over numbers.

In Haskell, the binary operation is generically referred to as 'mappend' (Probably meaning 'Monoidal Append', but I am nnot sure.) Also, in Haskell, the identity value is generically referred to as 'empty'.

Both 'mappend' and 'empty' must be defined (instantiated) for each monoid.

Once these two are properly defined,

mappend empty a = a
mappend a empty = a

These rules embody identity and associativity.

In Haskell a typeclass Monoid is defined:

class Monoid m where
mempty :: m
-- in this definition, m refers to some thing that is a Monoid
mappend :: m -> m -> m
-- mappend takes two values of this type m, and returns one value of that same type
mconcat :: [m] -> m
-- mconcat combines any list of things of type m, and returns one m.
mconcat = foldr mappend mempty
-- mconcat more generally can fold up any foldable structure of values of type m, and produce one final value of type m

Example of definition of a monoid: lists

Lists are instantiated via
instance Monoid [a] where
mempty = []
mappend = (++)

Why 'Integer' is not a monoid

Although integers have at least two operations that are closed over the set of integers, (+ and *) in Haskell a Monoid must have exactly one such operation.

We can define a near-synonym (a 'newtype') of Integer (e.g., 'Sum') that has the 'mappend' of (+), and the 'mempty' of '0'.

We can also define a newtype of Integer (e.g., 'Product') that has the 'mappend' of (*), and the 'mempty' of '1'.

newtype is exactly what is used to enforce Haskell's rule that a Monoid must have only one (operator, identity) pair.

using newtype constrains the new datatype to having
- a single unary data constructor, and
- no additional runtime overhead in “wrapping” the original type.

Actually, Sum and Product are defined in Data.Monoid.
-}

import Data.Monoid

foo = Sum 3

{-
>foo
Sum {getSum = 3}

> getSum foo
3

A powerful subset of monoids is the set of Abelian monoids, for which

a op b === b op a


In Haskell, with algebras-as-typeclasses. We’ll see examples of more later.
Monoid instances must abide by the following laws:

-- left identity
mappend mempty x = x

-- right identity
mappend x mempty = x

-- associativity
mappend x (mappend y z) = mappend (mappend x y) z
mconcat = foldr mappend mempty

A very important point is that, once a Monoid is properly defined, the following operators will just work.
(<>)
mappend
mconcat
(and mconcat = (foldr . mconcat . mempty) )


-}


