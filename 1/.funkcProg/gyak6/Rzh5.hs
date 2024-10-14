module Rzh5 where

    transformList :: Integral a => [a] -> [a]
    transformList [] = []
    transformList (x:xs)
        | x == 0    = transformList xs
        | even x    = (x `div` 2) : transformList xs
        | odd x     = (x * 2) : transformList xs
