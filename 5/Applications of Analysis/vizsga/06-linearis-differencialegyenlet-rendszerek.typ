// Typst source document for Exam Topic 6
// Analízis Alkalmazásai - 6. Tétel
// "A lineáris differenciálegyenlet-rendszer vizsgálata: homogén, inhomogén rendszerek. A megoldáshalmaz szerkezete."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (6. Tétel)
    ]
  ],
  footer: align(center)[
    #text(size: 10pt, fill: luma(100))[
      — #context counter(page).display() —
    ]
  ],
)

#set text(
  font: "Liberation Serif",
  lang: "hu",
  size: 11pt,
)

#set par(
  justify: true,
  leading: 0.7em,
)

#set heading(numbering: "1.1")

// Egyéni matematikai operátorok
#let Ker = math.op("Ker")
#let tr = math.op("tr")
#let diag = math.op("diag")

// Custom styles for boxes
#let defbox(title, body) = block(
  fill: rgb("f0f4f8"),
  stroke: (left: 4pt + rgb("2b5c8f")),
  inset: (x: 15pt, y: 12pt),
  radius: (right: 4pt),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("2b5c8f"))[#title]
    #v(4pt)
    #body
  ],
)

#let theorembox(title, body) = block(
  fill: rgb("fdf6f0"),
  stroke: (left: 4pt + rgb("c85a17")),
  inset: (x: 15pt, y: 12pt),
  radius: (right: 4pt),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("c85a17"))[#title]
    #v(4pt)
    #body
  ],
)

#let proofbox(title, body) = block(
  fill: rgb("f5f7f5"),
  stroke: (left: 4pt + rgb("3a7d44")),
  inset: (x: 15pt, y: 12pt),
  radius: (right: 4pt),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("3a7d44"))[#title]
    #v(4pt)
    #body
  ],
)

#let remarkbox(title, body) = block(
  fill: rgb("f9f9f9"),
  stroke: 0.5pt + luma(180),
  inset: (x: 12pt, y: 10pt),
  radius: 4pt,
  width: 100%,
  [
    #text(weight: "bold", fill: luma(80))[#title]
    #v(3pt)
    #body
  ],
)

#align(center)[
  #block(width: 90%, fill: rgb("fff8e7"), stroke: 1pt + rgb("e6a100"), inset: 10pt, radius: 4pt)[
    #text(weight: "bold")[6. Tétel:]
    _„A lineáris differenciálegyenlet-rendszer vizsgálata: homogén, inhomogén rendszerek. A megoldáshalmaz szerkezete.”_
  ]
]

#v(15pt)

= A lineáris differenciálegyenlet-rendszer fogalma

#defbox("Definíció: Elsőrendű lineáris differenciálegyenlet-rendszer", [
  Legyen $I subset bb(R)$ egy nyílt intervallum, $A: I -> bb(R)^(n times n)$ egy folytonos mátrixértékű függvény, és $b: I -> bb(R)^n$ egy folytonos vektorértékű függvény ($A in C(I, bb(R)^(n times n))$, $b in C(I, bb(R)^n)$).

  Az alábbi vektoros differenciálegyenletet *elsőrendű lineáris differenciálegyenlet-rendszernek* nevezzük:
  $ y' = A(x) y + b(x), $
  ahol $y: I -> bb(R)^n$ az ismeretlen, folytonosan differenciálható vektorértékű függvény ($y in C^1(I, bb(R)^n)$).

  - Ha $b(x) equiv 0$ minden $x in I$ esetén, akkor a rendszert *homogén lineáris differenciálegyenlet-rendszernek* nevezzük:
    $ y' = A(x) y. $
  - Ha $b(x) equiv.not 0$, akkor a rendszert *inhomogén lineáris differenciálegyenlet-rendszernek* nevezzük, az $y' = A(x) y$ egyenletet pedig az *inhomogén rendszerhez tartozó homogén rendszernek*.
])

#v(8pt)

Részletesen kiírva a komponensek szintjén, ha\ $y(x) = (y_1(x), y_2(x), dots, y_n(x))^T$, $b(x) = (b_1(x), b_2(x), dots, b_n(x))^T$ és $A(x) = (a_(i j)(x))_(i, j = 1)^n$:

