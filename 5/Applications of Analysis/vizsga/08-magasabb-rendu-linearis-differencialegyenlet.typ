// Typst source document for Exam Topic 8
// Analízis Alkalmazásai - 8. Tétel
// "Magasabb rendű lineáris differenciálegyenlet. Az átviteli elv. A megoldáshalmaz szerkezete. Az állandók variálásának a módszere."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (8. Tétel)
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
    #text(weight: "bold")[8. Tétel:]
    _„Magasabb rendű lineáris differenciálegyenlet. Az átviteli elv. A megoldáshalmaz szerkezete. Az állandók variálásának a módszere.”_
  ]
]

#v(15pt)

= A magasabb rendű lineáris differenciálegyenlet fogalma

A fizikai modellekben (például csillapított vagy gerjesztett rezgések) központi szerepet töltenek be a magasabb rendű lineáris differenciálegyenletek.

#defbox("Definíció: n-edrendű lineáris differenciálegyenlet", [
  Legyen $n in bb(N)^+$, $I subset bb(R)$ nyílt intervallum. Adottak az $a_0, a_1, dots, a_(n-1): I -> bb(K)$ és $c: I -> bb(K)$ folytonos együttható- és zavarófüggvények (ahol $bb(K) = bb(R)$ vagy $bb(C)$).

  Az alábbi egyenletet *explicit $n$-edrendű lineáris differenciálegyenletnek* nevezzük:
  $ y^((n))(x) + sum_(k=0)^(n-1) a_k (x) y^((k))(x) = c(x) quad (x in I). $

  - Ha $c(x) equiv 0$ az $I$ intervallumon, akkor az egyenlet *homogén*.
  - Ha létezik olyan $x in I$, ahol $c(x) != 0$, akkor az egyenlet *inhomogén*.

  Egy $y: I -> bb(K)$ függvény az egyenlet *megoldása*, ha $y in C^n (I)$, és az egyenletet minden $x in I$ pontban kielégíti.
])

#v(8pt)

#defbox("Definíció: Kezdetiérték-probléma (Cauchy-feladat)", [
  Adottak a $tau in I$ kezdeti alappont és a $xi_0, xi_1, dots, xi_(n-1) in bb(K)$ kezdeti értékek. A fenti $n$-edrendű lineáris differenciálegyenletre vonatkozó *kezdetiérték-probléma* olyan $y in C^n (I)$ megoldás keresése, amely kielégíti az alábbi $n$ darab kezdeti feltételt:
  $ y(tau) = xi_0, quad y'(tau) = xi_1, quad dots, quad y^((n-1))(tau) = xi_(n-1). $
])

#v(10pt)

= Az átviteli elv (transzformáció elsőrendű rendszerré)

A magasabb rendű lineáris differenciálegyenletek elméletének alapja az *átviteli elv*: minden $n$-edrendű lineáris differenciálegyenlet ekvivalens módon átírható egy elsőrendű, $n$-dimenziós lineáris differenciálegyenlet-rendszerré.

#theorembox("Tétel: az átviteli elv", [
  Legyen $y in C^n (I)$ az $n$-edrendű lineáris differenciálegyenlet egy megoldása. Vezessük be az $Y: I -> bb(K)^n$ vektorértékű függvényt:
  $ Y(x) := vec(y_1 (x), y_2 (x), y_3 (x), dots.v, y_n (x)) := vec(y(x), y'(x), y''(x), dots.v, y^((n-1))(x)). $

  Ekkor az $Y$ vektorfüggvény megoldása az alábbi elsőrendű inhomogén lineáris differenciálegyenlet-rendszernek:
  $ Y'(x) = A(x) Y(x) + b(x) quad (x in I), $
  ahol a kísérőmátrix $A(x) in bb(K)^(n times n)$ és a szabad tag $b(x) in bb(K)^n$:
  $
    A(x) = mat(
      0, 1, 0, dots, 0;
      0, 0, 1, dots, 0;
      dots.v, dots.v, dots.v, dots.down, dots.v;
      0, 0, 0, dots, 1;
      -a_0 (x), -a_1 (x), -a_2 (x), dots, -a_(n-1)(x)
    ), quad b(x) = vec(0, 0, dots.v, 0, c(x)).
  $

  *Megfordítva:* ha $Y = (y_1, y_2, dots, y_n)^T: I -> bb(K)^n$ megoldása a fenti rendszernek, akkor annak első komponense, $y := y_1$ $n$-szer folytonosan differenciálható, és megoldása az $n$-edrendű egyenletnek.
])

#v(8pt)

