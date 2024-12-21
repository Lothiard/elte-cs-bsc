module Vizsga where
    import Data.Char

    f5 :: Integral a => a -> a
    f5 a = a `mod` 5

    matchingArgs :: Eq a => a -> a -> a -> Bool 
    matchingArgs a b c
        | a == b = True
        | a == c = True
        | b == c = True
        | otherwise = False

    division :: Integral a => (a, a, a) -> Maybe a
    division (a, b, c)
        | a == 0 || b == 0 || c == 0 || m == 0 = Nothing
        | otherwise = Just (a `div` m)
        where
            m = b `mod` c
    
    elemOnEvenIdx :: Eq a => a -> [a] -> Bool
    elemOnEvenIdx _ [] = False
    elemOnEvenIdx _ [_] = False
    elemOnEvenIdx ind (_:x:xs) = (ind == x) || elemOnEvenIdx ind xs

    dropEveryNth :: Int -> [a] -> [a]
    dropEveryNth n xs = go n xs
        where
            go _ [] = []
            go 1 (_:ys) = go n ys
            go k (x:ys) = x : go (k - 1) ys

    simDiff :: Eq a => [a] -> [a] -> [a]
    simDiff a b = [x | x <- a, not (x `elem` b)] ++ [y | y <- b, not (y `elem` a)]
    
    parseNum :: String -> Maybe Integer
    parseNum [] = Nothing
    parseNum (x:xs)
        | (x == '+' || x == '-') && not (null xs) && all isDigit xs =
            Just (read (x:xs))
        | isDigit x && all isDigit xs =
            Just (read (x:xs))
        | otherwise = Nothing

    data Plant = Flower String Int | Tree String Int
        deriving (Show, Eq)

    survive :: [Plant] -> Int -> [String]
    survive [] _ = []
    survive (Flower name water : xs) n
        | water <= n = name : survive xs n
        | otherwise  = survive xs n
    survive (Tree _ _ : xs) n = survive xs n

    avgTreeWater :: [Plant] -> Maybe Double
    avgTreeWater plants
        | null trees = Nothing
        | otherwise  = Just (sum trees / fromIntegral (length trees))
        where
            trees = [fromIntegral w | Tree _ w <- plants]
