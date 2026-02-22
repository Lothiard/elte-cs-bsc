/ 1: Mennyi annak a valószínűsége, hogy a kenóhúzás során (80-ból 20 kihúzása) legalább kétszer több a páros, mint a páratlan? A megoldást mind pontos alakban (nem feltétlenül zárt alak), mind számszerű alakban add meg 4 tizedesjegyre kerekítve


Legyen a kihúzott páros számok száma $k$. Ebből a páratlan számok száma $20 - k$.
$
  k >= 2(20 - k)\
  k >= 40 - 2k\
  k >= 40/3 = 13.33 dots
$

Tehát a húzott páros számok száma $14$ és $20$ közé kell essen. ($14 <= k <= 20$).
$
  P = sum_(k = 14)^20 (binom(40, 4) binom(40, 20 - k))/(binom(80, 20)) approx 0.0346
$

#pagebreak()
/ 2: Mutassuk meg, hogy amennyiben $A_1, dots, A_n$ tetszőleges események, akkor $P(inter.big_(i = 1)^n A_i) >= sum_(i = 1)^n P(A_i) - n + 1$
A De Morgan azonosságok szerint
$
  (inter.big_(i = 1)^n A_i)^(complement) = union.big_(i = 1)^n A_i^complement
$
Tudjuk, hogy tetszőleges események uniójának valószínűsége sosem nagyobb a valószínűségeik összegénél.
$
  P(union.big_(i = 1)^n A_i^complement) <= sum_(i = 1)^n P(A_i^complement)
$
Mivel bármely $E$ esemény komplementerének valószínűsége $P(E^complement) = 1 - P(E)$, ezért

- bal oldalon
$
  P(union.big_(i = 1)^n A_i^complement) = P((inter.big_(i = 1)^n A_i)^complement) = 1 - P(inter.big_(i = 1)^n A_i)\
$
- jobb oldalon
$
  sum_(i = 1)^n P(A_i^complement) = sum_(i = 1)^n (1 - P(A_i)) = n - sum_(i = 1)^n P(A_i)
$

Behelyettesítve
$
  1 - P(inter.big_(i = 1)^n A_i) <= n - sum_(i = 1)^n P(A_i)
$

Átrendezve
$
  1 - n + sum_(i = 1)^n P(A_i) <= P(inter.big_(i = 1)^n A_i) <==> P(inter.big_(i = 1)^n A_i) >= sum_(i = 1)^n P(A_i) - n + 1
$
$qed$
