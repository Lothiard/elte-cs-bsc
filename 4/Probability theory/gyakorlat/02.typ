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
/ 1.): Egy hattagú társaság az étteremben három rántott sajtot, két mátrai borzas csirkemellet, és egy böllér tálat rendel. A pincér a megrendelt ételeket véletlenszerűen osztja szét. Mennyi a valószínűsége, hogy
=== a.) mindenki azt kapja, amit rendelt;
$
  1/((6!)/(3! dot 2! dot 1!))
$

=== b.) senki sem azt kapja, amit rendelt?
$
  ((3!)/(2! dot 1!) dot 1)/((6!)/(3! dot 2! dot 1!))
$

/ 2.): Gerike a Kinder csokoládéban lévő új játékokat, ’Shali baba’ figurákat gyűjt. 10 különböző fajta ilyen baba van, mindegyik Kinder csokoládéba a 10 figura közül véletlenszerűen kerül egy. Gerike nagymamája tudja, hogy ez a gyerek álma, ezért karácsonyra a Jézuskától 20-at rendel a kisfiúnak.
Tegyük fel, hogy Gerikének még nincs otthon Shali babája.
=== a.) Mennyi a valószínűsége, hogy Gerike mind a 10-féle Shali babát begyűjti?
$
  P = (sum_(i = 0)^10 binom(10, i) (-1)^i (10 - i)^20)/(10^20)
$

=== b.) Mi a valószínűsége, hogy éppen a 20. tojás kinyitásánál gyűlik össze a kisfiúnak a 10. fajta baba?
$
  P = (10 dot sum_(i = 0)^9 binom(9, i) (-1)^i (9 - i)^19)/(10^20)
$

/ 3.): Mennyi a valószínűsége, hogy két kockadobásnál mind a két dobás 6-os, azzal a feltétellel, hogy legalább az egyik dobás 6-os?
$
  A = "egyik hatos", "  " B = "mindketto hatos"\
  P(A) = 11/36\
  P(A inter B) = 1/36\
  P(B | A) = (P(A and B))/(P(A)) = (1/36)/(11/36) = 1/11
$

/ 4.): Három különböző kockával dobunk. Mekkora a valószínűsége, hogy az egyik kockával 6-ost dobunk, feltéve, hogy a dobott számok összege 12?
$
  B = "osszeg pontosan 12", "  " A = "pontosan az egyik hatos"\
  P(B) = (3 dot 6 + 2 dot 3 + 1)/(6^3) = 25/6^3\
  P(A inter B) = (2 dot 6 + 3)/(6^3) = 15/6^3\
  P(A | B) = (P(A inter B))/(P(B)) = 15/25 = 3/5
$

/ 5.): Egy érmével annyiszor dobunk, mint amennyi egy szabályos kockadobás eredménye. Mi a valószínűsége, hogy nem kapunk fejet?
$
  A_i: "i-est dobunk (1-6)"\
  B: "nem kapunk fejet"\
  P(B) = sum_(i = 1)^6 P(B | A_i) dot P(A_i) = sum_(i = 1)^6 (1/2)^i dot 1/6 = 1/6 dot (1/2 + 1/2^2 + dots + 1/2^6) = underline(underline(1/6 (1 - 1/2^6)))
$

/ 6.): Mennyi annak a valószínűsége, hogy 3 kockával kétszer dobva, mindkét esetben ugyanazt az eredményt kapjuk, ha
=== a.) a kockák megkülönböztethetőek?
Hogy a második dobás pont ugyanez legyen:
$ P = 1/6^3 approx 0,0046 $

=== b.) a kockák nem különböztethetőek meg?
+ Három különböző szám (20-féle multihalmaz, egyenként $6/216$ eséllyel): $20 dot (6/216)^2$
+ Két egyforma, egy különböző (30-féle multihalmaz, egyenként $3/216$ eséllyel): $30 dot (3/216)^2$
+ Három egyforma (6-féle multihalmaz, egyenként $1/216$ eséllyel): $6 dot (1/216)^2$
$ P = (20 dot 36 + 30 dot 9 + 6 dot 1) / 216^2 approx 0,0213 $

/ 7.): $100$ érme közül az egyik hamis (ennek mindkét oldalán fej van). Egy érmét kiválasztva és azzal $10$-szer dobva, $10$ fejet kaptunk. Ezen feltétellel mi a valószínűsége, hogy a hamis érmével dobtunk?

- $P("Hamis") = 0,01$
- $P(10" fej" | "Hamis") = 1$
- $P("Igazi") = 0,99$
- $P(10" fej" | "Igazi") = (1/2)^10 = 1/1024$

A Bayes-tétel alapján:
$ P("Hamis" | 10" fej") = (1 dot 0,01) / (1 dot 0,01 + 1/1024 dot 0,99) approx 0,9118 $

8.) Egy diák a vizsgán $p$ valószínűséggel tudja a helyes választ. Amennyiben nem tudja, akkor tippel, és $1/3$ a jó válasz esélye. Feltesszük, hogy a diák tudása biztos (azaz ha tudja a választ, akkor az jó is). Határozzuk meg $p$ értékét, ha $3/5$ annak a valószínűsége, hogy amennyiben helyesen válaszolt, tudta is a helyes választ!

- Tudja: $p$, esély a jó válaszra: $1$.
- Tippel: $1-p$, esély a jó válaszra: $1/3$.
$ P("Tudta" | "Jó válasz") = (1 dot p) / (1 dot p + 1/3 dot (1-p)) = 3/5 $
$ 5p = 3p + 1 - p => 3p = 1 => p = 1/3 $