#proofbox("Bizonyításvázlat (átviteli elv)", [
  1. *Direkt irány:* Ha $y in C^n (I)$ megoldás, akkor az $y_1 = y$, $y_2 = y'$, $dots$, $y_n = y^((n-1))$ választással:
    $ y'_1 = y_2, quad y'_2 = y_3, quad dots, quad y'_(n-1) = y_n, $
    $ y'_n = y^((n)) = -a_0 (x) y_1 - a_1 (x) y_2 - dots - a_(n-1)(x) y_n + c(x). $
    Ez pontosan az $Y' = A Y + b$ mátrixegyenlet.

  2. *Fordított irány:* Ha $Y$ megoldása a rendszernek, az első $n-1$ egyenletből $y_2 = y'_1$, $y_3 = y''_1$, $dots$, $y_n = y_1^((n-1))$. Ezt az utolsó egyenletbe írva $y_1^((n)) + sum_(k=0)^(n-1) a_k (x) y_1^((k)) = c(x)$ adódik, vagyis $y = y_1$ megoldja az $n$-edrendű egyenletet.
])

#v(8pt)

#theorembox("Következmény: létezési és egyértelműségi tétel", [
  A lineáris differenciálegyenlet-rendszerekre vonatkozó Picard–Lindelöf-tétel és az átviteli elv következménye:

  minden $tau in I$ alappontra és $xi_0, dots, xi_(n-1) in bb(K)$ kezdeti értékekre az $n$-edrendű lineáris differenciálegyenletre vonatkozó Cauchy-feladatnak *egyértelműen létezik megoldása*, és ez a megoldás a teljes $I$ intervallumon értelmezett.
])

#v(10pt)

= A megoldáshalmaz szerkezete

Az átviteli elv segítségével a megoldástér szerkezete visszavezethető a lineáris rendszerekre.

== A homogén egyenlet megoldásterének szerkezete

#defbox("Definíció: homogén megoldástér", [
  Jelölje $M_h$ a homogén egyenlet ($c equiv 0$) $I$-n értelmezett megoldásainak halmazát:
  $ M_h := {y in C^n (I) : y^((n))(x) + sum_(k=0)^(n-1) a_k (x) y^((k))(x) = 0 quad (forall x in I)}. $
])

#v(8pt)

#theorembox("Tétel: a homogén megoldástér dimenziója", [
  1. $M_h$ a $C^n (I)$ függvénytér egy *$n$-dimenziós altere* a $bb(K)$ test felett:
    $ dim M_h = n. $
  2. $M_h$ bármely $n$ elemű bázisát $(phi_1, phi_2, dots, phi_n)$ a homogén egyenlet *alaprendszerének* (fundamentálrendszerének) nevezzük.
  3. A homogén egyenlet általános megoldása:
    $ y_h (x) = sum_(k=1)^n c_k phi_k (x) = c_1 phi_1 (x) + c_2 phi_2 (x) + dots + c_n phi_n (x) quad (c_k in bb(K)). $
])

#v(8pt)

#proofbox("Bizonyításvázlat", [
  Tekintsük egy rögzített $tau in I$ pontban az alábbi $L: M_h -> bb(K)^n$ lineáris leképezést:
  $ L(y) := vec(y(tau), y'(tau), y''(tau), dots.v, y^((n-1))(tau)). $
  - *Injektivitás:* ha $L(y) = 0$, akkor csupa nulla kezdeti feltételű Cauchy-feladathoz jutunk. Az egyértelműség miatt $y equiv 0$, így $Ker(L) = {0}$.
  - *Szürjektivitás:* a létezési tétel miatt minden $(xi_0, dots, xi_(n-1))^T in bb(K)^n$ vektorhoz van olyan $y in M_h$, amelyre $L(y) = (xi_0, dots, xi_(n-1))^T$.

  Ezért $L$ vektortér-izomorfizmus $M_h$ és $bb(K)^n$ között, amiből $dim M_h = n$.
])

#v(8pt)

== A Wronski-determináns és a lineáris függetlenség

#defbox("Definíció: Wronski-determináns", [
  Legyenek $phi_1, phi_2, dots, phi_n in C^(n-1)(I)$ adott függvények. A rendszer *Wronski-mátrixa* és *Wronski-determinánsa*:
  $
    Phi(x) := mat(
      phi_1 (x), phi_2 (x), dots, phi_n (x);
      phi'_1 (x), phi'_2 (x), dots, phi'_n (x);
      dots.v, dots.v, dots.down, dots.v;
      phi_1^((n-1))(x), phi_2^((n-1))(x), dots, phi_n^((n-1))(x)
    ),
  $
  $ W(x) := det Phi(x) = det (phi_j^((i-1))(x))_(i, j = 1)^n. $
])

#v(8pt)

