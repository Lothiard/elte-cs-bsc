/ 1.): Jelölje $X$ az ötöslottón kihúzott lottószámok legkisebbikét (itt 1−90-ig számozott golyók közül húznak ötöt). Adjuk meg $X$ eloszlását!
$
  P(X = k) = (binom(90 - k, 4))/(binom(90, 5))
$

/ 2.): Tegyük fel, hogy az új internetelőfizetők mindegyike a többiektől függetlenül $20%$-a speciális kedvezményt kap. Mennyi a valószínűsége, hogy $10$ ismerősünk közül, akik most fizettek elő, legalább négyen részesülnek a kedvezményben?
$
  P(Z >= 4) = sum_(i = 4)^10 binom(10, i) (1/5)^i (1 - 1/5)^(10 - i)
$

/ 3.): Négy szabályos dobókockával dobunk sokszor egymás után addig, amíg elő nem fordul, hogy a négy dobásból legalább három hatos. Jelölje $Y$, hogy hányszor kell dobni ehhez. Adjuk meg $Y$ eloszlását.
$
  P("legalább 3 db hatos") = p = (1/6)^4 + (1/3)^3 (5/6) binom(1, 4)\
  P(Y = k) = (1-p)^(k-1) dot p, "  " k = 1, 2, 3, dots
$

/ 4.): Egy bükkösben a bükkmagoncok négyzetméterenkénti száma Poisson-eloszlású, $lambda = 2,5 "db" / m^2$ paraméterrel. Mennyi a valószínűsége annak, hogy egy $1 m^2$-es mintában
/ a): legfeljebb egy, ill.
$
  P(X <= 1) = sum_(k = 0)^1 (2,5^k e^(-2,5)),(k!) = (2,5^0 e^(-2,5))/(0!) + (2,5^1 e^(-2,5))/(1!)
$

/ b): több, mint három magoncot találunk?
$
  P(X > 3) = sum_(k = 4)^(infinity) (2,5^k e^(-2,5))/(k!)\ <==>\ 1 - P(X <= 3) = 1 - sum_(k = 0)^3 (2,5^k e^(-2,5))/(k!)
$

/ 5): Egy forgalmas útszakaszon azt figyelik, hogy öt perc alatt hány autó lépi át a megengedett sebességhatárt. A tapasztalatok alapján feltételezzük, hogy annak valószínűsége, hogy van ilyen autó, ugyanannyi, mint annak, hogy nincs. A gyorshajtók számát Poisson-eloszlásúnak feltételezve mennyi a valószínűsége, hogy pontosan három autó lépi át a megengedett sebességhatárt öt perc alatt?
$$

#pagebreak()
/ 6): Tegyük fel, hogy az, hogy Péter hány emailt, illetve hány facebook-üzenetet kap egy napon, egymástól független valószínűségi változók. Az emailek száma $X$, ennek paramétere $5$, a facebook-üzenetek száma $Y$, ennek paramétere $8$, és mindkét valószínűségi változó Poisson-eloszlású.
/ (a): Mennyi a valószínűsége, hogy Péter összesen 10 üzenetet kap egy nap alatt a két felületen összesen?
/ (b): Milyen eloszlású az egy nap alatt érkező összes üzenet száma, azaz $X + Y$?
/ (c): Feltéve, hogy Péter egy nap alatt összesen 10 üzenetet kapott, mennyi a valószínűsége, hogy ebből $5$ érkezett emailen, és $5$ facebookon?
$
  P(X = k) = "Poisson"(5) = (5^k e^(-5))/(k!) "   " P(Y = k) = "Poisson"(8) = (8^k e^(-8))/(k!)\
  X + Y ~ "Poisson"(5 + 8) = "Poisson"(13)\
  P(X + Y = 10) = (13^(10) e^(-13))/(10!)
$
