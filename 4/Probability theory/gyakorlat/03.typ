/ 1.): Jelölje $X$ az ötöslottón kihúzott lottószámok legkisebbikét (itt 1−90-ig számozott golyók közül húznak ötöt). Adjuk meg $X$ eloszlását!
$
  P(X = k) = (binom(90 - k, 4))/(binom(90, 5))
$

/ 2.): Tegyük fel, hogy az új internetelőfizetők mindegyike a többiektől függetlenül $20%$-a speciális kedvezményt kap. Mennyi a valószínűsége, hogy $10$ ismerősünk közül, akik most fizettek elő, legalább négyen részesülnek a kedvezményben?
$
  P(Z >= 4) = sum_(i = 4)^10 binom(10, i) (1/5)^i (1 - 1/5)^(10 - i)
$

/ 3.): Négy szabályos dobókockával dobunk sokszor egymás után addig, amíg elő nem fordul, hogy a négy dobásból legalább három hatos. Jelölje $Y$, hogy hányszor kell dobni ehhez. Adjuk meg $Y$ eloszlását.
