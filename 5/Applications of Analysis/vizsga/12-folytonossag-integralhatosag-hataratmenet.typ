// Typst source document for Exam Topic 12
// Analízis Alkalmazásai - 12. Tétel
// "A folytonosság, ill. a Riemann-integrálhatóság kérdése konvergens függvénysorozatokkal kapcsolatban. Egyenletesen konvergens függvénysorozat határfüggvényének a folytonossága, ill. integrálhatósága. Az integrálás és a határátmenet felcserélhetősége."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (12. Tétel)
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
    #text(weight: "bold")[12. Tétel:]
    _„A folytonosság, ill. a Riemann-integrálhatóság kérdése konvergens függvénysorozatokkal kapcsolatban. Egyenletesen konvergens függvénysorozat határfüggvényének a folytonossága, ill. integrálhatósága. Az integrálás és a határátmenet felcserélhetősége.”_
  ]
]

#v(15pt)

= Bevezetés és a probléma megfogalmazása

A függvénysorozatok és függvénysorok elméletének egyik központi kérdése, hogy a tagok jó tulajdonságai (folytonosság, Riemann-integrálhatóság, differenciálhatóság) átöröklődnek-e a határfüggvényre, illetve az összegfüggvényre.

Gyakorlati szempontból ez azt jelenti, hogy felcserélhető-e a határérték-képzés és az integrálás:
$
  lim_(n -> infinity) integral_a^b f_n (x) dif x eq.quest integral_a^b (lim_(n -> infinity) f_n (x)) dif x = integral_a^b f(x) dif x.
$

A puszta *pontonkénti konvergencia* általában *nem elegendő* ezen tulajdonságok megőrzéséhez. A kulcsfontosságú elégséges feltétel az *egyenletes konvergencia*.

== Miért nem elég a pontonkénti konvergencia? (klasszikus ellenpéldák)

#remarkbox("1. ellenpélda: a folytonosság elvesztése", [
  Tekintsük az $f_n: [0, 1] -> bb(R)$, $f_n (x) = x^n$ függvénysorozatot.
  - Minden $f_n$ folytonos a $[0, 1]$ intervallumon.
  - A sorozat pontonként konvergál az
    $ f(x) = lim_(n -> infinity) x^n = cases(0 quad "ha" 0 <= x < 1, 1 quad "ha" x = 1) $
    határfüggvényhez.
  - Az $f$ *nem folytonos* az $x = 1$ pontban, tehát a pontonkénti konvergencia nem őrzi meg a folytonosságot. (Az alábbi tétel szerint ebből az is következik, hogy a konvergencia nem egyenletes.)
])

#v(8pt)

#remarkbox("2. ellenpélda: az integrál és a határérték felcserélhetőségének bukása", [
  Tekintsük az $f_n: [0, 1] -> bb(R)$, $f_n (x) = 2 n^2 x e^(-n^2 x^2)$ függvénysorozatot.
  - Bármely rögzített $x in [0, 1]$ esetén $lim_(n -> infinity) f_n (x) = 0$, tehát a határfüggvény $f equiv 0$, és $integral_0^1 f(x) dif x = 0$.
  - Ugyanakkor:
    $ integral_0^1 f_n (x) dif x = [-e^(-n^2 x^2)]_0^1 = 1 - e^(-n^2). $
  - Így
    $ lim_(n -> infinity) integral_0^1 f_n (x) dif x = 1 != 0 = integral_0^1 (lim_(n -> infinity) f_n (x)) dif x. $
  - Bár a határfüggvény folytonos és integrálható, az integrálok határértéke nem egyezik meg a határfüggvény integráljával.
])

#v(8pt)

