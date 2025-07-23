module Lesson12 where

-- Más érdekes általánosított ötletű függvények:

-- Definiáld az on' függvényt, amely egy kétparaméteres függvényt alkalmaz két olyan értéken,
-- amelyek mindegyikén alkalmazva lett egy azonos egyparaméteres függvény.
on' :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on' = undefined
-- Az eredeti függvény a Data.Function modulban található.

{-
Ahhoz, hogy általánosítani lehessen, használni kell az Ord osztálynak az eddig
nem igazán használt függvényét, amellyel a legáltalánosabban állapítható meg
két elem egymáshoz képesti viszonya.
Ez lesz a compare

compare :: Ord a => a -> a -> Ordering

Mi ez az Ordering típus?
data Ordering = LT | EQ | GT
Ez a típus írja le két elem egymáshoz képesti viszonyát.
LT : Less Than; kisebb
EQ : Equals, egyenlő
GT : Greater Than, nagyobb

pl.
compare 1 2 == LT
compare 2 1 == GT
compare 2 2 == EQ

Tehát pontosabban megfogalmazva leírja az első elem viszonyát a másodikhoz képest!

A (<=) egyedül nem fedi le egyértelműen az összehasonlítás eredményét.
Ugyanígy az (==),(>=),(<),(>) sem.
Ahhoz, hogy le legyen fedve az összes lehetséges összehasonlítás
egyértelműen, kell a (<),(==),(>) is egyszerre.
Ehelyett létezik a compare függvény, hogy ezt egyben meg lehessen mondani.

Mire lesz használható a compare?
Általánosítsuk a minimum és maximum függvény ötletét. Az adott értéket szeretnénk eredményül,
de az összehasonlítást valamilyen más tulajdonság alapján elvégezni.

Előtte azonban általánosítani kell a minimum-ot és a maximum-ot.
Ahelyett, hogy a minimum-ban a (<) függvényt használnánk, vegyünk át paraméterül egy összehasonlító függvényt
és az alapján vegyünk minimum-ot.
-}

-- Definiáld a minimumBy' függvényt az előbb leírtak alapján!
-- A listáról feltehető, hogy van legalább egy eleme és véges.
-- minimumBy' (flip compare) [1,3,2,5,0,7,0,2] == 7
-- minimumBy' (\x y -> compare (length x) (length y)) ["alma","körte","fa","szilva","barack"] == "fa"
minimumBy' :: undefined
minimumBy' = undefined
-- Az eredeti függvény a Data.List-ben található.

-- maximumBy' hasonlóan definiálható.
maximumBy' :: undefined
maximumBy' = undefined
-- Az eredeti függvény a Data.List-ben található.

-- Hogyan kapjuk vissza az eredeti minimum és maximum függvényeket?
-- Válasz:

-- Ugyanilyen módon rendezni is lehet általánosabban.
-- Definiáld a sortBy' függvényt, amely egy összehasonlító függvény alapján rendezi az elemeket.
-- Ha az összehasonlítás eredménye EQ, akkor az elemek sorrendje ne változzon!
-- sortBy' (flip compare) [1,3,2,5,0,7,0,2] == [7,5,3,2,2,1,0,0]
-- sortBy' (\x y -> compare (length x) (length y)) ["alma","körte","fa","szilva","barack"] == ["fa","alma","körte","szilva","barack"]
sortBy' :: undefined
sortBy' = undefined
-- Az eredeti függvény a Data.List-ben található.

-- Hogyan kapjuk vissza az eredeti sort függvényt?
-- Válasz:

-- Feladatok:

-- Keressük meg egy véges szövegnek az első leghosszabb szavát!
longestWord :: String -> String
longestWord = undefined

-- Egy adott nem üres véges szövegben melyik karakter fordul elő legtöbbször?
mostFrequentChar :: String -> Char
mostFrequentChar = undefined

-- Keressük meg egy listában, hogy melyik indexű elem volt a legnagyobb!
-- Az indexelést kezdjük 0-tól!
maxIndex :: (Ord a, Num b) => [a] -> b
maxIndex = undefined

-- Rendezzük egy szöveg szavait a szavak hossza szerint.
sortWords :: String -> String
sortWords = undefined
