/ 1): Mennyi egy gamma eloszlású valószínűségi változó várható értéke?
A $xi ~ Gamma(lambda, alpha)$ eloszlás sűrűségfüggvénye $f(x) = lambda^alpha / Gamma(alpha) x^(alpha-1) e^(-lambda x)$.
A várható érték definíció szerint:
$
  E xi = integral_0^infinity x dot f(x) dif x = integral_0^infinity x dot lambda^alpha / Gamma(alpha) x^(alpha-1) e^(-lambda x) dif x,\
  lambda^alpha / Gamma(alpha) integral_0^infinity x dot x^(alpha-1) e^(-lambda x) dif x = lambda^alpha / Gamma(alpha) integral_0^oo x^alpha e^(-lambda x) dif x,\
  u = lambda x, "   " (dif u)/(dif x) = lambda, "   " dif x = 1/lambda dif u, "   " x = u/lambda\
  lambda^alpha / Gamma(alpha) integral_0^oo (u/lambda)^alpha e^(-u) 1/lambda dif u = lambda^alpha / Gamma(alpha) 1/(lambda^(alpha + 1)) integral_0^oo u^alpha e^(-u) dif u = lambda^alpha / Gamma(alpha) 1/(lambda^(alpha + 1)) Gamma(alpha + 1),\
$
Mivel $Gamma(n) = (n - 1)!:$
$
  1/(Gamma(alpha) lambda) dot alpha dot Gamma(alpha) = alpha/lambda = E
$

/ 2): $xi$ standard normális eloszlású. Mennyi $e^xi$ várható értéke?
Ha $xi ~ N(0, 1)$, akkor a sűrűségfüggvény $f(x) = 1/sqrt(2 pi) e^(-x^2/2)$.
Keressük $E[e^xi]$ értékét:
$
  E[e^xi] = integral_(-infinity)^infinity e^x dot 1/sqrt(2 pi) e^(-x^2/2) dif x,\
  - (x^2)/2 + x = (2x)/2 - x^2/2 = (2x - x^2)/2 = 1/2(2x - x^2) = -1/2(x^2 - 2x) = -1/2(x - 1)^2 + 1/2,\
  integral_(-oo)^oo 1/(sqrt(2 pi)) e^(-1/2(x - 1)^2 + 1/2) dif x = e^(1/2) dot integral_(-infinity)^infinity 1/sqrt(2 pi) e^(- (x-1)^2 / 2) dif x = e^(1/2) dot 1 = sqrt(e)
$

#pagebreak()
/ 3): Véletlenszerűen választunk egy pontot az $x^2 + y^2 < 1$ kör belsejében. Jelölje $Z$ a távolságát a középponttól. Adjuk meg $Z$ eloszlás– és sűrűségfüggvényét, várható értékét és szórását!
=== Eloszlásfüggvény:
Mivel egyenletes az eloszlás, a valószínűség a területek aránya:
$ F_Z(z) = (z^2 pi) / (1^2 pi) = z^2, " ha " 0 <= z <= 1 $
=== Sűrűségfüggvény:
$ f_Z(z) = F'_Z(z) = 2z $
=== Várható érték:
$ E Z = integral_0^1 z dot 2z dif z = [2/3 z^3]_0^1 = 2/3 $
=== Szórás:
$ E Z^2 = integral_0^1 z^2 dot 2z dif z = 1/2 $
A szórásnégyzet
$ D^2 Z = E Z^2 - E Z = 1/2 - (2/3)^2 = 1/18 $
A szórás $ D Z = sqrt(D^2 Z) = 1 / (3 sqrt(2)) $

#pagebreak()
/ 4): Legyen X sűrűségfüggvénye $c/x^4$ ha $x > 1$, és $0$ különben.
=== a) Mennyi $c$ értéke?
$
  1 = integral_1^oo c x^(-4) dif x = c [(x^(-3))/(-3)]_1^oo = c[(lim_(t arrow oo) t^(-3)/(-3)) - 1/(-3)] = c[0 + 1/3] = c/3 ==> c = 3
$