$
  y'_1 (x) & = a_(1 1)(x) y_1 (x) + a_(1 2)(x) y_2 (x) + dots + a_(1 n)(x) y_n (x) + b_1 (x) \
  y'_2 (x) & = a_(2 1)(x) y_1 (x) + a_(2 2)(x) y_2 (x) + dots + a_(2 n)(x) y_n (x) + b_2 (x) \
           & dots.v \
  y'_n (x) & = a_(n 1)(x) y_1 (x) + a_(n 2)(x) y_2 (x) + dots + a_(n n)(x) y_n (x) + b_n (x).
$

#remarkbox("Egzisztencia és unicitás", [
  Mivel $A(x)$ és $b(x)$ folytonosak az $I$ intervallumon, az $f(x, y) = A(x) y + b(x)$ jobb oldal folytonos, és $y$ szerint Lipschitz-tulajdonságú minden kompakt részintervallumon:
  $ norm(f(x, y_1) - f(x, y_2)) = norm(A(x)(y_1 - y_2)) <= norm(A(x)) dot norm(y_1 - y_2). $
  Ezért a Picard–Lindelöf-tétel értelmében bármely $x_0 in I$ és $y_0 in bb(R)^n$ esetén a
  $ y' = A(x) y + b(x), quad y(x_0) = y_0 $
  kezdetiérték-problémának *egyértelműen létezik* megoldása, és lineáris rendszerekről lévén szó, ez a megoldás a teljes $I$ intervallumon értelmezett.
])

#v(10pt)

= A homogén rendszer megoldáshalmazának szerkezete

Tekintsük a homogén rendszert:
$ y' = A(x) y. $

Legyen $S_0 := {y in C^1(I, bb(R)^n) : y'(x) = A(x) y(x) quad (forall x in I)}$ a homogén rendszer összes megoldásának halmaza.

#theorembox("Tétel: A homogén megoldástér lineáris altere", [
  A homogén lineáris differenciálegyenlet-rendszer $S_0$ megoldáshalmaza a $C^1(I, bb(R)^n)$ vektortér egy *$n$-dimenziós altere*:
  $ dim S_0 = n. $
])

#v(8pt)

#proofbox("Bizonyítás", [
  1. *Altér tulajdonság (szuperpozíció elve):* \
    Legyen $y_1, y_2 in S_0$ két megoldás, és $c_1, c_2 in bb(R)$ tetszőleges konstansok. Ekkor a deriválás és a mátrixszorzás linearitása miatt:
    $ (c_1 y_1 + c_2 y_2)' = c_1 y'_1 + c_2 y'_2 = c_1 A(x) y_1 + c_2 A(x) y_2 = A(x)(c_1 y_1 + c_2 y_2). $
    Így $c_1 y_1 + c_2 y_2 in S_0$, vagyis $S_0$ valóban altér.

  2. *A dimenzió igazolása ($dim S_0 = n$):* \
    Rögzítsünk egy tetszőleges $x_0 in I$ pontot, és tekintsük az alábbi leképezést:
    $ L: S_0 -> bb(R)^n, quad L(y) := y(x_0). $
    - *Linearitás:* $L(c_1 y_1 + c_2 y_2) = c_1 y_1 (x_0) + c_2 y_2 (x_0) = c_1 L(y_1) + c_2 L(y_2)$.
    - *Injektivitás:* Ha $L(y) = y(x_0) = 0$, akkor $y$ megoldása az $y' = A(x) y$, $y(x_0) = 0$ Cauchy-feladatnak. Ennek az $y equiv 0$ is megoldása, így az unicitás miatt $y equiv 0$ az egész $I$-n. Tehát $Ker(L) = {0}$, azaz $L$ injektív.
    - *Szürjektivitás:* Tetszőleges $v in bb(R)^n$ esetén a Picard–Lindelöf-tétel garantálja egy olyan $y in S_0$ megoldás létezését, amelyre $y(x_0) = v$. Így $L$ szürjektív.

    Mivel $L: S_0 -> bb(R)^n$ vektortér-izomorfizmus, ezért $dim S_0 = n$.
])

#v(8pt)

