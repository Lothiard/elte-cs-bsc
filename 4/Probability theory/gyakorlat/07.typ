/ 1): Mennyi egy gamma eloszlású valószínűségi változó szórásnégyzete?
A $xi ~ Gamma(lambda, alpha)$ eloszlás sűrűségfüggvénye $f(x) = lambda^alpha / Gamma(alpha) x^(alpha-1) e^(-lambda x)$.
A szórásnégyzethez szükségünk van a második momentumra ($E xi^2$):
$
  E xi^2 = integral_0^oo x^2 dot lambda^alpha / Gamma(alpha) x^(alpha-1) e^(-lambda x) dif x = lambda^alpha / Gamma(alpha) integral_0^oo x^(alpha+1) e^(-lambda x) dif x\
  u = lambda x, "   " (dif u)/(dif x) = lambda, "   " dif x = 1/lambda dif u, "   " x = u/lambda\
  E xi^2 = lambda^alpha / Gamma(alpha) integral_0^oo (u/lambda)^(alpha + 1) e^(-u) 1/lambda dif u = lambda^alpha / Gamma(alpha) dot 1 / lambda^(alpha+2) integral_0^oo u^(alpha+1) e^(-u) dif u = 1 / (lambda^2 Gamma(alpha)) dot Gamma(alpha + 2)
$
Mivel $Gamma(alpha+2) = (alpha+1)alpha Gamma(alpha)$:
$
  E xi^2 = ((alpha+1)alpha) / lambda^2
$
A szórásnégyzet képlete $D^2 xi = E xi^2 - (E xi)^2$, ahol $E xi = alpha/lambda$:
$
  D^2 xi = (alpha^2 + alpha) / lambda^2 - (alpha / lambda)^2 = alpha / lambda^2
$

/ 2): Mennyi egy Pareto eloszlású valószínűségi változó szórásnégyzete?
A forrás szerint a Pareto-eloszlás eloszlásfüggvénye $F(x) = 1 - (beta / (beta + x))^alpha$\
A sűrűségfüggvény a derivált: $f(x) = (alpha beta^alpha) / (beta + x)^(alpha + 1)$
- *Várható érték:* $E X = integral_0^oo x f(x) dif x = beta / (alpha - 1)$, ha $alpha > 1$
- *Második momentum:* $E X^2 = integral_0^oo x^2 f(x) dif x = (2 beta^2) / ((alpha-1)(alpha-2))$, ha $alpha > 2$
A szórásnégyzet:
$
  D^2 X = E X^2 - (E X)^2 = (2 beta^2) / ((alpha-1)(alpha-2)) - (beta / (alpha-1))^2 = \
  = (2 beta^2 (alpha-1) - beta^2 (alpha-2)) / ((alpha-1)^2 (alpha-2)) = (alpha beta^2) / ((alpha-1)^2 (alpha-2))
$

#pagebreak()
/ 3): Legyenek $X$ és $Y$ független egyenletes eloszlásúak a $(0, 1)$ intervallumon. Mennyi $R(min(X, Y),max(X, Y))$?
Legyen $U = min(X, Y)$ és $V = max(X, Y).$ $X, Y$ függetlensége miatt $E(U V) = E(X Y) = E X E Y = 1/2 dot 1/2 = 1/4$.
- $U$ sűrűségfüggvénye $f_U (u) = 2(1-u)$, amiből $E U = 1/3$ és $E U^2 = 1/6$, így $D^2 U = 1/18$.
- $V$ sűrűségfüggvénye $f_V (v) = 2v$, amiből $E V = 2/3$ és $E V^2 = 1/2$, így $D^2 V = 1/18$.
A kovariancia $"cov"(U, V) = E(U V) - E U E V$:
$
  "cov"(U, V) = 1/4 - (1/3 dot 2/3) = 1/4 - 2/9 = 1/36
$
A korreláció:
$
  R(U, V) = (1/36) / (sqrt(1/18) sqrt(1/18)) = (1/36) / (1/18) = 1/2
$

/ 4): Tegyük fel, hogy egy ember (szisztolés) vérnyomása minden mérésnél $120$ Hgmm várható értékű, $10$ szórású valószínűségi változó. Legyen $X$ és $Y$ két vérnyomásmérés eredménye, és tegyük fel, hogy elég sok idő eltelt a két mérés között ahhoz, hogy feltehessük, hogy a mérési eredmények egymástól függetlenek.
$ E X = 120, D X = 10 ==> D^2 X = 100 $
=== a) Mennyi a két mérés átlagának várható értéke és szórása?:
$ E((X+Y)/2) = 1/2(E X + E Y) = 120 $
Függetlenség miatt $D^2((X+Y)/2) = 1/4(D^2 X + D^2 Y) = 200/4 = 50$\
Szórás: $D = sqrt(50) = 5 sqrt(2)$

=== b) Mennyi lenne a mérések átlagának várható értéke és szórása $n = 10$, illetve $n = 100$ mérés esetén?:
$ E overline(X)_n = 120 $
$ D^2 overline(X)_n = (n D^2 X) / n^2 = (D^2 X) / n = 100 / n $
- $n=10 ==> D = sqrt(10) approx 3.16$\
- $n=100 ==> D = sqrt(1) = 1$\

=== c) Ha $n$ mérés van, mennyi az első $k$ mérés átlagának és az összes mérés átlagának a korrelációs együtthatója?:
$
  "cov"(overline(X)_k, overline(X)_n) = "cov"(1/k sum_1^k X_i, 1/n sum_1^n X_i) = 1/(k n) sum_1^k D^2 X_i = (k dot 100) / (k n) = 100 / n
