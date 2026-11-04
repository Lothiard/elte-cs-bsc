= Feltételes szélsőérték

Egyetlen téma maradt az első ZH anyagához: a feltételes szélsőérték.

== Emlékeztető: lokális szélsőérték (feltétel nélkül)

Többváltozós függvények szélsőértékéről beszéltünk Analízis 3-on: a valós értékeket össze tudjuk hasonlítani egymással, és a lokális szélsőértékeket keressük.
$
  f: RR^n arrow RR
$
A főbb eredmények a valós (egyváltozós) eset főbb kiterjesztései.

/ Elsőrendű szükséges feltétel: Ezt arra használtuk, hogy a belső pontokban mikor lehet egyáltalán lokális szélsőérték.
  $
    a in cal(D)_f, " " f in D {a}
  $
  Ha $f$-nek $a$-ban lokális szélsőértéke van, akkor
  $
    ==> f'(a) = 0
  $
  azaz itt az $1 times n$-es mátrix csupa nullát tartalmaz. Elképzelhetjük vektorként is (amit gradiensnek hívtunk):
  $
    [partial_1 f(a), dots, partial_n f(a)] = 0
  $

/ Másodrendű elégséges feltétel: Ha az elsőrendű feltétel teljesül, és a függvény kétszer differenciálható, akkor a Hesse-mátrix segítségével mondhatunk valamit a függvény konvexitásáról. Ha pozitív definit, akkor (lokálisan) konvex a függvény, és minimuma van -- az érintősík ilyenkor vízszintes. Ha negatív definit, akkor konkáv, és a függvénynek maximuma van.
  $
    a in "int" cal(D)_f, " " f in D^2 {a} " és " f'(a) = 0
  $
  Ekkor
  $
    f''(a) " pozitív definit" ==> "lok. min."\
    f''(a) " negatív definit" ==> "lok. max."\
    f''(a) " indefinit" ==> "nincs szélsőérték"
  $
  Vannak olyan esetek is, amikor a tétel nem mond semmit, és nem tudjuk eldönteni vele.

== A feltételes szélsőérték feladata

Feltételes szélsőértéknél egy kicsit megcsavarjuk a feladatot: többváltozós függvényem van, de a szélsőértéket csak egy feltétel által kijelölt halmazon vizsgálom. Egy alakzatot meg lehet adni függvénygrafikonként, paraméteresen, és -- ami kicsit problémásabb volt -- implicit alakban, egyenletként. Ezt a problémát visszük tovább: nem a teljes értelmezési tartományban keressük a szélsőértéket, hanem egy adott halmazon.
$
  f: RR^n arrow RR " célfüggvény"
$
amire a minimumot/maximumot keresem, mellette pedig van néhány *feltételfüggvény*:
$
  g_1, g_2, dots, g_k: RR^n arrow RR
$
Csak azok a pontok érdekelnek, ahol a feltételfüggvények mindegyike nulla:
$
  H_g = {x in RR^n : g_1(x) = 0, g_2(x) = 0, dots, g_k (x) = 0}
$
és csak a $H_g$ pontjaira keresünk szélsőértéket.

=== Példa

$
  f(x, y) = sqrt(x^2 + y^2) = norm((x, y))_2 " (az origótól vett távolság)"
$
Ennek mi a legnagyobb lehetséges értéke? Nincs neki, tetszőlegesen nagy lehet. A lehető legkisebb értéke $0$. A $0$ az egyetlen lokális szélsőérték: lokális minimum; maximum nincs.

Bonyolítsuk: tegyük hozzá feltételnek, hogy
$
  g(x, y) = 3x - y + 1 = 0
$
Melyik pontok érvényesek itt?
$
  y = 3x + 1
$
ez egy egyenes pontjai. Geometriailag azt a feladatot akarom megoldani, hogy mi az egyenes origóhoz legközelebbi pontja. Ezt már nem olyan egyszerű megmondani -- ez lenne a feltételes lokális minimum.

Ha a geometriát elfelejtjük, egy lehetséges megoldás, hogy visszavezetjük sima, feltétel nélküli szélsőérték-feladatra.

/ 1. megoldás: behelyettesítés. Az $f$ értéke $H_g$-n, ahol $y = 3x + 1$:
  $
    f(x, 3x + 1) = sqrt(x^2 + (3x + 1)^2) = sqrt(10x^2 + 6x + 1)
  $
  és erre vizsgálok szélsőértéket, de erre már nincs feltétel.

  Egy apróság, amit érdemes megjegyezni: ha elkezdeném megoldani, deriválni kéne, ami a négyzetgyök miatt kicsit ronda. Mivel a négyzetgyök szigorúan monoton (minél nagyobb az argumentum, annál nagyobb a gyök, és vice versa), a gyökfüggvény minimalizálása ugyanaz, mint az argumentumáé:
  $
    h(x) = 10x^2 + 6x + 1 " min./max. helye ugyanaz"
  $
  tehát elhagyhatom a gyököt. Az ilyesmi akkor hasznos, ha nem tudok kifejezni változót, hanem az eredeti alakban kell vele küzdeni.

