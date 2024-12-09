module Rzh11 where
    filterMaybe :: (a -> Bool) -> [a] -> Maybe [a]
    filterMaybe f xs = result (filter f xs)
        where
            result [] = Nothing
            result ys = Just ys
            
    on' :: (a -> a -> b) -> (c -> a) -> c -> c -> b
    on' f g x y = f (g x) (g y)

    minimumBy' :: (a -> a -> Ordering) -> [a] -> a
    minimumBy' f (x:xs) = helper f x xs
        where
            helper _ min [] = min
            helper f min (x:xs)
                | f x min == LT = helper f x xs
                | otherwise = helper f min xs

    sortBy' :: (a -> a -> Ordering) -> [a] -> [a]
    sortBy' f xs = helper f [] xs
        where
            helper _ acc [] = acc
            helper f acc (x:xs) = helper f (insert f x acc) xs
            insert _ x [] = [x]
            insert f x (y:ys)
                | f x y == LT = x:y:ys
                | otherwise = y : insert f x ys

    sortBy'' :: (a -> a -> Ordering) -> [a] -> [a]
    sortBy'' c ls = helper1 c ls ((length ls) - 1)
        where
            helper1 _ ls 0 = ls
            helper1 x ls i = helper1 c (helper2 c ls) (i - 1)
                where
                    helper2 _ [] = []
                    helper2 _ [x] = [x]
                    helper2 c (x:y:xs)
                        | c x y == GT = y : helper2 c (x:xs)
                        | otherwise = x : helper2 c (y:xs)