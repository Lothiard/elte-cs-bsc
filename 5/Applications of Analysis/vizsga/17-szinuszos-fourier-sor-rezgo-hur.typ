// Typst source document for Exam Topic 17
// Analízis Alkalmazásai - 17. Tétel
// "A sum_(k=1)^infty k^(-1) dot sin(k x) (x in bb(R)) sor konvergenciája, összegfüggvénye. A rezgő húr problémája."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (17. Tétel)
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
    #text(weight: "bold")[17. Tétel:]
    _„A $sum_(k=1)^infinity k^(-1) dot sin(k x)$ ($x in bb(R)$) sor konvergenciája, összegfüggvénye. A rezgő húr problémája.”_
  ]
]

#v(15pt)

= A $sum_(k=1)^infinity sin(k x) / k$ sor konvergenciája és összegfüggvénye

A trigonometrikus sorok elméletének egyik legszemléletesebb példája a $sum_(k=1)^infinity sin(k x) / k$ sor. Összegfüggvénye nemfolytonos (fűrészfogfüggvény), ezért jól mutatja a Dirichlet-féle konvergenciatétel működését és a szakadási pontok körüli viselkedést.

== A konvergencia jellege és tartománya

#theorembox("Tétel: a szinuszsor konvergenciája", [
  Tekintsük a $sum_(k=1)^infinity sin(k x) / k$ ($x in bb(R)$) trigonometrikus sort, és jelölje $S_n (x) := sum_(k=1)^n sin(k x) / k$ a részletösszegeit.
  1. *Pontonkénti konvergencia:* a sor minden $x in bb(R)$ helyen konvergens.
  2. *Egyenletes konvergencia:* tetszőleges $0 < u < v < 2 pi$ esetén a sor az $[u, v]$ zárt intervallumon egyenletesen konvergens.
  3. *Nem egyenletes konvergencia:* a $(0, 2 pi)$ nyílt intervallumon (így $bb(R)$-en sem) a konvergencia nem egyenletes.
  4. *Egyenletes korlátosság:* $abs(S_n (x)) <= 1 + pi$ minden $x in bb(R)$ és $n in bb(N)^+$ esetén.
])

#v(8pt)

#proofbox("A konvergencia-tulajdonságok igazolása", [
  *1. Pontonkénti konvergencia.* \
  - Ha $x = 2 m pi$ ($m in bb(Z)$), akkor $sin(k x) = 0$ minden $k$-ra, a sor összege $0$.
  - Ha $x in (0, 2 pi)$, a Dirichlet-kritériumot alkalmazzuk: $a_k = 1 / k$ monoton fogyó nullasorozat, $b_k (x) = sin(k x)$. A részletösszegek korlátosak:
    $
      sum_(k=1)^n sin(k x) = (cos(x / 2) - cos((n + 1 / 2) x)) / (2 sin(x / 2)) quad ==> quad abs(sum_(k=1)^n sin(k x)) <= 1 / sin(x / 2).
    $
    Így a sor konvergens. A többi $x$-re a $2 pi$-periodicitás miatt ugyanez érvényes.

  *2. Egyenletes konvergencia $[u, v] subset (0, 2 pi)$-n.* \
  Mivel $x / 2 in [u / 2, v / 2] subset (0, pi)$, a $q := min_(x in [u, v]) sin(x / 2)$ szám pozitív. Ezért $abs(sum_(k=1)^n sin(k x)) <= 1 / q$ minden $x in [u, v]$ és $n$ esetén. A Dirichlet-kritérium egyenletes változata szerint (a $1 / k$ nullasorozat független $x$-től) a sor $[u, v]$-n egyenletesen konvergál.

  *3. Nem egyenletes konvergencia $(0, 2 pi)$-n.* \
  Tegyük fel, hogy a konvergencia egyenletes lenne $(0, 2 pi)$-n, és jelölje $f$ az összegfüggvényt. Mivel minden $S_n$ folytonos és $lim_(x -> 0+) S_n (x) = 0$, az egyenletes konvergencia miatt a határátmenetek felcserélhetők:
  $ lim_(x -> 0+) f(x) = lim_(x -> 0+) lim_(n -> infinity) S_n (x) = lim_(n -> infinity) lim_(x -> 0+) S_n (x) = 0. $
  Az alábbiak szerint azonban $f(x) = (pi - x) / 2 -> pi / 2 != 0$ ($x -> 0+$), ami ellentmondás.

  *4. A korlát.* \
  A $S_n$ páratlan és $2 pi$-periodikus, ezért elég $x in (0, pi]$-re igazolni. Legyen $m := floor(pi / x) >= 1$. Az első $m$ tagra $abs(sin(k x) / k) <= x$ miatt $abs(sum_(k=1)^m sin(k x) / k) <= m x <= pi$. A maradékra az Abel-átrendezéssel és a fenti részletösszeg-korláttal ($1 / sin(x / 2) <= pi / x$, mert $sin(x / 2) >= x / pi$ ha $x in (0, pi]$):
  $ abs(sum_(k=m+1)^n sin(k x) / k) <= 1 / (m + 1) dot 1 / sin(x / 2) <= (pi) / ((m + 1) x) < 1, $
  mert $(m + 1) x > pi$. Összesen $abs(S_n (x)) <= pi + 1$. $square$
])

