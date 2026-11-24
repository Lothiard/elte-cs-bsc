// Typst source document for Exam Topic 7
// Analízis Alkalmazásai - 7. Tétel
// "Alaprendszer, alapmátrix. Az állandók variálásának a módszere. Alapmátrix előállítása állandó együtthatós, diagonalizálható mátrix esetén. Az n = 2 eset vizsgálata tetszőleges, állandó együtthatós mátrixra."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (7. Tétel)
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
    #text(weight: "bold")[7. Tétel:]
    _„Alaprendszer, alapmátrix. Az állandók variálásának a módszere. Alapmátrix előállítása állandó együtthatós, diagonalizálható mátrix esetén. Az n = 2 eset vizsgálata tetszőleges, állandó együtthatós mátrixra.”_
  ]
]

#v(15pt)

= Alaprendszer és alapmátrix

Tekintsük a homogén lineáris elsőrendű differenciálegyenlet-rendszert:
$ y' = A(x) y, $
ahol $I subset bb(R)$ nyílt intervallum, $A: I -> bb(R)^(n times n)$ folytonos mátrixértékű függvény, és $y: I -> bb(R)^n$ az ismeretlen vektorértékű függvény.

#defbox("Definíció: Alaprendszer (fundamentálrendszer)", [
  A homogén $y' = A(x) y$ rendszer megoldásterét jelölje $H_0 subset C^1(I, bb(R)^n)$. Tudjuk, hogy $dim H_0 = n$.

  A $H_0$ megoldástér egy tetszőleges $phi_1, phi_2, dots, phi_n in H_0$ bázisát a homogén lineáris differenciálegyenlet-rendszer *alaprendszerének* (vagy *fundamentálrendszerének*) nevezzük.
])

#v(8pt)

#defbox("Definíció: Alapmátrix (fundamentálmátrix)", [
  Legyen $phi_1, phi_2, dots, phi_n$ a homogén rendszer egy alaprendszere. Az ezekből mint oszlopvektorokból képezett mátrixértékű függvényt:
  $ Phi(x) := (phi_1(x), phi_2(x), dots, phi_n(x)) in bb(R)^(n times n) quad (x in I) $
  *alapmátrixnak* (vagy *fundamentálmátrixnak*) nevezzük.
])

#v(8pt)

#theorembox("Tétel: Az alapmátrix tulajdonságai", [
  Egy $Phi: I -> bb(R)^(n times n)$ mátrixértékű függvény pontosan akkor alapmátrixa az $y' = A(x) y$ homogén rendszernek, ha teljesíti az alábbi két feltételt:
  1. kielégíti a mátrix-differenciálegyenletet: $Phi'(x) = A(x) Phi(x)$ minden $x in I$ esetén;
  2. invertálható: $det Phi(x) != 0$ minden $x in I$ esetén (a Liouville-formula miatt elegendő egyetlen $x_0 in I$ pontban ellenőrizni).
])

#v(8pt)

#proofbox("Bizonyítás", [
  1. Mivel $Phi(x)$ oszlopai, a $phi_j (x)$ függvények megoldásai a rendszernek, ezért $phi'_j (x) = A(x) phi_j (x)$ minden $j = 1, dots, n$ esetén. A mátrixszorzás oszloponkénti értelmezése alapján:
    $ Phi'(x) = (phi'_1 (x), dots, phi'_n (x)) = (A(x) phi_1 (x), dots, A(x) phi_n (x)) = A(x) Phi(x). $
  2. A $phi_1, dots, phi_n$ megoldások pontosan akkor alkotnak bázist a megoldástérben, ha tetszőleges $x_0 in I$ pontban a $phi_1(x_0), dots, phi_n (x_0) in bb(R)^n$ kezdőértékvektorok lineárisan függetlenek (a Picard–Lindelöf-tétel egyértelműsége miatt a $y arrow.r.bar y(x_0)$ leképezés izomorfizmus). Ez pontosan akkor teljesül, ha $det Phi(x_0) != 0$.
])

#v(8pt)

#remarkbox("Megjegyzés: a homogén rendszer általános megoldása", [
  Az alapmátrix segítségével a homogén rendszer általános megoldása tömören felírható:
  $ y_h (x) = Phi(x) c = c_1 phi_1 (x) + c_2 phi_2 (x) + dots + c_n phi_n (x), $
  ahol $c = (c_1, c_2, dots, c_n)^T in bb(R)^n$ tetszőleges konstansvektor.
])

