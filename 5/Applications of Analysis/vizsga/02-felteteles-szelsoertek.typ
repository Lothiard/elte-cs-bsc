// Typst source document for Exam Topic 2
// Analízis Alkalmazásai — 2. Tétel
// "Feltételes szélsőérték, szükséges, ill. elégséges feltétel (a szükséges feltétel bizonyítása)."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (2. Tétel)
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
#let rang = math.op("rang")

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
    #text(weight: "bold")[2. Tétel:]
    _„Feltételes szélsőérték, szükséges, ill. elégséges feltétel (a szükséges feltétel bizonyítása).”_
  ]
]

#v(15pt)

= A feltételes szélsőérték fogalma

A gyakorlati és elméleti alkalmazásokban gyakran találkozunk olyan optimalizálási feladatokkal, ahol egy többváltozós célfüggvény szélsőértékeit nem a teljes értelmezési tartományon, hanem egy megadott egyenletrendszerrel kijelölt alakzaton (felületen, görbén, ill. részsokaságon) keressük.

#defbox("1. Definíció: Feltételes lokális szélsőérték", [
  Legyen $1 <= m < n$ ($m, n in bb(N)$), $U subset.eq bb(R)^n$ nyílt halmaz, továbbá $f: U -> bb(R)$ (célfüggvény) és $g: U -> bb(R)^m$ (feltételfüggvény).

  Azt mondjuk, hogy az $f$ függvénynek a $c in {g = 0} := {x in U : g(x) = 0}$ pontban a $g = 0$ feltételre vonatkozóan *feltételes lokális minimuma (resp. maximuma)* van, ha létezik olyan $K(c) subset U$ környezet, hogy minden $x in {g = 0} inter K(c)$ pontra:
  $ f(x) >= f(c) quad ("resp. " f(x) <= f(c)). $

  Amennyiben $x != c$ esetén szigorú egyenlőtlenség teljesül, akkor *szigorú feltételes lokális szélsőértékről* beszélünk.
])

#v(8pt)

#remarkbox("A feltételrendszer koordinátás alakja", [
  A $g = 0$ vektoregyenlet pontosan $m$ darab skalár egyenletből álló rendszert jelent:
  $ g_1(x_1, x_2, dots, x_n) = 0 \ g_2(x_1, x_2, dots, x_n) = 0 \ dots.v \ g_m (x_1, x_2, dots, x_n) = 0 $
  A geometriai dimenzió $n - m$: az $m$ darab független feltétel egy $(n - m)$-dimenziós felületre (kényszerfelületre) korlátozza a keresési tartományt.
])

#v(10pt)

= Elsőrendű szükséges feltétel (Lagrange-szorzók módszere)

Az elsőrendű szükséges feltétel kimondja, hogy ha egy pontban feltételes lokális szélsőérték van, és a feltételrendszer nem szinguláris (a Jacobi-mátrix rangja maximális), akkor a célfüggvény gradiense kifejezhető a feltételfüggvények gradiensvektorainak lineáris kombinációjaként.

#theorembox("1. Tétel: Elsőrendű szükséges feltétel (Lagrange)", [
  Tegyük fel, hogy $1 <= m < n$, $U subset.eq bb(R)^n$ nyílt halmaz, $f: U -> bb(R)$ differenciálható ($f in D$) és $g: U -> bb(R)^m$ folytonosan differenciálható ($g in C^1$).

  Ha az $f$ függvénynek a $c in {g = 0}$ pontban a $g = 0$ feltételre vonatkozóan *feltételes lokális szélsőértéke* van, és a $g'(c) in bb(R)^(m times n)$ Jacobi-mátrix rangja $m$ (rangfeltétel), akkor létezik olyan $lambda = (lambda_1, dots, lambda_m) in bb(R)^m$ Lagrange-szorzóvektor, hogy:
  $ nabla (f + lambda g)(c) = 0, $
  azaz az $F := f + lambda g = f + sum_(k=1)^m lambda_k g_k$ *Lagrange-függvény* stacionárius a $c$ helyen:
  $ nabla f(c) + sum_(k=1)^m lambda_k nabla g_k (c) = 0. $
])

