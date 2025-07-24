module Rzh10 where
    multiplyPositives :: [Integer] -> [Integer]
    multiplyPositives xs = map (*10) (filter (>0) xs)