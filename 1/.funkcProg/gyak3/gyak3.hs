module Gyak3 where

    fst' :: (a, b) -> a
    fst' (x,y) = x

    snd' :: (a,b) -> b
    snd' (x,y) = y

    -- parametrikusan polimorf fv: olyan fv, amely mukodese fuggetlen a bemeneti paratmeterek tipusatol
    -- megallapitas gyakorlatban: a fuggveny tipusaban nincs megkotes

    -- fromIntegral :: (Integral a, Num b) => a -> b

    -- ad-hoc polimorf fv: olyan fv, amely mukodese fugg a bemeneti parameterek tipusatol
    -- megallapitas gyakorlatban: a fuggveny tipusaban van megkotes

    add :: (Num a) => a -> a -> a
    add x y = x + y

    -- (==) :: Eq a => a -> a -> Bool
    
    isLarger :: (Ord a) => a -> a -> Bool
    isLarger x y = x > y

    -- (lancolt) listak
    -- homogen adatszerkezet

    -- [1,2,3,4] == 1 : 2 : 3 : 4 : []
    -- ['a','b','c']
    -- [True, False, Bool]
    -- "String" == 'S' : 't' : 'r' : 'i' : 'n' : 'g' : []

    -- [True, 5, 'a'] error

    null' :: [a] -> Bool
    -- null' l = length l == 0
        -- vegtelen lista eseten vegtelensegig szamol
        -- ezert jobb megoldas a mintaillesztes:
    null' [] = True
    null' _ = False

    head' :: [a] -> a
    head' (x:xs) = x 

    tail' :: [a] -> [a]
    tail' (x:xs) = xs

    remove2nd :: [a] -> [a]
    remove2nd (z:y:x:xs) = (z:x:xs)
    -- remove2nd l = l
    -- remove2nd list@(x:y:xs) = (z:y:xs) -- elnevezes @

    squares :: [Integer]
    squares = [ x^2 | x <- [1..10] ]

    evens :: [Integer]
    evens = [ x | x <- [1..10], even x, x > 10 ]

    add1 :: Num a => [a] -> [a]
    add1 list = [ x+1 | x <- list]

    onlyAs :: [String] -> [String]
    onlyAs s = [ "a" | "a" <- s ]

    firstIsA :: [String] -> [String]
    firstIsA s = [ w | w@('a':xs) <- s ]
