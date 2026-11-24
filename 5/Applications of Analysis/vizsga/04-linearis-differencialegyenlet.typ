// Typst source document for Exam Topic 4
// Analízis Alkalmazásai - 4. Tétel
// "Lineáris differenciálegyenlet. Az állandók variálásának a módszere. A radioaktív bomlás felezési idejének a meghatározása."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (4. Tétel)
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
    #text(weight: "bold")[4. Tétel:]
    _„Lineáris differenciálegyenlet. Az állandók variálásának a módszere. A radioaktív bomlás felezési idejének a meghatározása.”_
  ]
]

#v(15pt)

= Az elsőrendű lineáris differenciálegyenlet fogalma

#defbox("Definíció: Elsőrendű lineáris differenciálegyenlet", [
  Legyen $I subset bb(R)$ egy nyílt intervallum, és legyenek $p, q: I -> bb(R)$ folytonos függvények ($p, q in C(I)$).
  Az
  $ y' + p(x) y = q(x) $
  alakú egyenletet *elsőrendű lineáris differenciálegyenletnek* nevezzük.

  - Ha $q(x) equiv 0$ minden $x in I$ esetén, akkor az egyenlet *homogén lineáris differenciálegyenlet*:
    $ y' + p(x) y = 0. $
  - Ha $q(x) equiv.not 0$, akkor az egyenlet *inhomogén lineáris differenciálegyenlet*, ahol $q(x)$ a zavarótag (vagy forrástag).
])

#v(8pt)

#remarkbox("Alaki megjegyzés", [
  Néhány szakirodalomban az egyenletet az $y' = a(x) y + b(x)$ alakban adják meg. Ez teljesen ekvivalens a fenti alakkal, ha $a(x) = -p(x)$ és $b(x) = q(x)$. A tételsorban a klasszikus $y' + p(x) y = q(x)$ alakot követjük.
])

#v(10pt)

= A homogén lineáris differenciálegyenlet megoldása

A homogén lineáris differenciálegyenlet egyben szétválasztható változójú (szeparábilis) differenciálegyenlet is, így megoldása szeparálással határozható meg.

#theorembox("Tétel: A homogén lineáris differenciálegyenlet általános megoldása", [
  Legyen $p in C(I)$, és legyen $P(x) = integral p(x) dif x$ a $p(x)$ egy tetszőleges primitív függvénye az $I$ intervallumon.
  Ekkor az $y' + p(x) y = 0$ homogén lineáris differenciálegyenlet általános megoldása az $I$ intervallumon:
  $ y_h (x) = c e^(-P(x)) = c e^(-integral p(x) dif x), quad (c in bb(R)). $
])

#v(8pt)
\
\

#proofbox("Bizonyítás", [
  *1. Az $y(x) equiv 0$ triviális megoldás:* \
  Az $y(x) = 0$ konstans függvény minden $x in I$ esetén teljesíti a homogén egyenletet ($0' + p(x) dot 0 = 0$). Ez a $c = 0$ választásnak felel meg.

  *2. A nemnulla megoldások keresése szeparálással:* \
  Tegyük fel, hogy $y(x) != 0$ az $I$ egy részintervallumán. Ekkor az $y' = -p(x) y$ egyenlet mindkét oldalát eloszthatjuk $y$-nal:
  $ (y') / y = -p(x). $
  Mindkét oldalt $x$ szerint integrálva:
  $ integral 1 / y dif y = -integral p(x) dif x. $
  A bal oldal integrálja $ln abs(y)$, a jobb oldalé $-P(x) + K_1$, ahol $K_1 in bb(R)$ integrálási konstans:
  $ ln abs(y(x)) = -P(x) + K_1. $
  Mindkét oldal exponenciálisát véve:
  $ abs(y(x)) = e^(K_1) e^(-P(x)). $
  Az abszolútértéket feloldva $y(x) = plus.minus e^(K_1) e^(-P(x))$. Mivel $y$ folytonos és sehol sem nulla a részintervallumon, az előjel állandó, így a $c := plus.minus e^(K_1) != 0$ jelöléssel:
  $ y(x) = c e^(-P(x)). $
  Mivel a $c = 0$ eset az $y(x) equiv 0$ triviális megoldást adja, a homogén egyenlet összes megoldása tömören felírható az
  $ y_h (x) = c e^(-P(x)), quad (c in bb(R)) $
  alakban.
])

#v(8pt)

