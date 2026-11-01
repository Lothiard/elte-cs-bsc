= Inverzfüggvény-tétel és implicitfüggvény-tétel

== Az inverzfüggvény-tétel elméleti háttere

=== Egyváltozós felidézés és motiváció

Egyváltozós esetben ($f: RR arrow RR$) ha $f$ invertálható, az $a$ pontban differenciálható, ahol $f'(a) != 0$, és az inverz folytonos a $b = f(a)$ pontban (például ha $f$ folytonos és szigorúan monoton egy intervallumon), akkor a $b$ pontban az $f^(-1)$ inverz függvény is differenciálható, és a deriváltja:
$
  (f^(-1))'(b) = 1/(f'(a)) = 1/(f'(f^(-1)(b)))
$

*Geometriai jelentés:* Az $f$ grafikonjának $(a, b)$ pontbeli érintőjének meredeksége $f'(a)$. Az inverz függvény grafikonján a megfelelő pont $(b, a)$. Az inverz érintőjének meredeksége az eredeti érintő meredekségének reciproka ($1/(f'(a))$), ami az $y = x$ egyenesre vonatkozó tükrözésből következik.

=== Többváltozós kiterjesztés és lokális invertálhatóság

Többváltozós függvények esetén ($f: RR^n arrow RR^n$) a globális invertálhatóság (hogy a teljes értelmezési tartományon kölcsönösen egyértelmű legyen a függvény) túlságosan szigorú feltétel, ami a gyakorlatban ritkán teljesül. Ezért a többváltozós analízisben és a numerikus módszerekben *lokális invertálhatóságról* beszélünk.

*Definíció (lokális invertálhatóság).* Az $f: RR^n arrow RR^n$ függvény az $a in "int"(D_f)$ pontban *lokálisan invertálható*, ha létezik az $a$ pontnak olyan $U subset D_f$ környezete és a $b = f(a)$ pontnak olyan $V$ környezete, hogy az $f|_U : U arrow V$ leszűkítés bijekció (kölcsönösen egyértelmű leképezés).

=== Az inverzfüggvény-tétel kimondása

Legyen $D subset RR^n$ nyílt halmaz, $f: D arrow RR^n$ folytonosan differenciálható függvény ($f in C^1 (D, RR^n)$). Ha valamely $a in D$ pontban a Jacobi-mátrix determinánsa nem nulla:
$
  det f'(a) != 0
$
akkor:

+ Az $f$ függvény lokálisan invertálható az $a$ pont egy $U subset D$ környezetében.
+ A $b = f(a)$ pont $V = f(U)$ környezetén értelmezett $f^(-1): V arrow U$ lokális inverz függvény folytonosan differenciálható ($f^(-1) in C^1 (V, RR^n)$).
+ A lokális inverz Jacobi-mátrixa tetszőleges $y in V$ pontban a megfelelő $x = f^(-1)(y) in U$ pontbeli Jacobi-mátrix *mátrixinverze*:
  $
    (f^(-1))'(y) = [f'(f^(-1)(y))]^(-1)
  $
  Különösen a $b = f(a)$ helyen:
  $
    (f^(-1))'(b) = [f'(a)]^(-1)
  $

/ Megjegyzés: Az egyváltozós reciprokképzés ($1/(f'(a))$) többváltozós megfelelője a *Jacobi-mátrix inverzének* kiszámítása ($[f'(a)]^(-1)$).

=== Segédképlet: $2 times 2$-es mátrix inverze

Egy $M = mat(A, B; C, D)$ mátrix inverze (ha $det M = A D - B C != 0$):
$
  M^(-1) = 1/(det M) mat(D, -B; -C, A) = 1/(A D - B C) mat(D, -B; -C, A)
$
*Szabály:* a főátló elemeit felcseréljük ($A <-> D$), a mellékátló elemeit pedig megszorozzuk $(-1)$-gyel (előjelet váltanak), majd leosztunk a determinánssal.

