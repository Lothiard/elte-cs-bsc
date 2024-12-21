module Vizsga where
    
    byDunaOrTisza :: String -> Bool
    byDunaOrTisza ('T':'i':'s':'z':'a':_) = True
    byDunaOrTisza ('D':'u':'n':'a':_) = True
    byDunaOrTisza _ = False

    howManyDoubles :: Eq a => [[a]] -> Int
    howManyDoubles [] = 0
    howManyDoubles (x:xs) 
        | head x == last x = 1 + howManyDoubles xs
        | otherwise = howManyDoubles xs

    blackJackPoints :: Integral a => [a] -> Maybe a
    blackJackPoints ls
        | any (>11) ls = Nothing
        | total > 21 = Nothing
        | otherwise = Just total
        where
            total = sum ls

    notDivisibleByThree :: Integral a => [a] -> Maybe Int
    notDivisibleByThree ls
        | all (\x -> x `mod` 3 == 0) ls = Nothing
        | otherwise = go ls 1
        where
            go :: Integral a => [a] -> Int -> Maybe Int
            go [] _ = Nothing
            go (x:xs) n
                | x `mod` 3 /= 0 = Just n
                | otherwise = go xs (n + 1)

    crowd :: Int -> String
    crowd 0 = ""
    crowd n
        | odd n = concat $ replicate ((n - 1) `div` 2) "(-_" ++ "(-_-)" : replicate ((n - 1) `div` 2) "_-)"
        | even n = concat $ replicate ((n - 2) `div` 2) "(-_" ++ "(-_-)(-_-)" : replicate ((n - 2) `div` 2) "_-)"

    atLeastNFrom :: Eq a => Int -> a -> [a] -> Bool
    atLeastNFrom n p ls
        | n <= 0 = True
        | helper n p ls 0 == n = True
        | otherwise = False
        where
            helper :: Eq a => Int -> a -> [a] -> Int -> Int
            helper _ _ [] temp = temp
            helper n p (x:xs) temp
                | temp == n = n
                | p == x = helper n p xs (temp + 1)
                | otherwise = helper n p xs temp

    mapEither :: (a -> Bool) -> (a -> b) -> (a -> b) -> [a] -> [b]
    mapEither _ _ _ [] = []
    mapEither pred f1 f2 (x:xs)
        | pred x = f1 x : mapEither pred f1 f2 xs
        | otherwise = f2 x : mapEither pred f1 f2 xs

    numberOfFails :: Integral a => [[a]] -> Int
    numberOfFails [] = 0
    numberOfFails (x:xs)
        | null x = numberOfFails xs
        | avg < 2 = 1 + temp
        | otherwise = numberOfFails xs
        where 
            avg = fromIntegral (sum x) `div` fromIntegral (length x)
            temp = 0

    {-
    encode :: String -> String
    encode ls
        | ls == "" = ""
        | otherwise = counter ls 1
        where    
            counter :: String -> Int -> String
            counter 
            counter (x:y) n
                | x == y = counter y (n + 1)
                | otherwise = x
    -}

    mergedOf :: Eq a => [a] -> [a] -> [a] -> Bool
    mergedOf f s r = merge f s == r
        where
            merge :: [a] -> [a] -> [a]
            merge [] [] = []
            merge fs [] = fs
            merge [] ss = ss
            merge (x:xs) (y:ys) = x : y : merge xs ys

    data Weather = Sunny | Cloudy | Rainy deriving (Show, Eq)
    data Forecast = Prediction Weather Int deriving (Show, Eq)

    summerVacation :: [Forecast] -> [Weather]
    summerVacation = undefined

    
