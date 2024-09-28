module Hazi3 where
    import Data.List

    -- 1a
    isSingleton :: [a] -> Bool
    isSingleton [a] = True
    isSingleton _ = False

    -- 1b
    exactly2OrAtLeast4 :: [a] -> Bool
    exactly2OrAtLeast4 [_, _] = True
    exactly2OrAtLeast4 (_:_:_:_:_) = True
    exactly2OrAtLeast4 _ = False

    -- 2
    firstTwoElements :: [a] -> [a]
    firstTwoElements [_] = []
    firstTwoElements (x:y:_) = [x, y]
    firstTwoElements _ = []

    -- 3
    withoutThird :: [a] -> [a]
    withoutThird (x:y:_:zs) = x : y : zs
    withoutThird xs = xs

    -- 4
    onlySingletons :: [[a]] -> [[a]]
    onlySingletons xs = [[x] | [x] <- xs]

    -- 5
    compress :: (Eq a, Num b) => [a] -> [(a,b)]
    compress xs = [(head x, fromIntegral(length x)) | x <- group xs]

    -- 6
    -- decompress :: Integral b => [(a,b)] -> [a]
    -- decompress ?
