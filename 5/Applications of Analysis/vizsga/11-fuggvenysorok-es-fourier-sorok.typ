// Typst source document for Exam Topic 11
// Analízis Alkalmazásai - 11. Tétel
// "A függvénysorozat, függvénysor fogalma. Hatványsorok, trigonometrikus sorok, Fourier-sorok. A Dirichlet-féle magfüggvény. Konvergencia, határfüggvény (összegfüggvény), egyenletes konvergencia. A Weierstrass-féle majoráns kritérium."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (11. Tétel)
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
    #text(weight: "bold")[11. Tétel:]
    _„A függvénysorozat, függvénysor fogalma. Hatványsorok, trigonometrikus sorok, Fourier-sorok. A Dirichlet-féle magfüggvény. Konvergencia, határfüggvény (összegfüggvény), egyenletes konvergencia. A Weierstrass-féle majoráns kritérium.”_
  ]
]

#v(15pt)

= Függvénysorozatok és függvénysorok alapfogalmai

A klasszikus egyváltozós analízisben a szám- és vektorsorozatok határértékét vizsgáljuk. Amikor a sorozat elemei maguk is függvények, a konvergencia fogalma összetettebbé válik, mert az értelmezési tartomány egyes pontjaiban mutatott viselkedést globálisan, az egész halmazra vonatkozóan is jellemezhetjük.

#defbox("Függvénysorozat és konvergenciatartomány", [
  Legyen $X, Y$ nemüres halmaz ($Y$ általában $bb(R)$ vagy $bb(C)$), és $D subset X$ egy nemüres részhalmaz. Az $(f_n)_(n in bb(N))$ sorozatot *függvénysorozatnak* nevezzük, ha minden $n in bb(N)$ esetén $f_n: D -> Y$.

  Az $(f_n)$ függvénysorozat *konvergenciatartománya* azon $x in D$ pontok halmaza, ahol az $(f_n (x))$ számsorozat konvergens:
  $ D^* := {x in D : (f_n (x)) " konvergens"}. $
  Ha $D^* != emptyset$, akkor az $f: D^* -> Y$,
  $ f(x) := lim_(n -> infinity) f_n (x) quad (x in D^*) $
  függvényt az $(f_n)$ *határfüggvényének* nevezzük. Ha $D^* = D$, akkor az $(f_n)$ *pontonként konvergens* a $D$ halmazon.
])

#v(8pt)

#defbox("Függvénysor és összegfüggvény", [
  Tegyük fel, hogy $Y$ vektortér (pl. $bb(R)$ vagy $bb(C)$). Az $f_n: D -> Y$ ($n in bb(N)$) függvények által meghatározott *függvénysort* a
  $ sum_(k=0)^infinity f_k $
  szimbólummal jelöljük. A függvénysor nem más, mint a részletösszeg-függvényekből álló $(F_n)$ függvénysorozat:
  $ F_n (x) := sum_(k=0)^n f_k (x) quad (n in bb(N), x in D). $

  A $sum f_k$ függvénysor konvergenciatartománya $D^* := {x in D : (F_n (x)) " konvergens"}$. Ha $D^* != emptyset$, a függvénysor *összegfüggvénye*:
  $ F(x) := sum_(k=0)^infinity f_k (x) = lim_(n -> infinity) sum_(k=0)^n f_k (x) quad (x in D^*). $
])

#v(10pt)

= Konvergenciatípusok: pontonkénti és egyenletes konvergencia

A pontonkénti konvergencia csupán annyit követel meg, hogy minden $x_0$ pontban külön-külön létezzen a számsorozat határértéke. Ez nem garantálja, hogy a határfüggvény megőrizze a tagfüggvények jó tulajdonságait (folytonosság, integrálhatóság). Ezért van szükség egy erősebb, globális konvergenciafogalomra.

#defbox("Egyenletes konvergencia", [
  Legyen $(Y, rho)$ metrikus tér (pl. $Y = bb(R)$, $rho(u, v) = abs(u - v)$). Az $f_n: D -> Y$ függvénysorozat az $A subset D^*$ ($A != emptyset$) halmazon *egyenletesen konvergál* az $f: A -> Y$ függvényhez, ha minden $epsilon > 0$ esetén létezik olyan, $x$-től független $N in bb(N)$, hogy:
  $ rho(f_n (x), f(x)) < epsilon quad (forall x in A, forall n > N). $
  Normált térben ($Y = bb(R)$ vagy $bb(C)$) ez ekvivalens azzal, hogy
  $ sup_(x in A) abs(f_n (x) - f(x)) -> 0 quad (n -> infinity). $
  A $sum f_k$ függvénysor az $A$ halmazon *egyenletesen konvergens*, ha a részletösszeg-függvények $(F_n)$ sorozata egyenletesen konvergál az $F$ összegfüggvényhez $A$-n.
])

