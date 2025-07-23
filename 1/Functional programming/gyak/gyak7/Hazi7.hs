module Hazi7 where

    -- a
    data TriBool = Yes | Maybe | No
        deriving (Show, Eq)

    -- b
    instance Ord TriBool where
        No <= _ = True
        Maybe <= Maybe = True
        Maybe <= Yes = True
        Yes <= Yes = True
        _ <= _ = False

    -- c
    triAnd :: TriBool -> TriBool -> TriBool
    triAnd Yes Yes = Yes
    triAnd No _ = No
    triAnd _ No = No
    triAnd _ _ = Maybe

    triOr :: TriBool -> TriBool -> TriBool
    triOr No No = No
    triOr Yes _ = Yes
    triOr _ Yes = Yes
    triOr _ _ = Maybe

    -- d
    incMonotonityTest :: (Integral i, Ord a) => i -> [a] -> TriBool
    incMonotonityTest n xs = isIncreasing n xs
        where
            isIncreasing :: (Integral i, Ord a) => i -> [a] -> TriBool
            isIncreasing 0 _ = Maybe
            isIncreasing _ [] = Yes
            isIncreasing _ [_] = Yes
            isIncreasing k (x:y:ys)
                | x <= y = isIncreasing (k - 1) (y:ys)
                | otherwise = No