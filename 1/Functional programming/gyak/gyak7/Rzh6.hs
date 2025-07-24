module Rzh6 where

    type Name = String
    type Price = Int
    type Item = (Name, Price)

    itemsBelow100 :: [Item] -> [String] 
    itemsBelow100 [] = []
    itemsBelow100 ((name, price):xs)
        | price < 100 = name : itemsBelow100 xs
        | otherwise = itemsBelow100 xs
