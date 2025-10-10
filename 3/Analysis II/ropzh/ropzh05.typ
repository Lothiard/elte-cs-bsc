== Mikor mondjuk azt, hogy egy függvény n-szer (2 ≤ n ∈ N) differenciálható egy
pontban?
TFH $f in RR arrow RR, a in "int" D_f$ és egy $n = 2,3,dots$-re $exists$ az $f^((n-1))$ deriválható az $a in "int" D_f$ pontban (jelölése: $f in D^n{a}$), ha
- $exists r > 0: f in D^(n - 1)(K_r(a))$, és
- az $f^((n - 1))$ függvény deriválható $a$-ban, azaz $f^((n - 1)) in D{a}$.

Legyen ekkor
$
  f^((n))(a) := (f^((n - 1)))'(a)
$
az $f$ függvény $a$-beli $n$-edik deriváltja.

\
== Írja le a $0/0$ esetre vonatkozó L’Hospital-szabályt!
Legyen $-infinity <= a < b < +infinity$ és $f, g in D(a, b)$.\
TFH
- $ exists lim_(a + 0) f = lim_(a + 0) g = 0 $,
- $ g(x) != 0 " és " g'(x) != 0 "  " forall x in (a, b) $,
- $ exists lim_(a + 0) (f')/(g') in overline(RR) $.

Ekkor
$
  exists lim_(a + 0) f/g in overline(RR) "  és  " lim_(a + 0) f/g = lim_(a + 0) (f')/(g') in overline(RR)
$

\
== Írja le a $+infinity/+infinity$ esetre vonatkozó L’Hospital-szabályt!
Legyen $-infinity <= a < b < +infinity$ és $f, g in D(a, b)$.\
TFH
- $ exists lim_(a + 0) f = lim_(a + 0) g = +infinity $
- $ g(x) != 0 " és " g'(x) != 0 "  " forall x in (a, b) $
- $ exists lim_(a + 0) (f')/(g') in overline(RR) $

Ekkor
$
  exists lim_(a + 0) f/g in overline(RR) "  és  " lim_(a + 0) f/g = lim_(a + 0) (f')/(g') in overline(RR)
$

\
== Mi a kapcsolat a hatványsor összegfüggvénye és a hatványsor együtthatói között?
TFH a $sum_(k = 0) alpha_k(x - a)^k " " (x in RR)$ hatványsor $R$ konvergencisugara pozitív, és jelölje $f$ az összegfüggvényét. Ekkor minden $x in K_R(a)$ pontban $f in D^(infinity){x}$, és bármely $n in N^+$ esetén
$
  f^((n))(x) = sum_(k = n)^(+infinity) k(k - 1) dots (k - n + 1) alpha_k (x - a)^(k - n)
$
Ha $x = a$, akkor
$
  alpha_n = (f^((n))(a))/(n!) "  " (n in NN)
$

\
== Hogyan definiálja egy függvény Taylor-sorát?
Ha a $f in D^(infinity){a}$, akkor a
$
  T_a f(x) := sum_(k = 0) (f^((k))(a))/(k!) (x - a)^k "  " (x in RR)
$
hatványsort az $f$ függvény $a in "int" D_f$ ponthoz tartozó Taylor-sorának, a sor $n$-edik részletösszegét, azaz a
$
  T_(a, n) f(x) := sum_(k = 0)^n (f^((k))(a))/(k!) (x - a)^k "  " (x in RR)
$
polinomot az $f$ függvény $a in "int" D_f$ ponthoz tartozó $n$-edik Taylor-polinomjának nevezzük.\
Az $f$ függvény $a = 0$ ponthoz tartozó Taylor-sorát $f$ Maclauring-sorának is nevezzük.

\
== Fogalmazza meg a Taylor-formula Lagrange maradéktaggal néven tanult tételt!
Legyen $n in NN$\
TFH $f in D^(n + 1)(K(a))$\
Ekkor $forall x in K(a)$ ponthoz $exists$ olyan $a$ és $x$ közé eső $xi$ szám, hogy
$
  f(x) - T_(a, n)f(x) = (f^(n + 1)(xi))/((n + 1)!) (x - a)^(n + 1)
$

\
== Milyen elégséges feltételt ismer a Taylor-sornak a generáló függvényhez való konvergenciájával kapcsolatosan?
Legyen $f in D^(infinity) (K(a))$\
TFH
$
  exists M > 0: abs(f^((n))(x)) <= M (forall x in K(a), forall n in NN)
$
Ekkor $f$-nek az $a$ ponthoz tartozó Taylor-sora a $K(a)$ halmazon előállítja az $f$ függvényt, vagyik fennáll az
$
  f(x) = lim_(n arrow +infinity) sum_(k = 0)^n (f^((k))(a))/(k!) (x - a)^k = sum_(k = 0)^(+infinity) (f^((k))(a))/k! (x - a)^k "  " (x in K(a))
$
egyenlőség

\
== Írja fel az $f(x) = 1/(1 + x) "  " (x in RR, abs(x) < 1)$ függvény Taylor-sorát!
$
  f(x) = 1/(1+x) = sum_(n=0)^(infinity) (-1)^n x^n = 1 - x + x^2 - x^3 + x^4 - dots
$

\
== Írja fel az $f(x) = 1/(1 + x^2) "  " (x in RR, abs(x) < 1)$ függvény Taylor-sorát!
$
  f(x) = 1/(1+x^2) = sum_(n=0)^(infinity) (-1)^n x^(2n) = 1 - x^2 + x^4 - x^6 + x^8 - dots
$