#defbox("Definíció: Fundamentális rendszer és fundamentálmátrix", [
  - Az $S_0$ homogén megoldástér egy $y_1, y_2, dots, y_n in S_0$ bázisát a homogén rendszer *fundamentális megoldásrendszerének* nevezzük.
  - Ha az $y_1, dots, y_n$ megoldásokat oszlopvektorokként egy mátrixba rendezzük, megkapjuk az $Y(x) in bb(R)^(n times n)$ *fundamentálmátrixot*:
    $ Y(x) := [y_1(x) quad y_2(x) quad dots quad y_n(x)]. $
  - Mivel $y'_i = A(x) y_i$ minden $i = 1, dots, n$ esetén, a fundamentálmátrix kielégíti a mátrix-differenciálegyenletet:
    $ Y'(x) = A(x) Y(x). $
  - A homogén rendszer *általános megoldása* a fundamentális rendszer segítségével:
    $ y_h (x) = Y(x) c = sum_(i=1)^n c_i y_i (x) quad (c in bb(R)^n). $
])

#v(10pt)

= Wronski-determináns és Liouville-formula

#defbox("Definíció: Wronski-determináns", [
  Az $y_1, y_2, dots, y_n in S_0$ megoldásokhoz tartozó $Y(x)$ mátrix determinánsát *Wronski-determinánsnak* nevezzük:
  $ W(x) := det Y(x) = det [y_1(x) quad y_2(x) quad dots quad y_n(x)]. $
])

#v(8pt)

#theorembox("Liouville-formula (Jacobi–Liouville-tétel)", [
  Legyen $Y(x)$ az $y' = A(x) y$ homogén rendszer egy megoldásmátrixa az $I$ intervallumon. Ekkor a $W(x) = det Y(x)$ Wronski-determinánsra teljesül az alábbi differenciálegyenlet:
  $ W'(x) = tr(A(x)) dot W(x), $
  ahol $tr(A(x)) = sum_(i=1)^n a_(i i)(x)$ az $A(x)$ mátrix nyoma.

  Ennek következményeként tetszőleges $x_0, x in I$ esetén:
  $ W(x) = W(x_0) dot exp(integral_(x_0)^x tr(A(t)) dif t). $
])

#v(8pt)

#proofbox("Bizonyítás", [
  Legyenek $w_1^T, dots, w_n^T$ az $Y(x)$ mátrix sorai, így $W(x) = det Y(x)$. A determináns deriválási szabálya szerint a determináns deriváltja azon $n$ determináns összege, amelyekben rendre egyetlen sort deriválunk:
  $ W'(x) = sum_(i=1)^n det mat(w_1^T; dots.v; (w'_i)^T; dots.v; w_n^T). $
  Mivel $Y' = A Y$, az $i$-edik sor deriváltja:
  $ (w'_i (x))^T = sum_(k=1)^n a_(i k)(x) w_k (x)^T. $
  Ezt behelyettesítve, a $k != i$ tagoknál a determinánsban két azonos sor szerepel ($w_k^T$ kétszer), ami nullát ad. Így csak a $k = i$ tag marad meg:
  $
    W'(x) = sum_(i=1)^n a_(i i)(x) det mat(w_1^T; dots.v; w_i^T; dots.v; w_n^T) = (sum_(i=1)^n a_(i i)(x)) det Y(x) = tr(A(x)) W(x).
  $

  Ez egy elsőrendű lineáris (szeparábilis) differenciálegyenlet $W(x)$-re, melynek megoldása:
  $ W(x) = W(x_0) exp(integral_(x_0)^x tr(A(t)) dif t). $
])

#v(8pt)

#theorembox("Kritérium a megoldások lineáris függetlenségére", [
  Legyenek $y_1, y_2, dots, y_n in S_0$ a homogén rendszer megoldásai az $I$ intervallumon. Az alábbi állítások ekvivalensek:
  1. Az $y_1, dots, y_n$ megoldások lineárisan függetlenek $I$-n (vagyis fundamentális rendszert alkotnak);
  2. $W(x) != 0$ *minden* $x in I$ esetén;
  3. létezik *legalább egy* $x_0 in I$ pont, amelyre $W(x_0) != 0$.
])

#v(8pt)

