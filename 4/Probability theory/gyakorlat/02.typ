== felteteles valoszinuseg
$
  P(A | B) = (P(A and B))/(P(B))
$
"A valoszinusege, felteve hogy B mar megtortent"

== fuggetlenseg
$
  P(A and B) = P(A) dot P(B)
$
"A, B fuggetlen"

$ P(B) > 0 <==> P(A | B) = P(A) $

"ha tudjuk az egyiket akkor a masikbol nem nyertunk semmi informaciot"

=== "kizaro": $A inter B = nothing$, $P(A union B) = P(A) + P(B)$

=== "felteteles": $P(A inter B) = P(A)P(B)$

$
  A_1, dots, A_n in cal(A) "feltetelek"\ forall k <= n;\ 1 <= i_1 < dots < i_k <= n\
  P(inter.big_(0 = i)^k A_i_j) = product_(j = i)^k P(A_i_j)
$

== Bayes-tetel
=== egyszerubb alak
$
  P(A | B) = (P(B | A)P(A))/(P(B))
$

=== masik alak (teljes valoszinuseg tetele)
ha van nehany esemeny ami teljes esemenyrendszer (tehat diszjunk esemenyek, semelyik kettonek nincs trivialis metszet es egyuttesen lefedik az egesz teret) es B tetszoleges esemeny (pozitiv valoszinuseggel) akkor
$
  A_1, dots, A_n in cal(A) \ B in cal(A)\ P(A_i) > 0\ P(B) = sum_i P(B | A) dot P(A_i)\
  P(A | B) = (P(B | A) dot P(A))/(P(B | A) dot P(A) + P(B | overline(A)) dot P(overline(A)))
$

#pagebreak()
= gyakorlat
/ 3: Mennyi a valószínűsége, hogy két kockadobásnál mind a két dobás 6-os, azzal a feltétellel, hogy legalább az egyik dobás 6-os?
$
  A = "egyik hatos", "  " B = "mindketto hatos"\
  P(A) = 11/36\
  P(A inter B) = 1/36\
  P(B | A) = (P(A and B))/(P(A)) = (1/36)/(11/36) = 1/11
$

/ 4: Három különböző kockával dobunk. Mekkora a valószínűsége, hogy az egyik kockával 6-ost dobunk, feltéve, hogy a dobott számok összege 12?
$
  B = "osszeg pontosan 12", "  " A = "pontosan az egyik hatos"\
  P(B) = (3 dot 6 + 2 dot 3 + 1)/(6^3) = 25/6^3\
  P(A inter B) = (2 dot 6 + 3)/(6^3) = 15/6^3\
  P(A | B) = (P(A inter B))/(P(B)) = 15/25 = 3/5
$

/ 5: Egy érmével annyiszor dobunk, mint amennyi egy szabályos kockadobás eredménye.
Mi a valószínűsége, hogy nem kapunk fejet?
$
  A_i: "i-est dobunk (1-6)"\
  B: "nem kapunk fejet"\
  P(B) = sum_(i = 1)^6 P(B | A_i) dot P(A_i) = sum_(i = 1)^6 (1/2)^i dot 1/6 = 1/6 dot (1/2 + 1/2^2 + dots + 1/2^6) = underline(underline(1/6 (1 - 1/2^6)))
$

/ 6:
Mennyi annak a valószínűsége, hogy 3 kockával kétszer dobva, mindkét esetben ugyanazt az eredményt kapjuk, ha
=== a.) a kockák megkülönböztethetőek?
$
  P = (1/6)^3
$

=== b.) a kockák nem különböztethetőek meg?
$$