#theorembox("Tétel: az alaprendszer jellemzése a Wronski-determinánssal", [
  Legyenek $phi_1, phi_2, dots, phi_n in M_h$ a homogén egyenlet megoldásai. Az alábbi állítások ekvivalensek:
  1. a $(phi_1, dots, phi_n)$ rendszer lineárisan független $I$-n (azaz alaprendszer);
  2. minden $x in I$ esetén $W(x) != 0$;
  3. létezik olyan $tau in I$ pont, ahol $W(tau) != 0$.

  Következésképp, ha $W(tau) = 0$ valamely $tau in I$ pontban, akkor $W(x) equiv 0$ az egész $I$ intervallumon.
])

#v(8pt)

#proofbox("Bizonyításvázlat", [
  Az átviteli elv szerint a $phi_j$ megoldásokhoz tartozó $(phi_j, phi'_j, dots, phi_j^((n-1)))^T$ vektorfüggvények az $Y' = A Y$ homogén rendszer megoldásai, és a Wronski-mátrix ezek fundamentálmátrix-jelöltje. A lineáris rendszerek függetlenségi kritériuma szerint ezek pontosan akkor függetlenek, ha a determinánsuk valamely (és akkor minden) pontban nem nulla. A $phi_j$ függvények függetlensége ekvivalens a hozzájuk tartozó vektorfüggvények függetlenségével, mert az első koordinátájuk éppen $phi_j$, és az izomorfizmus az átviteli elvből adódik.
])

#v(8pt)

#remarkbox("Liouville-formula magasabb rendű egyenletekre", [
  A kísérőmátrix nyoma $-a_(n-1)(x)$, ezért a lineáris rendszerek Liouville-formulájából a Wronski-determinánsra:
  $ W'(x) = -a_(n-1)(x) W(x). $
  Ennek megoldása:
  $ W(x) = W(tau) exp(-integral_tau^x a_(n-1)(t) dif t) quad (x, tau in I). $
  Mivel az exponenciális tényező sehol sem nulla, $W(x)$ vagy mindenütt nulla, vagy sehol sem nulla az $I$ intervallumon.
])

#v(8pt)

== Az inhomogén egyenlet megoldásterének szerkezete

#theorembox("Tétel: az inhomogén megoldástér affin altér", [
  Jelölje $M$ az inhomogén egyenlet ($c equiv.not 0$) megoldásainak halmazát. Ekkor $M$ a $C^n (I)$ függvénytér egy *$n$-dimenziós affin altere*:
  $ M = y_p + M_h = {y_p (x) + sum_(k=1)^n c_k phi_k (x) : c_k in bb(K)}, $
  ahol $y_p in M$ az inhomogén egyenlet egy tetszőleges *partikuláris megoldása*, $(phi_1, dots, phi_n)$ pedig a homogén egyenlet egy alaprendszere.

  Tehát az inhomogén egyenlet általános megoldása:
  $ y_"ált." (x) = y_h (x) + y_p (x). $
])

#v(10pt)

= Az állandók variálásának módszere (Lagrange-módszer)

Az állandók variálásának módszere általános eljárás az inhomogén egyenlet egy $y_p (x)$ partikuláris megoldásának meghatározására, ha ismerjük a homogén egyenlet egy $(phi_1, dots, phi_n)$ alaprendszerét.

#theorembox([Tétel és algoritmus: az állandók variálása $n$-edrendben], [
  Keressük az inhomogén egyenlet partikuláris megoldását
  $ y_p (x) = sum_(k=1)^n c_k (x) phi_k (x) = c_1 (x) phi_1 (x) + c_2 (x) phi_2 (x) + dots + c_n (x) phi_n (x) $
  alakban, ahol a homogén megoldás $c_k$ konstansai helyett ismeretlen $c_k (x)$ együtthatófüggvények állnak.

  Rójunk ki a $c'_1 (x), dots, c'_n (x)$ függvényekre $n-1$ kényszerfeltételt úgy, hogy $y_p$ deriváltjaiban az $(n-1)$-edrendig ne jelenjenek meg a $c_k$ függvények deriváltjai. Ekkor a $c'_1, dots, c'_n$ ismeretlenekre az alábbi lineáris egyenletrendszert kapjuk:
  $
    mat(
      phi_1 (x), phi_2 (x), dots, phi_n (x);
      phi'_1 (x), phi'_2 (x), dots, phi'_n (x);
      dots.v, dots.v, dots.down, dots.v;
      phi_1^((n-2))(x), phi_2^((n-2))(x), dots, phi_n^((n-2))(x);
      phi_1^((n-1))(x), phi_2^((n-1))(x), dots, phi_n^((n-1))(x)
    ) vec(c'_1 (x), c'_2 (x), dots.v, c'_(n-1)(x), c'_n (x)) = vec(0, 0, dots.v, 0, c(x)).
  $
])