#proofbox("Bizonyítás", [
  *(2) $==>$ (3):* triviális.

  *(3) $==>$ (2):* Mivel $exp(integral_(x_0)^x tr(A(t)) dif t) > 0$ minden $x in I$ esetén, a Liouville-formulából $W(x)$ vagy mindenhol nulla (ha $W(x_0) = 0$), vagy sehol sem nulla (ha $W(x_0) != 0$).

  *(3) $==>$ (1):* Ha $W(x_0) != 0$, akkor az $Y(x_0) c = 0$ egyenletrendszernek csak a $c = 0$ megoldása van, így az $y_1(x_0), dots, y_n (x_0)$ vektorok lineárisan függetlenek $bb(R)^n$-ben. Ha $sum c_i y_i equiv 0$, akkor $x_0$-ban is nulla, ezért $c = 0$. Tehát a megoldások lineárisan függetlenek.

  *(1) $==>$ (2):* Indirekt: tegyük fel, hogy valamely $x_1 in I$-ben $W(x_1) = 0$. Ekkor van olyan $c != 0$, hogy $Y(x_1) c = 0$. Az $y := Y c = sum c_i y_i$ függvény megoldása a homogén rendszernek, és $y(x_1) = 0$, így az unicitás miatt $y equiv 0$ az egész $I$-n. Ez nemtriviális lineáris kombináció, amely azonosan nulla, ami ellentmond a lineáris függetlenségnek.
])

#pagebreak()

= Az inhomogén rendszer megoldáshalmazának szerkezete

Tekintsük az inhomogén lineáris differenciálegyenlet-rendszert:
$ y' = A(x) y + b(x). $

Legyen $S := {y in C^1(I, bb(R)^n) : y'(x) = A(x) y(x) + b(x) quad (forall x in I)}$ az inhomogén rendszer összes megoldásának halmaza.

#theorembox("Tétel: Az inhomogén megoldáshalmaz szerkezete", [
  Az inhomogén rendszer $S$ megoldáshalmaza egy *$n$-dimenziós affin altér* a $C^1(I, bb(R)^n)$ vektortérben.

  Pontosabban: ha $y_p in S$ az inhomogén rendszer egy tetszőleges (rögzített) partikuláris megoldása, akkor az inhomogén rendszer általános megoldása a partikuláris megoldás és a homogén rendszer általános megoldásának összege:
  $ S = y_p + S_0 = {y_p + y_h : y_h in S_0}, $
  vagyis tetszőleges $y in S$ megoldás egyértelműen előáll
  $ y(x) = y_p (x) + Y(x) c quad (c in bb(R)^n) $
  alakban.
])

#v(8pt)

#proofbox("Bizonyítás", [
  1. *Direkt irány ($y_p + y_h in S$):* \
    Legyen $y_p in S$ (azaz $y'_p = A y_p + b$) és $y_h in S_0$ (azaz $y'_h = A y_h$). Ekkor $y := y_p + y_h$-ra:
    $ y' = y'_p + y'_h = (A y_p + b) + A y_h = A(y_p + y_h) + b = A y + b. $
    Így $y_p + y_h in S$.

  2. *Inverz irány ($y in S ==> y - y_p in S_0$):* \
    Legyen $y in S$ tetszőleges, és $u := y - y_p$. Ekkor:
    $ u' = y' - y'_p = (A y + b) - (A y_p + b) = A(y - y_p) = A u. $
    Tehát $u in S_0$, és $y = y_p + u$, ami igazolja az állítást.
])

#v(10pt)

= Az állandók variálásának módszere (Lagrange-módszer)

Az inhomogén rendszer egy $y_p (x)$ partikuláris megoldásának meghatározására a Lagrange-féle állandók variálásának módszerét alkalmazzuk.

Legyen $Y(x)$ a homogén $y' = A(x) y$ rendszer egy ismert fundamentálmátrixa.

#theorembox("Tétel: Állandók variálása rendszerekre", [
  Az inhomogén $y' = A(x) y + b(x)$ rendszer egy partikuláris megoldása kereshető
  $ y_p (x) = Y(x) c(x) $
  alakban, ahol $c: I -> bb(R)^n$ egy ismeretlen, folytonosan differenciálható vektorértékű függvény ($c(x) = (c_1(x), dots, c_n(x))^T$).

  Ekkor $c'(x)$ kielégíti az alábbi algebrai egyenletrendszert:
  $ Y(x) c'(x) = b(x), $
  amelyből az invertálható $Y(x)$ miatt:
  $ c'(x) = Y(x)^(-1) b(x). $

  Így egy partikuláris megoldás integrállal kifejezhető:
  $ y_p (x) = Y(x) integral_(x_0)^x Y(t)^(-1) b(t) dif t. $
])