#v(10pt)

== Az összegfüggvény explicit előállítása

#defbox("Összegfüggvény (fűrészfogfüggvény)", [
  A $sum_(k=1)^infinity sin(k x) / k$ sor $f: bb(R) -> bb(R)$ összegfüggvénye $2 pi$-periodikus, páratlan, és
  $ f(x) = cases((pi - x) / 2 quad "ha" x in (0, 2 pi), 0 quad "ha" x = 2 m pi quad (m in bb(Z))). $
])

#v(8pt)

#proofbox("Az összegfüggvény levezetése két módszerrel", [
  *I. módszer: tagonkénti deriválás.* \
  A 16. tétel szerint $(x - pi)^2 / 2 = pi^2 / 6 + sum_(k=1)^infinity 2 cos(k x) / k^2$ ($0 <= x <= 2 pi$), vagyis
  $ g(x) := (x - pi)^2 / 4 - pi^2 / 12 = sum_(k=1)^infinity cos(k x) / k^2 quad (0 <= x <= 2 pi). $
  (Ellenőrzés: $x = 0$-nál mindkét oldal $pi^2 / 6$.) A tagonkénti deriválás feltételei a 13. tétel szerint: a sor egy pontban konvergens, és a deriváltak sora,
  $ sum_(k=1)^infinity (cos(k x) / k^2)' = -sum_(k=1)^infinity sin(k x) / k, $
  egyenletesen konvergens minden $[u, v] subset (0, 2 pi)$ intervallumon (fenti 2. pont). Ezért ezen az intervallumon a sor tagonként deriválható:
  $ g'(x) = (x - pi) / 2 = -sum_(k=1)^infinity sin(k x) / k, $
  azaz
  $ sum_(k=1)^infinity sin(k x) / k = (pi - x) / 2 quad (x in (0, 2 pi)). $

  *II. módszer: Dirichlet-féle konvergenciatétel.* \
  Legyen $f_0 (x) := (pi - x) / 2$ a $(0, 2 pi)$-n, $2 pi$-periodikusan kiterjesztve. Ez szakaszonként folytonosan differenciálható. Mivel $f_0 (2 pi - x) = -f_0 (x)$, a $pi$ körül páratlan, a $cos(k x)$ viszont $pi$ körül páros, ezért
  $
    a_0 = 1 / (2 pi) integral_0^(2 pi) (pi - x) / 2 dif x = 0, quad a_k = 1 / pi integral_0^(2 pi) (pi - x) / 2 cos(k x) dif x = 0.
  $
  A szinuszos együtthatókra parciális integrálással ($u = pi - x$, $v = -cos(k x) / k$):
  $
    integral_0^(2 pi) (pi - x) sin(k x) dif x = [-(pi - x) cos(k x) / k]_0^(2 pi) - 1 / k integral_0^(2 pi) cos(k x) dif x = pi / k + pi / k - 0 = (2 pi) / k,
  $
  tehát $b_k = 1 / pi dot 1 / 2 dot (2 pi) / k = 1 / k$. A Dirichlet-tétel szerint $f_0$ Fourier-sora, vagyis $sum sin(k x) / k$:
  - a folytonossági pontokban ($x in (0, 2 pi)$) $f_0 (x) = (pi - x) / 2$-hez konvergál;
  - a szakadási pontokban ($x = 2 m pi$) a határértékek félösszegéhez: $(pi / 2 + (-pi / 2)) / 2 = 0$. $square$
])

#v(8pt)

#remarkbox("A Gibbs-jelenség", [
  A $2 m pi$ szakadási pontok közelében a részletösszegek túllőnek a szakadás $pi$ nagyságú ugrásán. A $x = pi / n$ helyen
  $
    S_n (pi / n) = sum_(k=1)^n (pi / n) sin(k pi / n) / (k pi / n) -> integral_0^pi sin(t) / t dif t approx 1,8519 quad (n -> infinity),
  $
  miközben a határfüggvény bal oldali határértéke $pi / 2 approx 1,5708$. A túllövés $approx 0,281$, ami az ugrás ($pi$) kb. 8,95 %-a, és $n$-nel nem csökken. Ez magyarázza, hogy a konvergencia a szakadás körül nem egyenletes.
])

