module Vizsga where
    import Data.Char
    import Data.Maybe

    concatTripleString :: ([Char], [Char], [Char]) -> [Char]
    concatTripleString (a, b, c) = a ++ b ++ c

    mods :: Integral a => a -> a -> Maybe (a, a)
    mods a b
        | a == 0 || b == 0 = Nothing
        | otherwise = Just $ (a `mod` b, b `mod`a)

    dropEmpties :: Eq a => [[a]] -> [[a]]
    dropEmpties [] = []
    dropEmpties (x:xs)
        | null x = dropEmpties xs
        | otherwise = x : dropEmpties xs

    createChain :: Integer -> String
    createChain n
        | n <= 0 = ""
        | otherwise = helper n 1
        where
            helper n curr
                | curr <= n = '(' : show curr ++ ')' : helper n (curr + 1)
                | otherwise = ""

    aLtErNaTiNgCaPs :: String -> String
    aLtErNaTiNgCaPs "" = ""
    aLtErNaTiNgCaPs (x:y:xs) = toLower x : toUpper y : aLtErNaTiNgCaPs xs
    aLtErNaTiNgCaPs (x:xs) = toLower x : aLtErNaTiNgCaPs xs

    result :: [Maybe Bool] -> Int -> Bool
    result ls limit
        | calc ls 0 >= limit = True
        | otherwise = False
        where
            calc [] n = n
            calc (x:xs) n
                | x == Just True = calc xs (n + 1)
                | x == Just False = calc xs (n - 1)
                | otherwise = calc xs n

    {-
    maximumIF :: Ord a => (a -> Bool) -> [a] -> Maybe a
    maximumIF fv ls 
        | any fv ls = Just $ findMax fv ls
        | otherwise = Nothing
        where
            findMax _ [x] = x
            findMax fv (x:y:xs)
                | fv x = findMax fv (x:xs)
                | fv x && x < y = findMax fv (y:xs)
                | otherwise = findMax fv (x:xs)
    -}

    