#pagebreak()
9.) Vándorlásai közben Odüsszeusz egy hármas útelágazáshoz ér. Az egyik út Athénbe, a másik Spártába, a harmadik Mükénébe vezet. Az athéniek kereskedő népség, szeretik ámítani a látogatókat, csak minden $3$. alkalommal mondanak igazat. A mükénéiek egy fokkal jobbak: ők csak minden második alkalommal hazudnak. A szigorú spártai neveltetésnek köszönhetően a spártaiak becsületesek, ők mindig igazat mondanak. Odüsszeusznak fogalma sincs, melyik út merre vezet, így feldob egy kockát, egyenlő esélyt adva mindegyik útnak. Megérkezve a városba, megkérdez egy embert, mennyi $2 dot 2$, mire közlik vele, hogy $4$. Mi a valószínűsége, hogy Odüsszeusz Athénba jutott?

- $P(A) = P(M) = P(S) = 1/3$
- $P("Igaz" | A) = 1/3$, $P("Igaz" | M) = 1/2$, $P("Igaz" | S) = 1$
$ P("Igaz") = 1/3 dot 1/3 + 1/3 dot 1/2 + 1/3 dot 1 = 11/18 $
$ P(A | "Igaz") = (1/3 dot 1/3) / (11/18) approx 0,1818 $

10.) Négyen lőnek egymás után egy céltáblára. A résztvevők találati valószínűségei egymástól függetlenül, sorrendben $3/4$, $1/2$, $2/3$. Ketten érnek el találatot. Mi a valószínűsége, hogy a második elhibázta a lövést?

A találati esélyek: $p_1=3/4$, $p_2=1/2$, $p_3=2/3$. A tévesztések: $q_1=1/4$, $q_2=1/2$, $q_3=1/3$.
Pontosan 2 találat ($T_2$) esélye:
$ P(T_2) = p_1 p_2 q_3 + p_1 q_2 p_3 + q_1 p_2 p_3 = 3/24 + 6/24 + 2/24 = 11/24 $
$ P("2. hibázott" | T_2) approx 0,5455 $

11.) Milyen $n > 1$-re lesz független
=== a.) az a két esemény, hogy $A: n$ érmedobásból van fej és írás is, valamint $B:$ legfeljebb egy írás van.
Esemény $A$: van fej és írás is $arrow P(A) = 1 - 2/2^n$.
$P(B) = (1+n)/2^n$. Metszet ($A inter B$): pontosan egy írás -> $P = n/2^n$.
Függetlenség feltétele:
$ (1 - 2/2^n) (n+1)/2^n = n/2^n => 2^n = 2n + 2 => *n = 3* $

=== b.) az a két esemény, hogy $A: n$ érmedobásból van fej és írás is, valamint $B:$ az első dobás fej.
Esemény $A$: van fej és írás is $arrow P(A) = 1 - 2/2^n$.
$P(B) = 1/2$. Metszet: az első fej, de van legalább egy írás -> $P = 1/2 (1 - 1/2^(n-1)) = 1/2 - 1/2^n$.
$ (1 - 2/2^n) 1/2 = 1/2 - 1/2^n $
Ez az egyenlőség *minden $n > 1$* esetén igaz.

#pagebreak()
12.) Osztozkodási probléma: hogyan osztozzon a téten két játékos, ha 2:1 állásnál félbeszakadt a $4$ győzelemig tartó mérkőzésük? (Tfh. az egyes játékok egymástól függetlenek, bármelyikük $1/2$ valószínűséggel nyerhet az egyes játékoknál.)

Az első játékosnak $2$, a másodiknak $3$ meccset kell nyernie. Legfeljebb $4$ meccs van hátra.
$ P("1. nyer") = sum_(k=2)^4 binom(4, k) (1/2)^4 = (6 + 4 + 1) / 16 = 11/16 $
A tétet *11:5* arányban kell elosztani.

13.) Adjuk meg annak a valószínűségi változónak az eloszlását, ami egy hatgyermekes családban a fiúk számát adja meg. Tegyük fel, hogy mindig $1/2$ - $1/2$ a fiúk, ill. a lányok születési valószínűsége, és az egyes születések függetlenek egymástól.

Jelölje a fiúk számát $X$. Az eloszlás (Binomiális):
$ P(X=k) = binom(6, k) (1/2)^6 = binom(6, k) / 64 quad (k = 0, 1, ..., 6) $

14.) Jelölje $p_k$ annak a valószínűségét, hogy egy lottóhúzásnál $(90/5)$ a legnagyobb kihúzott szám $k$.
Számítsuk ki a $p_k$ értékeket, és mutassuk meg, hogy ez valóban valószínűségi eloszlás!

$ p_k = binom(k-1, 4) / binom(90, 5) quad (k in {5, 6, ..., 90}) $
Ez eloszlás, mert a "hokiütő-szabály" alapján: $sum_(k=5)^90 binom(k-1, 4) = binom(90, 5)$.

15.) Két doboz közül az elsőben $k$ piros és $l$ zöld golyó van, a másodikban $k$ zöld és $l$ piros. Visszatevéssel húzunk az alábbi szabály szerint: ha a kihúzott golyó piros, akkor a következő húzásnál az első dobozből; ha zöld, akkor a második dobozból húzunk. Először az első dobozból húzunk. Mennyi a valószínűsége, hogy az $n$. húzásnál piros golyót húzunk? Mihez tart ez a valószínűség, ha $n arrow infinity$?

Jelölje $p_n$ annak esélyét, hogy az $n$. húzás piros:
$ p_n = p_(n-1) (k / (k+l)) + (1 - p_(n-1)) (l / (k+l)) $
A rekurzió zárt alakja ($p_1 = k/(k+l)$):
$ p_n = 1/2 + 1/2 ((k-l)/(k+l))^n $
Ha $n -> infinity$, a valószínűség *$1/2$*-hez tart.
