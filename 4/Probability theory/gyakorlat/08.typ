/ 1): Egy $52$ lapos francia kártyacsomagból húzunk $2$ lapot visszatevés nélkül. Legyen $X$ a kőrök, $Y$ pedig az ászok száma. Adjuk meg $X$ és $Y$ korrelációs együtthatóját. Függetlenek-e ezek a változók?
=== Kovariancia meghatározása:
Használjuk az indikátor változókat: $X = I_(H 1) + I_(H 2)$ és $Y = I_(A 1) + I_(A 2)$.
A kovariancia linearitása miatt:
$ "cov"(X, Y) = "cov"(I_(H 1) + I_(H 2), I_(A 1) + I_(A 2)) = 2 "cov"(I_(H 1), I_(A 1)) + 2 "cov"(I_(H 1), I_(A 2)) $
- Egy lap esetén: $P(H) = 1/4, P(A) = 1/13$. Mivel $P(H inter A) = 1/52 = P(H)P(A)$, ezért *$"cov"(I_(H 1), I_(A 1)) = 0$*.
- Két különböző lap esetén: $P(H_1 inter A_2) = 1/52$ (számolható a teljes valószínűség tételével), és $P(H_1)P(A_2) = 1/52$.
Így $"cov"(X, Y) = 0$, amiből következik, hogy *$R(X, Y) = 0$*.

=== Függetlenség:
A változók *nem függetlenek*. Például $P(X=2, Y=2) = 0$, mert csak egy kőr ász van a csomagban, így nem lehet egyszerre két kőr és két ász a két lap között. Mivel $P(X=2)P(Y=2) > 0$, a függetlenség nem áll fenn.

/ 2): Legyen $X$ és $Y$ független, azonos eloszlású, véges szórású változók. Mennyi $R(X, a X + b Y)$?
Legyen $D X = D Y = sigma$ és $E X = E Y = m$.
- *Kovariancia:* $"cov"(X, a X + b Y) = a "cov"(X, X) + b "cov"(X, Y)$. Mivel függetlenek, $"cov"(X, Y) = 0$, így a számláló *$a sigma^2$*.
- *Szórások:* $D X = sigma$. Az összeg szórása: $D(a X + b Y) = sqrt(a^2 sigma^2 + b^2 sigma^2) = sigma sqrt(a^2 + b^2)$.
- *Korreláció:*
$ R = (a sigma^2) / (sigma dot sigma sqrt(a^2 + b^2)) = a / sqrt(a^2 + b^2) $

/ 3): $R(U, V) = -0.75$; $E U = 4; E V = 6; D(U) = D(V) = 1/sqrt(2)$. Becsüljük alulról a $P(8 < U + V < 12)$ valószínűséget!
=== Paraméterek kiszámítása:
- $E(U + V) = 4 + 6 = 10$.
- $D^2(U + V) = D^2 U + D^2 V + 2 R(U, V) D U D V = 1/2 + 1/2 + 2(-0.75)(1/sqrt(2))(1/sqrt(2)) = 1 - 0.75 = 0.25$.
=== Csebisev-becslés:
A keresett valószínűség $P(|(U + V) - 10| < 2) = 1 - P(|(U + V) - 10| >= 2)$.
$ P(|(U + V) - 10| >= 2) <= (D^2(U + V)) / 2^2 = 0.25 / 4 = 0.0625 $
Így $P > 1 - 0.0625 = 0.9375 " " (93,75%)$.

#pagebreak()
/ 4): Legyen $X_n n$ paraméterű Poisson eloszlású. Mihez tart $n arrow infinity$ esetén:
=== a) $P(X_n < n)$:
A Centrális Határeloszlástétel (CHT) alapján $X_n$ közelíthető $N(n, n)$ eloszlással. $ P(X_n < n) = P((X_n - n) / sqrt(n) < 0) arrow Phi(0) = 0.5 $

=== b) $P(X_n < n - n^(1/2))$:$ P(X_n < n - sqrt(n)) = P((X_n - n) / sqrt(n) < -1) arrow Phi(-1) = 1 - Phi(1) $

/ 5): Legyen $X_n tilde B(n, p_n)$. Mihez tart $n arrow infinity$ esetén:
- *a) $X_n / n$, ha $p_n = p$:* A Nagy Számok Gyenge Törvénye alapján a relatív gyakoriság *$p$*-hez tart.
- *b) $P(X_n < n p - n^(1/2))$, ha $p_n = p$:*
  Standardizálva: $ P((X_n - n p) / sqrt(n p q) < (-sqrt(n)) / sqrt(n p q)) = P(Z < -1 / sqrt(p q)) arrow Phi(- 1 / sqrt(p q)) $
- *c) $P(X_n < 2)$, ha $p_n = 1/n$:*
  A Poisson-közelítés miatt $X_n$ határeloszlása $P o i(1)$.
  $ P(X_n < 2) = P(X_n = 0) + P(X_n = 1) arrow e^(-1) + e^(-1) = 2/e approx 0.7358 $
- *d) $P(X_n = k)$, ha $p_n = 1/n$:* *$e^(-1) / k!$* (a $lambda=1$ paraméterű Poisson-eloszlás súlyfüggvénye).

/ 6): Egy életbiztosító társaságnak $10000$ biztosítottja van, tegyük fel, hogy ők egyforma korúak és egészségűek. $1%$ annak a valószínűsége, hogy egy ilyen személy az év folyamán meghal. Minden biztosított az év elején $11$ ezer Ft-ot fizet be, halála esetén pedig hozzátartozói $1$ millió Ft-ot kapnak a biztosítótól. Mi a valószínűsége, hogy a biztosító egy évben ezen biztosításra vonatkozóan nem lesz veszteséges?

=== Modell felírása:
Legyen $X$ a halálozások száma, $X tilde B(10000, 0.01)$.
Bevétel: $10000 dot 11000 = 110$ millió Ft.
Kifizetés: $X dot 1$ millió Ft.
Nem veszteséges, ha $110 >= X$.
=== Közelítés:
$E X = 10000 dot 0.01 = 100$, $D^2 X = 10000 dot 0.01 dot 0.99 = 99$.
A CHT alapján standardizálunk:
$ P(X <= 110) = P((X - 100) / sqrt(99) <= (110 - 100) / sqrt(99)) approx Phi(10 / 9.95) approx Phi(1.005) $
A táblázatból *$Phi(1.00) approx 0.8413$*, tehát a valószínűség kb. *84%*.
