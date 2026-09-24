= Fizikai mennyiségek hármas integrállal

Például a mechanikában a testeket úgy fogjuk fel, mint valamilyen halmazt. Jellemzően a testeket úgy reprezentáljuk, mintha egy halmaz pontjai alkotnák a testet:
$
  H subset RR^3 " a test pontjainak halmaza"
$
A legtöbb esetben a testek nem homogének. Emellett a test tömegéhez és súlyához bevezetünk egy sűrűségfüggvényt:
$
  rho : H arrow RR
$

== Térfogat és tömeg

A test térfogata (Jordan-mérték) nem függ a sűrűségtől:
$
  V(H) = integral_H 1 dif x dif y dif z
$
A tömeg viszont már függ a sűrűségtől:
$
  m(H) = integral_H rho(x, y, z) dif x dif y dif z
$
Ha a sűrűségfüggvény konstans, akkor konstansfüggvényt integrálunk, azt ki lehet emelni:
$
  m(H) = rho dot V(H)
$
(Pont, mint annak idején, óvodában.)

== Súlypont

/ Súlypont: Ha van egy kiterjedt testünk, de az alakjával nem akarunk komolyabb számításokat végezni, mert nem releváns a test alakja, akkor úgy tekintünk rá, mintha pontszerű test lenne -- ilyenkor kiszámoljuk a súlypontot, és azzal számolunk tovább.

A súlypont egy $(s_x, s_y, s_z) in RR^3$ pont, ahol
$
  s_x = 1/(m(H)) dot integral_H x dot rho(x, y, z) dif x dif y dif z\
  s_y = 1/(m(H)) dot integral_H y dot rho(x, y, z) dif x dif y dif z\
  s_z = 1/(m(H)) dot integral_H z dot rho(x, y, z) dif x dif y dif z
$

#pagebreak()

== Tehetetlenségi nyomaték

/ Tehetetlenségi nyomaték: Mindig egy egyenesre vonatkozóan határozzuk meg -- legyen ez most az $e$ egyenes. Integrálni kell valaminek és a sűrűségnek a szorzatát; a "valami" a $H$ halmaz fölött a pontok és $e$ távolságának négyzete:
$
  Theta_e = integral_H [d((x,y,z), e)]^2 dot rho(x, y, z) dif x dif y dif z
$
ahol $d(P, e)$ a $P$ pont és $e$ egyenes távolsága.

A feladatokban alapvetően egy-egy ilyen integrál mögé van bújtatva, amit ki kell számolni. Nézzünk egyet.

=== 1. feladat

$
  K = {(x, y, z) in RR^3 | " " 0 <= x <= 1 " és " sqrt(y^2 + z^2)/2 <= x}
$
és a sűrűség minden pontban egyenesen arányos az origótól mért távolság négyzetével -- ez csak azt jelenti, hogy valamilyen konstanssal meg van szorozva. Az origótól mért távolság négyzete a kettes norma négyzete, tehát
$
  rho(x, y, z) = alpha dot (x^2 + y^2 + z^2), " " alpha in RR "konstans"
$

Kell az $x$ tengelyre vonatkozó tehetetlenségi nyomaték. Mivel $x$ tengelyre nézzük a távolságot, $d(x,y,z) = sqrt(y^2+z^2)$, tehát
$
  Theta_K = integral_K (y^2 + z^2) dot rho(x, y, z) dif x dif y dif z = integral_K (y^2+z^2) dot alpha(x^2+y^2+z^2) dif x dif y dif z
$
Itt az integrandus nem is nagy szám -- inkább a $K$ halmaz a nehéz eset.

Nézzük a $K$ halmazt: $x$ egy rögzített érték $0$ és $1$ között; képzeljük el, mi történik ilyen rögzített $x$-re. Azt látjuk, hogy $y, z$ teljesíti, hogy
$
  0 <= sqrt(y^2+z^2)/2 <= x <==> y^2+z^2 <= 4x^2
