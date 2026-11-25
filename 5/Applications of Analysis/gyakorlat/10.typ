== Lineáris differenciálegyenletek

Előbb lineáris differenciálegyenletekkel foglalkoztunk, azon belül a homogén esetet néztük. Most nézzük általánosabban. Általában a lineáris d.e. olyan értelemben lineáris, hogy $y$ és $y'$ lineárisan van kifejezve:
$
  y'(x) + g(x) dot y(x) = b(x), " " g, b: I arrow RR, " " g, b in C(I)
$
Hasonlót oldottunk meg a $b equiv 0$ esetben: ez volt a homogén eset,
$
  y'(x) + g(x) dot y(x) = 0
$

/ 1. lépés: a homogén egyenlet megoldása. Ez egy szeparábilis eset:
  $
    y'(x) = -g(x) dot y(x)
  $
  A megoldás (ez nem triviális):
  $
    y_H (x) = c dot e^(-integral_tau^x g(s) dif s), " " c in RR
  $

Most már visszatérhetünk az eredeti, inhomogén feladathoz:
$
  y'(x) + g(x) dot y(x) = b(x)
$
Előadáson be van bizonyítva, hogy az inhomogén egyenlet általános megoldása felírható egy (tetszőleges) inhomogén megoldás és a homogén egyenlet összes megoldásának összegeként. Az ok: ha két különböző függvény is kiadja a $b$-t, akkor a két egyenlet különbsége a homogén egyenlet lesz (a $b$ kiesik). Ezért elegendő egyetlen megoldást ismernem, és abból az összes megoldást megkapom, ha hozzáadom a homogén egyenlet összes megoldását.

