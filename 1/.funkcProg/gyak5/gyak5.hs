module Gyak5 where

    numberWords :: [String] -> Int -> [(Int, String)]
    numberWords [] _ = []
    numberWords (x:xs) i = (i, x) : numberWords xs (i+1)

    numberWords' :: [String] -> [(Int, String)]
    numberWords' list = helper list 1 
        where
            helper [] _ = []
            helper (x:xs) i = (i,x) : helper xs (i+1)

    unzip' :: [(a,b)] -> ([a], [b])
    unzip' list = let a = map fst list in let b = map snd list in (a,b)

    {-
    reverse' :: [a] -> [a]
    reverse' list = rev list
        where
            -- ?
    -}

    take' :: Integral a => a -> [b] -> [b]
    take' k _
        | k <= 0 = []
    take' k [] = []
    take' k (x:xs) = x : take' (k-1) xs

    drop' :: Integral a => a -> [b] -> [b]
    drop' k list
        | k <= 0 = list
    drop' k [] = []
    drop' k (x:xs) = drop' (k-1) xs

    splitAt' :: Integral a => a -> [b] -> ([a],[b])
    splitAt' k list = (take' k list, drop' k list)

    replicate' :: Integral b => b -> a -> [a]
    replicate' k _
        | k <= 0 = []
        | otherwise = e : replicate' (k-1) e
