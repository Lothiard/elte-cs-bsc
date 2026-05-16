/ 1): Legyen $X$ diszkrét valószínűségi változó az alábbi eloszlással: $P (X = i) = 1/6$, ahol $i = −2, −1, 0, 1, 2, 3.$

=== a) Határozzuk meg $Y = X^2$ eloszlását és várható értékét! Igaz-e, hogy $E(X^2) = (E X)^2$?:
$Y$ lehetséges értékei a $\{-2, -1, 0, 1, 2, 3\}$ négyzetei: $\{0, 1, 4, 9\}$.
- $P(Y=0) = P(X=0) = 1/6$
- $P(Y=1) = P(X=-1) + P(X=1) = 1/6 + 1/6 = 1/3$
- $P(Y=4) = P(X=-2) + P(X=2) = 1/6 + 1/6 = 1/3$
- $P(Y=9) = P(X=3) = 1/6$
A várható érték kiszámítása:
$
  E Y = 0 dot 1/6 + 1 dot 1/3 + 4 dot 1/3 + 9 dot 1/6 = 1/3 + 4/3 + 3/2 = 5/3 + 3/2 = 19/6
$
Összehasonlítás $(E X)^2$-el:
$
  E X = (-2-1+0+1+2+3)/6 = 3/6 = 0.5 ==> (E X)^2 = 0.25\
  E(X^2) = E Y = 3.16 != 0.25, "tehát az egyenlőség nem áll fenn."
$

=== b) Igaz-e, hogy $E(1/X) = 1/(E X)$?:
Mivel $P(X=0)=1/6$, az $1/X$ változó a $0$ helyen nincs értelmezve, így a várható értéke *nem létezik* (divergens). Az egyenlőség tehát nem értelmezhető és nem igaz.

/ 2): Legyen $X tilde "Bin"(n, p).$ Határozzuk meg $1/(X+1)$ várható értékét!:
$
  E(1/(X+1)) = sum_(k=0)^n 1/(k + 1) dot binom(n, k) p^k (1-p)^(n-k)
$
Használjuk a $1/(k+1) binom(n, k) = 1/(n+1) binom(n+1, k+1)$ azonosságot:
$
  E = sum_(k=0)^n 1/(n + 1) binom(n + 1, k + 1) p^k (1-p)^(n-k) = 1/((n+1)p) sum_(k=0)^n binom(n + 1, k + 1) p^(k+1) (1-p)^(n-k)
$
A szumma egy teljes binomiális eloszlás összege, kivéve a $k+1=0$ tagot:
$
  E = 1/((n + 1)p) dot ( sum_(j=0)^(n+1) binom(n + 1, j) p^j (1-p)^(n+1-j) - binom(n + 1, 0) p^0 (1-p)^(n+1) )\
  E = (1 - (1-p)^(n+1)) / ((n + 1)p)
$

#pagebreak()
/ 3): Határozzuk meg $Y = -log(X)$ sűrűségfüggvényét, ha $X$ valószínűségi változó:
=== a) exponenciális eloszlású ($lambda$):
$F_Y (y) = P(-ln X < y) = P(ln X > -y) = P(X > e^(-y)) = 1 - F_X (e^(-y))$.\
Mivel $X$ exponenciális: $1 - (1 - e^(-lambda e^(-y))) = e^(-lambda e^(-y))$.
$
  f_Y (y) = F_Y '(y) = lambda e^(-y) exp(-lambda e^(-y)), " " y in RR
$

=== b) egyenletes eloszlású az $(a, b)$ intervallumon:
Tegyük fel $a>0$. $F_Y (y) = P(X > e^(-y)) = (b - e^(-y))/(b - a)$ ha $-ln b < y < -ln a$.
$
  f_Y (y) = e^(-y) / (b - a) " az adott intervallumon."
$

/ 4): Legyen $X tilde U(-1, 1)$ és $Y = 2^X$. Határozzuk meg $Y$ sűrűségfüggvényét és várható értékét! Igaz-e, hogy $E(2^X) = 2^(E X)$?:
$X$ sűrűségfüggvénye $f_X (x) = 1/2$ a $[-1, 1]$-en.
$Y = 2^X ==> X = log_2 Y$. Az eloszlásfüggvény: $F_Y (y) = P(X < log_2 y) = (log_2 y - (-1)) / 2 = (log_2 y + 1) / 2$.
$
  f_Y (y) = F_Y '(y) = 1 / (2 y ln 2) " , ha " y in [1/2, 2]
$
A várható érték a LOTUS-tétellel:
$
  E Y = integral_(-1)^1 2^x dot 1/2 dif x = 1/(2 ln 2) [2^x]_(-1)^1 = 1/(2 ln 2) (2 - 0.5) = 0.75 / ln 2\
  2^(E X) = 2^0 = 1. " Mivel " 1.082 != 1, "az egyenlőség nem igaz."
$

/ 5): Legyen $X tilde N(2, 1)$ és $Y = X^5.$ Határozzuk meg $Y$ sűrűségfüggvényét és várható értékét!:
A sűrűségfüggvény transzformációval ($X = Y^(1/5)$):
$
  f_Y (y) = f_X (y^(1/5)) dot |dif/dif y y^(1/5)| = 1/(5 sqrt(2 pi)) y^(-4/5) exp(-(y^(1/5) - 2)^2 / 2)
$
A várható értékhez legyen $X = 2 + Z$, ahol $Z tilde N(0, 1)$:
$
  E Y = E(2 + Z)^5 = E(2^5 + 5 dot 2^4 Z + 10 dot 2^3 Z^2 + 10 dot 2^2 Z^3 + 5 dot 2 Z^4 + Z^5)
