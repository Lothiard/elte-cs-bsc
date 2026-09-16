leginkabb ismetles lesz az elejen

= harmas integralok
teljesen hasonlitani fog a ketvaltozosokhoz, nincs tul nagy kulonbseg

/ 1.:
$
  integral_H x^2 + y^2 dif x dif y dif z "   ahol" H "halmazt" x^2 + y^2 = 2z "es" z = 2 "egyenletu feluletek hataroljak"
$
meg kell nezni fel tudjuk-e irni normaltartomanykenyt, vagy uj valtozot kell bevezetni es utana Reimann integralni\
$
  z = 2 <==> {(x, y, 2) : x, y in RR}\
$
az egyik dolog amit tehetunk hogy fuggvenykent kepzeljuk el
$
  (z = (x^2 + y^2)/(2) = f(x, y) "grafikonja")
$
ezen az uton haladva egy lehetseges modja az elkepzelesnek hogy sikmetszetekkelk kepzeljuk el. Rogzitek egy $y$ erteket es latom hogy az egy parabola, igy tovabb a tobbivel\

masodik elkepzeles: ha a $z$-t rogzitem es megnezem milyen pontok tartoznak az adott feluletben\
ebben az esetben muszaj $z >= 0$ es rogzitett\
ezek mindig $sqrt(2z)$ sugaru korvonalak sokasaga lesz\
igy nem parabolaszeletek vannak hanem korok, ami sokkal baratsagosabb\

/ megjegyzes: ez egy parabola forgastest. ezt ugy kellett kepezni hogy
$
  f(z) "fuggveny, ahol " z in [a, b]\
  f(sqrt(x^2 + y^2)) " behelyettesitem"\
  ==> f(x, y) = (x^2 + y^2)/2 = ((sqrt(x^2 + y^2))^2)/2 = z^2/2 "megforgatasa"
$

a kerdes az hogy hogyan integralok ezen a $H$ halmazon igy hogy megvan hogy ez hogy nez ki\
ez egy normaltartomany, annak a lenyege meg fuggvenyek altal hatarolt sikresz valamilyen intervallumon.
/ emlekezteto: normaltartomany: $RR^2$
$
  {(x, y) in RR^2 : x in [a, b], " " g_1(x) <= y <= g_2(x)}
$

$RR^3$ eseten ugyanilyen csak annyiban mas hogy ket fuggvenyfelulet hataroljon egy teret

/ 1. otlet:
$
  I subset RR^2 " korlatos es zart"\
  g_1, g_2 : I arrow RR
$

$
  integral_H x^2 + y^2 dif x dif y dif z, g_1(x, y) <= g_2(x, y),\ g_1, g_2 in C "eseten" H = {(x, y, z) in RR^3 : (x, y) in I " es " g_1(x, y) <= z <= g_2(x, y)}
$

ilyenkor azt allitom hogy: Ha $f: H arrow RR$ es $f in C(H)$ es $H$ normaltartomany

$
  integral_H x^2 + y^2 dif x dif y dif z = integral_I (integral_(g_1(x, y))^(g_2(x, y)) f(x, y, z) dif x) dif x dif y
$

/ 2. otlet:
tovabbi megszoritast teszek, az $I$ is legyen normaltartomany az $(x, y)$ sikon. ezt siman beleegetem a definicioba.

formalisan: (az elozo felteteleken kivul kell meg) letezik  tovabba
$
  h_1, h_2 : [a, b] arrow RR, " " h_1, h_2 in C\
  H = {(x, y, z) in RR^3 : x in [a, b], h_1(x) <= y <= h_2(x), " " g_1(x, y) <= z <= g_2(x, y)}
$

ez annyiban mas hogy rogton tudok szukcessziven integralni, mert
$
  "ha" f in C(H):\ integral_H x^2 + y^2 dif x dif y dif z = integral_a^b integral_(h_1(x))^(h_2(x)) integral_(g_1(x, y))^(g_2(x, y)) f(x, y, z) dif z dif y dif x
$

mostmar vannak eszkozeink megoldani az eredeti feladatot

/ 1. megoldas: (2. otletre epulve)
$
  I : x^2 + y^2 <= 4 "felett" z = 2 = g_1(x, y), " " y = (x^2 + y^2)/2 = g_2(x, y) "hatarolja"\
  I : x^2 + y^2 <= 4 "olyan normaltartomany hogy" y = -sqrt(4 - x^2),\
  x in [-2, 2]"-n" h_1(x) = - sqrt(4 - x^2), " " h_2(x) = sqrt(4 - x^2)\
  ==> integral_H f = integral_(-2)^2 (integral_(-sqrt(4 - x^2))^(sqrt(4 - x^2)) integral_((x^2 + y^2)/2)^2 x^2 + y^2 dif z) dif y dif x
$

/ 2. megoldas: (1. otletre epulve)
lehet annyit egyszerusiteni a dolgon hogy a kort nem normaltartomanykent tekintjuk hanem bevezetunk polarkoordinatakat
$
  I = {(x, y) in RR^2 : x^2 + y^2 <= 4} "felett" z = 2 = g_1(x, y), " " y = (x^2 + y^2)/2 = g_2(x, y) "hatarolja"\
  integral_H f = integral_I (integral_((x^2 + y^2)/2)^2 x^2 + y^2 dif z) dif x dif y = integral_I (x^2 + y^2) dot [z]_((x^2 + y^2)/2)^2 dif x dif y =\ = integral_I 2(x^2 + y^2) - ((x^2 + y^2)^2)/2 dif x dif y =_"polartranszformacio" dots
$

$
  (x, y) = (r cos phi, r sin phi) = g(r, phi) "  " g: J arrow I\
  x^2 + y^2 <= 4 <==> r^2 <= 4 " es " r >= 0 " es " f in (0, 2 pi)\
  integral_I f(x, y) dif x dif y = integral_J f(cos phi, sin phi) dot r dif r dif phi\
  dots = integral_J (2r^2 - r^4/2) dot r dif r dif phi = integral_0^(2pi) integral_0^2 2r^3 - r^5/2 dif r dif phi = integral_0^(2pi) [r^4/2 - r^6/12]_0^2 dif phi = integral_0^(2 pi) 8/3 dif phi = underline(underline((16pi)/3))
$

/ 3. megoldas: (3D-s integral) $->$ Hengertranszformacio (tipikusan forgastestekre alkalmazhato, 2 valtozo szerinti polarhelyettesites)
egy pont helyet ugy fogjuk meghatarozni hogy ket valtozo szerint polarkoordinatakkal adunk meg egy pontot, a harmadik koordinatat pedig nem bantjuk

$
  g(x, y, z) "   " (x, y, z) = (r cos phi, r sin phi, z), "   " 0 <= r, " " 0 <= f < 2 pi, " " z in RR\ \
  g'(r, phi, z) = mat(
    cos phi, - sin phi, 0;
    sin phi, r cos phi, 0;
    0, 0, 1;
  )\
  abs("det" g'(r, phi, z)) = r\ \
  I: z in [0, 2], "tetszoleges, es adott z-re"\
  phi in [0, 2pi]\
  0 <= r <= sqrt(2z)\ \
  integral_H x^2 + y^2 dif x dif y dif z = integral_I r^2 dot r dif r dif phi dif z = integral_0^2 integral_0^(2pi) integral_0^(sqrt(2z)) r^3 dif r dif phi dif z = [r^4/4]_0^(sqrt(2z)) = integral_0^2 integral_0^(2pi) z^2 dif phi dif z = underline(underline((16pi)/3))
$

