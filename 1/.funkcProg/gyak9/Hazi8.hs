module Hazi8 where
    import Data.Ratio (Rational, (%), numerator)

    -- 1
    data LucasNumber = LucasNumber Rational Rational
        deriving Show

    addLucas :: LucasNumber -> LucasNumber -> LucasNumber
    addLucas (LucasNumber a b) (LucasNumber c d) = LucasNumber (a + c) (b + d)

    mulLucas :: LucasNumber -> LucasNumber -> LucasNumber
    mulLucas (LucasNumber a b) (LucasNumber c d) = LucasNumber (a * c + b * d * 5) (a * d + b * c)

    powLucas :: LucasNumber -> Integer -> LucasNumber
    powLucas _ 0 = LucasNumber 1 0
    powLucas x n
        | even n = powLucas (mulLucas x x) (n `div` 2)
        | otherwise = mulLucas x (powLucas x (n - 1))

    phi :: LucasNumber
    phi = LucasNumber (1 % 2) (1 % 2)

    conjugatePhi :: LucasNumber
    conjugatePhi = LucasNumber (1 % 2) ((-1) % 2)

    lucas :: Integer -> Integer
    lucas n =
        let LucasNumber num _ = addLucas (powLucas phi n) (powLucas conjugatePhi n) 
        in numerator num

    isNotPrime :: Integral a => a -> Bool
    isNotPrime n
        | n <= 1 = True
        | lucas (fromIntegral n) - 1 `mod` fromIntegral n /= 0 = True
        | otherwise = False

    dropMaybes :: [Maybe a] -> [a]
    dropMaybes [] = []
    dropMaybes (Nothing:xs) = dropMaybes xs
    dropMaybes (Just x:xs) = x : dropMaybes xs

    data ListWithHoles a = Nil | Cons a (ListWithHoles a) | Hole (ListWithHoles a)
        deriving Eq

    instance Show a => Show (ListWithHoles a) where
        show Nil = "[]"
        show (Cons x xs) = show x ++ "," ++ show xs
        show (Hole xs) = "_" ++ show xs

    dehole :: ListWithHoles a -> [a]
    dehole Nil = []
    dehole (Cons x xs) = x : dehole xs
    dehole (Hole xs) = dehole xs

    fromMaybeList :: [Maybe a] -> ListWithHoles a
    fromMaybeList [] = Nil
    fromMaybeList (Nothing:xs) = Hole (fromMaybeList xs)
    fromMaybeList (Just x:xs) = Cons x (fromMaybeList xs)

    preserveHoles :: ListWithHoles a -> [Maybe a]
    preserveHoles Nil = []
    preserveHoles (Cons x xs) = Just x : preserveHoles xs
    preserveHoles (Hole xs) = Nothing : preserveHoles xs

    fillHoles :: ListWithHoles a -> a -> [a]
    fillHoles Nil _ = []
    fillHoles (Cons x xs) v = x : fillHoles xs v
    fillHoles (Hole xs) v = v : fillHoles xs v

    data NonEmptyList a = Last a | NECons a (NonEmptyList a)
        deriving Eq

    instance Show a => Show (NonEmptyList a)
        where
            show (Last x) = show [x]
            show (NECons x xs) = show (x : toList xs)
            
    toList :: NonEmptyList a -> [a]
    toList (Last x) = [x]
    toList (NECons x xs) = x : toList xs

    data Stream a = SCons a (Stream a)
        deriving Eq

    neLength :: Num b => NonEmptyList a -> b
    neLength (Last _) = 1
    neLength (NECons _ xs) = 1 + neLength xs

    eqUpTo :: (Eq a, Integral i) => i -> Stream a -> Stream a -> Bool
    eqUpTo 0 _ _ = True
    eqUpTo n (SCons x xs) (SCons y ys) = x == y && eqUpTo (n - 1) xs ys

    cycleNE :: NonEmptyList a -> Stream a
    cycleNE list = cycleHelper list list
        where
            cycleHelper :: NonEmptyList a -> NonEmptyList a -> Stream a
            cycleHelper (Last x) ys = SCons x (cycleHelper ys ys)
            cycleHelper (NECons x xs) ys = SCons x (cycleHelper xs ys)