$
és ez mindig egy $2x$ sugarú körlemez, bárhol mozog az $x$. Például $x=1$-re ez egy $2$ sugarú körlemez, $x=1/2$-re pedig egy $1$ sugarú körlemez.

Látjuk, hogy a sugár egyenesen arányos az $x$-szel: a körlemezeket tehát összeköthetjük egy egyenessel, és ábrázolva látjuk, hogy ez egy fektetett kúp lesz. (Felfoghattuk volna úgy is, hogy egy $y = 2x$ egyenest az $x$ tengelyre tekintve megforgattunk, és így kaptunk egy forgástestet.) Fontos észrevenni, hogy az $x=1$ körlemezzel a test véget ér.

Lehetne normáltartományozni, de talán egyszerűbb és gyorsabb a koordinátatranszformáció -- használjuk a bevált hengertranszformációt, de $(y,z)$-re csinálunk polártranszformációt, $x$-et pedig rögzítve hagyjuk:
$
  y = r cos phi, " " z = r sin phi
$
tehát a helyettesítő függvényünk
$
  g(x, r, phi) = mat(x; r cos phi; r sin phi)
$
A tartomány: egyből leszögezhetjük, hogy $x in [0, 1]$. $(y,z)$-nél a szokásos polár-dolog van: ha $x$-et rögzítjük, a szög bármi lehet a $[0, 2pi]$ intervallumon, a sugár pedig $x$-től függ, legfeljebb $r = 2x$. Tehát összességében
$
  phi in [0, 2pi], " " r in [0, 2x]
$
Már csak a Jacobi-determináns kell -- polárkoordinátás feladatoknál ez mindig egyszerűen $r$:
$
  |"det " g'(x, r, phi)| = r
$
Ekkor egy $I$ halmazon integrálunk:
$
  I = {(x, r, phi) in RR^3 | " " 0 <= x <= 1, " " 0 <= r <= 2x, " " 0 <= phi <= 2pi}
$
$
  Theta_K = integral_I r^2 dot alpha (x^2+r^2) dot r dif x dif r dif phi
$
Figyelnünk kell, hogy ez normáltartomány, tehát nem tetszőleges sorrendben integrálunk:
$
  Theta_K = integral_0^1 integral_0^(2x) integral_0^(2pi) alpha dot r^3 (x^2+r^2) dif phi dif r dif x = 2pi alpha integral_0^1 integral_0^(2x) r^3 x^2 + r^5 dif r dif x =\
  = 2pi alpha integral_0^1 [(r^4 x^2)/4 + r^6/6]_(r=0)^(2x) dif x = 2pi alpha integral_0^1 4x^6 + 32/3 x^6 dif x = 2pi alpha dot 44/3 [x^7/7]_0^1 = underline(underline((88 pi alpha)/21))
$

Házi feladat: számítsuk ki a $z$ tengelyre vonatkozó tehetetlenségi nyomatékot. Ha átlátjuk, viszonylag gyorsan megoldható, mivel az integrandusban csak az egyik tag változik, a halmaz tulajdonképpen marad ugyanaz.

#pagebreak()

=== 2. feladat

Legyen $R > 0$ sugarú, origó középpontú $G$ gömb:
$
  G = {(x,y,z) in RR^3 | " " x^2+y^2+z^2 <= R^2}
$
és a sűrűség fordítottan arányos a távolság négyzetének eggyel megnövelt értékével (fordított arányosság = reciprok):
$
  rho(x, y, z) = alpha/(x^2+y^2+z^2+1), " " alpha in RR "rögzített"
$
Kérdés: mekkora lesz egy origón átmenő egyenesre vonatkozó tehetetlenségi nyomatéka?

Maga a test is az origó körüli forgástest. Vegyük észre, hogy a test forgásszimmetrikus az origóra nézve, tehát igazából mindegy, melyik egyenest választjuk, mindig ugyanazt az eredményt kapjuk -- nézzük az $x$ tengelyt. Annyiban könnyű dolgunk van, hogy magát a $Theta$-t rögtön fel tudjuk írni, csak a halmazzal kell foglalkoznunk:
$
  Theta_x = integral_G underbrace((y^2+z^2), d^2(P, x "tengely")) dot underbrace(alpha/(x^2+y^2+z^2+1), rho(x, y, z)) dif x dif y dif z