#v(10pt)

#proofbox("Az 1. Tétel (szükséges feltétel) teljes bizonyítása", [
  *Bizonyítás:*

  1. *A Jacobi-mátrix particionálása:* \
    A feltétel szerint $rang g'(c) = m$. A mátrix rangjának definíciója alapján kiválasztható a $g'(c) in bb(R)^(m times n)$ mátrixból $m$ darab lineárisan független oszlop, melyekből képezett $m times m$-es részmátrix determinánsa nem nulla.

    Az általánosság megszorítása nélkül feltehető, hogy ezen független oszlopok a $g'(c)$ mátrix utolsó $m$ oszlopát alkotják. Particionáljuk a teret és a $c$ pontot:
    $ bb(R)^n = bb(R)^(n-m) times bb(R)^m, quad c = (a, b), quad "ahol " a in bb(R)^(n-m), b in bb(R)^m. $
    Ennek megfelelően a parciális deriváltak blokkmátrixai:
    $ g'(c) = [partial_1 g(c) quad partial_2 g(c)], $
    ahol $partial_1 g(c) in bb(R)^(m times (n-m))$ az első $n-m$ változó szerinti, míg $partial_2 g(c) in bb(R)^(m times m)$ az utolsó $m$ változó szerinti parciális deriváltmátrix. A választásunk miatt:
    $ det(partial_2 g(c)) != 0. $

  2. *Az implicitfüggvény-tétel alkalmazása:* \
    A $g: bb(R)^(n-m) times bb(R)^m -> bb(R)^m$ függvényre teljesülnek az implicitfüggvény-tétel feltételei a $c = (a, b)$ pontban:
    - $g(a, b) = 0$,
    - $g in C^1$,
    - $det(partial_2 g(a, b)) != 0$.

    Ezért létezik az $a in bb(R)^(n-m)$ pontnak egy $K(a)$ környezete, a $b in bb(R)^m$ pontnak egy $K(b)$ környezete és egy egyértelműen meghatározott $h: K(a) -> K(b)$ folytonosan differenciálható implicitfüggvény ($h in C^1$), amelyre $h(a) = b$ és:
    $ g(x, h(x)) = 0 quad (x in K(a)). $
    Továbbá a láncszabály alapján az implicitfüggvény deriváltja:
    $ h'(a) = -[partial_2 g(c)]^(-1) partial_1 g(c) in bb(R)^(m times (n-m)). $

  3. *Visszavezetés feltétel nélküli szélsőértékre:* \
    Definiáljuk a $Phi: K(a) -> bb(R)$ összetett függvényt:
    $ Phi(x) := f(x, h(x)) quad (x in K(a)). $
    Mivel $f$-nek a $c = (a, b)$ pontban a $g = 0$ feltétel mellett lokális szélsőértéke van, és a $(x, h(x))$ pontok mind kielégítik a $g(x, h(x)) = 0$ feltételt, ezért a $Phi$ függvénynek az $a in bb(R)^(n-m)$ *belső* pontban *feltétel nélküli lokális szélsőértéke* van.

  4. *Stacionárius feltétel levezetése:* \
    A feltétel nélküli lokális szélsőértékekre vonatkozó elsőrendű szükséges feltétel szerint $Phi$ deriváltja az $a$ pontban nulla:
    $ Phi'(a) = 0 in bb(R)^(1 times (n-m)). $
    Alkalmazzuk a láncszabályt a $Phi(x) = f(x, h(x)) = (f compose phi)(x)$ leképezésre, ahol $phi(x) = (x, h(x))$:
    $ phi'(a) = mat(I_(n-m); h'(a)) in bb(R)^(n times (n-m)). $
    Ekkor:
    $
      Phi'(a) = f'(c) phi'(a) = [partial_1 f(c) quad partial_2 f(c)] mat(I_(n-m); h'(a)) = partial_1 f(c) + partial_2 f(c) h'(a) = 0.
    $

  5. *A $lambda$ Lagrange-szorzóvektor konstrukciója:* \
    Helyettesítsük be $h'(a)$ előzőleg kapott explicit alakját:
    $ partial_1 f(c) - partial_2 f(c) [partial_2 g(c)]^(-1) partial_1 g(c) = 0. $
    Válasszuk a $lambda in bb(R)^m$ vektort (sorvektorként) a következőképpen:
    $ lambda := -partial_2 f(c) [partial_2 g(c)]^(-1). $
    Ebből átrendezéssel kapjuk, hogy:
    $ partial_2 f(c) + lambda partial_2 g(c) = 0. $
    Ugyanakkor $lambda$ definícióját visszaírva az előző egyenletbe:
    $ partial_1 f(c) + lambda partial_1 g(c) = 0. $
    A két blokkegyenletet egymás mellé írva pontosan a teljes gradiensvektor nullává válását kapjuk:
    $
      [partial_1 f(c) + lambda partial_1 g(c) quad partial_2 f(c) + lambda partial_2 g(c)] = 0 \ ==> f'(c) + lambda g'(c) = 0 \ ==> nabla (f + lambda g)(c) = 0.
    $
    Ezzel a tételt bebizonyítottuk. #h(1fr) $square$
])