#remarkbox("3. ellenpélda: a Riemann-integrálhatóság elvesztése", [
  Legyen $r_1, r_2, r_3, dots$ a $[0, 1]$-be eső racionális számok egy felsorolása. Definiáljuk az $f_n: [0, 1] -> bb(R)$ függvényeket:
  $ f_n (x) = cases(1 quad "ha" x in {r_1, r_2, dots, r_n}, 0 quad "egyébként"). $
  - Minden $f_n$ csak véges sok pontban nem nulla, így Riemann-integrálható, és $integral_0^1 f_n (x) dif x = 0$.
  - A pontonkénti határfüggvény a *Dirichlet-függvény*:
    $
      f(x) = lim_(n -> infinity) f_n (x) = cases(1 quad "ha" x in bb(Q) inter [0, 1], 0 quad "ha" x in [0, 1] without bb(Q)).
    $
  - Az $f$ egyetlen részintervallumon sem Riemann-integrálható (minden részintervallumon az alsó közelítő összeg $0$, a felső $1$).
])

#v(10pt)

= A határfüggvény folytonossága egyenletes konvergencia esetén

#defbox("Definíció: egyenletes konvergencia", [
  Az $f_n: I -> bb(R)$ függvénysorozat *egyenletesen konvergál* az $f: I -> bb(R)$ függvényhez az $I subset bb(R)$ halmazon (jelölés: $f_n arrows.rr f$), ha minden $epsilon > 0$-hoz létezik olyan $N(epsilon) in bb(N)$, hogy minden $n >= N(epsilon)$ és *minden* $x in I$ esetén
  $ abs(f_n (x) - f(x)) < epsilon. $
])

#v(8pt)

#theorembox("Tétel: az egyenletes határfüggvény folytonossága", [
  Legyen $I subset bb(R)$ intervallum, $f_n: I -> bb(R)$ függvénysorozat. Ha
  1. minden $n$ esetén $f_n$ folytonos az $x_0 in I$ pontban, és
  2. $f_n arrows.rr f$ az $I$-n,

  akkor az $f$ határfüggvény is folytonos $x_0$-ban.

  _Következmény:_ ha minden $f_n$ folytonos $I$-n és $f_n arrows.rr f$, akkor $f in C(I)$.
])

#v(8pt)

#proofbox([A tétel bizonyítása ($epsilon slash 3$-argumentum)], [
  Azt kell igazolnunk, hogy tetszőleges $epsilon > 0$-hoz létezik $delta > 0$, hogy $x in I$, $abs(x - x_0) < delta$ esetén $abs(f(x) - f(x_0)) < epsilon$. Tetszőleges $n$-re a háromszög-egyenlőtlenség szerint:
  $ abs(f(x) - f(x_0)) <= abs(f(x) - f_n (x)) + abs(f_n (x) - f_n (x_0)) + abs(f_n (x_0) - f(x_0)). $

  *1. lépés (egyenletes konvergencia).* Az egyenletes konvergencia miatt $epsilon / 3$-hoz létezik $N$, hogy minden $n >= N$ és minden $y in I$ esetén $abs(f_n (y) - f(y)) < epsilon / 3$. Rögzítsünk egy $n_0 >= N$ indexet. Ekkor $abs(f_(n_0)(x) - f(x)) < epsilon / 3$ minden $x in I$-re, és $abs(f_(n_0)(x_0) - f(x_0)) < epsilon / 3$.

  *2. lépés ($f_(n_0)$ folytonossága).* Mivel $f_(n_0)$ folytonos $x_0$-ban, $epsilon / 3$-hoz van olyan $delta > 0$, hogy $x in I$, $abs(x - x_0) < delta$ esetén $abs(f_(n_0)(x) - f_(n_0)(x_0)) < epsilon / 3$.

  *3. lépés (összegzés).* Ha $x in I$ és $abs(x - x_0) < delta$, akkor
  $
    abs(f(x) - f(x_0)) <= underbrace(abs(f(x) - f_(n_0)(x)), < epsilon / 3) + underbrace(abs(f_(n_0)(x) - f_(n_0)(x_0)), < epsilon / 3) + underbrace(abs(f_(n_0)(x_0) - f(x_0)), < epsilon / 3) < epsilon.
  $
  Tehát $f$ folytonos $x_0$-ban. $square$
])

