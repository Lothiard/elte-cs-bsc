module Gyak2 where
    -- infixen -> balra vagy jobbra koto, kotesi erosseg 0-9
    alma :: Integer -> Integer -> Integer
    alma x y = 2 * x + y

    infixl 7 `alma`

    (+*) :: Integer -> Integer -> Integer
    x +* y = x * y + 2

    infixl 5 +*

    one :: Int
    one = 1

    three :: Integer
    three = 3

    -- fromIntegral -> egesz szamrol alakitunk (Int, Integer -> Int, Integer, Double, Float)
    -- realToFrac -> valos szamrol Double vagy Floatra (Int, Integer, Double, Float -> Double, Float)

    four :: Integer
    four = three + (fromIntegral one)

    {-
        Int -> Integer : fromIntegral
        Integer -> Double : mindketto
        Float -> Double : realToFrac
        Double -> Double : realToFrac
        Double -> Integer : 'kerekites'
    -} 

    -- kerekitesek
    {-
        floor: lekerekit
        ceiling: felkerekit
        truncate: megadja az egesz reszt
        round: matematikai kerekites
    -}

    not' :: Bool -> Bool
    not' True = False
    not' False = True

    -- Mik minosulnek mintanak
        -- ertekek: True, False, 0, 5, 'a', 'B'
        -- valtozok (kisbetuk): x, y, z, a, b, c
        -- Joker: _

    -- logikai es muvelet
    (&&&) :: Bool -> Bool -> Bool
    (&&&) True True = True
    (&&&) _ _ = False 

    -- logikai vagy muvelet
    (|||) :: Bool -> Bool -> Bool
    (|||) False False = False
    (|||) _ _ = True

    isZero :: Integer -> Bool
    isZero 0 = True
    isZero _ = False

    isAorB :: Char -> Bool
    isAorB 'A' = True
    isAorB 'B' = True
    isAorB _ = False

    -- moho
    {-
        f a b = 2 * a + b
        g y = y * 2

        f (g 3) (g 2)
        f (3 + 2) (2 + 2)
        f 5 4
        2 * 5 + 4
        14
    -}

    -- lusta
    {-
        f a b = 2 * a + b
        g y = y * 2

        f (g 3) (g 2)
        2 * (g 3) + (g 2)
        2 * (3 + 2) + (g 2)
        2 * 5 + (g 2)
        10 + (g 2)
        10 + 4
        14
    -}

    -- (4,5) vagy (,) 4 5
    -- Integer, Integer
    -- Integer, Char

    -- fst
    -- snd

    sum2 :: (Integer, Integer) -> Integer
    sum2 (x,y) = x + y

    incBoth :: (Integer, Double) -> (Integer, Double)
    -- incBoth t = (fst t + 1, snd t + 1)
    incBoth (x,y) = (x + 1, y + 1)