#v(10pt)

= Feltételes kvadratikus alakok és definitás

A másodrendű feltételek felírásához az $F = f + lambda g$ Lagrange-függvény Hesse-mátrixát kell vizsgálnunk, de nem a teljes $bb(R)^n$ téren, hanem csak a feltételfüggvények által kijelölt érintőtérben (a Jacobi-mátrix magjában).

#defbox("2. Definíció: Feltételes definitás", [
  Legyen $Q: bb(R)^n -> bb(R)$ egy kvadratikus alak (melyet az $A in bb(R)^(n times n)$ szimmetrikus mátrix határoz meg: $Q(x) = x^T A x$), és $B in bb(R)^(m times n)$ egy $m$ rangú mátrix.

  Tekintsük a $B$ mátrix magját (az érintőalteret):
  $ A_B := Ker(B) = {x in bb(R)^n : B x = 0}. $

  Azt mondjuk, hogy a $Q$ kvadratikus alak a $B$ mátrixra nézve:
  1. *feltételesen pozitív (resp. negatív) definit*, ha $Q(x) > 0$ (resp. $Q(x) < 0$) minden $0 != x in A_B$ esetén;
  2. *feltételesen pozitív (resp. negatív) szemidefinit*, ha $Q(x) >= 0$ (resp. $Q(x) <= 0$) minden $x in A_B$ esetén.
])

#v(8pt)

#remarkbox("A Lagrange-függvény másodrendű kvadratikus alakja", [
  A $c$ stacionárius pontban az $F = f + lambda g$ függvény másodrendű deriváltja által meghatározott kvadratikus alak:
  $ Q_(F, c)(h) := h^T F''(c) h = sum_(i=1)^n sum_(j=1)^n partial_(i j) F(c) h_i h_j, $
  ahol $F''(c) = f''(c) + sum_(k=1)^m lambda_k g''_k (c)$ a szimmetrikus Hesse-mátrix.
  Az $A_B$ altér ebben az esetben $Ker(g'(c)) = {h in bb(R)^n : g'(c) h = 0}$.
])

#v(10pt)

= Másodrendű elégséges feltétel

#theorembox("2. Tétel: Másodrendű elégséges feltétel", [
  Legyen $1 <= m < n$, $U subset.eq bb(R)^n$ nyílt halmaz, $f, g in C^2(U)$.
  Feltesszük, hogy $c in {g = 0}$, $rang g'(c) = m$, és létezik olyan $lambda in bb(R)^m$ Lagrange-szorzóvektor, hogy az $F := f + lambda g$ Lagrange-függvényre:

  1. $nabla F(c) = 0$ (stacionárius pont);
  2. a $Q_(F, c)$ kvadratikus alak a $g'(c)$ mátrixra (azaz a $Ker(g'(c))$ altérre) nézve *feltételesen pozitív (resp. negatív) definit*.

  Ekkor az $f$ függvénynek a $c$ pontban a $g = 0$ feltételre vonatkozóan *szigorú feltételes lokális minimuma (resp. maximuma)* van.
])

#v(8pt)