== Az inverzfüggvény-tétel feladatai

=== 1. feladat

Tekintsük az alábbi $f: RR^2 arrow RR^2$ függvényt:
$
  f(x, y) := (e^x cos(y), " " e^x sin(y))
$
+ Vizsgáljuk meg a globális és lokális invertálhatóságot!
+ Mutassuk meg, hogy az $a = (0, pi/3)$ pontban a függvény lokálisan invertálható!
+ Számítsuk ki a lokális inverz deriváltját a $b = f(a)$ pontban!
+ Írjuk fel a lokális inverz függvényt explicit módon is az $a$ pont környezetében, és ellenőrizzük az eredményt!

*Megoldás.*

*1. Globális invertálhatóság.* A függvény geometriailag a polárkoordinátás átváltáshoz hasonlít ($r = e^x$, $phi = y$).
- Nem globálisan invertálható, mert $y$-ban $2pi$ szerint periodikus:
  $
    f(x, y + 2k pi) = f(x, y) " " (forall k in ZZ)
  $
  tehát végtelen sok különböző helyen veszi fel ugyanazt az értéket.
- Értékkészlete $R_f = RR^2 ∖ {(0, 0)}$, mert $e^x > 0$, így az origót nem tudja felvenni.

*2. Lokális invertálhatóság.* A Jacobi-mátrix egy tetszőleges $(x, y)$ pontban:
$
  f'(x, y) = mat(partial_x f_1, partial_y f_1; partial_x f_2, partial_y f_2) = mat(e^x cos(y), -e^x sin(y); e^x sin(y), e^x cos(y))
$
A determináns:
$
  det f'(x, y) = (e^x cos(y))(e^x cos(y)) - (-e^x sin(y))(e^x sin(y)) = e^(2x) cos^2(y) + e^(2x) sin^2(y) = e^(2x)
$
Mivel $e^(2x) > 0$ minden $(x, y) in RR^2$ esetén, a $det f'(x, y) != 0$ feltétel *mindenhol* teljesül. Így a függvény *bármely* $(x, y) in RR^2$ pont környezetében lokálisan invertálható.

*3. Derivált az $a = (0, pi/3)$ pontban.* A $b = f(a)$ érték:
$
  b_1 = e^0 cos(pi/3) = 1 dot 1/2 = 1/2\
  b_2 = e^0 sin(pi/3) = 1 dot sqrt(3)/2 = sqrt(3)/2
$
tehát $b = (1/2, sqrt(3)/2)$. A Jacobi-mátrix értéke $a$-ban:
$
  f'(0, pi/3) = mat(cos(pi/3), -sin(pi/3); sin(pi/3), cos(pi/3)) = mat(1/2, -sqrt(3)/2; sqrt(3)/2, 1/2)
$
Determinánsa: $det f'(0, pi/3) = e^(2 dot 0) = 1$. A lokális inverz deriváltja a $b$ pontban a Jacobi-mátrix inverze:
$
  (f^(-1))'(b) = [f'(a)]^(-1) = 1/1 mat(1/2, sqrt(3)/2; -sqrt(3)/2, 1/2) = mat(1/2, sqrt(3)/2; -sqrt(3)/2, 1/2)
$

*4. Explicit lokális inverz és ellenőrzés.* Legyen $u = e^x cos(y)$ és $v = e^x sin(y)$.
- A két egyenlet négyzetösszege:
  $
    u^2 + v^2 = e^(2x) cos^2(y) + e^(2x) sin^2(y) = e^(2x) ==> x = 1/2 ln(u^2 + v^2)
  $
- A két egyenlet hányadosa (mivel $u > 0$ a $b$ pont környezetében):
  $
    v/u = (e^x sin(y))/(e^x cos(y)) = "tg"(y) ==> y = op("arctg")(v/u) + k pi
  $
  Mivel $y_0 = pi/3 in (-pi/2, pi/2)$, a főágat választjuk ($k = 0$): $y = op("arctg")(v/u)$.

