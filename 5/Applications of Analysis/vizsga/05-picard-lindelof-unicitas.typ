// Typst source document for Exam Topic 5
// Analízis Alkalmazásai - 5. Tétel
// "Lipschitz-feltétel. A Picard-Lindelöf-féle egzisztencia-tétel (a fixpont-tétel alkalmazása). A k.é.p. megoldásának az egyértelműsége, unicitási tétel (bizonyítás nélkül)."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (5. Tétel)
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
    #text(weight: "bold")[5. Tétel:]
    _„Lipschitz-feltétel. A Picard-Lindelöf-féle egzisztencia-tétel (a fixpont-tétel alkalmazása). A k.é.p. megoldásának az egyértelműsége, unicitási tétel (bizonyítás nélkül).”_
  ]
]

#v(15pt)

= Bevezetés és a téma matematikai kontextusa

Az elsőrendű közönséges differenciálegyenletek elméletében az egyik legalapvetőbb kérdés az úgynevezett *Cauchy-feladat* (kezdetiérték-probléma, k.é.p.):
$ y' = f(t, y), quad y(t_0) = y_0 $
megoldhatósága és a megoldás egyértelműsége.

A fizikai és mérnöki modellekben a folyamatok determinisztikus jellege megköveteli, hogy a kezdeti állapot ($y_0$) egyértelműen meghatározza a rendszer jövőbeli állapotát. Matematikailag azonban a pusztán folytonos $f(t, y)$ jobb oldal (a Peano-féle egzisztenciatétel) csak a megoldás *létezését* garantálja, az *egyértelműségét* nem.

Az egyértelműséghez és a konstruktív megoldáshoz egy erősebb feltételre, a *Lipschitz-feltételre* van szükségünk. A tételsor ezen fejezete bemutatja a Lipschitz-tulajdonságot, az ekvivalens Volterra-integrálegyenletet, a Picard–Lindelöf-egzisztenciatételt a Banach-féle fixpont-tétel segítségével, valamint az unicitási tételt.

#v(10pt)

= A Lipschitz-feltétel

#defbox("1. Definíció: Lipschitz-feltétel a második változóban")[
  Legyen $I subset bb(R)$ egy intervallum, és $Omega subset bb(R)^n$ egy nyílt halmaz. Az $f: I times Omega -> bb(R)^n$ függvény *teljesíti a Lipschitz-feltételt a második (vektor)változójában* az $I times Omega$ halmazon, ha létezik olyan $L >= 0$ konstans (Lipschitz-konstans), hogy minden $t in I$ és minden $y_1, y_2 in Omega$ esetén:
  $ norm(f(t, y_1) - f(t, y_2)) <= L norm(y_1 - y_2). $
]

#v(8pt)

#defbox("2. Definíció: Lokális Lipschitz-feltétel")[
  Az $f: I times Omega -> bb(R)^n$ függvény *lokálisan Lipschitz-tulajdonságú* a második változójában az $I times Omega$ halmazon, ha minden $(t_0, y_0) in I times Omega$ pontnak létezik olyan $U subset I times Omega$ nyílt környezete, amelyen $f$ teljesíti a Lipschitz-feltételt valamely $L_U >= 0$ konstanssal.
]

#v(8pt)

#remarkbox("Gyakorlati elégséges feltétel a Lipschitz-tulajdonságra")[
  Ha az $f(t, y)$ függvény folytonosan differenciálható az $y$ változója szerint ($partial_y f in C(I times Omega)$), akkor a többváltozós középértéktétel miatt $f$ lokálisan Lipschitz-tulajdonságú. Ha ezen felül $norm(partial_y f(t, y)) <= L$ és $Omega$ konvex, akkor $f$ globálisan is teljesíti a Lipschitz-feltételt $L$-lel.
]

#v(10pt)

= Az ekvivalens integrálegyenlet és a Picard-operátor

A Cauchy-feladat megoldásának kulcsa a differenciálegyenlet átfogalmazása integrálegyenletté.