/ 2. lépés: az inhomogén egyenlet partikuláris megoldása. Keressünk megoldást olyan alakban, hogy az exponenciális függvény "számszorosai" (a konstans helyén függvénnyel) a megoldások:
  $
    y_P (x) = c(x) dot Phi(x), " ahol " Phi(x) = e^(-integral_tau^x g(s) dif s)
  $
  Behelyettesítve a differenciálegyenletbe:
  $
    (c(x) dot Phi(x))' + g(x) dot c(x) dot Phi(x) = b(x)\
    c'(x) dot Phi(x) + c(x) underbrace([Phi'(x) + g(x) Phi(x)], = 0) = b(x)\
    <==>_(Phi > 0) c'(x) = b(x)/(Phi(x)) in C ==> "létezik primitív függvénye"
  $
  Felírjuk a varázsigét: legyen $c(x)$ a $b(x)/(Phi(x))$ egy primitív függvénye, és kész is vagyunk.

  A fentebbi a *próbafüggvény-módszer* (az állandók variálása): úgymond próbálkozunk, hogy hátha ez lesz a megoldás.

/ 3. lépés: az inhomogén egyenlet általános megoldása.
  $
    y(x) = y_H (x) + y_P (x)
  $

Ehhez jön még a *kezdetiérték-feladat* megoldása: a $c$ konstanst a kezdeti feltételből határozzuk meg.

=== 1. példa

$
  y'(x) + 2/x dot y(x) = x^3, " " y(1) = 1
$
Itt $x != 0$.

/ 1. lépés: A feltétel az, hogy $g, b in C$ kell. Mivel a kezdeti érték $x = 1$-ben van, elég a pozitív oldalon keresnem a megoldást: $y in C(0, +infinity)$.
  $
    g(x) = 2/x
  $
  A formulánk szerint:
  $
    y_H (x) = c dot e^(-integral_1^x g(s) dif s) = c dot e^(-2 integral_1^x 1/s dif s) = c dot e^(-2(ln(x) - ln(1))) = c dot e^(-2 ln(x)) = c dot x^(-2)\
    y_H (x) = c/x^2, " " Phi(x) = 1/x^2, " " c in RR " tetszőleges"
  $

/ 2. lépés: inhomogén partikuláris megoldás. Olyan alakban keressük, hogy
  $
    y_P (x) = c(x) dot Phi(x) = c(x) dot 1/x^2
  $
  A differenciálegyenletbe helyettesítve:
  $
    (c(x) dot 1/x^2)' + 2/x dot c(x) dot 1/x^2 = x^3\
    c'(x) dot 1/x^2 underbrace(+ c(x) dot (-2)/x^3 + c(x) dot 2/x^3, 0) = x^3\
    <==> c'(x) dot 1/x^2 = x^3\
    c'(x) = x^5, " " I = (0, +infinity)
  $
  Például legyen $c(x) = x^6/6$, ekkor $y_P (x) = x^6/6 dot 1/x^2 = x^4/6$ egy partikuláris megoldás.

/ 3. lépés: az általános megoldás. Az eredeti differenciálegyenletre:
  $
    y(x) = y_H (x) + y_P (x) = c dot 1/x^2 + x^4/6, " " x in (0, +infinity)
  $
  Kezdetiérték-feladat: $y(1) = 1$, de $y(1) = c dot 1/1^2 + 1^4/6$, tehát
  $
    c + 1/6 = 1 ==> c = 5/6 ==> y(x) = 5/6 dot 1/x^2 + x^4/6
  $

=== 2. példa

$
  y'(x) dot sin(x) - y(x) dot cos(x) = -1, " " y(pi/2) = 1
$
Itt annyi csavar van, hogy az egyenlet a szögfüggvények miatt nem a megszokott $y' + g y = b$ alakban van (lineáris, csak az együtthatók függnek $x$-től). Hogy ebből a kívánt alak legyen, osszunk le $sin(x)$-szel. Viszont akkor figyelnem kell, milyen megoldást tudok garantálni: így csak olyan $x$-ekkel tudok dolgozni, ahol $sin(x) != 0$, és globálisan egyértelmű megoldást csak olyan intervallumon tudok adni, ahol $sin(x)$ nem nulla -- ez egy megkötés. Így rögtön kizárt az $x = k dot pi$ ($x = 0, pi, -pi, dots$). Mivel folytonosnak kell lennie, nem szakadhat, tehát az intervallum, amin nézni fogom: $x in (0, pi)$.
$
  y'(x) - cos(x)/sin(x) dot y(x) = (-1)/sin(x)\
  g(x) = -cos(x)/sin(x), " " g in C(I)
$

/ 1. lépés: A homogén egyenlet megoldása:
  $
    y_H (x) = c dot e^(-integral_(pi/2)^x (-cos(s)/sin(s)) dif s)\
    integral_(pi/2)^x cos(s)/sin(s) dif s =_(integral f'/f, " " f > 0) [ln(sin(s))]_(pi/2)^x = ln(sin(x)) - ln(sin(pi/2)) = ln(sin(x))
  $
  $
    y_H (x) = c dot e^(ln(sin(x))) = c dot sin(x)
  $

/ 2. lépés: Keresünk partikuláris megoldást, tehát $c$ helyett $c(x)$:
  $
    y_P (x) = c(x) dot sin(x)
  $
  Ha behelyettesítjük (akár az eredetibe is lehet, ha nem felejtjük el, hogy új intervallumunk van):
  $
    c'(x) sin(x) + c(x) cos(x) - cos(x)/sin(x) dot c(x) sin(x) = (-1)/sin(x)\
    c'(x) dot sin(x) = (-1)/sin(x) <==> c'(x) = (-1)/(sin^2 (x))\
    "legyen " c(x) = op("ctg")(x)
  $
  A partikuláris megoldás így $y_P (x) = c(x) dot Phi(x) = op("ctg")(x) dot sin(x) = cos(x)$.

/ 3. lépés: Általános megoldás:
  $
    y(x) = y_H (x) + y_P (x) = c sin(x) + cos(x), " " c in RR " tetszőleges, " x in (0, pi)
  $
  Kezdetiérték-feladat:
  $
    y(pi/2) = c sin(pi/2) + cos(pi/2) = 1 <==> c = 1 ==> y(x) = sin(x) + cos(x)
  $

=== Megjegyzés: a próbafüggvény speciális $b(x)$ esetén

A próbafüggvényt néha konkrétabban is megválaszthatjuk speciális $b(x)$ esetén. Példa:
$
  y'(x) + 3y(x) = 3 e^x, " ötlet: " y_P (x) := A e^x\
  ==> A e^x + 3 A e^x = 3 e^x\
  4A e^x = 3 e^x\
  A = 3/4
$
Ez akkor működik jól, ha
+ $g$ konstans (állandó együtthatós eset),
+ $b(x)$ polinom, exponenciális függvény, trigonometrikus függvény, vagy ezek szorzata.

Ilyenre ZH-n *nem* kell számítani.

#pagebreak()

== Lineáris differenciálegyenlet-rendszerek

Általában úgy néznek ki, hogy a függvény, amit keresünk, nem valós, hanem vektorértékű: nem $y$-t keresünk, hanem $y_1, y_2, dots$ -t, tehát $y: I arrow RR^n$. Az $n$ összefüggés olyan lesz, hogy a deriváltak az $y$ értékek lineáris kombinációjaként lesznek kifejezve. Nagyjából így fog kinézni:
$
  y'_1 (x) = g_(1 1) (x) y_1 (x) + g_(1 2) (x) y_2 (x) + dots + g_(1 n) (x) y_n (x) + b_1 (x)\
  y'_2 (x) = g_(2 1) (x) y_1 (x) + g_(2 2) (x) y_2 (x) + dots + g_(2 n) (x) y_n (x) + b_2 (x)\
  dots.v\
  y'_n (x) = g_(n 1) (x) y_1 (x) + g_(n 2) (x) y_2 (x) + dots + g_(n n) (x) y_n (x) + b_n (x)
$
Tömörebben:
$
  y'(x) = G(x) dot y(x) + b(x), " " G(x) = [g_(i j) (x)]_(i, j = 1)^n: I arrow RR^(n times n)
$

Gyakorlatban sokszor:
- az $I$ egy felosztását vesszük pici lépésközzel,
- elindulunk az $I$-n, és egy konkrét értéket veszünk, megpróbáljuk megoldani az egyenletet,
- minden osztópontban kiszámoljuk a $G(x_n) =: A in RR^(n times n)$ (konstans) mátrixot,
- megoldjuk az $y'(x) = A y(x) + b(x)$ egyenletet.

Mi csak a $G(x) = A$ állandó együtthatós esettel foglalkozunk.

=== Példa

$
  cases(
    y'_1 (x) = y_1 (x) + 2 y_2 (x) + e^x,
    y'_2 (x) = 2 y_1 (x) + y_2 (x)
  )
$
átírva:
$
  y'(x) = vec(y'_1 (x), y'_2 (x)) = mat(1, 2; 2, 1) vec(y_1 (x), y_2 (x)) + vec(e^x, 0), " és " y(0) = vec(1, 1/2)
$

/ 1. lépés: a homogén egyenlet megoldása. Az ötlet: nagyon hasonlít az előző esethez, van benne egy kicsi plusz. A lineáris homogén egyenlet állandó együtthatóval: $y'(x) = alpha dot y(x)$, itt a megoldás $y(x) = c dot e^(alpha x)$.

  A rendszer esetén keressünk megoldást olyan alakban, hogy
  $
    y(x) = e^(lambda x) vec(v_1, v_2, dots.v, v_n) = e^(lambda x) v ==> y'(x) = lambda e^(lambda x) v = A e^(lambda x) v
  $
  Ez a sajátérték-egyenlet: keressük az $y(x) = e^(lambda x) v$ alakú megoldást $<==> lambda v = A v$.

  A sajátértékek:
  $
    det(A - lambda I) = mat(delim: "|", 1 - lambda, 2; 2, 1 - lambda) = 0\
    (1 - lambda)^2 - 4 = 0\
    lambda_1 = -1, " " lambda_2 = 3
  $

  A sajátvektorok:
  $
    lambda_1 = -1: " " mat(2, 2; 2, 2) vec(v_1, v_2) = vec(0, 0)\
    2 v_1 + 2 v_2 = 0\
    v_2 = -v_1, " " v_1 in RR " tetszőleges"\
    ==> vec(v_1, -v_1) " sajátvektor, pl. " vec(1, -1)\
    ==> phi_1 (x) = e^(-x) vec(1, -1)
  $
  $
    lambda_2 = 3: " " mat(-2, 2; 2, -2) vec(v_1, v_2) = vec(0, 0)\
    -2 v_1 + 2 v_2 = 0\
    v_2 = v_1, " " v_1 in RR " tetszőleges"\
    ==> vec(v_1, v_1) " sajátvektor, pl. " vec(1, 1)\
    ==> phi_2 (x) = e^(3x) vec(1, 1)
  $

  Elmélet: a homogén rendszer megoldáshalmaza, $cal(M)$, $n$-dimenziós altér. Most $phi_1, phi_2$ lineárisan független és $cal(M)$ $2$-dimenziós, így
  $
    cal(M) = op("Span")(phi_1, phi_2) ==> y_H (x) = c_1 dot e^(-x) vec(1, -1) + c_2 dot e^(3x) vec(1, 1)
  $
  Ez vektoriálisan úgy néz ki, hogy
  $
    Phi(x) = [phi_1 (x), phi_2 (x)] = mat(e^(-x), e^(3x); -e^(-x), e^(3x))\
    y_H (x) = Phi(x) vec(c_1, c_2) = phi_1 (x) c_1 + phi_2 (x) c_2, " " x in I = RR
  $