Tehát az explicit lokális inverz leképezés:
$
  f^(-1)(u, v) = (1/2 ln(u^2 + v^2), " " op("arctg")(v/u))
$
Deriváljuk ezt közvetlenül az $u, v$ szerint:
$
  partial_u x = 1/2 dot (2u)/(u^2 + v^2) = u/(u^2 + v^2), " " partial_v x = 1/2 dot (2v)/(u^2 + v^2) = v/(u^2 + v^2)\
  partial_u y = 1/(1 + (v/u)^2) dot (-v/u^2) = (-v)/(u^2 + v^2), " " partial_v y = 1/(1 + (v/u)^2) dot 1/u = u/(u^2 + v^2)
$
Behelyettesítve $(u, v) = (1/2, sqrt(3)/2)$-t, ahol $u^2 + v^2 = 1/4 + 3/4 = 1$:
$
  partial_u x = 1/2, " " partial_v x = sqrt(3)/2, " " partial_u y = -sqrt(3)/2, " " partial_v y = 1/2
$
Így a kapott Jacobi-mátrix:
$
  (f^(-1))'(b) = mat(1/2, sqrt(3)/2; -sqrt(3)/2, 1/2)
$
Ez pontosan megegyezik a tételből kapott eredményünkkel.

=== 2. feladat

Tekintsük az $f: RR^2 ∖ {(0, 0)} arrow RR^2$ függvényt:
$
  f(x, y) := (x sqrt(x^2 + y^2), " " y sqrt(x^2 + y^2))
$
+ Mutassuk meg, hogy az $a = (4, -3)$ pontban $f$ lokálisan invertálható!
+ Számítsuk ki a lokális inverz deriváltját a $b = f(a)$ pontban!

*Megoldás.*

*1. Folytonos differenciálhatóság és Jacobi-mátrix.* Az origót kivéve a gyökös kifejezések $C^1$ osztályúak. A komponensek deriváltjai:
$
  partial_x f_1 = sqrt(x^2 + y^2) + x dot (2x)/(2 sqrt(x^2 + y^2)) = sqrt(x^2 + y^2) + x^2/sqrt(x^2 + y^2) = (2x^2 + y^2)/sqrt(x^2 + y^2)\
  partial_y f_1 = x dot (2y)/(2 sqrt(x^2 + y^2)) = (x y)/sqrt(x^2 + y^2)\
  partial_x f_2 = (x y)/sqrt(x^2 + y^2), " " partial_y f_2 = (x^2 + 2y^2)/sqrt(x^2 + y^2)
$
Az $a = (4, -3)$ pontban $sqrt(4^2 + (-3)^2) = sqrt(25) = 5$:
$
  partial_x f_1 (4, -3) = (2 dot 16 + 9)/5 = 41/5, " " partial_y f_1 (4, -3) = (4 dot (-3))/5 = -12/5\
  partial_x f_2 (4, -3) = -12/5, " " partial_y f_2 (4, -3) = (16 + 2 dot 9)/5 = 34/5
$
Így
$
  f'(4, -3) = mat(41/5, -12/5; -12/5, 34/5)
$
$
  det f'(4, -3) = 41/5 dot 34/5 - (-12/5)(-12/5) = (1394 - 144)/25 = 1250/25 = 50 != 0
$
Az inverzfüggvény-tétel értelmében $f$ az $a = (4, -3)$ pont környezetében *lokálisan invertálható*.

*2. A lokális inverz deriváltja.* A $b = f(a)$ érték:
$
  b = f(4, -3) = (4 dot 5, -3 dot 5) = (20, -15)
$
$
  (f^(-1))'(20, -15) = [f'(4, -3)]^(-1) = 1/50 mat(34/5, 12/5; 12/5, 41/5) = mat(17/125, 6/125; 6/125, 41/250)
$

=== 3. feladat