#v(10pt)

= A rezgő húr problémája (egydimenziós hullámegyenlet)

A véges hosszúságú, rögzített végű rugalmas húr rezgéseinek leírása a fizika és az analízis történetének egyik meghatározó feladata, amely d'Alembert, Bernoulli, Euler és Fourier munkásságán át a Fourier-sorok és a parciális differenciálegyenletek elméletéhez vezetett.

== A fizikai modell és a matematikai megfogalmazás

Tekintsünk egy $l > 0$ hosszúságú, mindkét végén ($x = 0$ és $x = l$) rögzített, homogén, feszített húrt. Legyen $u(x, t)$ a húr $x in [0, l]$ pontjának kitérése a $t >= 0$ időpontban; kis transzverzális rezgéseket feltételezünk.

#defbox("A rezgő húr kezdeti- és peremérték-problémája", [
  Keresünk egy $u: [0, l] times [0, infinity) -> bb(R)$, $u in C^2$ függvényt, amelyre:
  1. *hullámegyenlet:*
    $ partial_t^2 u(x, t) = c^2 partial_x^2 u(x, t) quad (x in (0, l), t > 0), $
    ahol $c = sqrt(T / rho) > 0$ a terjedési sebesség ($T$ a feszítőerő, $rho$ a vonalsűrűség);
  2. *peremfeltételek:*
    $ u(0, t) = 0, quad u(l, t) = 0 quad (t >= 0); $
  3. *kezdeti feltételek:*
    $ u(x, 0) = f(x) quad "(kezdőalak)", quad partial_t u(x, 0) = g(x) quad "(kezdősebesség)", $
    ahol $f, g: [0, l] -> bb(R)$ adott függvények és $f(0) = f(l) = 0$.
])

#v(10pt)

== A megoldás változók szétválasztásával (Bernoulli-módszer)

Keressük a megoldást $u(x, t) = F(x) G(t)$ szorzat alakban.

#proofbox("A Bernoulli-féle eljárás lépései", [
  *1. lépés: szétválasztás.* \
  Behelyettesítve a hullámegyenletbe: $F(x) G''(t) = c^2 F''(x) G(t)$. Osztva $c^2 F(x) G(t)$-vel:
  $ G''(t) / (c^2 G(t)) = F''(x) / F(x) = -lambda quad (lambda "állandó"). $
  Ebből két közönséges differenciálegyenlet:
  $ F''(x) + lambda F(x) = 0, quad G''(t) + c^2 lambda G(t) = 0. $

  *2. lépés: a térbeli peremértékfeladat.* \
  A peremfeltételekből a nemtriviális megoldáshoz $F(0) = F(l) = 0$ kell.
  - Ha $lambda <= 0$: az általános megoldás $a x + b$ ($lambda = 0$), illetve exponenciális függvények kombinációja ($lambda < 0$). A peremfeltételekből ekkor csak $F equiv 0$ adódik.
  - Ha $lambda > 0$, legyen $lambda = k^2$ ($k > 0$): $F(x) = C_1 cos(k x) + C_2 sin(k x)$. Az $F(0) = 0$ miatt $C_1 = 0$, az $F(l) = C_2 sin(k l) = 0$ és $C_2 != 0$ miatt $sin(k l) = 0$, azaz
    $ k_n = (n pi) / l quad (n in bb(N)^+). $
  A *sajátértékek* és *sajátfüggvények*:
  $ lambda_n = ((n pi) / l)^2, quad F_n (x) = sin((n pi x) / l) quad (n = 1, 2, 3, dots). $

  *3. lépés: az időbeli egyenlet.* \
  A $G''_n (t) + ((n pi c) / l)^2 G_n (t) = 0$ általános megoldása
  $ G_n (t) = A_n cos((n pi c t) / l) + B_n sin((n pi c t) / l). $
  Így minden $n$-re kapunk egy sajátrezgést (állóhullámot):
  $ u_n (x, t) = [A_n cos((n pi c t) / l) + B_n sin((n pi c t) / l)] sin((n pi x) / l). $

  *4. lépés: szuperpozíció.* \
  A hullámegyenlet és a peremfeltételek lineárisak és homogének, ezért a megoldások összege is megoldás (formálisan):
  $ u(x, t) = sum_(n=1)^infinity [A_n cos((n pi c t) / l) + B_n sin((n pi c t) / l)] sin((n pi x) / l). $

  *5. lépés: a kezdeti feltételek illesztése.* \
  - A $t = 0$ helyen $u(x, 0) = sum_(n=1)^infinity A_n sin((n pi x) / l) = f(x)$, ez $f$ Fourier-szinuszsora $[0, l]$-en, így az ortogonalitás miatt
    $ A_n = 2 / l integral_0^l f(x) sin((n pi x) / l) dif x. $
  - Tagonkénti deriválás után $partial_t u(x, 0) = sum_(n=1)^infinity B_n (n pi c) / l sin((n pi x) / l) = g(x)$, ezért
    $ B_n = 2 / (n pi c) integral_0^l g(x) sin((n pi x) / l) dif x. $
])