$

Írjuk fel a $G$ halmazt.

/ 1. megoldás: Egy félkört forgatunk meg a térben. A félkör
$
  f(x) = sqrt(R^2-x^2)
$
megforgatása: $(y,z)$-re $f(x)$ sugarú kör pontjai, azaz $y^2+z^2 <= R^2-x^2$. Innen lehetne hengertranszformáció, stb.

/ 2. megoldás: Gömbszerű testeknél a polárkoordináta általánosítása, az úgynevezett gömbi koordináták használata. Viszonylag könnyű megjegyezni, mert olyan, mint a földrajzban: az egyik koordináta a polárkoordinátához hasonlóan az origótól vett $r$ távolság. Két szöget használunk: az egyik az $r$ egyenesnek a $z$ tengellyel bezárt szöge, legyen ez $Theta$; a másik a $P$ pont $x y$ síkra vett merőleges vetületének ($P_(x y)$) és az $x$ tengelynek a szöge, legyen ez $phi$.
$
  0 <= r <= R, " " 0 <= Theta <= pi, " " 0 <= phi < 2pi
$
$
  mat(x; y; z) = mat(r sin Theta dot cos phi; r sin Theta dot sin phi; r cos Theta) = g(r, phi, Theta)
$
$
  |"det " g'(r,phi,Theta)| = r^2 sin Theta " (abszolútértéke önmaga, ha " Theta in [0, pi] ")"
$
$
  integral_G (y^2+z^2) dot alpha/(x^2+y^2+z^2+1) dif x dif y dif z = integral_I r^2 (sin^2 Theta sin^2 phi + cos^2 Theta) dot alpha/(r^2+1) dot r^2 sin Theta dif r dif Theta dif phi
$
Vegyük észre, hogy
$
  x^2+y^2+z^2 = r^2 <==> y^2+z^2 = r^2 - z^2 = r^2 - r^2 sin^2 Theta cos^2 phi
$
ezért kicsit kevesebb a trigonometrikus tag:
$
  = integral_I r^2(1 - sin^2 Theta cos^2 phi) dot alpha/(r^2+1) dot r^2 sin Theta dif r dif Theta dif phi
$
ahol
$
  I = {(r, Theta, phi) : " " 0 <= r <= R, " " 0 <= Theta <= pi, " " 0 <= phi < 2pi}
$
$
  = alpha integral_0^pi integral_0^(2pi) integral_0^R r^4/(r^2+1) sin Theta (1 - sin^2 Theta cos^2 phi) dif r dif phi dif Theta
$

(Innentől a jegyzet vázlatos maradt -- a további lépések nyers számolás, nincs a végén összerakva.)

Radiális rész:
$
  integral_0^R r^4/(r^2+1) dif r = integral_0^R r^2 - 1 + 1/(r^2+1) dif r = [r^3/3 - r + arctan(r)]_0^R
$

Szög szerinti rész, amit még ki kell számolni:
$
  integral_0^pi integral_0^(2pi) sin Theta (1 - sin^2 Theta cos^2 phi) dif phi dif Theta = integral_0^pi integral_0^(2pi) sin Theta - sin^3 Theta dot cos^2 phi dif phi dif Theta
$

$Theta$ szerint:
$
  integral sin Theta dif Theta = - cos Theta\
  integral sin^3 Theta dif Theta = integral sin Theta - cos^2 Theta dot sin Theta dif Theta = integral cos^2 Theta dot (-sin Theta) dif Theta = (cos^3 Theta)/3
$

$phi$ szerint:
$
  cos(2phi) = cos^2 phi - sin^2 phi = 2cos^2 phi - 1 <==> cos^2 phi = (1+cos(2phi))/2\
  integral cos^2 phi dif phi = integral (1+cos(2phi))/2 dif phi
$
