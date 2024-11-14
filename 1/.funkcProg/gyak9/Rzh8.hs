module Rzh8 where
    safeMod :: Integral a => a -> a -> Maybe a
    safeMod _ 0 = Nothing
    safeMod a b = Just (a `mod` b)