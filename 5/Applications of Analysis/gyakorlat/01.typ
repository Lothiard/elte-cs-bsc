Az óra elején főleg ismétlés lesz.

= Hármas integrálok

Nagyon hasonlítani fog a kétváltozós esethez, nincs nagy különbség.

== Bevezető példa

$
  integral_H x^2 + y^2 dif x dif y dif z "  ahol " H "halmazt" x^2 + y^2 = 2z "és" z = 2 "egyenletű felületek határolják"
$

Meg kell néznünk, hogy fel tudjuk-e írni $H$-t normáltartományként, vagy be kell vezetnünk egy új koordinátát, és úgy Riemann-integrálni.

$
  z = 2 <==> {(x, y, 2) : x, y in RR}
$

Az egyik lehetőség, hogy függvényként képzeljük el a felületet:
$
  z = (x^2 + y^2)/2 = f(x, y) "  (grafikonja)"
$

Ezen az úton haladva egy lehetséges elképzelés, hogy síkmetszetekkel gondolkodunk. Ha rögzítünk egy $y$ értéket, azt látjuk, hogy az egy parabola -- és így tovább a többivel.

Egy másik elképzelés: ha $z$-t rögzítjük, és megnézzük, mely pontok tartoznak az adott felülethez. Ebben az esetben szükséges, hogy $z >= 0$ legyen (és rögzített). Ezek mindig $sqrt(2z)$ sugarú körvonalak sokasága lesznek -- ez sokkal barátságosabb, mint a parabolaszeletek.

/ Megjegyzés: Ez egy forgásparaboloid. Ha van egy $h(r)$ függvényünk, $r in [a, b]$-n, és ebbe $r = sqrt(x^2+y^2)$-t helyettesítünk, az így kapott felület éppen $h$ grafikonjának forgásfelülete a $z$-tengely körül. Itt
$
  h(r) = r^2 / 2, " tehát " z = (x^2+y^2)/2 = (sqrt(x^2+y^2))^2/2 = h(sqrt(x^2+y^2))
$
azaz a mi felületünk pontosan a $z = r^2/2$ parabola megforgatása a $z$-tengely körül.

A kérdés, hogy hogyan integráljunk ezen a $H$ halmazon, most hogy tudjuk, hogy néz ki. Ez egy normáltartomány: a lényege, hogy függvények által határolt síkrész valamilyen intervallumon.

/ Emlékeztető (normáltartomány $RR^2$-ben):
$
  {(x, y) in RR^2 : x in [a, b], " " g_1(x) <= y <= g_2(x)}
$
$RR^3$ esetén ugyanez, csak annyiban más, hogy két függvényfelület határol egy teret egy síkbeli tartomány fölött.

== Elméleti háttér

=== 1. ötlet

$
  I subset RR^2 " korlátos és zárt"\
  g_1, g_2 : I arrow RR
$

Ha $g_1(x, y) <= g_2(x, y)$, $g_1, g_2 in C$, akkor
$
  H = {(x, y, z) in RR^3 : (x, y) in I " és " g_1(x, y) <= z <= g_2(x, y)}
$

Ekkor: ha $f: H arrow RR$, $f in C(H)$ és $H$ normáltartomány, akkor
$
  integral_H f(x, y, z) dif x dif y dif z = integral_I (integral_(g_1(x, y))^(g_2(x, y)) f(x, y, z) dif z) dif x dif y
$

=== 2. ötlet

További megszorítás: legyen $I$ is normáltartomány az $(x, y)$ síkon -- ezt beleépítjük a definícióba.

Formálisan (az előző feltételeken kívül) létezik $h_1, h_2 : [a, b] arrow RR$, $h_1, h_2 in C$, úgy hogy
$
  H = {(x, y, z) in RR^3 : x in [a, b], " " h_1(x) <= y <= h_2(x), " " g_1(x, y) <= z <= g_2(x, y)}
$

