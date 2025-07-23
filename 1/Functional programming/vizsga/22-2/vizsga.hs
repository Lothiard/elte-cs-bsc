module Vizsga where
    import Data.Char (isDigit, isUpper, toLower, isLetter)
    import Data.Maybe 

    -- 1
    threeDivs :: Integral a => (a,a) -> (a,a) -> (a,a) -> Maybe a
    threeDivs elso masodik harmadik
        | snd elso == 0 || snd masodik == 0 || snd harmadik == 0 = Nothing
        | otherwise = Just $ (fst elso `div` snd elso) + (fst masodik `div` snd masodik) + (fst harmadik `div` snd harmadik)

    -- 2
    howManyDifferences :: Eq a => [(a,a)] -> Int
    howManyDifferences [] = 0
    howManyDifferences (x:xs) 
        | fst x /= snd x = 1 + howManyDifferences xs
        | otherwise = howManyDifferences xs

    -- 3
    getDigitsFromCode :: String -> String
    getDigitsFromCode [] = []
    getDigitsFromCode (x:xs) 
        | isLetter x = getDigitsFromCode []
        | isDigit x = x : getDigitsFromCode xs
        | otherwise = getDigitsFromCode xs

    -- 4 fos
    isTriangularNumber :: Integral a => a -> Bool
    isTriangularNumber n
        | counter temp n > n = False
        | otherwise = True
        where 
            temp = 1
            counter temp n
                | temp == n = n
                | temp < n = temp + counter (temp + 1) n
                | otherwise = n
                
    smallestInSize :: [a] -> [b] -> [c] -> Maybe Int
    smallestInSize e m h = undefined

    reverseWords :: Integral a => String -> [a] -> String
    reverseWords str n = undefined

    camelToSnake :: String -> String
    camelToSnake "" = ""
    camelToSnake (x:xs)
        | isUpper x = "_" ++ toLower x : camelToSnake xs
        | otherwise = x : camelToSnake xs
         
    sumMaybe :: Num a => [Maybe a] -> a
    sumMaybe [] = 0
    sumMaybe (x:xs)
        | isJust x = abs (fromJust x) + sumMaybe xs
        | otherwise = sumMaybe xs

    applyIfIncreases :: Ord a => (a -> a) -> [a] -> [a]
    applyIfIncreases _ [] = []
    applyIfIncreases f (x:xs)
        | f x > x = f x : applyIfIncreases f xs
        | otherwise = x : applyIfIncreases f xs

    elemFreqByFirstOcc :: Eq a => [a] -> [(a, Int)]
    elemFreqByFirstOcc (x:xs) = undefined

    type RegNum = String -- rendszám
    type Level = Int -- emelet
    type SpotNum = Int -- parklóhely sorszáma

    data Status = Free | Occupied RegNum deriving (Show, Eq)
    data ParkingSpace = PS Level SpotNum Status deriving (Show, Eq)

    type ParkingLot = [ParkingSpace]

    freeSpaces :: ParkingLot -> Int -> Int
    freeSpaces [] _ = 0
    freeSpaces ((PS lvl _ stat):xs) n
        | lvl == n && stat == Free = 1 + freeSpaces xs n
        | otherwise = freeSpaces xs n 

    {-
    findCar :: ParkingLot -> RegNum -> Maybe (Level, SpotNum)
    findCar [] _ = Nothing
    findCar ((PS lvl spot stat):xs) ren
        | stat == Occupied
    -}