#v(8pt)

#remarkbox("Geometriai szemléltetés ($2 epsilon$-sáv)", [
  Valós értékű függvények esetén az egyenletes konvergencia azt jelenti, hogy tetszőleges $epsilon > 0$ esetén az $N$-nél nagyobb indexű $f_n$ függvények teljes grafikonja beleesik az $f$ grafikonja köré rajzolt, $2 epsilon$ szélességű
  $ H_epsilon (f) := {(x, y) : x in A, f(x) - epsilon < y < f(x) + epsilon} $
  sávba.
])

#v(8pt)

#theorembox("Egyenletes Cauchy-kritérium", [
  Teljes metrikus térben ($Y = bb(R)$ vagy $bb(C)$) az egyenletes konvergencia ekvivalens az egyenletes Cauchy-feltétellel:

  1. Függvénysorozatra: az $(f_n)$ sorozat akkor és csak akkor egyenletesen konvergens az $A$ halmazon, ha minden $epsilon > 0$ esetén van olyan $N in bb(N)$, hogy
    $ abs(f_n (x) - f_m (x)) < epsilon quad (forall x in A, forall n, m > N). $
  2. Függvénysorra: a $sum f_k$ sor akkor és csak akkor egyenletesen konvergens az $A$ halmazon, ha minden $epsilon > 0$ esetén van olyan $N in bb(N)$, hogy
    $ abs(sum_(k=n+1)^m f_k (x)) < epsilon quad (forall x in A, forall m > n > N). $
])

#v(10pt)

= A Weierstrass-féle majoráns kritérium

Az egyenletes konvergencia igazolásának legfontosabb, a gyakorlatban leggyakrabban használt elégséges feltétele a Weierstrass-féle majoráns (vagy $M$-) teszt.

#theorembox("Weierstrass-féle majoráns kritérium", [
  Legyen $D$ nemüres halmaz, és $f_n: D -> bb(K)$ ($n in bb(N)$, $bb(K) = bb(R)$ vagy $bb(C)$) függvények sorozata. Tegyük fel, hogy $A subset D$ nemüres halmaz, és létezik olyan $sum_(n=0)^infinity a_n < +infinity$ konvergens, nemnegatív tagú számsor ($a_n >= 0$), amelyre:
  $ sup_(x in A) abs(f_n (x)) <= a_n quad (forall n in bb(N)). $
  Ekkor a $sum_(n=0)^infinity f_n$ függvénysor az $A$ halmazon *egyenletesen és abszolút konvergens*.
])

#v(8pt)

#proofbox("A Weierstrass-kritérium bizonyítása", [
  Legyen $x in A$ tetszőleges, és $m > n$. A háromszög-egyenlőtlenséggel és a feltételben megadott korláttal:
  $ abs(sum_(k=n+1)^m f_k (x)) <= sum_(k=n+1)^m abs(f_k (x)) <= sum_(k=n+1)^m a_k. $

  Mivel a $sum a_k$ számsor konvergens, a Cauchy-kritérium szerint minden $epsilon > 0$ esetén létezik $N in bb(N)$, hogy minden $m > n > N$ esetén $sum_(k=n+1)^m a_k < epsilon$. Ezt visszaírva, minden $x in A$ és $m > n > N$ esetén:
  $ abs(sum_(k=n+1)^m f_k (x)) <= sum_(k=n+1)^m abs(f_k (x)) <= sum_(k=n+1)^m a_k < epsilon. $
  Ez éppen az egyenletes Cauchy-kritérium a $sum f_k$ sorra. Mivel $bb(K)$ teljes, a függvénysor $A$-n egyenletesen konvergens.

  Az abszolút konvergenciához: $abs(f_k (x)) <= a_k$ miatt az összehasonlító kritérium szerint a $sum abs(f_k (x))$ sor is konvergens minden $x in A$ pontban. #h(1fr) $square$
])

#v(10pt)

= Hatványsorok

