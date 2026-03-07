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
  P(X <= 1) = sum_(k = 0)^1 (2,5^k e^(-2,5))/(k!) = (2,5^0 e^(-2,5))/(0!) + (2,5^1 e^(-2,5))/(1!)
$

/ b): több, mint három magoncot találunk?
$
  P(X > 3) = sum_(k = 4)^(infinity) (2,5^k e^(-2,5))/(k!)\ <==>\ 1 - P(X <= 3) = 1 - sum_(k = 0)^3 (2,5^k e^(-2,5))/(k!)
$

/ 5): Egy forgalmas útszakaszon azt figyelik, hogy öt perc alatt hány autó lépi át a megengedett sebességhatárt. A tapasztalatok alapján feltételezzük, hogy annak valószínűsége, hogy van ilyen autó, ugyanannyi, mint annak, hogy nincs. A gyorshajtók számát Poisson-eloszlásúnak feltételezve mennyi a valószínűsége, hogy pontosan három autó lépi át a megengedett sebességhatárt öt perc alatt?
$
  P(X > 0) = P(X = 0) = 1 ==> P(X = 0) = 1/2\
  (e^(-lambda) lambda^0)/(0!) = 1/2 => e^(-lambda) = 1/2 => lambda = ln 2\
  P(X = 3) = (e^(-lambda) lambda^3)/(3!) = (1/2 dot (ln 2)^3)/6
$

#pagebreak()
/ 6): Tegyük fel, hogy az, hogy Péter hány emailt, illetve hány facebook-üzenetet kap egy napon, egymástól független valószínűségi változók. Az emailek száma $X$, ennek paramétere $5$, a facebook-üzenetek száma $Y$, ennek paramétere $8$, és mindkét valószínűségi változó Poisson-eloszlású.
/ (a): Mennyi a valószínűsége, hogy Péter összesen 10 üzenetet kap egy nap alatt a két felületen összesen?
$
  P(X = k) = "Poisson"(5) = (5^k e^(-5))/(k!) "   " P(Y = k) = "Poisson"(8) = (8^k e^(-8))/(k!)\
  X + Y ~ "Poisson"(5 + 8) = "Poisson"(13)\
  P(X + Y = 10) = (13^(10) e^(-13))/(10!)
$

/ (b): Milyen eloszlású az egy nap alatt érkező összes üzenet száma, azaz $X + Y$?
$
  X + Y ~ "Poisson"(5 + 8) = "Poisson"(13)\
$

/ (c): Feltéve, hogy Péter egy nap alatt összesen 10 üzenetet kapott, mennyi a valószínűsége, hogy ebből $5$ érkezett emailen, és $5$ facebookon?
$
  P(X=5 | Z=10) = binom(10, 5) (5/13)^5 (8/13)^5
$

/ 7): Egy szövegben a sajtóhibák száma $lambda$ paraméterű Poisson-eloszlású valószínűségi változó. A lektor a hibákat egymástól függetlenül $p$ valószínűséggel kijavítja, illetve $1 - p$ valószínűséggel nem veszi őket észre.
/ (a): Határozzuk meg a megmaradó hibák számának eloszlását.
$
  mu = lambda(1 - p)
$

/ (b): Mennyi a valószínűsége, hogy a megmaradó hibák száma páros?
$
  P("páros") = sum_(k=0)^oo e^(-mu) (mu^(2k))/(2k!) = e^(-mu) cosh(mu) = e^(-mu) (e^mu + e^(-mu))/2 = (1 + e^(-2 lambda (1-p))) / 2
$

/ 8): Pisti reggel is, este is binomiális eloszlású számú Túrórudit eszik meg. Mi az eloszlása a Pisti által egy nap megevett Túrórudik számának, ha feltételezzük, hogy a reggel és este megevett Túrórudik száma független egymástól és paramétereik $(10; 0,27)$ illetve $(8; 0,27)$?
$
  X ~ "Bin"(10; 0,27) "   " Y ~ "Bin"(8; 0,27)\
  X+Y ~ "Bin"(18; 0,27)
$

/ 9): Pisti naponta 0,4-paraméterű geometriai eloszlású felest iszik meg. Mi az általa hetente megivott felesek számának eloszlása, ha feltételezzük, hogy a napi mennyiségek függetlenek egymástól?
$
  X ~ "Geo"(0,4)\
  P(X = k) = binom(k + r - 1, k) p^r (1 - p)^k = binom(k + 7 - 1, k) 0,4^7 (1-0,4)^k\
$

#pagebreak()
/ 10): Egy mozipénztár előtt $50$-en állnak sorban. Egy jegy $5$ ezer Ft-ba kerül, a mozipénztár kasszája üres a nyitás előtt. $30$ embernek $5$ ezer Ft-osa van és $20$ várakozónak pedig $10$ ezer Ft-osa. Milyen valószínűséggel nem akad meg a sor?
$
  P = (binom(50, 30) - binom(50, 31))/(binom(50, 30))
$
