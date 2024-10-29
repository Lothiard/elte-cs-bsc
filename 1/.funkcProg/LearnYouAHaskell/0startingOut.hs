module StartingOut where

    doubleMe :: Num a => a -> a
    doubleMe x = x + x

    doubleUs :: Num a => a -> a -> a
    doubleUs x y = x + x + y + y

    -- i prefer
    doubleSmallNumber :: (Ord a, Num a) => a -> a
    doubleSmallNumber x
        | x > 100 = x
        | otherwise = x * x

    {-
        ugly ahh implementation
        x = if x > 100
            then x
            else x*2 
    -}

    doubleSmallNumber' :: (Ord a, Num a) => a -> a
    doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

    boomBangs :: Integral a => [a] -> [String]
    boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x ]
    