#defbox("Hatványsor fogalma", [
  A $sum_(n=0)^infinity a_n (x - a)^n$ alakú függvénysorokat *hatványsoroknak* nevezzük, ahol $a in bb(K)$ a hatványsor középpontja, $a_n in bb(K)$ az együtthatói, és $x in bb(K)$ a változó.
])

#v(8pt)

#theorembox("Cauchy–Hadamard-tétel", [
  Tetszőleges $sum_(n=0)^infinity a_n (x - a)^n$ hatványsorhoz létezik egyértelműen meghatározott $R in [0, +infinity]$ szám (a *konvergenciasugár*), amelyre:
  $ 1 / R = limsup_(n -> infinity) root(n, abs(a_n)). $
  (Itt $1 / 0 = +infinity$ és $1 / (+infinity) = 0$.) A hatványsor viselkedése:
  1. Ha $abs(x - a) < R$, akkor a hatványsor *abszolút konvergens*.
  2. Ha $abs(x - a) > R$, akkor a hatványsor *divergens*.
  3. Bármely $0 < r < R$ esetén a hatványsor *egyenletesen konvergens* a zárt $K_r (a) := {x in bb(K) : abs(x - a) <= r}$ golyón (valós esetben intervallumon).
])

#v(8pt)

#remarkbox("Hatványsorok egyenletes konvergenciája", [
  A 3. pont közvetlen következménye a Weierstrass-kritériumnak: ha $abs(x - a) <= r < R$, akkor $abs(a_n (x - a)^n) <= abs(a_n) r^n$, és a $sum abs(a_n) r^n$ számsor konvergens, mert $r < R$ (az 1. pont szerint a hatványsor $r$-ben abszolút konvergens).
])

#v(10pt)

= Trigonometrikus sorok és Fourier-sorok

#defbox("Trigonometrikus sor", [
  A $2 pi$-periodikus trigonometrikus sor általános alakja:
  $ a_0 + sum_(n=1)^infinity (a_n cos(n x) + b_n sin(n x)), $
  ahol $a_0, a_n, b_n in bb(R)$ ($n in bb(N)^+$) a sor valós együtthatói. A sor $n$-edik részletösszege egy trigonometrikus polinom:
  $ S_n (x) = a_0 + sum_(k=1)^n (a_k cos(k x) + b_k sin(k x)). $
])

#v(8pt)

#theorembox("A trigonometrikus rendszer ortogonalitása", [
  Az ${1, cos(n x), sin(n x) : n in bb(N)^+}$ függvényrendszer ortogonális a $[0, 2 pi]$ intervallumon az $chevron.l f, g chevron.r = integral_0^(2 pi) f(x) g(x) dif x$ skaláris szorzatra nézve:
  $ integral_0^(2 pi) 1 dif x = 2 pi, $
  $ integral_0^(2 pi) cos(n x) dif x = 0, quad integral_0^(2 pi) sin(n x) dif x = 0 quad (n >= 1), $
  $ integral_0^(2 pi) cos(n x) cos(m x) dif x = pi delta_(n m) quad (n, m >= 1), $
  $ integral_0^(2 pi) sin(n x) sin(m x) dif x = pi delta_(n m) quad (n, m >= 1), $
  $ integral_0^(2 pi) cos(n x) sin(m x) dif x = 0 quad (n, m >= 1). $
])

#v(8pt)

#theorembox("Egyenletesen konvergens trigonometrikus sor együtthatói", [
  Ha az $a_0 + sum_(n=1)^infinity (a_n cos(n x) + b_n sin(n x))$ trigonometrikus sor egyenletesen konvergál az $f$ összegfüggvényhez a $[0, 2 pi]$ intervallumon, akkor az együtthatók $f$-ből egyértelműen kifejezhetők:
  $ a_0 = 1 / (2 pi) integral_0^(2 pi) f(x) dif x, $
  $ a_n = 1 / pi integral_0^(2 pi) f(x) cos(n x) dif x quad (n >= 1), $
  $ b_n = 1 / pi integral_0^(2 pi) f(x) sin(n x) dif x quad (n >= 1). $
])

#v(8pt)

#defbox("Fourier-sor és Fourier-együtthatók", [
  Jelölje $cal(R)_(2 pi)$ a $2 pi$-periodikus, $[0, 2 pi]$-n Riemann-integrálható függvények osztályát. Bármely $f in cal(R)_(2 pi)$ esetén a fenti képletekkel számolt $a_0, a_n, b_n$ számokat az $f$ *Fourier-együtthatóinak*, a
  $ S_f (x) := a_0 + sum_(n=1)^infinity (a_n cos(n x) + b_n sin(n x)) $
  trigonometrikus sort az $f$ *Fourier-sorának*, a részletösszegét pedig, $S_n f (x)$-et az $f$ *$n$-edik Fourier-részletösszegének* nevezzük.
])

