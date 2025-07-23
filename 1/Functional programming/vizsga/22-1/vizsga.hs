module Vizsga where
    import Data.Char
    import Data.List 
    import Data.Maybe

    --
    squareSum :: Num a => (a, a) -> (a, a, a)
    squareSum (a, b) = (a, b, a*a + b*b)

    --
    names :: [String] -> [String] -> [String]
    names [] [] = []
    names [] y = y
    names x [] = x
    names (x:xs) (y:ys) = (x ++ " " ++ y) : names xs ys

    triangleArea :: (Double, Double, Double) -> Maybe Double
    triangleArea (a,b,c)
        | a <= 0 || b <= 0 || c <= 0 = Nothing
        | sqrt (a * a + b * b) == c = Just area
        | otherwise = Nothing
        where
            area = a * b / 2

    doubleIdxs :: Eq a  => [(a,a)] -> Maybe [Int]
    doubleIdxs [] = Nothing
    doubleIdxs (x:xs)
        | counter (x:xs) 1 == [] = Nothing
        | otherwise = Just $ counter (x:xs) 1
            where
                counter :: Eq a  => [(a,a)] -> Int -> [Int]
                counter [] _ = []
                counter (x:xs) n
                    | fst x == snd x = n : counter xs (n + 1)
                    | otherwise = counter xs (n + 1)

    snakeToCamel :: String -> String
    snakeToCamel [] = []
    snakeToCamel [a] = [a]
    snakeToCamel (x:y:xs)
        | x == '_' = toUpper y : snakeToCamel xs
        | otherwise = x : snakeToCamel (y:xs)

    removeExtremes :: Ord a => [a] -> [a]
    removeExtremes [] = []
    removeExtremes ls = [x | x <- ls, x /= max, x /= min]
        where
            max = maximum ls
            min = minimum ls

    replaceLastOcc :: Eq a => a {-mit-} -> a {-mire-} -> [a] -> Maybe [a]
    replaceLastOcc mit mire ls
        | elemIndex mit ls /= Nothing = Just $ reverse $ replaceFirstOcc mit mire (reverse ls)
        | otherwise = Nothing

    replaceFirstOcc :: Eq a => a {-mit-} -> a {-mire-} -> [a] ->  [a]
    replaceFirstOcc mit mire (x:xs)
        | x == mit = mire : xs
        | otherwise = x : replaceFirstOcc mit mire xs

    anagram :: String -> String -> Bool
    anagram elso masodik = sort elso == sort masodik

    -- fos
    sumWithLenghtN :: Num a => Int -> [[a]] -> a
    sumWithLenghtN _ [] = 0
    sumWithLenghtN n (x:xs)
        | n <= 0 = 0
        | longEnough n (x:xs) = szamol (x:xs)
        | otherwise = sumWithLenghtN n xs
        where
            longEnough _ [] = False
            longEnough n (x:xs)
                | n > 0 = longEnough (n - 1) xs
                | otherwise = True
            szamol (x:xs) = sum x

    isSteady :: Eq b => (a -> b) -> [a] -> Bool
    isSteady = undefined
