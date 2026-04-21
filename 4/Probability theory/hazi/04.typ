/ 5): Legyen $X$ egyenletes eloszlású az $[1,4]$ intervallumon. Számítsuk ki $(X− 1)^2$ várható értékét!
$X ~ U(1, 4)$, így $f(x) = 1/(4 - 1) = 1/3$ az $[1, 4]$ intervallumon.
$
  E[(X - 1)^2] = integral_1^4 (x - 1)^2 dot 1/3 dif x = 1/3 [x^3/3 - x^2 + x]_1^4 =\ = 1/3[(64/3 - 16 + 4) - (1/3 - 1 + 1)] = 1/3(28/3 - 1/3) = 1/3 dot 27/3 = 3
$

/ 8): Egy cukrászdában a naponta fagylaltozók számáról azt tudjuk, hogy a kis adagot kérők száma (ez legyen X), Poisson-eloszlású $50$ paraméterrel, a nagy adagot kérők száma Poisson-eloszlású $150$ paraméterrel (ez legyen Y), és hogy X és Y függetlenek. A kis adag ára $300$ forint, a nagyé $500.$
=== 1. Mennyi a napi bevétel várható értéke, illetve szórása?
$ E B = 300 E X + 500 E Y = 300(50) + 500(150) = 15000 + 75000 = 90000 $
$ D^2 B = 300^2 D^2 X + 500^2 D^2 Y = 90000(50) + 250000(150) = 4.5 dot 10^6 + 37.5 dot 10^6 = 42 dot 10^6 $
$ D B = sqrt(42 dot 10^6) $

=== 2. Számítsuk ki $X$-nek és napi bevételnek a korrelációs együtthatóját.
$ "cov"(X, B) = "cov"(X, 300X + 500Y) = 300 D^2 X + 500 "cov"(X, Y) = 300(50) + 0 = 15000 $
$ R(X, B) = 15000 / (sqrt(50) dot sqrt(42 dot 10^6)) $