#v(8pt)

== A d'Alembert-féle megoldóképlet

A Fourier-féle soros megoldás trigonometrikus átalakításokkal zárt alakra hozható.

#theorembox("Tétel: d'Alembert-formula", [
  Legyen $f^*$ és $g^*$ az $f$, $g$ függvények $2 l$-periodikus, páratlan kiterjesztése $bb(R)$-re. Ha $f in C^2$, $g in C^1$ és $f(0) = f(l) = f''(0) = f''(l) = g(0) = g(l) = 0$ (hogy a kiterjesztések is sima függvények legyenek), akkor a feladat $C^2$ megoldása
  $ u(x, t) = (f^*(x - c t) + f^*(x + c t)) / 2 + 1 / (2 c) integral_(x - c t)^(x + c t) g^*(s) dif s. $
])

#v(8pt)

#proofbox("A d'Alembert-formula és a Fourier-sor kapcsolata", [
  A $sin alpha cos beta = (sin(alpha + beta) + sin(alpha - beta)) / 2$ azonossággal:
  $ A_n sin((n pi x) / l) cos((n pi c t) / l) = A_n / 2 [sin((n pi (x + c t)) / l) + sin((n pi (x - c t)) / l)]. $
  Összegezve $n$-re éppen az $f^*$ szinuszsora adódik az $x + c t$ és $x - c t$ helyeken: $(f^*(x + c t) + f^*(x - c t)) / 2$.

  A $B_n$ tagokra a $sin alpha sin beta = (cos(alpha - beta) - cos(alpha + beta)) / 2$ azonosság szerint
  $ B_n sin((n pi x) / l) sin((n pi c t) / l) = B_n / 2 [cos((n pi (x - c t)) / l) - cos((n pi (x + c t)) / l)]. $
  Másrészt $g^*(s) = sum_(n=1)^infinity B_n (n pi c) / l sin((n pi s) / l)$, így
  $
    1 / (2 c) integral_(x - c t)^(x + c t) g^*(s) dif s = sum_(n=1)^infinity B_n / 2 [cos((n pi (x - c t)) / l) - cos((n pi (x + c t)) / l)],
  $
  ami pontosan a $B_n$-tagok összege. $square$
])

#v(8pt)

#remarkbox("Fizikai értelmezés", [
  A d'Alembert-formula szerint a kezdeti alakváltozás két, ellentétes irányba, $c$ sebességgel haladó hullámra bomlik: $f^*(x - c t)$ jobbra, $f^*(x + c t)$ balra terjed. A rögzített végeknél a páratlan kiterjesztés miatt a hullámok fázisfordulással (ellenkező előjellel) verődnek vissza.
])

#v(10pt)

== Összefoglaló táblázat

#align(center)[
  #table(
    columns: (1.5fr, 2.5fr, 2.5fr),
    fill: (x, y) => if y == 0 { rgb("e6ecf2") } else { none },
    stroke: 0.5pt + luma(150),
    [*Témakör*], [*Kulcsképlet / állítás*], [*Feltétel / megjegyzés*],
    [Szinuszsor],
    [$sum_(k=1)^infinity sin(k x) / k = (pi - x) / 2$],
    [$x in (0, 2 pi)$-re; $x = 2 m pi$-ben $0$ (félösszeg)],

    [Konvergenciatípus],
    [pontonként $bb(R)$-en, egyenletesen $[u, v] subset (0, 2 pi)$-n],
    [$(0, 2 pi)$-n nem egyenletes (Gibbs-túllövés $approx 8,95$ %)],

    [Hullámegyenlet], [$partial_t^2 u = c^2 partial_x^2 u$, $c = sqrt(T / rho)$], [$u(0, t) = u(l, t) = 0$],
    [Sajátfüggvények],
    [$F_n (x) = sin((n pi x) / l)$, $lambda_n = ((n pi) / l)^2$],
    [a térbeli peremértékfeladat megoldásai],

    [Bernoulli-sor],
    [$u(x, t) = sum_(n=1)^infinity G_n (t) F_n (x)$],
    [$A_n$, $B_n$ az $f$, $g$ Fourier-szinuszegyütthatói],

    [d'Alembert-alak],
    [$u = (f^*(x - c t) + f^*(x + c t)) / 2 + 1 / (2 c) integral_(x - c t)^(x + c t) g^*$],
    [jobbra és balra haladó hullámok szuperpozíciója],
  )
]