/ 2. megoldás: Lagrange-függvény. Az ötlet az, hogy bevezetünk egy új változót ($lambda$):
  $
    L(x, y, lambda) = f(x, y) + lambda dot g(x, y)
  $
  Ha olyan pontot veszek, ahol $f$-nek szélsőértéke van a feltételen, akkor ott $g(x, y) = 0$, tehát a $lambda dot g$ tag nem változtat az összegen. Ha viszont elmozdulok a ponttól, akkor már változni fog, és ehhez kell a $lambda$. A tételben ezt rögtön a deriváltra írjuk fel.

  Most a példában az egyszerűsítést használva $f(x, y) = x^2 + y^2$ (a gyököt elhagyjuk).

*Szükséges feltétel.* Legyen $a in "int" cal(D)_f inter cal(D)_g$, $f, g in D {a}$. Ha $f$-nek $a$-ban feltételes lokális szélsőértéke van, és $g'(a) != 0$, akkor
$
  exists lambda in RR: L'(a, lambda) = 0
$
Más szóval: ha $f$-nek $H_g$-n lokális szélsőértéke van, akkor van olyan $lambda in RR$, amivel az $L$ Lagrange-függvény deriváltja nulla.

A példában:
$
  L(x, y, lambda) = (x^2 + y^2) + lambda dot (3x - y + 1)
$
$
  partial_x L = 2x + 3 lambda = 0 ==> x = -3/2 lambda\
  partial_y L = 2y - lambda = 0 ==> y = 1/2 lambda\
  partial_lambda L = 3x - y + 1 = 0 ==> -9/2 lambda - 1/2 lambda + 1 = 0
$
(A $lambda$ szerinti deriválás éppen a feltételt adja vissza, mert az $x^2 + y^2$ tag nem függ $lambda$-tól.)
$
  lambda = 1/5, " " x = -3/10, " " y = 1/10
$
Egyetlen pontot kaptam, tehát csak ebben a pontban lehet feltételes lokális szélsőérték. Ahhoz, hogy a tétel alkalmazható legyen, még teljesülnie kell, hogy
$
  g'(a) != 0, " ahol " g'(x, y) = mat(delim: "[", 3, -1) != 0
$
és ez most teljesül.

A kérdés az, hogy van-e valami elégséges feltétel, amivel beláthatjuk, hogy ez valóban szélsőérték. Van; hasonló lesz az eredeti elégséges feltételhez. Nem nagyon fogjuk ezt csinálni, mert eléggé általános megkötés. Az egyik módszer, hogy a Lagrange-függvény Hesse-mátrixának definitségét nézzük -- csak az a baj, hogy ez sokszor nem működik, vagyis túl sokszor jön ki az az eset, hogy a módszer nem alkalmazható / nem mond semmit.

Az eredeti esetben azt vizsgáltuk, hogy
$
  chevron.l f''(a) h, h chevron.r
$
nagyobb vagy kisebb-e nullánál, ahol $h != 0$. Most csak a $H_g$ mentén kell ezt vizsgálni, ugyanígy, azzal a különbséggel, hogy
$
  chevron.l L''(a) h, h chevron.r, " " forall h != 0 " és " chevron.l g'(a), h chevron.r = 0 " esetén"
$

*Elégséges feltétel.* Legyen $a in "int" cal(D)_f inter cal(D)_g$, $f, g in D^2 {a}$, és legyen $lambda$ olyan, amivel teljesül a szükséges feltétel. Ekkor ha ($L''(a, lambda)$ az $L$ második deriváltja az $x$ változók szerint)

- $L''(a, lambda)$ feltételesen pozitív definit $==>$ lok. min.,
- $L''(a, lambda)$ feltételesen negatív definit $==>$ lok. max.,
- $L''(a, lambda)$ feltételesen indefinit $==>$ nincs szélsőérték.

Itt
$
  L''(a, lambda) " feltételesen pozitív definit" <==> chevron.l L''(a, lambda) h, h chevron.r > 0\
  "minden " h != 0, " " chevron.l g'(a), h chevron.r = 0 " vektorra"
$

*A példában.*

/ 1. lépés: Azt vizsgálom, hogy milyen $h$ vektorokat kell vizsgálni:
  $
    chevron.l g'(a), mat(h_1; h_2) chevron.r = chevron.l mat(3; -1), mat(h_1; h_2) chevron.r = 3h_1 - h_2 = 0
  $
  tehát $h_2 = 3h_1$, azaz $h = mat(h_1; 3h_1)$.