$
Mivel a standard normális páratlan momentumai 0-ák, és $E Z^2 = 1, E Z^4 = 3$:
$
  E Y = 32 + 0 + 80 dot 1 + 0 + 10 dot 3 + 0 = 32 + 80 + 30 = 142
$

/ 6): Tegyük fel, hogy az egyetemisták IQ teszten elért eredménye normális eloszlású 105 várható értékkel és 10 szórással. Mi a valószínűsége, hogy valaki 120-nál több pontot ér el a teszten?:
$X tilde N(105, 10^2)$. Standardizálunk:
$
  P(X > 120) = 1 - P(X < 120) = 1 - Phi((120 - 105) / 10) = 1 - Phi(1.5)\
  "Táblázatból " Phi(1.5) = 0.9332 ==> P = 1 - 0.9332 = 0.0668 (6.68%)
$

#pagebreak()
/ 7): Mennyi garanciát adjunk, ha azt szeretnénk, hogy termékeink legfeljebb 10%-át kelljen garanciaidőn belül javítani, ha a készülék élettartama 10 év várható értékű és 2 év szórású normális eloszlással közelíthető?:
$T tilde N(10, 2^2)$. Keressük $g$-t, amire $P(T < g) = 0.1$:
$
  Phi((g - 10) / 2) = 0.1 ==> (g - 10) / 2 = Phi^(-1)(0.1)
$
Mivel $Phi(-x) = 1 - Phi(x)$, tudjuk, hogy $Phi(1.28)$, így $Phi(-1.28)$.
$
  (g - 10) / 2 = -1.28 ==> g = 10 - 2.56 = 7.44 "év"
$

/ 8): Tegyük fel, hogy egy tábla csokoládé tömege normális eloszlású 100 g várható értékkel és 3 g szórással, valamint, hogy az egyes táblák tömege egymástól független. Legalább hány csokoládét csomagoljunk egy dobozba, hogy a dobozban levő táblák átlagos tömege legalább 0.9 valószínűséggel nagyobb legyen 99.5 g-nál?:
Az átlag eloszlása $overline(X)_n tilde N(100, 3^2 / n)$. Feltétel: $P(overline(X)_n > 99.5) >= 0.9$.
$
  1 - Phi((99.5 - 100) / (3 / sqrt(n))) >= 0.9 ==> Phi((0.5 sqrt(n)) / 3) >= 0.9\
  Phi(sqrt(n) / 6) >= 0.9 ==> sqrt(n) / 6 >= 1.28 ==> sqrt(n) >= 7.68\
  n >= 58.98 ==> "Legalább 59 darab csokoládé kell."
$

/ 9): Legyen $X$ standard normális eloszlású. Adjuk meg\ a.) $Y = sigma X + m$;\ b.) $Y = e^X$;\ c.) $Y = X^2$ sűrűségfüggvényét és várható értékét. $P(Y < 1) = ?$\

Alapadat: $X tilde N(0, 1)$, tehát sűrűségfüggvénye $phi(x) = 1/sqrt(2 pi) e^(-x^2/2)$, várható értéke $E X = 0$, szórásnégyzete $D^2 X = 1$

=== a) $Y = sigma X + m$:
Ez a transzformáció egy $m$ várható értékű és $sigma^2$ szórásnégyzetű normális eloszlást eredményez\ ($Y tilde N(m, sigma^2)$)
- *Sűrűségfüggvény:*
$ f_Y (y) = 1/(sigma sqrt(2 pi)) exp(- (y - m)^2 / (2 sigma^2)) $
- *Várható érték:* A várható érték linearitása miatt $E(sigma X + m) = sigma E X + m = sigma dot 0 + m = m$
- *Valószínűség:*
$ P(Y < 1) = P(sigma X + m < 1) = P(X < (1 - m) / sigma) = Phi((1 - m) / sigma) $

#pagebreak()
=== b) $Y = e^X$:
- *Sűrűségfüggvény:* Mivel $X = ln Y$ és a derivált $1/y$:
$ f_Y (y) = f_X (ln y) dot abs(1/y) = 1 / (y sqrt(2 pi)) exp(- (ln y)^2 / 2), " ha " y > 0 $
- *Várható érték:* A LOTUS-tétel alapján $E e^X = integral_(-oo)^oo e^x dot 1/sqrt(2 pi) e^(-x^2/2) dif x$. A kitevő kiegészítésével:
$
  E Y = 1/sqrt(2 pi) integral_(-oo)^oo exp(- (x^2 - 2x) / 2) dif x = e^(1/2) integral_(-oo)^oo 1/sqrt(2 pi) exp(- (x - 1)^2 / 2) dif x = e^(1/2)
$
- *Valószínűség:*
$ P(Y < 1) = P(e^X < 1) = P(X < 0) = Phi(0) = 0,5 $

=== c) $Y = X^2$ (Khi-négyzet eloszlás, $d f=1$):
- *Sűrűségfüggvény:* Az eloszlásfüggvény $F_Y (y) = P(X^2 < y) = P(-sqrt(y) < X < sqrt(y)) = 2 Phi(sqrt(y)) - 1$. Ennek deriváltja:
$ f_Y (y) = 2 dot phi(sqrt(y)) dot 1/(2 sqrt(y)) = 1 / sqrt(2 pi y) e^(-y/2), " ha " y > 0 $
- *Várható érték:* A szórásnégyzet definíciójából adódik, hogy $E X^2 = D^2 X + (E X)^2 = 1 + 0^2 = 1$
- *Valószínűség:*
$ P(Y < 1) = P(X^2 < 1) = P(-1 < X < 1) = Phi(1) - Phi(-1) = 2 Phi(1) - 1 $
A táblázat alapján $Phi(1) approx 0,8413$, így $P = 2 dot 0,8413 - 1 = 0,6826$.
