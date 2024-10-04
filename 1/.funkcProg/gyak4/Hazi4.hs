module Hazi4 where
    import Data.List (genericReplicate)

    mountain :: Integral i => i -> String
    mountain 0 = ""
    mountain n = mountain (n-1) ++ genericReplicate (fromIntegral n) '#' ++ "\n"

    countAChars :: Num i => String -> i
    countAChars [] = 0
    countAChars (x:xs) = fromIntegral(fromEnum (x == 'a')) + countAChars xs

    lucas :: (Integral a, Num b) => a -> b
    lucas 0 = 2
    lucas 1 = 1
    lucas n = lucas (n - 1) + lucas (n - 2) 

    longerThan :: Integral i => [a] -> i -> Bool
    longerThan [] _ = False
    longerThan _ n | n < 0 = True
    longerThan (_:xs) 0 = True
    longerThan (_:xs) n = longerThan xs (n - 1)


    format :: Integral i => i -> String -> String
    format n (x:xs) = undefined

    merge :: [a] -> [a] -> [a]
    merge [] ys = ys
    merge xs [] = xs
    merge (x:xs) (y:ys) = x : y : merge xs ys