#remarkbox("A másodrendű elégséges feltétel bizonyításának vázlata", [
  Az elégséges feltétel bizonyítása indirekt úton történik. Ha $c$ nem lenne szigorú lokális minimumhely, akkor létezne olyan, $c$-hez tartó $x_k in {g = 0}$, $x_k != c$ sorozat, melyre $f(x_k) <= f(c)$.
  Mivel $g(x_k) = 0$, ezért $F(x_k) = f(x_k)$, így a Taylor-formulával:
  $ F(x_k) - F(c) = 1/2 Q_(F, c)(x_k - c) + o(norm(x_k - c)^2) <= 0. $
  Normálva a $h_k = (x_k - c) / norm(x_k - c)$ iránysorozatot, annak egy $h$ torlódási pontjára $g'(c) h = 0$ (azaz $h in Ker(g'(c))$), $norm(h) = 1$ és $Q_(F, c)(h) <= 0$ adódna, ami ellentmond a feltételes pozitív definitásnak ($Q_(F, c)(h) > 0$).
])

#v(10pt)

= Másodrendű szükséges feltétel

#theorembox("3. Tétel: Másodrendű szükséges feltétel", [
  Legyen $1 <= m < n$, $U subset.eq bb(R)^n$ nyílt halmaz, $f, g in C^2(U)$.
  Feltesszük, hogy $c in {g = 0}$, $rang g'(c) = m$, és az $f$ függvénynek a $c$ pontban a $g = 0$ feltételre vonatkozóan *feltételes lokális minimuma (resp. maximuma)* van.

  Ekkor létezik olyan $lambda in bb(R)^m$ Lagrange-szorzóvektor, hogy az $F := f + lambda g$ függvényre:
  1. $nabla F(c) = 0$;
  2. a $Q_(F, c)$ kvadratikus alak a $g'(c)$ mátrixra nézve *feltételesen pozitív (resp. negatív) szemidefinit*.
])

#v(10pt)

= Megjegyzések és gyakorlati használat

#remarkbox("1. Megjegyzés: Az egyenletrendszer felépítése", [
  A feltételes szélsőértékek megkeresése a gyakorlatban az alábbi, $n + m$ darab ismeretlent ($c_1, dots, c_n, lambda_1, dots, lambda_m$) tartalmazó egyenletrendszer megoldását jelenti:
  $
    partial_j f(c) + sum_(k=1)^m lambda_k partial_j g_k (c) = 0 quad (j = 1, dots, n) \ g_k (c) = 0 quad (k = 1, dots, m)
  $
])

#v(8pt)

#remarkbox("2. Megjegyzés: Szegélyezett Hesse-mátrix", [
  A $Q_(F, c)$ kvadratikus alak feltételes definitása a gyakorlatban a *szegélyezett Hesse-mátrix* ($H_F$) minorjainak előjeléből határozható meg. A szegélyezett mátrix blokkalakja:
  $ H_F = mat(0, g'(c); g'(c)^T, F''(c)) in bb(R)^((m+n) times (m+n)). $

  - $n = 2$, $m = 1$ esetén: ha $det(H_F) < 0$, akkor feltételes lokális *minimum*, ha $det(H_F) > 0$, akkor feltételes lokális *maximum* van.
])

#v(8pt)

#remarkbox("3. Megjegyzés: Feltételes abszolút szélsőérték korlátos és zárt halmazon", [
  Ha a $H = {x in U : g(x) = 0}$ feltételhalmaz korlátos és zárt (kompakt $bb(R)^n$-ben), akkor a *Weierstrass-tétel* értelmében a folytonos $f$ célfüggvény felveszi a $H$-n a globális (abszolút) minimumát és maximumát.
  Ekkor a feladat megoldásának menete:
  1. Megkeressük a Lagrange-egyenletrendszer összes stacionárius pontját.
  2. Megvizsgáljuk azokat a pontokat is, ahol a $g'(x)$ mátrix rangja kisebb, mint $m$ (ha van ilyen).
  3. Kiszámítjuk a célfüggvény $f(c_i)$ értékeit ezen pontokban; a legnagyobb érték adja a globális maximumot, a legkisebb pedig a globális minimumot.
])