Ez annyiban jobb, hogy rögtön szukcesszíven integrálhatunk: ha $f in C(H)$,
$
  integral_H f(x, y, z) dif x dif y dif z = integral_a^b integral_(h_1(x))^(h_2(x)) integral_(g_1(x, y))^(g_2(x, y)) f(x, y, z) dif z dif y dif x
$

Mostmár vannak eszközeink megoldani az eredeti feladatot.

== A bevezető példa megoldása

=== 1. megoldás (a 2. ötletre épülve)

$
  I : x^2 + y^2 <= 4 " fölött alulról " g_1(x, y) = (x^2+y^2)/2 " (paraboloid), felülről " g_2(x, y) = 2 " (sík) határolja a tartományt"\
  I " normáltartomány, " x in [-2, 2] "-n " h_1(x) = -sqrt(4 - x^2), " " h_2(x) = sqrt(4 - x^2)\
  ==> integral_H f = integral_(-2)^2 (integral_(-sqrt(4 - x^2))^(sqrt(4 - x^2)) integral_((x^2 + y^2)/2)^2 x^2 + y^2 dif z) dif y dif x
$

=== 2. megoldás (az 1. ötletre épülve)

Egyszerűsíthetünk azzal, hogy a kört nem normáltartományként kezeljük, hanem polárkoordinátákat vezetünk be.

$
  I = {(x, y) in RR^2 : x^2 + y^2 <= 4} " fölött ugyanúgy " g_1(x, y) = (x^2+y^2)/2 " és " g_2(x, y) = 2 " határolja a tartományt"\
  integral_H f = integral_I (integral_((x^2 + y^2)/2)^2 x^2 + y^2 dif z) dif x dif y = integral_I (x^2 + y^2) dot [z]_((x^2 + y^2)/2)^2 dif x dif y =\
  = integral_I 2(x^2 + y^2) - (x^2 + y^2)^2/2 dif x dif y =_"polártranszformáció" dots
$

$
  (x, y) = (r cos phi, r sin phi) = g(r, phi), " " g: J arrow I\
  x^2 + y^2 <= 4 <==> r^2 <= 4 " és " r >= 0 " és " phi in [0, 2pi)\
  integral_I f(x, y) dif x dif y = integral_J f(r cos phi, r sin phi) dot r dif r dif phi\
  dots = integral_J (2r^2 - r^4/2) dot r dif r dif phi = integral_0^(2pi) integral_0^2 2r^3 - r^5/2 dif r dif phi = integral_0^(2pi) [r^4/2 - r^6/12]_0^2 dif phi = integral_0^(2pi) 8/3 dif phi = underline(underline((16pi)/3))
$

=== 3. megoldás -- hengertranszformáció

(Tipikusan forgástestekre alkalmazható: két koordinátát polárban adunk meg, a harmadikat nem bántjuk.)

$
  g(r, phi, z) = (r cos phi, r sin phi, z), " " 0 <= r, " " 0 <= phi < 2pi, " " z in RR\ \
  g'(r, phi, z) = mat(
    cos phi, -r sin phi, 0;
    sin phi, r cos phi, 0;
    0, 0, 1;
  )\ \
  abs("det " g'(r, phi, z)) = r\ \
  I: z in [0, 2], "tetszőleges, és adott " z"-re"\
  phi in [0, 2pi)\
  0 <= r <= sqrt(2z)\ \
  integral_H x^2 + y^2 dif x dif y dif z = integral_I r^2 dot r dif r dif phi dif z = integral_0^2 integral_0^(2pi) integral_0^(sqrt(2z)) r^3 dif r dif phi dif z =\
  = integral_0^2 integral_0^(2pi) [r^4/4]_0^(sqrt(2z)) dif phi dif z = integral_0^2 integral_0^(2pi) z^2 dif phi dif z = integral_0^2 2pi z^2 dif z = underline(underline((16pi)/3))
$