=== b) Számítsuk ki $X$ momentumait minden olyan $k >= 1$-re, melyre ez véges.
$
  E X^k = integral_1^oo x^k 3/x^4 dif x = integral_1^oo 3 x^(k - 4) dif x\
  k - 4 < - 1 ==> k < 3 " eseten konvergens",\
  E X^k = 3[(x^(k - 3))/(k - 3)]_1^oo = 3[0 - 1/(k - 3)] = - 3/(k -3) = 3/(3 - k)
$

=== c) Mennyi $X$ szórása?
$
  D X = sqrt(E X^2 - (E X)^2)\
  E X^2 = integral_1^oo x^2 3/x^4 dif x = 3 integral_1^oo x^(-2) dif x = 3[(x^(-1))/(-1)]_1^oo = 3(- 1/(-1)) = 3,\
  E X = integral_1^oo x 3/x^4 dif x = 3[x^(-2)/(-2)]_1^oo = 3(- 1/(-2)) = 3/2,\
  D X = sqrt(3 - (3/2)^2) = sqrt(12/4 - 9/4) = sqrt(3)/2
$

/ 5): Legyen $X$ egyenletes eloszlású az $[1,4]$ intervallumon. Számítsuk ki $(X− 1)^2$ várható értékét!
$X ~ U(1, 4)$, így $f(x) = 1/(4 - 1) = 1/3$ az $[1, 4]$ intervallumon.
$
  E[(X - 1)^2] = integral_1^4 (x - 1)^2 dot 1/3 dif x = 1/3 [x^3/3 - x^2 + x]_1^4 =\ = 1/3[(64/3 - 16 + 4) - (1/3 - 1 + 1)] = 1/3(28/3 - 1/3) = 1/3 dot 27/3 = 3
$

#pagebreak()
/ 6): Egy osztályba $16$ fiú és $20$ lány jár. Tegyük fel, hogy minden tanítási napon egymástól függetlenül a fiúk $0.04$, a lányok $0.05$ valószínűséggel hiányoznak. Legyen $X$ a jövő hétfőn hiányzó fiúk, $Y$ pedig a jövő hétfőn hiányzó lányok száma.
Mivel a hiányzások független kísérleteknek tekinthetőek:
$ X tilde B(16, 0.04), "   " Y tilde B(20, 0.05) $

=== a) Számítsuk ki az összes jövő hétfői hiányzó, vagyis $X + Y$ várható értékét.
A várható érték linearitása miatt:
$ E(X + Y) = E X + E Y = n_1 p_1 + n_2 p_2 = 16 dot 0.04 + 20 dot 0.05 = 0.64 + 1 = 1.64 $

=== b) Számítsuk ki $X, Y$ és $X + Y$ szórását.
A binomiális eloszlás szórásnégyzete $D^2 X = n p (1 - p)$:
$ D^2 X = 16 dot 0.04 dot 0.96 = 0.6144 ==> D X = sqrt(0.6144) $
$ D^2 Y = 20 dot 0.05 dot 0.95 = 0.95 ==> D Y = sqrt(0.95) $
Mivel $X$ és $Y$ függetlenek, a szórásnégyzeteik összeadódnak:
$ D^2 (X + Y) = D^2 X + D^2 Y = 0.6144 + 0.95 = 1.5644 $
$ D(X + Y) = sqrt(1.5644) $

=== c) Mennyi $X$ és $Y$ kovarianciája?
Mivel $X$ és $Y$ függetlenek:
$ "cov"(X, Y) = 0 $

=== d) Mennyi $X$ és $X + Y$ kovarianciája?
$ "cov"(X, X + Y) = "cov"(X, X) + "cov"(X, Y) = D^2 X + 0 = 0.6144 $

=== e) Mennyi $X$ és $X + Y$ korrelációs együtthatója?
$ R(X, X + Y) = ("cov"(X, X + Y)) / (D X dot D(X + Y)) = 0.6144 / (sqrt(0.6144) dot sqrt(1.5644)) $

#pagebreak()
/ 7): Legyenek $X$ és $Y$ független Poisson-eloszlású valószínűségi változók, $X$ várható értéke $4$, $Y$ várható értéke pedig $10$.
$ X tilde "Poi"(4), "   " Y tilde "Poi"(10) $

=== a) Mennyi $X + Y$ várható értéke?
$ E(X + Y) = E X + E Y = 4 + 10 = 14 $