#defbox("A homogén megoldások altere", [
  A homogén lineáris differenciálegyenlet megoldáshalmaza a $C^1(I)$ vektortér egy 1-dimenziós alterét alkotja, melynek egy bázisát a $v(x) = e^(-P(x))$ nemnulla megoldás (az úgynevezett fundamentális rendszer) képezi.
])

#v(10pt)

#pagebreak()
= Az inhomogén lineáris differenciálegyenlet és az állandók variálásának módszere

#theorembox("Tétel: Az inhomogén egyenlet megoldási szerkezete", [
  Az $y' + p(x) y = q(x)$ inhomogén lineáris differenciálegyenlet általános megoldása felírható a homogén egyenlet általános megoldásának ($y_h$) és az inhomogén egyenlet egyetlen tetszőleges partikuláris megoldásának ($y_p$) összegeként:
  $ y(x) = y_h (x) + y_p (x) = c e^(-P(x)) + y_p (x), quad (c in bb(R)). $
])

#v(8pt)

== Az állandók variálásának módszere (Lagrange-módszer)

Az állandók variálásának módszere egy szisztematikus eljárás az inhomogén egyenlet egy $y_p (x)$ partikuláris megoldásának megkeresésére.

#theorembox("Tétel: Az állandók variálásának módszere", [
  Legyen $P(x) = integral p(x) dif x$. Keressük az inhomogén egyenlet partikuláris megoldását a homogén megoldás alakjában, de a $c$ konstans helyett egy ismeretlen, differenciálható $c(x)$ függvényt feltételezve:
  $ y_p (x) = c(x) e^(-P(x)). $
  Ekkor a $c(x)$ függvény deriváltjára a
  $ c'(x) = q(x) e^(P(x)) $
  egyenlet adódik, ahonnan $c(x)$ egy határozatlan integrálással megkapható:
  $ c(x) = integral q(x) e^(P(x)) dif x. $
  Így az inhomogén egyenlet teljes általános megoldása:
  $ y(x) = c e^(-P(x)) + e^(-P(x)) integral q(x) e^(P(x)) dif x, quad (c in bb(R)). $
])

#v(8pt)

#proofbox("Bizonyítás", [
  Tegyük fel, hogy létezik $y_p (x) = c(x) e^(-P(x))$ alakú partikuláris megoldás. Deriváljuk a szorzat és az összetett függvény deriválási szabálya alapján (figyelembe véve, hogy $P'(x) = p(x)$):
  $ y'_p (x) = c'(x) e^(-P(x)) + c(x) e^(-P(x)) (-P'(x)) = c'(x) e^(-P(x)) - c(x) p(x) e^(-P(x)). $
  Helyettesítsük be $y_p (x)$-et és $y'_p (x)$-et az inhomogén $y' + p(x) y = q(x)$ egyenletbe:
  $ (c'(x) e^(-P(x)) - c(x) p(x) e^(-P(x))) + p(x) (c(x) e^(-P(x))) = q(x). $
  A bal oldalon a $c(x)$-et tartalmazó második és harmadik tag pontosan kiejti egymást:
  $ c'(x) e^(-P(x)) = q(x). $
  Mindkét oldalt megszorozva $e^(P(x))$-szel:
  $ c'(x) = q(x) e^(P(x)). $
  Mivel $q(x)$ és $P(x)$ folytonosak, a jobb oldal is folytonos, így létezik primitív függvénye:
  $ c(x) = integral q(x) e^(P(x)) dif x. $
  Ezt visszahelyettesítve $y_p (x)$ alakjába megkapjuk a partikuláris megoldást:
  $ y_p (x) = e^(-P(x)) integral q(x) e^(P(x)) dif x. $
  Ezt hozzáadva a $c e^(-P(x))$ homogén általános megoldáshoz megkapjuk az inhomogén egyenlet teljes általános megoldását.
])

#v(10pt)

= Kezdetiérték-probléma (Cauchy-feladat)

#defbox("Definíció: Kezdetiérték-probléma", [
  Legyen $x_0 in I$ és $y_0 in bb(R)$. Az elsőrendű lineáris differenciálegyenletre vonatkozó *Cauchy-feladat* (kezdetiérték-probléma):
  $ cases(y' + p(x) y = q(x), y(x_0) = y_0). $
])

#v(8pt)

#theorembox("Tétel: A Cauchy-feladat egyértelmű megoldhatósága", [
  Ha $p, q in C(I)$, akkor a fenti Cauchy-feladatnak az $I$ intervallumon *egyértelműen létezik* megoldása, amely határozott integrálokkal közvetlenül felírható:
  $ y(x) = y_0 e^(-integral_(x_0)^x p(t) dif t) + integral_(x_0)^x q(s) e^(-integral_s^x p(t) dif t) dif s. $
])