Tekintsük az alábbi egyenletrendszert:
$
  cases(
    e^(x - 1) + x sin(y) = u,
    e^(x - 1) - x cos(y) = v
  )
$
Igazoljuk, hogy az $(x_0, y_0) = (1, pi/4)$ megoldásponthoz tartozó $(u_0, v_0) = (1 + sqrt(2)/2, 1 - sqrt(2)/2)$ paraméterértékek környezetében az egyenletrendszernek létezik egyértelmű $(x, y)$ megoldása az $(u, v)$ paraméterek függvényében! Számítsuk ki a megoldásfüggvény Jacobi-mátrixát az $(u_0, v_0)$ pontban!

*Megoldás.* Tekintsük az $f(x, y) = (e^(x-1) + x sin(y), " " e^(x-1) - x cos(y))$ leképezést. Az $(x_0, y_0) = (1, pi/4)$ pontban:
$
  u_0 = e^0 + 1 dot sin(pi/4) = 1 + sqrt(2)/2\
  v_0 = e^0 - 1 dot cos(pi/4) = 1 - sqrt(2)/2
$
Deriváljuk $f$-et $(x, y)$ szerint:
$
  f'(x, y) = mat(e^(x-1) + sin(y), x cos(y); e^(x-1) - cos(y), x sin(y))
$
Az $(1, pi/4)$ pontban:
$
  f'(1, pi/4) = mat(1 + sqrt(2)/2, sqrt(2)/2; 1 - sqrt(2)/2, sqrt(2)/2)
$
$
  det f'(1, pi/4) = (1 + sqrt(2)/2) sqrt(2)/2 - (1 - sqrt(2)/2) sqrt(2)/2 = sqrt(2)/2 + 1/2 - sqrt(2)/2 + 1/2 = 1 != 0
$
Mivel a determináns $1 != 0$, az inverzfüggvény-tétel értelmében az egyenletrendszer megoldása, $(x, y) = f^(-1)(u, v)$, lokálisan létezik, egyértelmű és folytonosan differenciálható.

A megoldásfüggvény Jacobi-mátrixa az $(u_0, v_0)$ helyen:
$
  (f^(-1))'(u_0, v_0) = 1/1 mat(sqrt(2)/2, -sqrt(2)/2; -(1 - sqrt(2)/2), 1 + sqrt(2)/2) = mat(sqrt(2)/2, -sqrt(2)/2; sqrt(2)/2 - 1, 1 + sqrt(2)/2)
$

*Gyakorlati jelentőség (linearizált közelítés).* Ha a paramétereket kis $h = (h_1, h_2)$ értékkel megváltoztatjuk, az új egyenletrendszer megoldása jó közelítéssel:
$
  vec(x(u_0 + h_1, v_0 + h_2), y(u_0 + h_1, v_0 + h_2)) approx vec(x_0, y_0) + (f^(-1))'(u_0, v_0) dot vec(h_1, h_2)
$

== Az implicitfüggvény-tétel elméleti háttere

=== Geometriai motiváció

Gyakran egy alakzatot (görbét, felületet) nem explicit függvénygrafikonként ($y = f(x)$), hanem implicit egyenlettel adunk meg:
$
  F(x, y) = 0
$
Például az origó középpontú egységkör egyenlete: $x^2 + y^2 - 1 = 0$. A teljes egységkör nem egyetlen $y = f(x)$ függvény grafikonja. Azonban ha a kör egy pontjának, mondjuk a $(sqrt(3)/2, 1/2)$ pontnak vesszük egy kis környezetét, ott a felső félkörív egyértelműen leírható az $y = phi(x) = sqrt(1 - x^2)$ explicit függvénnyel.

*Kivételes pontok.* A $(1, 0)$ pont környezetében nem fejezhető ki $y$ az $x$ függvényeként, mert minden $x < 1$ esetén két $y$ érték tartozik hozzá (hasonlóan a $(-1, 0)$ pont körül, $x > -1$ esetén). Ezekben a pontokban a görbe érintője függőleges, azaz $partial_y F(x, y) = 2y = 0$.

