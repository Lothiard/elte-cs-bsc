module Hazi2 where
    addV :: (Double, Double) -> (Double, Double) -> (Double, Double)
    addV x y = (fst x + fst y, snd x + snd y)

    subV :: (Double, Double) -> (Double, Double) -> (Double, Double)
    subV x y = (fst x - fst y, snd x - snd y)

    scaleV :: Double -> (Double, Double) -> (Double, Double)
    scaleV scale vector = (fst vector * scale, snd vector * scale)

    scalar :: (Double, Double) -> (Double, Double) -> Double
    scalar x y = (fst x * fst y + snd x * snd y)

    divides :: Integral a => a -> a -> Bool
    divides 0 0 = True
    divides 0 _ = False
    divides x y = y `mod` x == 0

    add :: (Integral a, Integral b, Num c) => a -> b -> c
    add x y = fromIntegral x + fromIntegral y