#v(8pt)

#proofbox("A kényszerfeltételek levezetése és a bizonyítás", [
  Deriváljuk az $y_p (x) = sum_(k=1)^n c_k (x) phi_k (x)$ függvényt egymás után.

  1. Első derivált: $y'_p = sum_(k=1)^n c'_k phi_k + sum_(k=1)^n c_k phi'_k$. \
    Rójuk ki az *1. kényszerfeltételt*: $sum_(k=1)^n c'_k (x) phi_k (x) = 0$. Ekkor $y'_p = sum_(k=1)^n c_k phi'_k$.

  2. Második derivált: $y''_p = sum_(k=1)^n c'_k phi'_k + sum_(k=1)^n c_k phi''_k$. \
    Rójuk ki a *2. kényszerfeltételt*: $sum_(k=1)^n c'_k (x) phi'_k (x) = 0$. Ekkor $y''_p = sum_(k=1)^n c_k phi''_k$.

  3. Ezt az $(n-1)$-edik deriváltig folytatva az $(n-1)$. kényszerfeltétel:
    $
      sum_(k=1)^n c'_k (x) phi_k^((n-2))(x) = 0, quad "és így" quad y_p^((n-1)) = sum_(k=1)^n c_k (x) phi_k^((n-1))(x).
    $

  4. Az $n$-edik deriváltat kényszer nélkül számolva:
    $ y_p^((n)) = sum_(k=1)^n c'_k (x) phi_k^((n-1))(x) + sum_(k=1)^n c_k (x) phi_k^((n))(x). $

  Behelyettesítve $y_p, y'_p, dots, y_p^((n))$-t az inhomogén egyenletbe, és felhasználva, hogy minden $phi_k$ kielégíti a homogén egyenletet ($phi_k^((n)) + sum_(i=0)^(n-1) a_i phi_k^((i)) = 0$), a $c_k$-t tartalmazó tagok kiesnek, és marad:
  $ sum_(k=1)^n c'_k (x) phi_k^((n-1))(x) = c(x). $
  Ez éppen a fenti lineáris egyenletrendszer utolsó sora.
])

#v(8pt)

#theorembox([A $c_k (x)$ együtthatófüggvények kiszámítása], [
  Az egyenletrendszer együtthatómátrixa a $Phi(x)$ Wronski-mátrix, és az alaprendszer miatt $det Phi(x) = W(x) != 0$. Ezért a Cramer-szabállyal a $c'_k$ függvények egyértelműen kifejezhetők:
  $ c'_k (x) = (W_k (x)) / (W(x)) quad (k = 1, 2, dots, n), $
  ahol $W_k (x)$ a Wronski-determinánsból úgy adódik, hogy annak $k$-adik oszlopát a $(0, 0, dots, 0, c(x))^T$ jobb oldali vektorra cseréljük.

  Integrálással:
  $ c_k (x) = integral (W_k (x)) / (W(x)) dif x. $
  Ezeket visszahelyettesítve az $y_p$ alakjába megkapjuk az inhomogén egyenlet partikuláris megoldását.
])

#v(10pt)

= Gyakorlati alkalmazás: a másodrendű eset ($n = 2$)

A leggyakrabban előforduló eset a másodrendű lineáris inhomogén differenciálegyenlet:
$ y''(x) + a_1 (x) y'(x) + a_0 (x) y(x) = c(x). $

1. *Homogén alaprendszer:* $(phi_1, phi_2)$, ahol a Wronski-determináns:
  $ W(x) = det mat(phi_1 (x), phi_2 (x); phi'_1 (x), phi'_2 (x)) = phi_1 (x) phi'_2 (x) - phi_2 (x) phi'_1 (x) != 0. $

2. *Az állandók variálásának egyenletrendszere:*
  $
    cases(
      c'_1 (x) phi_1 (x) + c'_2 (x) phi_2 (x) = 0,
      c'_1 (x) phi'_1 (x) + c'_2 (x) phi'_2 (x) = c(x).
    )
  $

3. *Megoldás Cramer-szabállyal:*
  $ c'_1 (x) = (-c(x) phi_2 (x)) / (W(x)), quad c'_2 (x) = (c(x) phi_1 (x)) / (W(x)). $

4. *Partikuláris megoldás:*
  $
    y_p (x) = -phi_1 (x) integral (c(x) phi_2 (x)) / (W(x)) dif x + phi_2 (x) integral (c(x) phi_1 (x)) / (W(x)) dif x.
  $
