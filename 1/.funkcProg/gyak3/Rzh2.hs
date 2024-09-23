module Rzh2 where

    isLargerThan :: (Integer, Integer) -> Int -> Bool
    isLargerThan (x, y) z = (x `mod` y) > (fromIntegral z)
    