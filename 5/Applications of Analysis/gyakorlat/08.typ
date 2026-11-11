= Differenciálegyenletek

Innentől kezdődik a második ZH anyaga. A fő témakör itt a differenciálegyenletek.

Vannak olyanok, hogy függvényegyenletek, amikor az értékek között van valamilyen összefüggés. A differenciálegyenletek ehhez hasonlóak, viszont itt a függvény és a deriváltjai közötti összefüggéssel foglalkozunk.

== Explicit közönséges differenciálegyenletek

Először az *explicit közönséges elsőrendű differenciálegyenletekkel* foglalkozunk:
$
  x'(t) = f(t, x(t)), " " t in I subset RR " nyílt intervallum", " " x: I arrow RR^n " és " f: I times RR^n arrow RR^n, " " x in D(I)
$
Ez egyfajta alapesete a differenciálegyenleteknek.

- *explicit*: a derivált explicit ki van fejezve,
- *elsőrendű*: mert csak első derivált van benne,
- *közönséges*: mivel csak egy változó van.

A feladatokban az $I$ nem szokott megadva lenni. A feladat két típusa:

+ Megkeressük az $I$-t úgy, hogy a fentiek teljesüljenek. Próbáljuk meg az $I$-t a lehető legbővebben megadni, mert nyilván a szűkebb is jó lesz.
+ Az egyenlet mellé szoktak adni egy $tau$ kezdeti időpontot és egy $xi in RR^n$ vektort (*kezdetiérték-feladat*), és keressünk olyan $I subset RR$ intervallumot és $x in D(I)$ függvényt, amire
  - $tau in I$,
  - $x(tau) = xi$,
  - teljesül a differenciálegyenlet.

Viszonylag sok tétel szól arról, hogy egy differenciálegyenlet milyen feltételek mellett megoldható, létezik-e megoldás, és egyértelmű-e. Nagyvonalban: $f in C$ a megoldás *létezéséhez* elég; az egyértelműséghez ennél több kell (például hogy $f$ az $x$ szerint folytonosan differenciálható legyen).

=== Példa: kiürülő tartály

Van egy henger alakú tartály, az alján egy lyuk. A magassága legyen $h > 0$. Kezdetben tele van vízzel, és a lyukon kiáramlik a folyadék. A kiáramlás sebessége arányos a pillanatnyi magasság négyzetgyökével. Mennyi idő kell, amíg kiürül a tartály?

Meg kell választani a változókat: $t$ legyen az idő, $x(t)$ pedig a folyadék magassága $t$ idő múlva. Kezdetben $h$ a magasság:
$
  x(0) = h
$
Látjuk, hogy az $x$ függvényre ez egy kezdeti érték, tehát a két felsorolt problématípus közül ez a második lesz, $tau = 0$ és $xi = h$ értékekkel.

*Az $x$ változása.* A derivált megmondja, hogy egy kis intervallumon milyen gyorsan változik egy mennyiség: egy dolog változásának a mértéke a derivált. (A sebesség deriváltja a gyorsulás -- ez most ilyen fizikai okoskodás.) $Delta t$ idő elteltével $x(t)$-ből $x(t + Delta t)$ lesz. A különbség $x(t + Delta t) - x(t)$, a változás sebessége pedig
$
  (x(t + Delta t) - x(t))/(Delta t)
$
Ez akkor ad releváns mennyiséget, ha $Delta t$ nagyon kicsi; sok idő alatt nem mond sokat. Ezért a határértéket nézem:
$
  lim_(Delta t arrow 0) (x(t + Delta t) - x(t))/(Delta t) = x'(t)
$
ami történetesen a derivált definíciója. Tehát
$
  x'(t) = alpha sqrt(x(t)), " ahol " alpha in RR " paraméter"
$
Itt fontos megjegyezni, hogy $sqrt(x(t))$-t csak pozitív előjellel nézem, mert nincs értelme negatív folyadéknak:
$
  x(t) >= 0
$
Ezt kellene megoldani.