#v(8pt)

#theorembox("Következmény függvénysorokra", [
  Ha a $sum_(k=1)^infinity u_k (x)$ függvénysor tagjai folytonosak az $I$ intervallumon, és a sor $I$-n egyenletesen konvergens, akkor az $S(x) = sum_(k=1)^infinity u_k (x)$ összegfüggvény is folytonos $I$-n.
])

#v(10pt)

= A Riemann-integrálhatóság és az integrálás felcserélhetősége

#theorembox("Főtétel: integrálhatóság átöröklődése és a határátmenet felcserélhetősége", [
  Legyen $[a, b] subset bb(R)$ korlátos és zárt intervallum, és $f_n: [a, b] -> bb(R)$ olyan függvénysorozat, amelyre
  1. minden $n$-re $f_n in cal(R)([a, b])$ (Riemann-integrálható), és
  2. $f_n arrows.rr f$ a $[a, b]$-n.

  Ekkor
  1. $f in cal(R)([a, b])$, és
  2. az integrálás és a határérték-képzés felcserélhető:
    $
      lim_(n -> infinity) integral_a^b f_n (x) dif x = integral_a^b (lim_(n -> infinity) f_n (x)) dif x = integral_a^b f(x) dif x.
    $
])

#v(8pt)

#proofbox("A főtétel bizonyítása", [
  *1. rész: $f in cal(R)([a, b])$.* \
  Legyen $epsilon > 0$. Az egyenletes konvergencia miatt van $N$, hogy minden $n >= N$ és $x in [a, b]$ esetén $abs(f_n (x) - f(x)) < eta$, ahol $eta := epsilon / (4 (b - a))$. Rögzítsünk $n_0 >= N$-et. Ekkor
  $ f_(n_0)(x) - eta <= f(x) <= f_(n_0)(x) + eta quad (x in [a, b]), $
  így $f$ korlátos (mert $f_(n_0)$ az).

  Mivel $f_(n_0)$ integrálható, a Riemann-kritérium szerint van a $[a, b]$-nek olyan $P$ felosztása, amelyre $U(f_(n_0), P) - L(f_(n_0), P) < epsilon / 2$. A fenti egyenlőtlenségek miatt a felosztás minden részintervallumán $sup f <= sup f_(n_0) + eta$ és $inf f >= inf f_(n_0) - eta$, ezért
  $ U(f, P) <= U(f_(n_0), P) + eta (b - a) = U(f_(n_0), P) + epsilon / 4, $
  $ L(f, P) >= L(f_(n_0), P) - eta (b - a) = L(f_(n_0), P) - epsilon / 4. $
  Kivonva:
  $ U(f, P) - L(f, P) <= U(f_(n_0), P) - L(f_(n_0), P) + epsilon / 2 < epsilon. $
  A Riemann-kritérium szerint tehát $f in cal(R)([a, b])$.

  *2. rész: az integrálok határértéke.* \
  Az integrál linearitásával és monotonitásával:
  $
    abs(integral_a^b f_n (x) dif x - integral_a^b f(x) dif x) <= integral_a^b abs(f_n (x) - f(x)) dif x <= norm(f_n - f)_infinity (b - a),
  $
  ahol $norm(f_n - f)_infinity := sup_(x in [a, b]) abs(f_n (x) - f(x))$. Az egyenletes konvergencia éppen azt jelenti, hogy $norm(f_n - f)_infinity -> 0$, így a rendőrelv szerint
  $ lim_(n -> infinity) integral_a^b f_n (x) dif x = integral_a^b f(x) dif x. quad square $
])

#v(8pt)

