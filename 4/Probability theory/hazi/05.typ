/ 5): Egy csoportban $25$-en tanulnak. Tegyük fel, hogy a tanulók születésnapjai függetlenek és az év tizenkét hónapjában egyenletes eloszlásúak. Számítsuk ki azon hónapok számának a várható értékét és szórását, amelyekre egy születésnap sem esik.
Legyen $chi_i$ indikátor: $1$ ha az $i$. hónap üres, $0$ különben.\
$ P(chi_i = 1) = (11/12)^25 = p $
=== Várható érték:
$ E X = E(sum_1^12 chi_i) = 12 p = 12 dot (11/12)^25 $

=== Szórásnégyzet:
$ D^2 X = sum_1^12 D^2 chi_i + sum_(i != j) "cov"(chi_i, chi_j) $
$ D^2 chi_i = p(1-p) $
$ E(chi_i chi_j) = P(i. "és" j. "is üres") = (10/12)^25 $
$ "cov"(chi_i, chi_j) = (10/12)^25 - p^2 $
$ D^2 X = 12 p(1-p) + 12 dot 11 dot ((10/12)^25 - p^2) $

/ 9): Az $X$ valószínűségi változó sűrűségfüggvénye legyen $x^(−5)$, ha $x > c$, és $0$ különben.\
=== a) Határozzuk meg $c$ értékét:
$ integral_c^oo x^(-5) dif x = 1 ==> [ -1/(4 x^4) ]_c^oo = 1 ==> 1/(4 c^4) = 1 ==> c = root(4, 1/4) = *1/sqrt(2)* $

=== b) Feltéve, hogy $X > 2c$, mennyi a valószínűsége, hogy $X > 3c$?:
$ P(X > 3c | X > 2c) = (P(X > 3c)) / (P(X > 2c)) = ((3c)^(-4)) / ((2c)^(-4)) = (2/3)^4 = 16/81 $

=== c) Legyenek $X_1, X_2, dots$ az $X$-szel azonos eloszlású, egymástól független valószínűségi változók. Határozzuk meg az:
$ (X_1^3 + X_2^3 + dots + X_n^3)/n $
limeszét sztochasztikus, illetve $1$ valószínűségű értelemben, ha ezek a limeszek léteznek $n arrow oo$ esetén.
$ Y_n arrow E X^3 = integral_c^oo x^3 dot x^(-5) dif x = integral_c^oo x^(-2) dif x = [ -1/x ]_c^oo = 1/c = sqrt(2) $