=== Az implicitfüggvény-tétel kimondása ($F: RR^2 arrow RR$)

Legyen $D subset RR^2$ nyílt halmaz, $F: D arrow RR$ folytonosan differenciálható ($F in C^1 (D)$). Legyen $(a, b) in D$ olyan pont, amelyre:

+ $F(a, b) = 0$ (a pont rajta van az implicit egyenlet által definiált görbén),
+ a második változó szerinti parciális derivált nem nulla az $(a, b)$ pontban:
  $
    partial_2 F(a, b) != 0 " " ("azaz " partial_y F(a, b) != 0)
  $

Ekkor:

+ Létezik az $a$ pontnak egy $U subset RR$ környezete és a $b$ pontnak egy $V subset RR$ környezete, valamint egy egyértelműen meghatározott $phi: U arrow V$ folytonosan differenciálható függvény ($phi in C^1 (U)$), hogy
  $
    phi(a) = b
  $
  és minden $x in U$ esetén
  $
    F(x, phi(x)) = 0
  $
+ Az implicit $phi$ függvény deriváltja az $x in U$ pontokban:
  $
    phi'(x) = -(partial_1 F(x, phi(x)))/(partial_2 F(x, phi(x))) = -(partial_x F(x, y))/(partial_y F(x, y))
  $

*A deriválási képlet levezetése (láncszabály).* Mivel $F(x, phi(x)) = 0$ az egész $U$ intervallumon, deriváljuk az összetett kifejezést $x$ szerint:
$
  d/(dif x) F(x, phi(x)) = partial_1 F(x, phi(x)) dot 1 + partial_2 F(x, phi(x)) dot phi'(x) = 0
$
Kifejezve $phi'(x)$-et:
$
  phi'(x) = -(partial_1 F(x, phi(x)))/(partial_2 F(x, phi(x)))
$

== Az implicitfüggvény-tétel feladatai

=== 1. feladat

Igazoljuk, hogy az $ln x + y dot e^(y^2) + 1 = 0$ egyenletből az $x_0 = 1/e$ pont egy környezetében $y$ kifejezhető $x$ implicit függvényeként! Számítsuk ki az implicit függvény deriváltját az $x_0 = 1/e$ helyen!

*Megoldás.* Legyen $F(x, y) := ln x + y e^(y^2) + 1$. $D_F = {(x, y) in RR^2 : x > 0}$, ahol $F in C^1$.

*1. A megfelelő $y_0$ meghatározása.* Helyettesítsük be $x_0 = 1/e$-t az $F(x, y) = 0$ egyenletbe:
$
  ln(1/e) + y_0 e^(y_0^2) + 1 = 0 ==> -1 + y_0 e^(y_0^2) + 1 = 0 ==> y_0 e^(y_0^2) = 0
$
Mivel $e^(y_0^2) > 0$, ebből egyértelműen $y_0 = 0$. Tehát az illeszkedési pont $(a, b) = (1/e, 0)$, és $F(1/e, 0) = 0$.

*2. Parciális deriváltak.*
$
  partial_x F(x, y) = 1/x\
  partial_y F(x, y) = 1 dot e^(y^2) + y dot (e^(y^2) dot 2y) = e^(y^2) (1 + 2y^2)
$
A $(1/e, 0)$ pontban:
$
  partial_x F(1/e, 0) = 1/(1/e) = e, " " partial_y F(1/e, 0) = e^0 (1 + 0) = 1 != 0
$
Az implicitfüggvény-tétel feltételei teljesülnek, így $x_0 = 1/e$ környezetében létezik az egyértelmű $y = phi(x)$ implicit függvény.

*3. A derivált.*
$
  phi'(1/e) = -(partial_x F(1/e, 0))/(partial_y F(1/e, 0)) = -e/1 = -e
$

=== 2. feladat