#v(10pt)

= Az állandók variálásának módszere rendszerekre

Tekintsük az inhomogén lineáris differenciálegyenlet-rendszert:
$ y' = A(x) y + b(x), $
ahol $b: I -> bb(R)^n$ folytonos vektorértékű függvény.

#theorembox("Tétel: az inhomogén rendszer általános megoldása", [
  Legyen $Phi(x)$ a homogén $y' = A(x) y$ rendszer egy alapmátrixa $I$-n. Ekkor az inhomogén rendszer egy partikuláris megoldása:
  $ y_p (x) = Phi(x) integral_(x_0)^x Phi^(-1)(t) b(t) dif t quad (x_0, x in I). $
  Az inhomogén rendszer általános megoldása pedig:
  $ y(x) = y_h (x) + y_p (x) = Phi(x) c + Phi(x) integral_(x_0)^x Phi^(-1)(t) b(t) dif t, $
  ahol $c in bb(R)^n$ tetszőleges konstansvektor.
])

#v(8pt)

#proofbox("Bizonyítás (az állandók variálása)", [
  Keressük az inhomogén rendszer partikuláris megoldását $y_p (x) = Phi(x) c(x)$ alakban, ahol $c: I -> bb(R)^n$ ismeretlen, folytonosan differenciálható vektorértékű függvény.

  Deriváljuk $y_p (x)$-et a szorzat deriválási szabálya szerint:
  $ y'_p (x) = Phi'(x) c(x) + Phi(x) c'(x). $
  Mivel $Phi(x)$ alapmátrix, $Phi'(x) = A(x) Phi(x)$. Behelyettesítve:
  $ y'_p (x) = A(x) Phi(x) c(x) + Phi(x) c'(x). $

  Az inhomogén egyenlet szerint $y'_p (x) = A(x) y_p (x) + b(x)$, azaz:
  $ A(x) Phi(x) c(x) + Phi(x) c'(x) = A(x) Phi(x) c(x) + b(x). $
  Az $A(x) Phi(x) c(x)$ tag mindkét oldalon kiesik, így:
  $ Phi(x) c'(x) = b(x). $

  Mivel $det Phi(x) != 0$, a $Phi^(-1)(x)$ inverz minden $x in I$ esetén létezik. Balról szorozva vele:
  $ c'(x) = Phi^(-1)(x) b(x). $
  Integrálva $x_0$-tól $x$-ig:
  $ c(x) = integral_(x_0)^x Phi^(-1)(t) b(t) dif t + c_0. $
  A $c_0 = 0$ választással kapjuk a partikuláris megoldást:
  $ y_p (x) = Phi(x) c(x) = Phi(x) integral_(x_0)^x Phi^(-1)(t) b(t) dif t. $
])

#v(10pt)

= Alapmátrix előállítása állandó együtthatós, diagonalizálható mátrix esetén

Tekintsük az állandó együtthatós homogén rendszert:
$ y' = A y, $
ahol $A in bb(R)^(n times n)$ konstans mátrix.

#defbox("Definíció: Diagonalizálható mátrix", [
  Az $A in bb(R)^(n times n)$ mátrix *diagonalizálható*, ha létezik $n$ darab lineárisan független sajátvektora $v_1, v_2, dots, v_n in bb(C)^n$, a hozzájuk tartozó $lambda_1, lambda_2, dots, lambda_n in bb(C)$ sajátértékekkel.

  Ekkor az $S := (v_1, v_2, dots, v_n)$ nemszinguláris transzformációs mátrixszal:
  $ A = S D S^(-1), quad "ahol" quad D = diag(lambda_1, lambda_2, dots, lambda_n). $
])

#v(8pt)

#theorembox("Tétel: alapmátrix diagonalizálható esetben", [
  Ha az $A in bb(R)^(n times n)$ mátrix diagonalizálható a $v_1, dots, v_n$ sajátvektorokkal és $lambda_1, dots, lambda_n$ sajátértékekkel, akkor az $y' = A y$ rendszer egy alapmátrixa:
  $ Phi(x) = (e^(lambda_1 x) v_1, e^(lambda_2 x) v_2, dots, e^(lambda_n x) v_n) in bb(C)^(n times n). $
  (Komplex sajátértékek esetén ez komplex alapmátrix; a valós alapmátrixot az $n = 2$ eset 2. pontja mutatja.)

  A mátrix-exponenciális segítségével kifejezett kanonikus alapmátrix:
  $ e^(x A) = S e^(x D) S^(-1) = S diag(e^(lambda_1 x), e^(lambda_2 x), dots, e^(lambda_n x)) S^(-1). $
])

