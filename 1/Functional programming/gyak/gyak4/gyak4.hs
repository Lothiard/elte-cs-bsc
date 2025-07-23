module Gyak4 where

    add1' :: Num a => [a] -> [a]
    add1' [] = []
    add1' (x:xs) = x + 1 : add1' xs

    fact :: Integer -> Integer
    fact 0 = 1
    fact n = n * fact (n - 1)

    sum' :: Num a => [a] -> a
    sum' [] = 0
    sum' (x:xs) = x + sum' xs

    product' :: Num a => [a] -> a
    product' [] = 1
    product' (x:xs) = x * product' xs

    elem' :: Eq a => a -> [a] -> Bool
    elem' _ [] = False
    elem' a (x:xs) = a == x || elem' a xs 

    genericLength' :: Num b => [a] -> b
    genericLength' [] = 0
    genericLength' (_:xs) = 1 + genericLength' xs

    replicateFact :: [a] -> b -> [b]
    replicateFact i e = replicate (fromIntegral (fact (genericLength' i))) e

    (+++) :: [a] -> [a] -> [a]
    (+++) [] l = l
    -- (+++) l [] = l
    (+++) (x:xs) l = x : (+++) xs l

    concat' :: [[a]] -> [a]
    concat' [] = []
    concat' (x:xs) = x ++ concat' xs 

    slowReverse :: [a] -> [a]
    slowReverse [] = []
    slowReverse (x:xs) = slowReverse xs ++ [x]