Tekintsük az $ln sqrt(x^2 + y^2) = op("arctg")(y/x)$ egyenletet.
+ Igazoljuk, hogy az $(x_0, y_0) = (1, 0)$ pont környezetében $y$ kifejezhető $x$ implicit függvényeként!
+ Számítsuk ki az implicit függvény deriváltját az $x_0 = 1$ helyen!
+ Írjuk fel a görbe $(1, 0)$ pontbeli érintőegyenesének egyenletét!

*Megoldás.*

*1. Az $F(x, y)$ felírása.* Rendezzük nullára az egyenletet ($x != 0$):
$
  F(x, y) := ln sqrt(x^2 + y^2) - op("arctg")(y/x) = 1/2 ln(x^2 + y^2) - op("arctg")(y/x) = 0
$
Az $(1, 0)$ pont illeszkedése:
$
  F(1, 0) = 1/2 ln(1 + 0) - op("arctg")(0) = 0 - 0 = 0
$

*2. Parciális deriváltak.*
$
  partial_x F(x, y) = 1/2 dot (2x)/(x^2 + y^2) - 1/(1 + (y/x)^2) dot (-y/x^2) = x/(x^2 + y^2) + y/(x^2 + y^2) = (x + y)/(x^2 + y^2)\
  partial_y F(x, y) = 1/2 dot (2y)/(x^2 + y^2) - 1/(1 + (y/x)^2) dot 1/x = y/(x^2 + y^2) - x/(x^2 + y^2) = (y - x)/(x^2 + y^2)
$
Az $(1, 0)$ pontban:
$
  partial_x F(1, 0) = (1 + 0)/1 = 1, " " partial_y F(1, 0) = (0 - 1)/1 = -1 != 0
$
Az implicitfüggvény-tétel feltételei teljesülnek, így $y = phi(x)$ lokálisan létezik és $C^1$ osztályú.

*3. A derivált és az érintőegyenes.*
$
  phi'(1) = -(partial_x F(1, 0))/(partial_y F(1, 0)) = -1/(-1) = 1
$
Az érintőegyenes egyenlete az $(x_0, y_0) = (1, 0)$ pontban:
$
  y - y_0 = phi'(x_0)(x - x_0) ==> y - 0 = 1 dot (x - 1) ==> y = x - 1
$

== A többváltozós (rendszer-) implicitfüggvény-tétel

=== Az általános tétel kimondása

Tegyük fel, hogy $m$ darab független változónk ($x in RR^m$) és $n$ darab függő változónk ($y in RR^n$) van, melyekre egy $n$ egyenletből álló egyenletrendszer teljesül:
$
  F(x, y) = 0 " " (F: RR^m times RR^n arrow RR^n)
$
Legyen $(a, b) in RR^m times RR^n$ olyan pont, amelyre:

+ $F(a, b) = 0$,
+ $F in C^1$ az $(a, b)$ pont egy környezetében,
+ a kifejezendő $y$ változók szerinti $n times n$-es Jacobi-mátrix determinánsa nem nulla az $(a, b)$ pontban:
  $
    det [partial_y F(a, b)] != 0
  $

Ekkor létezik az $a in RR^m$ pontnak egy $U$ környezete és egy egyértelmű $phi: U arrow RR^n$ folytonosan differenciálható leképezés, hogy $phi(a) = b$, és minden $x in U$ esetén $F(x, phi(x)) = 0$. A $phi$ leképezés $n times m$-es Jacobi-mátrixa:
$
  phi'(x) = -[partial_y F(x, phi(x))]^(-1) dot partial_x F(x, phi(x))
$

=== 1. feladat (térbeli metszetgörbe)

Tekintsük az alábbi egyenletrendszert:
$
  cases(
    (x - 2)^2 + y^2 = 4,
    x^2 + y^2 + z^2 = 16
  )
$
+ Igazoljuk, hogy az $a = (2, 2, 2 sqrt(2))$ pont környezetében az $y$ és $z$ változók kifejezhetők az $x$ implicit függvényeként!
+ Határozzuk meg az implicit függvény deriváltvektorát az $x_0 = 2$ helyen!

