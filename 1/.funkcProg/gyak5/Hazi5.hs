module Hazi5 where
    import Data.Char (toUpper)
    import Data.Char (isDigit)

    toUpperThird :: String -> String
    toUpperThird (x:y:z:zs) = x : y : toUpper z : zs
    toUpperThird xs = xs

    isSorted :: Ord a => [a] -> Bool
    isSorted [] = True
    isSorted [_] = True
    isSorted (x:y:zs) = x <= y && isSorted (y:zs)

    (!!!) :: Integral b => [a] -> b -> a
    (x:xs) !!! n
        | n == 0 = x
        | n > 0 = xs !!! (n - 1)
        | n < 0 = reverse (x:xs) !!! (-n - 1)

    format :: Integral b => b -> String -> String
    format n s
        | n <= 0 = s
        | otherwise = format' n s
        where
            format' 0 s = s
            format' n [] = ' ' : format' (n - 1) []
            format' n (x:xs) = x : format' (n - 1) xs

    mightyGale :: (Num a, Ord b, Num b, Integral c) => [(String, a, b, c)] -> String
    mightyGale [] = ""
    mightyGale ((nev, _, szel, _):xs) 
        | szel > 110 = nev
        | otherwise = mightyGale xs

    cipher :: String -> String
    cipher [] = ""
    cipher (x:y:xs) 
        | isDigit (head xs) = [x, y]
        | otherwise = cipher (y:xs)
    cipher _ = "" 

    doubleElements :: [a] -> [a]
    doubleElements [] = []
    doubleElements (x:xs) = x : x : doubleElements xs

    deleteDuplicateSpaces :: String -> String
    deleteDuplicateSpaces [] = []
    deleteDuplicateSpaces (' ': ' ': xs) = deleteDuplicateSpaces (' ': xs)
    deleteDuplicateSpaces (x:xs) = x : deleteDuplicateSpaces xs