#v(8pt)

#proofbox("Bizonyítás", [
  Helyettesítsük be az $y_p (x) = Y(x) c(x)$ alakot az inhomogén $y' = A(x) y + b(x)$ egyenletbe.

  A szorzat deriválási szabálya alapján:
  $ y'_p (x) = Y'(x) c(x) + Y(x) c'(x). $

  Mivel $Y(x)$ fundamentálmátrix, $Y'(x) = A(x) Y(x)$. Ezt beírva:
  $ y'_p (x) = A(x) Y(x) c(x) + Y(x) c'(x). $

  Az inhomogén egyenlet jobb oldala $y_p$-re:
  $ A(x) y_p (x) + b(x) = A(x) Y(x) c(x) + b(x). $

  A két oldal egyenlőségéből:
  $ A(x) Y(x) c(x) + Y(x) c'(x) = A(x) Y(x) c(x) + b(x), $
  amiből az $A(x) Y(x) c(x)$ tagot levonva:
  $ Y(x) c'(x) = b(x). $

  Mivel $Y(x)$ Wronski-determinánsa sehol sem nulla, $Y(x)$ minden $x in I$ pontban invertálható. Balról szorozva $Y(x)^(-1)$-gyel:
  $ c'(x) = Y(x)^(-1) b(x). $

  Integrálva $x_0$-tól $x$-ig:
  $ c(x) = integral_(x_0)^x Y(t)^(-1) b(t) dif t. $

  Visszahelyettesítve az $y_p (x) = Y(x) c(x)$ alakba, megkapjuk a tételben szereplő formulát.
])

#v(8pt)

#theorembox("Az inhomogén Cauchy-feladat megoldása", [
  Az $y' = A(x) y + b(x)$, $y(x_0) = y_0$ kezdetiérték-probléma egyértelmű megoldása:
  $ y(x) = Y(x) Y(x_0)^(-1) y_0 + Y(x) integral_(x_0)^x Y(t)^(-1) b(t) dif t. $
])

#v(10pt)

= Állandó együtthatós homogén rendszerek és a mátrix-exponenciális

Ha az $A(x) equiv A in bb(R)^(n times n)$ mátrix független $x$-től (állandó együtthatós rendszer), a homogén rendszer:
$ y' = A y. $

#defbox("Definíció: Mátrix-exponenciális", [
  Tetszőleges $A in bb(R)^(n times n)$ mátrix esetén a *mátrix-exponenciális* függvényt az alábbi abszolút konvergens hatványsorral definiáljuk:
  $ e^(x A) := sum_(k=0)^infinity (x^k A^k) / (k!) = I + x A + (x^2 A^2) / 2 + (x^3 A^3) / 6 + dots. $
])

#v(8pt)

#theorembox("Tétel: A mátrix-exponenciális mint fundamentálmátrix", [
  Az $Y(x) = e^(x A)$ mátrixfüggvényre teljesülnek az alábbiak:
  1. $(e^(x A))' = A e^(x A) = e^(x A) A$, vagyis $Y(x) = e^(x A)$ a homogén rendszer egy fundamentálmátrixa;
  2. $Y(0) = e^(0 A) = I$ (az egységmátrix);
  3. az $y' = A y$, $y(0) = y_0$ Cauchy-feladat egyértelmű megoldása:
    $ y(x) = e^(x A) y_0. $
])

#v(8pt)

#remarkbox("A mátrix-exponenciális kiszámítása a gyakorlatban", [
  - *Diagonalizálható mátrix esetén:* ha $A = P D P^(-1)$, ahol $D = diag(lambda_1, dots, lambda_n)$, akkor:
    $ e^(x A) = P e^(x D) P^(-1) = P diag(e^(x lambda_1), e^(x lambda_2), dots, e^(x lambda_n)) P^(-1). $
  - *Jordan-alak esetén:* ha $A$ nem diagonalizálható, a Jordan-féle normálalak segítségével számítható ki $e^(x A)$, ahol a Jordan-blokkok exponenciálisa polinomos-exponenciális tagokat tartalmaz.
])
