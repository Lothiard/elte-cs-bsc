module Rzh4 where

    format :: Integral i => i -> String -> String
    format 0 s = s
    format n [] = ' ' : format (n - 1) []
    format n (x:xs) = x : format (n - 1) xs
