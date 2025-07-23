module Hazi6 where

    splitOn :: Eq a => a -> [a] -> [[a]]
    splitOn _ [] = [[]]
    splitOn a (x:xs)
        | x == a = [] : rest
        | otherwise  = (x : head rest) : tail rest
        where
            rest = splitOn a xs

    emptyLines :: Num a => String -> [a]
    emptyLines = x 1
        where
            x _ [] = []
            x n ('\n':xs) 
                | head xs == '\n' = n : x (n + 1) xs
                | otherwise = x (n + 1) xs
            x n (_:xs) = x n xs

    csv :: String -> [[String]]
    csv input = map (filter (not . null)) (map (splitOn ',') (splitOn '\n' input))