#theorembox("Tagonkénti integrálhatóság függvénysorokra", [
  Ha a $sum_(k=1)^infinity u_k$ függvénysor tagjai Riemann-integrálhatók a $[a, b]$ korlátos és zárt intervallumon, és a sor $[a, b]$-n egyenletesen konvergens, akkor
  1. az $S(x) = sum_(k=1)^infinity u_k (x)$ összegfüggvény is Riemann-integrálható $[a, b]$-n;
  2. a sor tagonként integrálható:
    $ integral_a^b (sum_(k=1)^infinity u_k (x)) dif x = sum_(k=1)^infinity (integral_a^b u_k (x) dif x). $
])

#v(10pt)

= Kiegészítés: a határfüggvény deriválhatósága

#remarkbox("Figyelmeztetés: az egyenletes konvergencia nem elég a deriválhatósághoz", [
  A folytonossággal és az integrálhatósággal ellentétben az $f_n arrows.rr f$ egyenletes konvergenciából *nem következik*, hogy a határfüggvény deriválható. Például az $f_n (x) = sqrt(x^2 + 1 / n)$ függvények a $[-1, 1]$-en egyenletesen konvergálnak az $f(x) = abs(x)$ függvényhez (mert $0 <= f_n (x) - abs(x) <= 1 / sqrt(n)$), és minden $f_n$ végtelen sokszor differenciálható, de $f(x) = abs(x)$ az $x = 0$ pontban nem deriválható.
])

#v(8pt)

#theorembox("Tétel: tagonkénti deriválás elégséges feltétele", [
  Legyen $[a, b]$ korlátos és zárt intervallum, $f_n in C^1([a, b])$. Ha
  1. van olyan $x_0 in [a, b]$, hogy az $(f_n (x_0))$ számsorozat konvergens, és
  2. a deriváltak $(f'_n)$ sorozata egyenletesen konvergál a $[a, b]$-n egy $g$ függvényhez ($f'_n arrows.rr g$),

  akkor
  1. $f_n$ egyenletesen konvergál a $[a, b]$-n egy $f in C^1([a, b])$ függvényhez, és
  2. $f' = g$, azaz
    $ (lim_(n -> infinity) f_n (x))' = lim_(n -> infinity) f'_n (x). $
])

#v(8pt)

#remarkbox("A deriválási tétel indoklásának vázlata", [
  Mivel $f'_n arrows.rr g$ és $f'_n$ folytonos, $g$ folytonos. Az $f_n (x) = f_n (x_0) + integral_(x_0)^x f'_n (t) dif t$ előállításban a második tag egyenletesen konvergál $integral_(x_0)^x g(t) dif t$-hez (az integrálos tétel szerint), az első tag pedig számsorozatként konvergál. Így $f_n arrows.rr f$, ahol $f(x) = lim f_n (x_0) + integral_(x_0)^x g(t) dif t$. Az analízis alaptétele szerint $f in C^1$ és $f' = g$.
])

#v(10pt)

= Összefoglaló táblázat

#align(center)[
  #table(
    columns: (3fr, 4fr, 4fr),
    inset: 8pt,
    align: (left, center, center),
    fill: (x, y) => if y == 0 { rgb("e6ecf2") } else if calc.even(y) { rgb("f9fbfd") } else { none },
    stroke: 0.5pt + luma(150),
    [*Tulajdonság*], [*Pontonkénti konvergencia*], [*Egyenletes konvergencia*],
    [Folytonosság átöröklődése],
    [nem (pl. $x^n$ a $[0, 1]$-en)],
    [igen ($f_n$ folytonos, $f_n arrows.rr f ==> f in C$)],

    [Riemann-integrálhatóság],
    [nem (pl. Dirichlet-függvény)],
    [igen ($f_n in cal(R)$, $f_n arrows.rr f ==> f in cal(R)$)],

    [Integrál és határérték felcserélhetősége],
    [nem (pl. $2 n^2 x e^(-n^2 x^2)$)],
    [igen ($lim integral f_n = integral lim f_n$)],

    [Deriválhatóság átöröklődése], [nem], [csak ha $f'_n$ egyenletesen konvergens (és $f_n (x_0)$ konvergens)],
  )
]