#theorembox("1. Tétel: Ekvivalens Volterra-integrálegyenlet")[
  Legyen $f: I times Omega -> bb(R)^n$ folytonos függvény, és $(t_0, y_0) in I times Omega$. Az $y: I_0 -> Omega$ ($t_0 in I_0 subset I$) függvény pontosan akkor $C^1$-beli megoldása az
  $ y' = f(t, y), quad y(t_0) = y_0 $
  kezdetiérték-problémának, ha $y$ folytonos $I_0$-on és kielégíti az alábbi Volterra-típusú integrálegyenletet:
  $ y(t) = y_0 + integral_(t_0)^t f(s, y(s)) dif s, quad (t in I_0). $
]

#v(8pt)

#proofbox("Az ekvivalencia bizonyítása")[
  *1. ($==>$) irány:* \
  Ha $y in C^1(I_0)$ megoldás, akkor $y'(s) = f(s, y(s))$ minden $s in I_0$-ra. Integrálva mindkét oldalt $t_0$-tól $t$-ig, a Newton–Leibniz-tétel alapján:
  $ integral_(t_0)^t y'(s) dif s = y(t) - y(t_0) = integral_(t_0)^t f(s, y(s)) dif s, $
  amiből $y(t_0) = y_0$ miatt $y(t) = y_0 + integral_(t_0)^t f(s, y(s)) dif s$.

  *2. ($arrow.l.double$) irány:* \
  Ha $y in C(I_0)$ kielégíti az integrálegyenletet, akkor $s |-> f(s, y(s))$ folytonos függvények kompozíciójaként folytonos, így az integrálfüggvény az analízis alaptétele szerint folytonosan differenciálható. Tehát $y in C^1(I_0)$, és $t$ szerint deriválva:
  $ y'(t) = (dif) / (dif t) (y_0 + integral_(t_0)^t f(s, y(s)) dif s) = f(t, y(t)), $
  továbbá $y(t_0) = y_0 + integral_(t_0)^(t_0) f(s, y(s)) dif s = y_0$.
]

#v(8pt)

#defbox("3. Definíció: Picard-operátor")[
  A Cauchy-feladathoz tartozó *Picard-operátort* a $C(I_0, bb(R)^n)$ függvénytéren az alábbiak szerint értelmezzük:
  $ (A y)(t) := y_0 + integral_(t_0)^t f(s, y(s)) dif s. $
  Így a kezdetiérték-probléma megoldása nem más, mint az $A$ operátor *fixpontjának* megkeresése: $A y = y$.
]

#v(10pt)

= A Picard–Lindelöf-féle egzisztenciatétel

#theorembox("2. Tétel: Picard–Lindelöf egzisztenciatétel (lokális változat)")[
  Legyen $(t_0, y_0) in bb(R) times bb(R)^n$. Tekintsük a zárt téglatestet:
  $ R := {(t, y) in bb(R) times bb(R)^n : abs(t - t_0) <= a, norm(y - y_0) <= b} quad (a, b > 0). $
  Tételezzük fel, hogy az $f: R -> bb(R)^n$ függvényre teljesülnek az alábbiak:
  1. $f$ folytonos az $R$ téglatesten, így $M := max_((t, y) in R) norm(f(t, y)) < infinity$;
  2. $f$ a második változójában teljesíti a Lipschitz-feltételt $R$-en $L >= 0$ konstanssal.

  Legyen $delta := min(a, b / M)$ (ha $M = 0$, akkor $delta := a$). Ekkor az $I_delta := [t_0 - delta, t_0 + delta]$ intervallumon az $y' = f(t, y)$, $y(t_0) = y_0$ Cauchy-feladatnak *létezik* egy (sőt, egyértelmű) $y in C^1(I_delta)$ megoldása.
]

#v(8pt)