#v(8pt)

#proofbox("Bizonyítás", [
  Vizsgáljuk a $phi_j (x) := e^(lambda_j x) v_j$ vektorfüggvényt. Deriváljuk $x$ szerint:
  $ phi'_j (x) = lambda_j e^(lambda_j x) v_j = e^(lambda_j x) (lambda_j v_j). $
  Mivel $v_j$ a $lambda_j$-hez tartozó sajátvektor, $A v_j = lambda_j v_j$. Ezért:
  $ phi'_j (x) = e^(lambda_j x) (A v_j) = A (e^(lambda_j x) v_j) = A phi_j (x). $
  Tehát $phi_j (x)$ valóban megoldása az $y' = A y$ rendszernek.

  Az $x = 0$ pontban:
  $ det Phi(0) = det S != 0, $
  mivel a sajátvektorok lineárisan függetlenek. Így $Phi(x)$ oszlopai bázist alkotnak, tehát $Phi(x)$ alapmátrix.
])

#v(10pt)

= Az $n = 2$ eset vizsgálata tetszőleges, állandó együtthatós mátrixra

Tekintsük a kétdimenziós állandó együtthatós homogén rendszert:
$ y' = A y, quad A = mat(a, b; c, d) in bb(R)^(2 times 2). $

A mátrix karakterisztikus egyenlete:
$ det(A - lambda I) = det mat(a - lambda, b; c, d - lambda) = lambda^2 - tr(A) lambda + det(A) = 0, $
ahol $tr(A) = a + d$ a mátrix nyoma, $det(A) = a d - b c$ a determinánsa.

A sajátértékek alapján három fő esetet különböztetünk meg.

== 1. eset: két különböző valós sajátérték ($lambda_1 != lambda_2$, $lambda_1, lambda_2 in bb(R)$)

Mivel a sajátértékek különbözők, a hozzájuk tartozó $v_1, v_2 in bb(R)^2$ sajátvektorok lineárisan függetlenek, a mátrix diagonalizálható.

*Alaprendszer:*
$ y_1 (x) = e^(lambda_1 x) v_1, quad y_2 (x) = e^(lambda_2 x) v_2. $

*Valós alapmátrix és általános megoldás:*
$ Phi(x) = (e^(lambda_1 x) v_1, e^(lambda_2 x) v_2), quad y(x) = c_1 e^(lambda_1 x) v_1 + c_2 e^(lambda_2 x) v_2. $

== 2. eset: konjugált komplex sajátértékpár ($lambda_(1,2) = alpha plus.minus i beta$, $beta != 0$)

Mivel $A$ valós mátrix, a komplex sajátértékek egymás konjugáltjai. Legyen $v = u + i w$ ($u, w in bb(R)^2$) a $lambda_1 = alpha + i beta$ sajátértékhez tartozó komplex sajátvektor.

A komplex megoldás:
$ y_C (x) = e^((alpha + i beta) x) (u + i w) = e^(alpha x) (cos(beta x) + i sin(beta x)) (u + i w). $

A komplex megoldás valós és képzetes részét véve két lineárisan független valós megoldást kapunk:

#theorembox("Tétel: valós alaprendszer komplex sajátértékek esetén", [
  A konjugált komplex sajátértékpárhoz tartozó valós alaprendszer elemei:
  $ y_1 (x) = Re(y_C (x)) = e^(alpha x) (cos(beta x) u - sin(beta x) w), $
  $ y_2 (x) = Im(y_C (x)) = e^(alpha x) (sin(beta x) u + cos(beta x) w). $
  A valós alapmátrix $Phi(x) = (y_1 (x), y_2 (x))$.
])

#v(8pt)