#v(10pt)

= A Dirichlet-féle magfüggvény

A Fourier-sorok konvergenciájának vizsgálatában központi szerepet játszik az $n$-edik Fourier-részletösszeg integrálalakja a Dirichlet-mag segítségével.

#defbox("Dirichlet-féle magfüggvény", [
  Az $n$-edik *Dirichlet-magfüggvény* ($D_n: bb(R) -> bb(R)$):
  $ D_0 (z) := 1 / 2, quad D_n (z) := 1 / 2 + sum_(k=1)^n cos(k z) quad (n >= 1). $
])

#v(8pt)

#theorembox("A Dirichlet-mag zárt alakja és integrálelőállítás", [
  1. *Zárt alak:* minden $n in bb(N)$ és $z in bb(R) without {2 k pi : k in bb(Z)}$ esetén
    $ D_n (z) = (sin((n + 1 / 2) z)) / (2 sin(z / 2)), $
    míg $z = 2 k pi$ esetén $D_n (2 k pi) = n + 1 / 2$.
  2. *Normálás:* tetszőleges $2 pi$ hosszúságú $I$ intervallumra
    $ integral_I D_n (z) dif z = pi quad (n in bb(N)). $
  3. *Fourier-részletösszeg integrálalakja:* tetszőleges $f in cal(R)_(2 pi)$ esetén
    $ S_n f (x) = 1 / pi integral_0^(2 pi) f(t) D_n (x - t) dif t = 1 / pi integral_(-pi)^pi f(x + t) D_n (t) dif t. $
])

#v(8pt)

#proofbox("A Dirichlet-mag zárt alakjának levezetése", [
  Szorozzuk meg $D_n (z) = 1 / 2 + sum_(k=1)^n cos(k z)$-t $2 sin(z / 2)$-vel. A $2 sin A cos B = sin(A + B) + sin(A - B)$ azonosságból $A = z / 2$, $B = k z$ esetén:
  $ 2 sin(z / 2) cos(k z) = sin((k + 1 / 2) z) - sin((k - 1 / 2) z). $
  Összegezve $k = 1$-től $n$-ig teleszkópösszeget kapunk:
  $
    2 sin(z / 2) D_n (z) & = sin(z / 2) + sum_(k=1)^n [sin((k + 1 / 2) z) - sin((k - 1 / 2) z)] \
                         & = sin(z / 2) + (sin(3 z / 2) - sin(z / 2)) + dots + (sin((n + 1 / 2) z) - sin((n - 1 / 2) z)) \
                         & = sin((n + 1 / 2) z).
  $
  Ha $z != 2 k pi$, akkor $sin(z / 2) != 0$, így osztva:
  $ D_n (z) = (sin((n + 1 / 2) z)) / (2 sin(z / 2)). $
  Ha $z = 2 k pi$, akkor $cos(j z) = 1$ minden $j$-re, tehát $D_n (z) = 1 / 2 + n$. Ez a zárt alak határértéke is $z -> 2 k pi$ esetén. $square$
])

#v(8pt)

#remarkbox("A konvergenciakérdés lényege", [
  - *Folytonosság és divergencia:* Du Bois-Reymond igazolta, hogy létezik olyan folytonos, $2 pi$-periodikus $f$, amelynek Fourier-sora egy pontban divergens. Fejér Lipót viszont megmutatta, hogy a Fejér-közepek, $sigma_n f = 1 / (n + 1) sum_(k=0)^n S_k f$ folytonos $f$-re mindig egyenletesen konvergálnak $f$-hez.
  - *Carleson-tétel (1966):* ha $f in L^2 (0, 2 pi)$, akkor az $S_n f (x)$ Fourier-sor majdnem mindenütt pontonként konvergál $f(x)$-hez.
  - *Sima függvények:* ha $f$ $2 pi$-periodikus és kétszer folytonosan differenciálható, akkor kétszeri parciális integrálással $abs(a_n), abs(b_n) <= C / n^2$ adódik, így a Weierstrass-kritérium alapján $S_f$ egyenletesen és abszolút konvergál $f$-hez.
])