#proofbox("A Picard–Lindelöf-tétel bizonyításának vázlata (Banach-fixponttétel)")[
  A bizonyítás 4 fő lépésből áll a Banach-féle fixpont-tétel alkalmazásával.

  *1. Lépés: A metrikus tér kijelölése.* \
  Tekintsük a folytonos függvények terében az alábbi részhalmazt:
  $ X := {y in C(I_delta, bb(R)^n) : norm(y(t) - y_0) <= b "minden" t in I_delta "esetén"}. $
  A szupremum-normával ($norm(y)_infinity = max_(t in I_delta) norm(y(t))$) ellátott $C(I_delta, bb(R)^n)$ Banach-tér, $X$ pedig zárt részhalmaz, ezért $(X, d_infinity)$ teljes metrikus tér.

  *2. Lépés: A Picard-operátor önmagába képezése ($A(X) subset X$).* \
  Legyen $y in X$. Ekkor minden $t in I_delta$ esetén:
  $
    norm((A y)(t) - y_0) = norm(integral_(t_0)^t f(s, y(s)) dif s) <= abs(integral_(t_0)^t norm(f(s, y(s))) dif s) <= M abs(t - t_0) <= M delta.
  $
  Mivel $delta <= b / M$, ezért $M delta <= b$, vagyis $norm((A y)(t) - y_0) <= b$. Így $A y in X$, azaz $A$ az $X$ halmazt önmagába képezi.

  *3. Lépés: A kontrakciós tulajdonság igazolása.* \
  Legyen $y_1, y_2 in X$. Ekkor a Lipschitz-feltétel miatt:
  $
    norm((A y_1)(t) - (A y_2)(t)) <= abs(integral_(t_0)^t norm(f(s, y_1(s)) - f(s, y_2(s))) dif s) <= L abs(integral_(t_0)^t norm(y_1(s) - y_2(s)) dif s).
  $
  A szupremum-norma szerinti becsléssel:
  $ norm(A y_1 - A y_2)_infinity <= L delta norm(y_1 - y_2)_infinity. $
  - *a) eset:* Ha $L delta < 1$ (ami $delta$ további csökkentésével elérhető), akkor $A$ szigorú kontrakció $X$-en a $q = L delta < 1$ konstanssal.
  - *b) eset (elegánsabb változat, Bielecki-normával):* Az $X$ téren használjuk a $norm(y)_B := max_(t in I_delta) (e^(-L abs(t - t_0)) norm(y(t)))$ normát, amely ekvivalens a szupremum-normával (így $X$ ebben is teljes). Erre a normára
    $ norm(A y_1 - A y_2)_B <= (1 - e^(-L delta)) norm(y_1 - y_2)_B, $
    tehát $A$ *tetszőleges* $delta = min(a, b / M)$ esetén szigorú kontrakció a $q = 1 - e^(-L delta) < 1$ konstanssal, $delta$ további csökkentése nélkül.

  *4. Lépés: Konklúzió.* \
  A Banach-féle fixpont-tétel értelmében az $A: X -> X$ leképezésnek egyértelmű $y^* in X$ fixpontja létezik ($A y^* = y^*$). Az 1. Tétel (ekvivalencia) miatt ez az $y^*$ függvény a Cauchy-feladat megoldása.
]

#v(8pt)

#remarkbox("A Picard-iteráció (szukcesszív approximáció)")[
  A Banach-fixponttétel konstrukciót is ad a megoldás megkeresésére. A megoldás a *Picard-iterációs sorozat* határértékeként áll elő:
  $ phi_0 (t) := y_0, quad phi_(k+1)(t) := y_0 + integral_(t_0)^t f(s, phi_k (s)) dif s quad (k = 0, 1, 2, dots). $
  A tétel garantálja, hogy $phi_k -> y^*$ egyenletesen az $I_delta$ intervallumon.
]

#v(10pt)

= A megoldás egyértelműsége (unicitási tétel)

#theorembox("3. Tétel: Cauchy–Lipschitz unicitási tétel (bizonyítás nélkül)")[
  Legyen $D subset bb(R) times bb(R)^n$ nyílt tartomány, és $f: D -> bb(R)^n$ folytonos függvény, amely a második változójában lokálisan teljesíti a Lipschitz-feltételt $D$-n.

  Ekkor ha $y_1: I_1 -> bb(R)^n$ és $y_2: I_2 -> bb(R)^n$ két megoldása (ahol $I_1, I_2$ a $t_0$-t tartalmazó intervallumok) az
  $ y' = f(t, y), quad y(t_0) = y_0 $
  kezdetiérték-problémának, ahol $(t_0, y_0) in D$, akkor a két megoldás *egybeesik* a közös értelmezési tartományukon:
  $ y_1(t) = y_2(t) quad "minden" t in I_1 inter I_2 "esetén". $
]

