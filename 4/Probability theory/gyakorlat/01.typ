= 1) Mi a valószínűsége, hogy egy véletlenszerűen kiválasztott 6 jegyű szám jegyei mind különbözőek?
$
  (9 dot 9 dot 8 dot 7 dot 6 dot 5)/(9 dot 10^5)
$

= 2) Hányféleképpen lehet 8 bástyát letenni egy sakktáblára, hogy ne üssék egymást?
$
  8!
$

= 3) 2 számozott érmével dobunk, majd még annyi érmével, ahány fejet az első két érmével kaptunk. Mik lesznek az eseménytér elemei?
$
  Omega = {{I, I}, {F, I, I}, {F, I, F}, {I, F, I}, {I, F, F}, {F, F, I, I}, {F, F, I, F}, {F, F, F, I}, {F, F, F, F}}\
  // Omega = {0, 1}^4
$

= 4) Legyen A,B,C három esemény. Írjuk fel annak az eseménynek a valószínűségét, hogy közülük
=== a.) pontosan k
$
  P("pontosan 1") = P((A inter overline(B) inter overline(C)) union (overline(A) inter B inter overline(C)) union (overline(A) inter overline(B) inter C))\
  P("pontosan 2") = P((A inter B inter overline(C)) union (A inter overline(B) inter C) union (overline(A) inter B inter C))\
  P("pontosan 3") = P(A inter B inter C)\
$
altalanosan:
$
  "legyen" A_1, dots, A_n "esemenyek"\
  P("pontonsan k") = P(union.big_(i_1, dots, i_k)(inter.big_(j = 1)^k A_i_j)) minus (union.big_(l in.not {i_1, dots, i_k}) A_l)
$

=== b.) legfeljebb k esemény következik be (k = 1, 2, 3)).
$
  P("legfeljebb 1") = P("pontosan 0 vagy 1") =\ = P(overline(A) inter overline(B) inter overline(C)) union P((A inter overline(B) inter overline(C)) union (overline(A) inter B inter overline(C)) union (overline(A) inter overline(B) inter C))\
  dots.v
$

= 5) A német labdarúgó válogatott edzésének megkezdése előtt, az edzésen résztvevő 20 mezőnyjátékost két csoportba osztják. Mi annak a valószínűsége, ha találomra történik a szétosztás a két 10-es csoportba, hogy Schweinsteiger és Özil egymás ellen játszik?
$
  P = (binom(18, 9))/(binom(20, 10))
$

#pagebreak()
= 6) De Méré problémája, 1654.
= De Méré lovag nagy szerencsejátékos volt, az alábbi két kérdéssel fordult Pascal-hoz:
    - Ha egy kockát 4-szer feldobunk, akkor mi annak a valószínűsége, hogy legalább egy hatos dobás lesz?
    - Ha két kockát 24-szer feldobunk, mi annak a valószínűsége, hogy legalább egy dupla hatos lesz?

=== a.) Számítsuk ki a két valószínűség pontos értékét!
$
    P("elso") = 1 - (5/6)^4 = 0,5177469136\
    P("masodik") = 1 - (35/36)^24 = 0,4914038761\
$

=== b.) A két valószínűség miért van közel egymáshoz?
$
    1 - (5/6)^4 = 1 - (1 - 1/6)^(2/3 dot 6)\
    1 - (35/36)^24 = 1 - (1 - 1/36)^(2/1 dot 36)\
    (1 - 1/n)^(3/2 dot n) arrow_(n arrow infinity) 1/e^(2/3)
$

= 7) Mintavétel: Adott N különböző termék, amik között van M selejtes. Veszünk n elemű mintát
Mennyi a valószínűsége, hogy az n termékből pontosan k selejtest sikerült kiválasztanunk?
=== a.) visszatevés nélkül;
$
    P = (binom(M, k) binom(N - M, n - k))/binom(N, n)
$

=== b.) visszatevéssel.
$
    P = (binom(n, k) M^k (N - M)^(k))/(N^n)
$

= 8) A $(0, 1)$ intervallumot felosztjuk két véletlenül rádobott pont segítségével $3$ részre. Mennyi a valószínűsége, hogy
=== a.) mindhárom szakasz hossza rövidebb $1/2$ -nél;
$
    dots
$

=== b.) a 3 szakaszból háromszög alkotható;
$

$

=== c.) a legrövidebb szakasz hossza rövidebb $1/5$ -nél?
$

$