#proofbox("Bizonyítás", [
  A komplex $y_C (x) = y_1 (x) + i y_2 (x)$ megoldásra $y'_C (x) = A y_C (x)$. Mivel $A$ valós, a valós és a képzetes részeket összehasonlítva:
  $
    y'_1 (x) + i y'_2 (x) = A y_1 (x) + i A y_2 (x) quad ==> quad y'_1 (x) = A y_1 (x) quad "és" quad y'_2 (x) = A y_2 (x).
  $
  A függetlenséghez: $y_1 (0) = u$ és $y_2 (0) = w$. Mivel $beta != 0$, a $lambda_1$ és $overline(lambda_1)$ különböző sajátértékek, így a hozzájuk tartozó $v$ és $overline(v)$ sajátvektorok lineárisan függetlenek $bb(C)^2$-ben. Ebből $u = (v + overline(v)) / 2$ és $w = (v - overline(v)) / (2 i)$ lineárisan függetlenek, tehát $det Phi(0) = det(u, w) != 0$.
])

#v(8pt)

== 3. eset: kétszeres valós sajátérték ($lambda_1 = lambda_2 = lambda in bb(R)$)

Két esetet különböztetünk meg a sajátérték geometriai multiplicitása szerint.

=== 3a. Geometriai multiplicitás 2 (két független sajátvektor)

Ez pontosan akkor áll fenn, ha $A = lambda I = mat(lambda, 0; 0, lambda)$. Ekkor minden nemnulla vektor sajátvektor.

*Alapmátrix:* $Phi(x) = e^(lambda x) I = mat(e^(lambda x), 0; 0, e^(lambda x))$.

=== 3b. Geometriai multiplicitás 1 (egyetlen független sajátvektor, Jordan-blokk)

Ekkor a mátrix nem diagonalizálható. Csak egyetlen (skalárszorosától eltekintve egyértelmű) $v in bb(R)^2$ sajátvektor létezik:
$ (A - lambda I) v = 0. $
A második független megoldást $y_2 (x) = e^(lambda x) (w + x v)$ alakban keressük, ahol $w in bb(R)^2$ az úgynevezett *általánosított sajátvektor* (fővektor).

#theorembox("Tétel: alaprendszer Jordan-blokk esetén (n = 2)", [
  Legyen $(A - lambda I) v = 0$ ($v != 0$), és legyen $w in bb(R)^2$ az alábbi lineáris egyenletrendszer egy megoldása:
  $ (A - lambda I) w = v. $
  Ekkor az $y' = A y$ rendszer egy valós alaprendszere:
  $ y_1 (x) = e^(lambda x) v, $
  $ y_2 (x) = e^(lambda x) (w + x v) = e^(lambda x) w + x e^(lambda x) v. $
  Az alapmátrix: $Phi(x) = e^(lambda x) mat(v_1, w_1 + x v_1; v_2, w_2 + x v_2)$.
])

#v(8pt)

#proofbox("Bizonyítás", [
  *A $w$ létezése és $v$, $w$ függetlensége.* A Cayley–Hamilton-tétel szerint $(A - lambda I)^2 = 0$, és $A - lambda I != 0$ (különben $A = lambda I$ volna). Ezért $A - lambda I$ képtere egydimenziós, és a $v$ vektor ebben van, hiszen $(A - lambda I) v = 0$ és a magja egydimenziós. Így van olyan $w$, amelyre $(A - lambda I) w = v$. Ha $w = k v$ valamely $k$-ra, akkor $(A - lambda I) w = 0 != v$ volna, tehát $v$ és $w$ lineárisan függetlenek.

  *A megoldás ellenőrzése.* Deriváljuk $y_2 (x)$-et $x$ szerint:
  $ y'_2 (x) = lambda e^(lambda x) (w + x v) + e^(lambda x) v = e^(lambda x) (lambda w + v + x lambda v). $
  Másrészt:
  $ A y_2 (x) = e^(lambda x) (A w + x A v). $
  Mivel $A v = lambda v$ és $A w = lambda w + v$ (a $(A - lambda I) w = v$ definícióból):
  $ A y_2 (x) = e^(lambda x) ((lambda w + v) + x lambda v) = e^(lambda x) (lambda w + v + x lambda v). $
  Tehát $y'_2 (x) = A y_2 (x)$, azaz $y_2$ megoldás. Mivel $v$ és $w$ lineárisan függetlenek, $det Phi(0) = det(v, w) != 0$, így $y_1$ és $y_2$ alaprendszert alkot.
])