*Megoldás.*

*1. Az $F(x, y, z)$ felírása és ellenőrzése.* Itt $m = 1$ (a független változó $x$), és $n = 2$ (a kifejezendő változók $y$ és $z$):
$
  F(x, y, z) = vec((x - 2)^2 + y^2 - 4, x^2 + y^2 + z^2 - 16) = vec(0, 0)
$
Az $a = (2, 2, 2 sqrt(2))$ pont ellenőrzése:
- $(2 - 2)^2 + 2^2 - 4 = 0 + 4 - 4 = 0$ #sym.checkmark
- $2^2 + 2^2 + (2 sqrt(2))^2 - 16 = 4 + 4 + 8 - 16 = 0$ #sym.checkmark

*2. A kifejezendő $(y, z)$ szerinti Jacobi-mátrix.*
$
  partial_(y z) F(x, y, z) = mat(partial_y F_1, partial_z F_1; partial_y F_2, partial_z F_2) = mat(2y, 0; 2y, 2z)
$
Az $a$ pontban:
$
  partial_(y z) F(2, 2, 2 sqrt(2)) = mat(4, 0; 4, 4 sqrt(2))
$
$
  det [partial_(y z) F(2, 2, 2 sqrt(2))] = 4 dot 4 sqrt(2) - 0 dot 4 = 16 sqrt(2) != 0
$
Mivel a determináns nem nulla, a tétel értelmében $y$ és $z$ kifejezhető $x$ implicit függvényeként, $phi(x) = vec(y(x), z(x))$ alakban, az $x_0 = 2$ környezetében.

*3. Az $x$ szerinti parciális deriváltvektor.*
$
  partial_x F(x, y, z) = vec(2(x - 2), 2x) ==> partial_x F(2, 2, 2 sqrt(2)) = vec(0, 4)
$

*4. Az implicit függvény deriváltvektora az $x_0 = 2$ helyen.* Először a $partial_(y z) F$ mátrix inverze:
$
  [partial_(y z) F]^(-1) = 1/(16 sqrt(2)) mat(4 sqrt(2), 0; -4, 4) = mat(1/4, 0; -1/(4 sqrt(2)), 1/(4 sqrt(2)))
$
A képlet alkalmazása:
$
  phi'(2) = - mat(1/4, 0; -1/(4 sqrt(2)), 1/(4 sqrt(2))) vec(0, 4) = - vec(0, 4/(4 sqrt(2))) = vec(0, -1/sqrt(2))
$
Tehát
$
  y'(2) = 0, " " z'(2) = -1/sqrt(2) = -sqrt(2)/2
$

*5. Explicit ellenőrzés (a metszetgörbe felírásával).*
+ Az első egyenletből $y^2 = 4 - (x - 2)^2 = 4x - x^2$, tehát $y(x) = sqrt(4 - (x - 2)^2)$ (mivel $y_0 = 2 > 0$). Deriváltja:
  $
    y'(x) = (-2(x - 2))/(2 sqrt(4 - (x - 2)^2)) ==> y'(2) = 0/2 = 0 " " #sym.checkmark
  $
+ A második egyenletből:
  $
    z^2 = 16 - x^2 - y^2 = 16 - x^2 - (4x - x^2) = 16 - 4x
  $
  tehát $z(x) = sqrt(16 - 4x) = 2 sqrt(4 - x)$ (mivel $z_0 = 2 sqrt(2) > 0$). Deriváltja:
  $
    z'(x) = -1/sqrt(4 - x) ==> z'(2) = -1/sqrt(2) = -sqrt(2)/2 " " #sym.checkmark
  $

=== 2. feladat (négyváltozós egyenletrendszer)

Tekintsük az alábbi egyenletrendszert:
$
  cases(
    3x_1 + x_2 - x_3 - x_4^2 = 0,
    x_1 - x_2 + 2x_3 + x_4 = 0,
    2x_1 + 2x_2 - 3x_3 + 2x_4 = 0
  )
