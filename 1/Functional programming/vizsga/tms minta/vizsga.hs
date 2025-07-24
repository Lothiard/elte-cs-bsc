module Vizsga where

    points :: Integral a => [(String, a, a)] -> [(String, a)]
    points [] = []
    points ((nev, ido, hiba):xs)
        | hiba == 100 = points xs 
        | pont <= 0 = points xs
        | otherwise = (nev, pont) : points xs
        where
            pont = 100 - ido `div` 2 - hiba

    type Apple = (Bool, Int)
    type Tree = [Apple]
    type Garden = [Tree]

{-
    ryuksApples :: Garden -> Int
    ryuksApples [] = 0
    ryuksApples (((erett, magas):ts):gs) 
        | erett && magas <= 3 = 1 + ryuksApples gs
        | otherwise = ryuksApples gs
-}

    doesContain :: String -> String -> Bool
    doesContain = undefined

    barbie :: [String] -> String
    barbie str = eldont str 1 where
        eldont [] _ = "farmer"
        eldont (x:xs) n
            | x == "rozsaszin" = "rozsaszin"
            | odd n || x == "fekete" = eldont xs (n + 1)
            | even n && x /= "fekete" = x
            | otherwise = "farmer"

    firstValid :: [a -> Bool] -> a -> Maybe Int
    firstValid (x:xs) n = helper (x:xs) n 0 where
        helper [] _ _ = Nothing
        helper (x:xs) n ind
            | x n = Just ind
            | otherwise = helper xs n (ind + 1)

    combineListsIf :: (a -> b -> Bool) -> (a -> b -> c) -> [a] -> [b] -> [c]
    combineListsIf _ _ [] _ = []
    combineListsIf _ _ _ [] = []
    combineListsIf pred fv (x:xs) (y:ys)
        | pred x y = fv x y : combineListsIf pred fv xs ys
        | otherwise = combineListsIf pred fv xs ys

    
    


    data Line = Tram Integer [String] Line | Bus Integer [String] Line