/ 2. lépés: Kell a második derivált. Ilyenkor már csak $x, y$ szerint kell deriválni, a $lambda$ már nem kell:
  $
    L(x, y, lambda) = (x^2 + y^2) + lambda (3x - y + 1)\
    partial_((x, y)) L(x, y, lambda) = (2x + 3 lambda, " " 2y - lambda)\
    partial_((x, y)^2) L(x, y, lambda) = mat(delim: "[", 2, 0; 0, 2)
  $
  Ez a mátrix feltételesen pozitív definit -- sőt, feltétel nélkül is az, mert diagonális, a sajátértékei a főátlóban állnak ($2 > 0$). A feltételes esetben viszont meg kell nézni a kapott mátrixot az $a$ pontban, és skalárisan szorozni $h$-val, ahol az előző levezetés alapján $h = mat(h_1; 3h_1)$:
  $
    chevron.l partial_((x, y)^2) L(a, lambda) h, h chevron.r = chevron.l mat(delim: "[", 2, 0; 0, 2) dot mat(h_1; 3h_1), mat(h_1; 3h_1) chevron.r = 2h_1^2 + 18 h_1^2 =_(h_1 != 0) 20 h_1^2 > 0
  $
  tehát feltételesen pozitív definit, vagyis *lokális minimum* van.

#pagebreak()

=== Második példa

Nézzünk egy feladatot túlmagyarázás nélkül:
$
  f(x, y) = x y + 12, " " (x, y) in RR^2
$
Keressük a lokális szélsőértékeit az $x^2 + y^2 = 8$ feltétel mellett. Itt kifejezetten undorító lenne, ha megpróbálnánk $x$-et $y$-ból kifejezni általánosan.

Hogy lesz ebből feltételfüggvény? Nullára rendezzük:
$
  g(x, y) = x^2 + y^2 - 8
$
Ahol ez nulla, ott szeretnénk a függvényértéket min-/maximalizálni.

/ 1. szükséges feltétel: (most jelöljük inkább így)
  $
    L_lambda (x, y) = f(x, y) + lambda g(x, y) = (x y + 12) + lambda (x^2 + y^2 - 8)
  $
  Keressük azokat az $(x_0, y_0)$ és $lambda$ értékeket, ahol
  $
    partial_x L_lambda (x, y) = y + lambda dot 2x = 0\
    partial_y L_lambda (x, y) = x + lambda dot 2y = 0\
    g(x, y) = x^2 + y^2 - 8 = 0
  $
  Az elsőből kifejezem $y$-t:
  $
    y = -2 lambda x
  $
  a másodikba:
  $
    x - 4 lambda^2 x = 0\
    x (1 - 4 lambda^2) = 0
  $
  Kétféle módon teljesülhet:

  / ha $x = 0$: Ekkor $y = 0$, de nem teljesül a feltétel $==>$ nem megoldás.
  / ha $1 - 4 lambda^2 = 0$: Ekkor $lambda = plus.minus 1/2$.

  Ha $lambda = 1/2$:
  $
    y = -x ==> x^2 + (-x)^2 - 8 = 0 ==> x^2 = 4
  $
  ha $x = 2 ==> y = -2$ és $lambda = 1/2$;\
  ha $x = -2 ==> y = 2$ és $lambda = 1/2$.

  Ha $lambda = -1/2$:
  $
    y = x ==> x^2 + x^2 - 8 = 0 ==> x^2 = 4
  $
  ha $x = 2 ==> y = 2$ és $lambda = -1/2$;\
  ha $x = -2 ==> y = -2$ és $lambda = -1/2$.

  Tehát négy pontot kaptam, ezek a feltételes lokális szélsőérték *jelöltjei*.

Kell még: $g'(a) != 0$:
$
  g'(x, y) = mat(2x, 2y) ==> g'(a) = (plus.minus 4, plus.minus 4)
$
Akármilyen pontot írok be, ez nem lesz nullvektor.

/ 2. elégséges feltétel: Alkalmazzuk az elégséges feltételt: a $chevron.l L''_lambda (x, y) h, h chevron.r$ előjelét vizsgáljuk az $a$ pontokban, ahol $h != 0$ és $chevron.l g'(a), h chevron.r = 0$.
  $
    L'_lambda (x, y) = (y + 2 lambda x, " " x + 2 lambda y)\
    L''_lambda (x, y) = mat(delim: "[", 2 lambda, 1; 1, 2 lambda)
  $

  / ha $(x, y, lambda) = (2, -2, 1/2)$:
    $
      chevron.l g'(a), h chevron.r = chevron.l mat(4; -4), mat(h_1; h_2) chevron.r = 4h_1 - 4h_2 = 0\
      h_1 = h_2 " és " h_1 != 0, " " h = mat(h_1; h_1)\
      lambda = 1/2 ==> chevron.l mat(delim: "[", 1, 1; 1, 1) dot mat(h_1; h_1), mat(h_1; h_1) chevron.r = 4h_1^2 > 0
    $
    tehát feltételesen pozitív definit, vagyis *lokális minimum* ($f(2, -2) = 8$).

Így tovább a többivel, nagyjából ugyanaz a menet. (Az eredmény: $(-2, 2)$ szintén lokális minimum, $f = 8$; $(2, 2)$ és $(-2, -2)$ lokális maximum, $f = 16$, mert ott $lambda = -1/2$, $h = mat(h_1; -h_1)$ és $chevron.l L'' h, h chevron.r = -4h_1^2 < 0$.)