$
$ R = (100/n) / (sqrt(100/k) sqrt(100/n)) = (1/n) / (1/sqrt(k n)) = sqrt(k / n) $

#pagebreak()
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

/ 6): Egy elektromos vezetékgyártó cég $40$ m-es vezetékeket gyárt $0.2$ m szórással. Legfeljebb mennyi annak a valószínűsége, hogy a vezeték hossza legalább $1$ m-rel eltér a várható $40$ m-es értéktől? Mennyi a pontos érték, ha feltesszük még azt is, hogy a hossz normális eloszlású?
$ E X = 40, D X = 0.2 $
=== Csebisev-becslés:
A kérdés $P(|X - 40| >= 1)$. A Csebisev-egyenlőtlenség szerint:
$
  P(|X - 40| >= 1) <= (D^2 X) / 1^2 = 0.04 / 1 = 0.04 " " (4%)
$

=== Normális eloszlás esetén:
$X tilde N(40, 0.04)$. Standardizálva $Z = (X-40)/0.2$\
$ P(|X - 40| >= 1) = P(|Z| >= 5) = 2(1 - Phi(5)) $
A táblázat szerint $Phi(2.84) = 0.9977$, így $Phi(5) approx 1$. A valószínűség *elhanyagolhatóan kicsi ($approx 0$)*.

#pagebreak()
/ 7): Legalább mekkora valószínűséggel állíthatjuk, hogy egy szabályos érmével végzett $100$-as dobássorozatban a fejdobások száma legalább $44$ és legfeljebb $56$? Mit mondhatunk $1000$-es dobássorozat esetén arról, hogy a fejdobások száma legalább $440$ és legfeljebb $560$?
$ n=100, p=0.5 ==> E X = 50, D^2 X = 25, D = 5 $
Kérdés:
$ P(44 <= X <= 56) = P(|X-50| <= 6) = 1 - P(|X-50| >= 7) $
Csebisevvel:
$ P(|X-50| >= 7) <= 25/49 approx 0.51 $
Így
$ P >= 1 - 0.51 = 0.49 $

$n=1000$ esetén:
$ E X = 500, D^2 X = 250, D approx 15.81 $
Kérdés:
$ P(|X-500| <= 60) = 1 - P(|X-500| >= 61) $
$ P(|X-500| >= 61) <= 250 / 61^2 $
Így
$ P >= 1 - 250 / 61^2 = 0.933 $

/ 8): Legyenek az $X_1, X_2, dots,$ valószínűségi változók függetlenek. Milyen értelemben konvergensek az alábbi sorozatok, és mi a limeszük?
=== a) $X_i$ független $p$ paraméterű indikátorváltozó; $Y_n = (X_1^5 + dots + X_n^5)/n$:
Mivel $X_i in {0, 1}$, ezért $X_i^5 = X_i$. A Nagy Számok Erős Törvénye szerint:
$ Y_n = (sum X_i) / n arrow E X_1 = p " (1 valószínűséggel)" $

=== b) $X_i$ az $i.$ szabályos kockadobás eredménye; $Y_n = (X_1 + dots + X_n)/n$; illetve $Z_n = (X_1^2 + dots + X_n^2)/2$:
- $Y_n = (sum X_i) / n arrow E X_1 = 3.5$.
- $Z_n = (sum X_i^2) / n arrow E X_1^2 = (1+4+9+16+25+36)/6 = 91/6$.

=== c) $X_i$ exponenciális eloszlású $2$ paraméterrel (azaz sűrűségfüggvénye $f(x) = 2e^(−2x) " " (x > 0); Y_n = (e^(X_1) + dots + e^(X_n))/n,$ illetve $Z_n = (X_1^2 + X_2^2 + dots + X_n^2)/n$:
- $Y_n arrow E(e^X) = integral_0^oo e^x dot 2 e^(-2x) dif x = [ -2 e^(-x) ]_0^oo = *2*$.
- $Z_n arrow E X^2 = 2 / lambda^2 = 2/4 = *0.5*$.

#pagebreak()
/ 9): Az $X$ valószínűségi változó sűrűségfüggvénye legyen $x^(−5)$, ha $x > c$, és $0$ különben.\
=== a) Határozzuk meg $c$ értékét:
$ integral_c^oo x^(-5) dif x = 1 ==> [ -1/(4 x^4) ]_c^oo = 1 ==> 1/(4 c^4) = 1 ==> c = root(4, 1/4) = *1/sqrt(2)* $

=== b) Feltéve, hogy $X > 2c$, mennyi a valószínűsége, hogy $X > 3c$?:
$ P(X > 3c | X > 2c) = (P(X > 3c)) / (P(X > 2c)) = ((3c)^(-4)) / ((2c)^(-4)) = (2/3)^4 = 16/81 $

=== c) Legyenek $X_1, X_2, dots$ az $X$-szel azonos eloszlású, egymástól független valószínűségi változók. Határozzuk meg az:
$ (X_1^3 + X_2^3 + dots + X_n^3)/n $
limeszét sztochasztikus, illetve $1$ valószínűségű értelemben, ha ezek a limeszek léteznek $n arrow oo$ esetén.
$ Y_n arrow E X^3 = integral_c^oo x^3 dot x^(-5) dif x = integral_c^oo x^(-2) dif x = [ -1/x ]_c^oo = 1/c = sqrt(2) $