#v(10pt)

= Fizikai alkalmazás: a radioaktív bomlás felezési idejének meghatározása

A radioaktív bomlás az elsőrendű lineáris differenciálegyenletek egyik legfontosabb természeti alkalmazása.

== A fizikai modell felállítása

#defbox("A radioaktív bomlás törvénye", [
  Tapasztalati tény, hogy egy radioaktív mintában az egységnyi idő alatt elbomló atommagok száma arányos a pillanatnyilag jelen lévő, el nem bomlott atommagok $N(t)$ számával (vagy $m(t)$ tömegével).

  Legyen $N(t)$ a $t$ időpontban jelen lévő bomlóképes atommagok száma. Ekkor a bomlási sebesség:
  $ (dif N) / (dif t) = -lambda N(t), $
  ahol $lambda > 0$ az izotópra jellemző *bomlási állandó* (mértékegysége $1 / "s"$), a mínuszjel pedig azt fejezi ki, hogy az atommagok száma az idő múlásával csökken.
])

#v(8pt)

== A differenciálegyenlet megoldása

Az $(dif N) / (dif t) = -lambda N(t)$ egyenlet egy homogén lineáris (és egyben szeparábilis) differenciálegyenlet, ahol $p(t) = lambda$ konstans.

Kezdeti feltételként adjuk meg a $t = 0$ időpontbeli atommagszámot: $N(0) = N_0$.

#proofbox("A bomlási egyenlet levezetése", [
  *1. Szétválasztás:*
  $ 1 / N dif N = -lambda dif t. $
  *2. Integrálás $0$-tól $t$-ig:*
  $ integral_(N_0)^(N(t)) 1 / N dif N = -lambda integral_0^t dif s, $
  $ [ln N]_(N_0)^(N(t)) = -lambda t, $
  $ ln((N(t)) / N_0) = -lambda t. $
  *3. Exponenciálisra emelés:*
  $ (N(t)) / N_0 = e^(-lambda t) quad ==> quad N(t) = N_0 e^(-lambda t). $
  Ez a híres *exponenciális bomlástörvény*.
])

#v(8pt)

== A felezési idő ($T_(1 slash 2)$) definíciója és meghatározása

#defbox("Definíció: Felezési idő", [
  A radioaktív izotóp *felezési idején* ($T_(1 slash 2)$) azt az időtartamot értjük, amely alatt a mintában lévő bomlóképes atommagok száma az eredeti mennyiség felére csökken, azaz:
  $ N(T_(1 slash 2)) = N_0 / 2. $
])

#v(8pt)

#theorembox("Tétel: A felezési idő és a bomlási állandó kapcsolata", [
  A $T_(1 slash 2)$ felezési idő független a kezdeti $N_0$ anyagmennyiségtől, és kizárólag a $lambda$ bomlási állandótól függ:
  $ T_(1 slash 2) = (ln 2) / lambda. $
])

#v(8pt)

#proofbox("Bizonyítás és levezetés", [
  Helyettesítsük be a felezési idő definícióját az $N(t) = N_0 e^(-lambda t)$ bomlástörvénybe:
  $ N_0 / 2 = N_0 e^(-lambda T_(1 slash 2)). $
  Mivel $N_0 > 0$, eloszthatjuk mindkét oldalt $N_0$-lal:
  $ 1 / 2 = e^(-lambda T_(1 slash 2)). $
  Vegyük mindkét oldal természetes alapú logaritmusát:
  $ ln(1 / 2) = ln(e^(-lambda T_(1 slash 2))). $
  Mivel $ln(1 / 2) = -ln 2$ és $ln(e^x) = x$:
  $ -ln 2 = -lambda T_(1 slash 2). $
  Mindkét oldalt elosztva $(-lambda)$-val ($lambda > 0$):
  $ T_(1 slash 2) = (ln 2) / lambda. $
])

#v(8pt)

#remarkbox("Összefoglaló a radioaktív bomlás jellemzőiről", [
  - *Bomlástörvény:* $N(t) = N_0 e^(-lambda t) = N_0 2^(-t slash T_(1 slash 2))$
  - *Felezési idő:* $T_(1 slash 2) = (ln 2) / lambda approx 0.693 / lambda$
  - *Átlagos élettartam:* $tau = 1 / lambda = T_(1 slash 2) / (ln 2)$
])
