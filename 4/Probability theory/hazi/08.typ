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