$
Igazoljuk, hogy az $x_1, x_2, x_4$ változók kifejezhetők az $x_3$ implicit függvényeként egy tetszőleges megoldáspont környezetében!

*Megoldás.* Itt 4 változó ($x_1, x_2, x_3, x_4$) és $n = 3$ egyenlet van. A független változó $x_3$ ($m = 1$), a kifejezendő változók $y = (x_1, x_2, x_4) in RR^3$.

A kifejezendő $(x_1, x_2, x_4)$ szerinti $3 times 3$-as Jacobi-mátrix:
$
  partial_(x_1, x_2, x_4) F = mat(
    partial_(x_1) F_1, partial_(x_2) F_1, partial_(x_4) F_1;
    partial_(x_1) F_2, partial_(x_2) F_2, partial_(x_4) F_2;
    partial_(x_1) F_3, partial_(x_2) F_3, partial_(x_4) F_3
  ) = mat(3, 1, -2x_4; 1, -1, 1; 2, 2, 2)
$
A determináns az első sor szerinti kifejtéssel:
$
  det [partial_(x_1, x_2, x_4) F] = 3(-2 - 2) - 1(2 - 2) + (-2x_4)(2 - (-2)) = -12 - 8x_4
$
Az implicit függvény létezésének feltétele:
$
  det [partial_(x_1, x_2, x_4) F] != 0 <==> -12 - 8x_4 != 0 <==> x_4 != -3/2
$
Tehát minden olyan megoldáspont környezetében, ahol $x_4 != -3/2$, az $x_1, x_2, x_4$ változók egyértelműen kifejezhetők $x_3$ függvényeként.

*Végül azt kell belátni, hogy megoldáspontban valóban $x_4 != -3/2$.* A második és harmadik egyenletből $x_1$ és $x_2$ kifejezhető:
$
  x_1 - x_2 = -2x_3 - x_4, " " x_1 + x_2 = (3x_3 - 2x_4)/2 ==> x_1 = -(x_3 + 4x_4)/4, " " x_2 = (7x_3)/4
$
Ezt az első egyenletbe helyettesítve:
$
  3 dot (-(x_3 + 4x_4)/4) + (7x_3)/4 - x_3 - x_4^2 = -3x_4 - x_4^2 = -x_4 (x_4 + 3) = 0
$
tehát minden megoldáspontban $x_4 in {0, -3}$, és így a determináns értéke $-12$ vagy $12$, vagyis soha nem nulla. A tétel feltétele tehát *minden* megoldásponton teljesül.

== Összefoglaló összehasonlító táblázat

#table(
  columns: (auto, 1fr, 1fr),
  align: left,
  inset: 6pt,
  [*Tulajdonság*], [*Inverzfüggvény-tétel*], [*Implicitfüggvény-tétel*],
  [Kiindulási objektum],
  [$f: RR^n arrow RR^n$ leképezés],
  [$F: RR^m times RR^n arrow RR^n$ egyenlet ($F(x, y) = 0$)],
  [Cél],
  [Az $f^(-1)$ inverz létezése és deriváltja],
  [Az $y = phi(x)$ kifejezhetősége és deriváltja],
  [Kulcsfeltétel],
  [$det f'(a) != 0$ (a teljes Jacobi nem elfajuló)],
  [$det [partial_y F(a, b)] != 0$ (a függő változók szerinti Jacobi nem elfajuló)],
  [Derivált képlete],
  [$(f^(-1))'(b) = [f'(a)]^(-1)$],
  [$phi'(x) = -[partial_y F(x, y)]^(-1) dot partial_x F(x, y)$],
  [Skaláris speciális eset],
  [$(f^(-1))'(b) = 1/(f'(a))$],
  [$phi'(x) = -(F'_x (x, y))/(F'_y (x, y))$],
)
