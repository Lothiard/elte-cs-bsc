module Gyak1 where
    -- egy soros komment

    {- 
        tobb soros komment
    -}

    one :: Int -- architectura fuggo mekkora
    one = 1

    three :: Integer -- vegtelensegig
    three = undefined

    -- (+) (-) (*)

    negativeOne :: Integer
    negativeOne = -1

    oops :: Integer
    oops = 4 + (-1) -- () nelkul error

    -- float es double

    half :: Float
    half = 0.5

    quarter :: Double
    quarter = 0.25

    -- (/) mod div

    divByThree :: Integer -> Integer
    divByThree x = div x 3

    a :: Char
    a = 'a'

    -- bool

    -- True or False

    true :: Bool
    true = undefined

    false :: Bool 
    false = False

    -- (not), &&, ||

    plusOne :: Int -> Int
    plusOne x = x + 1

    double :: Int -> Int
    double x = x * 2

    isDivisibleBy :: Int -> Int -> Bool
    isDivisibleBy n k = mod n k == 0

    greater :: Int -> Int -> Bool 
    greater n k = n > k