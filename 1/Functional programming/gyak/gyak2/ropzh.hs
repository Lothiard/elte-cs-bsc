module Rzh1 where

    twelve :: Integer
    twelve = incTwo(incTwo(double(double(incTwo 0))))

    incTwo:: Integer -> Integer
    incTwo a = a + 2

    double :: Integer -> Integer
    double a = a * 2