=== b) Mennyi $X + Y$ szórása?
Poisson-eloszlásnál $D^2 X = E X = lambda$. Függetlenség miatt:
$ D^2 (X + Y) = D^2 X + D^2 Y = 4 + 10 = 14 $
$ D(X + Y) = sqrt(14) $

=== c) Mennyi $X$ és $X + Y$ korrelációs együtthatója?
$
  R(X, X + Y) = ("cov"(X, X + Y)) / (D X dot D(X + Y)) = (D^2 X) / (sqrt(D^2 X) dot sqrt(D^2(X + Y))) = 4 / (2 dot sqrt(14)) = 2/sqrt(14)
$

=== d) Mennyi $2X + 3Y$ és $X − Y$ kovarianciája?
$
  "cov"(2X + 3Y, X - Y) = 2 "cov"(X, X) - 2 "cov"(X, Y) + 3 "cov"(Y, X) - 3 "cov"(Y, Y) = \
  = 2 D^2 X - 3 D^2 Y = 2(4) - 3(10) = 8 - 30 = -22
$

=== e) Mennyi $2X - Y$ szórása?
$ D^2 (2X - Y) = 2^2 D^2 X + (-1)^2 D^2 Y = 4(4) + 10 = 16 + 10 = 26 $
$ D(2X - Y) = sqrt(26) $

#pagebreak()
/ 8): Egy cukrászdában a naponta fagylaltozók számáról azt tudjuk, hogy a kis adagot kérők száma (ez legyen X), Poisson-eloszlású $50$ paraméterrel, a nagy adagot kérők száma Poisson-eloszlású $150$ paraméterrel (ez legyen Y), és hogy X és Y függetlenek. A kis adag ára $300$ forint, a nagyé $500.$
=== 1. Mennyi a napi bevétel várható értéke, illetve szórása?
$ E B = 300 E X + 500 E Y = 300(50) + 500(150) = 15000 + 75000 = 90000 $
$ D^2 B = 300^2 D^2 X + 500^2 D^2 Y = 90000(50) + 250000(150) = 4.5 dot 10^6 + 37.5 dot 10^6 = 42 dot 10^6 $
$ D B = sqrt(42 dot 10^6) $

=== 2. Számítsuk ki $X$-nek és napi bevételnek a korrelációs együtthatóját.
$ "cov"(X, B) = "cov"(X, 300X + 500Y) = 300 D^2 X + 500 "cov"(X, Y) = 300(50) + 0 = 15000 $
$ R(X, B) = 15000 / (sqrt(50) dot sqrt(42 dot 10^6)) $

#pagebreak()
/ 9): Egy szabályos dobókockát kétszer feldobunk. Legyen $X$ a dobások összege, $Y$ a különbségük. Számítsuk ki $"cov"(X,Y)$-t és $R(X,Y)$-t! Független-e $X$ és $Y$? Számítsuk ki $R(X+ Y,2X− Y)$-t is.

=== Kovariancia és Korreláció:
$ "cov"(X, Y) = "cov"(A + B, A - B) = D^2 A - "cov"(A, B) + "cov"(B, A) - D^2 B = D^2 A - D^2 B $
Mivel $A$ és $B$ azonos eloszlásúak, $D^2 A = D^2 B$, így $"cov"(X, Y) = 0$ és $R(X, Y) = 0$.

=== Függetlenség:
Nem függetlenek. Például ha $X = 2$, akkor $A=1, B=1$, amiből $Y=0$ következik.
$ P(X = 2, Y = 0) = 1/36 $ de $ P(X = 2)P(Y = 0) = 1/36 dot 6/36 = 1/216 $ Mivel $1/36 != 1/216$, nem függetlenek.

=== $R(X + Y, 2X - Y)$ kiszámítása:
$ X + Y = (A + B) + (A - B) = 2A $
$ 2X - Y = 2(A + B) - (A - B) = A + 3B $
$ "cov"(2A, A + 3B) = 2 "cov"(A, A) + 6 "cov"(A, B) = 2 D^2 A $
$ D(2A) = 2 D A, "   " D^2(A + 3B) = D^2 A + 9 D^2 B = 10 D^2 A ==> D(A + 3B) = sqrt(10) D A $
$ R = (2 D^2 A) / (2 D A dot sqrt(10) D A) = (2 D^2 A) / (2 sqrt(10) D^2 A) = 1/sqrt(10) $
