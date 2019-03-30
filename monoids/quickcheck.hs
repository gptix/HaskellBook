import Data.Monoid
import Test.QuickCheck
monoidAssoc :: (Eq m, Monoid m)
  => m -> m -> m -> Bool
monoidAssoc a b c =
  (a <> (b <> c)) == ((a <> b) <> c)

type S = String
type B = Bool

foo =  quickCheck (monoidAssoc :: S -> S -> S -> B)


{-
-- this does not cause errors in GHCi, but does in GHC

goo = verboseCheck monoidAssoc
-}

monoidLeftIdentity :: (Eq m, Monoid m)
  => m
  -> Bool
monoidLeftIdentity a = (mempty <> a) == a

monoidRightIdentity :: (Eq m, Monoid m)
  => m
  -> Bool
monoidRightIdentity a = (a <> mempty) == a
  