Itt van egy trükk, amit később is látni fogunk: ha $x(t)$ értéke valaha nulla lenne, akkor ott a derivált is nulla; az $x equiv 0$ konstans függvény megoldása a differenciálegyenletnek. Elég tehát azokat az eseteket vizsgálni, ahol $x(t) > 0$, azaz még nem folyt ki az összes folyadék. Azért akartuk a pozitivitást, mert akkor (elsőre eléggé nagy trükknek tűnik) leoszthatunk $sqrt(x(t))$-vel:
$
  (x'(t))/sqrt(x(t)) = alpha
$

/ 1. megoldás: (primitív függvénnyel) Tekintsük mindkét oldalt egy-egy függvény deriváltjának:
  $
    K'(t) = l'(t)
  $
  Ez akkor teljesül, ha a két függvény csak konstansban tér el egymástól:
  $
    K(t) = l(t) + C
  $
  Keressük meg a primitív függvényeket, és térjenek el konstansban. Integrálással:
  $
    integral (x'(t))/sqrt(x(t)) dif t = integral (x(t))^(-1/2) dot x'(t) dif t = (x(t)^(1/2))/(1/2) + C = 2 sqrt(x(t)) + C
  $
  (a helyettesítéses integrálás szabálya: $(F compose x)' = (F' compose x) dot x'$). Tehát
  $
    2 sqrt(x(t)) = alpha t + C
  $
  Ennek $C$-től függően végtelen sok megoldása van (bármekkora magasságú tartályra lesz egy megoldás arra, hogy mikor folyik ki), ezért van nekünk kezdeti értékünk.

  Megkínozhatnám magam azzal, hogy kifejezem a gyököt, de akkor figyelnem kellene, hogy mindkét oldal csak nagyobb lehet nullánál, és az $t$ és $C$ valamilyen összefüggése lenne -- ez nem kell nekem. Ilyenkor a fenti alakot *implicit alakú megoldásnak* hívom. Az $x(t)$ kifejezése helyett, ha van $x(0)$ értékünk, azt kell használni:
  $
    x(0) = h > 0, " tehát " t = 0 "-ra " 2 sqrt(x(0)) = alpha dot 0 + C ==> 2 sqrt(h) = C
  $
  A megoldás $2 sqrt(x(t)) = alpha t + 2 sqrt(h)$, azaz
  $
    x(t) = (sqrt(h) + (alpha t)/2)^2, " ahol " alpha < 0 " (mivel csökken " x(t) ")"
  $
  És mi lesz az $I$ intervallum? $I = (-infinity, ?)$, ahol "?" az a pont, ahol kiürül a tartály, azaz $x(t) = 0$:
  $
    x(t) = (sqrt(h) + (alpha t)/2)^2 = 0 <==> sqrt(h) + (alpha t)/2 = 0 <==> t = -(2 sqrt(h))/alpha
  $
  Ennél a pontnál ürül ki a tartály, így
  $
    I = (-infinity, -(2 sqrt(h))/alpha)
  $
  és a tartály kiürülésének ideje $T = -(2 sqrt(h))/alpha = (2 sqrt(h))/abs(alpha)$.

  (Mivel $x equiv 0$ is megoldás, és $x'(T) = 0$, matematikailag a megoldás $T$ után $0$-val folytatható; fizikailag viszont ekkor ürül ki a tartály, ezért az $I$-t itt megállítjuk.)

/ 2. megoldás: (integrálfüggvénnyel) A kezdeti ponttól integrálok $t$-ig, és egy új változóval ($s$) jelölöm az integrációs változót:
  $
    integral_0^t (x'(s))/sqrt(x(s)) dif s = integral_0^t alpha dif s = [alpha s]_0^t = alpha t
  $
  A másik oldalon pedig
  $
    integral_0^t (x'(s))/sqrt(x(s)) dif s = [2 sqrt(x(s))]_0^t = 2 sqrt(x(t)) - 2 sqrt(x(0)) = 2 sqrt(x(t)) - 2 sqrt(h)
  $
  Következésképpen
  $
    2 sqrt(x(t)) - 2 sqrt(h) = alpha t
  $
  Ugyanott vagyunk -- ízlés kérdése, melyiket választjuk.

== Szeparábilis differenciálegyenletek

A fenti az egyik típusú differenciálegyenlet volt: *szeparábilis differenciálegyenlet*. Ezek azok, amik két függvény szorzataként vannak felírva:
$
  x'(t) = g(t) dot h(x(t))
$
A jobb oldalt szét tudom választani ($t$-s és $x$-es részre), ezért szeparábilis.

Tegyük fel, hogy $g in C(I)$ és $h in C(J)$ ($J$ az $x$ értékeinek intervalluma), és $h(x(t)) != 0$. Ekkor (a lokális létezés és egyértelműség mellett) az egyenlet úgy oldható meg, hogy leosztunk $h(x(t))$-vel, és utána például az integrálfüggvényeket használjuk:
$
  (x'(t))/(h(x(t))) = g(t) <==> integral_tau^t (x'(s))/(h(x(s))) dif s = integral_tau^t g(s) dif s
$
és a bal oldal helyettesítéssel:
$
  integral_tau^t (x'(s))/(h(x(s))) dif s = integral_xi^(x(t)) 1/(h(x)) dif x " (ahol " x(tau) = xi ")"
$
Ha úgy tetszik, ez a *megoldóképlet* a szeparábilis differenciálegyenletekre:
$
  integral_xi^(x(t)) 1/(h(x)) dif x = integral_tau^t g(s) dif s
$

/ Példa: Az $x'(t) = alpha sqrt(x(t))$ egyenletre:
  $
    g(t) = alpha, " " h(x) = sqrt(x), " " h(x(t)) = sqrt(x(t))
  $
  és ha $g, h in C$, $h > 0$ (azaz $x > 0$), akkor
  $
    integral_xi^(x(t)) 1/h(x) dif x = integral_xi^(x(t)) 1/sqrt(x) dif x = integral_0^t alpha dif s
  $

=== 1. példa

Oldjuk meg:
$
  y'(x) = x^3/(1 + y(x))^2, " " y(1) = 2
$
Azonnal látjuk, hogy szeparábilis, mivel
$
  y'(x) = underbrace(x^3, g(x)) dot underbrace(1/(1 + y(x))^2, h(y(x)))
$
Mindkettő az összes $x$-re és $y$-ra értelmezhető, egyedül $y = -1$-nél van gond a $h$-val; ezen kívül $h$ értéke soha nem nulla:
$
  g in C(RR), " " h in C(RR ∖ {-1})
$
Ez azt jelenti, hogy ha elképzelek egy koordináta-rendszert, akkor az $y$ nem lehet $-1$. Nekem folytonos függvények kellenek az $I$ intervallumon, és azt kaptuk még feltételnek, hogy $y(1) = 2$: az a megoldás kell, ami átmegy az $(1, 2)$ ponton. Mivel $2 > -1$, az $y > -1$ tartományban dolgozunk:
$
  g(x) = x^3, " " x in RR\
  h(y) = 1/(1 + y)^2, " " y > -1\
  ==> g in C(RR), " " h in C(-1, +infinity), " " h(y) != 0
$
A megoldóképlet ($tau = 1$, $xi = 2$):
$
  integral_2^(y(x)) 1/(h(y)) dif y = integral_1^x g(s) dif s
$
A jobb oldal:
$
  integral_1^x s^3 dif s = [s^4/4]_1^x = x^4/4 - 1/4 = (x^4 - 1)/4
$
a bal oldal pedig:
$
  integral_2^(y(x)) (1 + y)^2 dif y = [(1 + y)^3/3]_2^(y(x)) = (1 + y(x))^3/3 - 27/3 = (1 + y(x))^3/3 - 9
$
Tehát
$
  (1 + y(x))^3/3 - 9 = (x^4 - 1)/4 <==> (1 + y(x))^3 = (3x^4)/4 - 3/4 + 27 = (3x^4 + 105)/4
$
$
  y(x) = root(3, (3x^4 + 105)/4) - 1
$
(Ellenőrzés: $y(1) = root(3, 27) - 1 = 2$.) Mivel $(3x^4 + 105)/4 > 0$, mindig $y > -1$, így $I = RR$.

=== 2. példa

$
  y'(x) = y(x) + y^2(x), " " y(0) = -1/2
$
$
  y'(x) = 1 dot (y(x) + y^2(x))\
  g(x) = 1, " " x in RR\
  h(y) = y + y^2, " " y in RR
$
$
  g in C(RR) " és " h in C(RR)
$
Viszont probléma, hogy $h$ értéke lehet $0$:
$
  h(y) = y + y^2 = 0 <==> y(1 + y) = 0 <==> y = 0 " vagy " y = -1
$
Ezek egyébként a differenciálegyenlet konstans megoldásai. Mivel $y(0) = -1/2$, legyen
$
  g(x) = 1, " " x in RR\
  h(y) = y + y^2, " " y in (-1, 0)
$
ekkor $g in C(RR)$, $h in C(-1, 0)$, $h != 0$, és
$
  integral_(-1/2)^(y(x)) 1/(y + y^2) dif y = integral_0^x 1 dif s = x
$
A másik oldal, parciális törtekre bontással ($1/(y(1 + y)) = 1/y - 1/(y + 1)$):
$
  integral_(-1/2)^(y(x)) 1/(y + y^2) dif y = integral_(-1/2)^(y(x)) (1/y - 1/(y + 1)) dif y = [ln(-y) - ln(y + 1)]_(-1/2)^(y(x))
$
mivel $y + 1 > 0$ miatt $integral 1/(y + 1) dif y = ln(y + 1) + C$, és $y < 0$ miatt $integral 1/y dif y = ln(-y) + C$. A határokat behelyettesítve:
$
  ln(-y(x)) - ln(y(x) + 1) - (ln(1/2) - ln(1/2)) = ln((-y(x))/(1 + y(x))) = x
$
$
  (-y(x))/(1 + y(x)) = e^x ==> y(x) = -e^x/(1 + e^x), " " I = RR
$
(Ellenőrzés: $y(0) = -1/2$, és $y in (-1, 0)$ minden $x$-re.)