#v(8pt)

#remarkbox("A Gronwall-lemma szerepe az unicitás bizonyításában")[
  Bár a tételt bizonyítás nélkül kérjük, megjegyezzük, hogy az unicitás bizonyításának alapja a *Gronwall-egyenlőtlenség*. Ha $u(t) = norm(y_1(t) - y_2(t))$, akkor az integrálegyenletből (egy, a megoldások pályáját tartalmazó kompakt halmazon érvényes Lipschitz-konstanssal) $u(t) <= L abs(integral_(t_0)^t u(s) dif s)$ adódik $u(t_0) = 0$ mellett, amiből a Gronwall-lemma alapján $u(t) equiv 0$ következik.
]

#v(10pt)

= A Peano-tétel és a nem-egyértelműségi ellenpélda

Ahhoz, hogy megértsük a Lipschitz-feltétel fontosságát, érdemes összevetni a Peano-tétellel.

#theorembox("4. Tétel: Peano egzisztenciatétel")[
  Ha $f: R -> bb(R)^n$ csupán *folytonos* a $(t_0, y_0)$ pont egy környezetében (de nem feltétlenül Lipschitz-tulajdonságú), akkor az $y' = f(t, y)$, $y(t_0) = y_0$ Cauchy-feladatnak *létezik legalább egy* lokális megoldása. (A megoldás azonban *nem* feltétlenül egyértelmű.)
]

#v(8pt)

#remarkbox("Klasszikus ellenpélda: a Peano-féle nem-egyértelműség")[
  Tekintsük az alábbi kezdetiérték-problémát:
  $ y' = 3 y^(2/3), quad y(0) = 0. $
  - Az $f(t, y) = 3 y^(2/3)$ függvény folytonos az egész $bb(R)^2$-en, így a Peano-tétel szerint létezik megoldás.
  - Ugyanakkor $partial_y f(t, y) = 2 y^(-1/3)$, ami az $y = 0$ pont környezetében *nem korlátos*, így $f$ *nem teljesíti a Lipschitz-feltételt* az $y = 0$ pont körül.
  - *Következmény:* a kezdetiérték-problémának *végtelen sok* megoldása létezik. Például:
    1. $y_1(t) = 0$ (a triviális megoldás);
    2. $y_2(t) = t^3$ (mivel $y'_2(t) = 3 t^2$ és $3 (t^3)^(2/3) = 3 t^2$);
    3. tetszőleges $c > 0$ esetén:
      $ y_c (t) = cases(0 quad "ha" t <= c, (t - c)^3 quad "ha" t > c). $

  Ez a példa jól szemlélteti, hogy a Lipschitz-feltétel elengedhetetlen a determinisztikus viselkedést garantáló egyértelműséghez.
]

#v(10pt)

= Összefoglaló táblázat a tételek összehasonlítására

#align(center)[
  #table(
    columns: (30%, 35%, 35%),
    fill: (x, y) => if y == 0 { rgb("e6ecf2") } else if calc.even(y) { rgb("f9fbfd") } else { white },
    stroke: 0.5pt + luma(150),
    align: (left, left, left),
    [*Jellemző*], [*Peano-tétel*], [*Picard–Lindelöf-tétel*],
    [*Feltétel $f$-re*], [Folytonosság ($f in C$)], [Folytonosság + Lipschitz-feltétel $y$-ban],
    [*Létezés (egzisztencia)*], [Létezik lokális megoldás], [Létezik lokális megoldás],
    [*Egyértelműség (unicitás)*], [Nem garantált (lehet végtelen sok)], [Garantált (egyértelmű megoldás)],
    [*Bizonyítás módszere*], [Arzelà–Ascoli-tétel (kompaktság)], [Banach-féle fixpont-tétel (kontrakció)],
    [*Konstruktivitás*], [Nem konstruktív], [Konstruktív (a Picard-iteráció konvergál)],
  )
]
