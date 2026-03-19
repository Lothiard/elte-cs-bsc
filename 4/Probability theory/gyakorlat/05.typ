= felteteles varhato ertek
ez egy fuggveny lesz nem egy szam valamiert. Ha az egy darab A esemenyre nezzuk akkor valoban szam lesz de tetszoleges esemenyre ez egy fuggveny.

== Wald azonossag
ha valamennyi valoszinusegi valtozot adunk ossze akkor az osszeg varhato erteke a ket valtozo varhato ertekenek a szorzata.

onnan tudjuk hogy a varhato erteket kell hasznalni hogy van valami dontest es a vegen kell valami aggregalt dolgot csinalni

= 5. feladatsor
== 1
ket parametere van a normalis eloszlasnak. varhato ertek es szorasnegyzet
ennek van egy "standard normalis parameterezese". nullan van a kozepe es -1 es 1 kozott van szorasa

van egy surusegfuggvenye. a standarnak $1/(sqrt(2 pi)) dot e^(-(x^2)/2)$ es higgyuk el hogy ennek az integralja 1

az integralfuggvenye sajnos nem analitikus

ezt hivjak "standard normalis eloszlas fuggveny"enek

van ezponencialis eloszlas is aminek jellemzoen $lambda$ parametere van.

kicsit megteveszto mert a diszkret eloszlasoknal poisson eloszlasnak a parametere $lambda$ azert mert az valamilyen ratat jelol, visoznt ez nem a poisson folytonositasa hanem a geometriai eloszlasnak

ez pl az hogy beallitunk egy ebresztot es nem tudjuk mikor fog csorogni, es akkor idovel exponencialisan nagyobb eselye van hogy csorogni fog, vagy random kimegyek a buszmegalloba es exponencialis idoben fog jonni a busz

$X tilde exp(lambda)$

azt jelenti hogy $X$ egy idopontot jelent exponencialis idoben

$
  X >= 0\
  FF_X (t) = 1 - e^(1 - lambda t)\
  f_X(t) = lambda dot e^(- lambda t) dot II_(t > 0)
$

nyolcas feladat
$
  X tilde N(6, 2^2)\
$
szorasnegyzet:
$
  D^2(x) = EE((X - EE X )^2)
$

mekkora valoszinueseg hogy legfeljebb 10 fok van

nem tudjuk mi a nagy fi, nem tudjuk kiszamolni

atalakitjuk standard normalissa
$
  PP(X <= 10) = PP(underbrace((X - 6)/2, N(0, 1^2)) <= (10 - 6)/2)\
  Phi(2) approx 0,96 dots
$

nezzunk egy exponencialis eloszlasut
= 10
$
  X tilde exp(2)\
  X' "reakcioido"\
  F_X (t) = 1 - e^(- lambda t) = cases(1 - e^(- 2 t)\, "  " t > 0, 0\, "           " t < 0)\
  f_X (t) = 2 dot e^(-2 t) dot II_(t > 0)
$

b)
$
  PP(X >= 0, 5) = 1 - PP(X < 0, 5) = 1 - F_X (0,5) = 1 - [1 - e^(-2 dot 0,5)] = 1/e\
$

haonlit az exponencialis a geometriaira mert igaz ra az orokifju tulajdonsag

azt jelenti hogy ha varunk es nem tortent semmi akkor onnantol kezdve igazabol ujracsinaljuk a szamolast
$
  PP(X >= 2 | X >= 1) = PP(X >= 1)
$

teljesen altalanosan
$
  PP(X >= a | X >= b) = PP(X >= a - b)
$

f)
$
  PP(X < t) = 1/2\
  1 - e^(-2 dot t) = 1/2\
  2 = e^(2t) ==> t = (ln 2)/2
$

= 5/3
veges sok erteket felvevo dobokockak osszege\
teljes valoszinuseg tetel
$
  k in {0, 1, dots, 12} "   " PP(X = k) = sum_(f = 0)^2 PP(X = k | f_("fej")) dot PP(f_("fej"))\
  #table(
    columns: 8,
    [f/k], [0], [1], [2], [3], [4], [5], [6],
    [0], [1], [], [], [], [], [], [],
    [1], [1/6], [], [], [], [], [], [],
    [2], [0], [0], [1/36], [2/36], [5/36], [], [1/36],
  )
$

0. sor 1/4 suly
1. sor 1/2 suly
2. sor 1/4 suly
es ezt osszeadni

= 5/6
$
  PP(X = -2) = 1/2\
  PP(X = 1) = 1/3\
  PP(X = 3) = 1/6\
  FF_X (t) = PP(X < t)
$
olyan pontokban kell vizsgalni ahol "tortenik valami", tehat amik meg vannak adva

minden -2 elott nullat vesz fel, -2ben meg van egy folytonos ugras 1/2-re 1-ig, utana megint egy ugras 5/6-ra

= 5/7
$
  f(x) = x dot x dot bb(1)_(x in [0, 1])
$
mindig teljesulnie kell hogy integralja 1
$
  1 = integral_RR f = integral_(-oo)^(+oo) c dot x dot bb(1)_(x in [0,1]) dif x = integral_0^1 c dot x dif x = [c dot 1/2 x^2]_0^1 = c dot 1/2 (1^2 - 0^2) = c/2 ==> c = 2
$

$
  PP(X in [1/4, 1/2]) = integral_([1/4, 1/2]) f = integral_(1/4)^(1/2) 2 dot x dif x = [2 dot 1/2 x^2]_(1/4)^(1/2) = (1/2)^2 - (1/4)^2 = 3/16\
  F_X (t) = integral_(-oo)^t f(x) dif x = integral_(-oo)^t 2 dot x dot bb(1)_(x in [0,1]) dif x\
  t <= 0 : 0 "  " t > 1 : 1 "  " t in (0, 1] : FF_X (t) = integral_0^t 2 dot x dif x = [2 dot 1/2 x^2]_0^t = t^2
$

= 5/5
$
  X : "fejek szama"\
  Y : "kockadobas erteke"\
  X in {0, dots, 6}\
  PP(X = k) =_(T union T) sum_(y in {1, dots, 6}) overbrace(PP(X = k | Y = y), "Bin"(y; 1/2)) dot PP(Y = y) = sum_y = bb(1)_(k < q) dot 1/(2^y) binom(y, k) dot 1/6 =\ = 1/6 dot sum_(y = 0)^k 1/(2^y) binom(y, k)
$
