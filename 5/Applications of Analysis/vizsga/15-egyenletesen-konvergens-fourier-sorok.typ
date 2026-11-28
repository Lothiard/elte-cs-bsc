// Typst source document for Exam Topic 15
// Analízis Alkalmazásai - 15. Tétel
// "Egyenletesen konvergens Fourier-sorok, a trigonometrikus rendszer teljessége C_2pi-re."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (15. Tétel)
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
    #text(weight: "bold")[15. Tétel:]
    _„Egyenletesen konvergens Fourier-sorok, a trigonometrikus rendszer teljessége $C_(2 pi)$-re.”_
  ]
]

#v(15pt)

= Bevezetés és alapfogalmak

A trigonometrikus Fourier-sorok elméletében központi kérdés, hogy milyen feltételek mellett állítja elő a Fourier-sor az eredeti $f$ függvényt nemcsak pontonként vagy $L^2$-normában, hanem *egyenletesen*. Alapvető fontosságú továbbá a trigonometrikus rendszer *teljessége* a $2 pi$-periodikus folytonos függvények $C_(2 pi)$ terében, vagyis hogy a trigonometrikus polinomok sűrű alteret alkotnak.

#defbox([A $C_(2 pi)$ tér és a normák], [
  Legyen $C_(2 pi)$ a $2 pi$-periodikus, folytonos $f: bb(R) -> bb(R)$ függvények vektortere.
  1. *Szupremum-norma (egyenletes norma):*
    $ norm(f)_infinity := max_(x in [-pi, pi]) abs(f(x)). $
  2. *$L^2$-norma:*
    $ norm(f)_2 := sqrt(integral_(-pi)^pi f^2 (x) dif x). $
  3. *Trigonometrikus polinom:* olyan $P_N$ függvény, amely
    $ P_N (x) = a_0 / 2 + sum_(k=1)^N (a_k cos(k x) + b_k sin(k x)) quad (a_k, b_k in bb(R)) $
    alakú.
])

#v(10pt)

= Egyenletesen konvergens Fourier-sorok (sima függvények)

Ha egy függvény elég sima (például folytonosan differenciálható), akkor Fourier-együtthatói olyan gyorsan tartanak nullához, hogy a Fourier-sor abszolút és egyenletesen konvergál magához a függvényhez.

#theorembox([Főtétel: $C^1_(2 pi)$ függvények Fourier-sorának egyenletes konvergenciája], [
  Ha $f in C^1_(2 pi)$ (azaz $f$ $2 pi$-periodikus és folytonosan differenciálható $bb(R)$-en), akkor $f$ Fourier-sora abszolút és egyenletesen konvergál $f$-hez $bb(R)$-en:
  $ S_N (f, x) = a_0 / 2 + sum_(k=1)^N (a_k cos(k x) + b_k sin(k x)) arrows.rr f(x) quad (N -> infinity). $
])

#v(8pt)

#proofbox("Bizonyítás (parciális integrálás és Bessel-egyenlőtlenség)", [
  *1. lépés: a derivált Fourier-együtthatói.* \
  Jelölje $A_k, B_k$ az $f'$ Fourier-együtthatóit. Parciális integrálással, a $2 pi$-periodicitás miatt ($f(pi) = f(-pi)$, így a kiintegrált tagok eltűnnek):
  $
    A_k = 1 / pi integral_(-pi)^pi f'(x) cos(k x) dif x = 1 / pi [f(x) cos(k x)]_(-pi)^pi + k / pi integral_(-pi)^pi f(x) sin(k x) dif x = k b_k,
  $
  $
    B_k = 1 / pi integral_(-pi)^pi f'(x) sin(k x) dif x = 1 / pi [f(x) sin(k x)]_(-pi)^pi - k / pi integral_(-pi)^pi f(x) cos(k x) dif x = -k a_k,
  $
  ahol $a_k, b_k$ az $f$ Fourier-együtthatói. Tehát $abs(a_k) = abs(B_k) / k$ és $abs(b_k) = abs(A_k) / k$.

  *2. lépés: a számtani–mértani közép egyenlőtlensége.* \
  Tetszőleges $u, v in bb(R)$-re $2 abs(u v) <= u^2 + v^2$. Ezt $1 / k$-ra és $abs(B_k)$-ra, illetve $abs(A_k)$-ra alkalmazva:
  $ abs(a_k) <= 1 / 2 (1 / k^2 + B_k^2), quad abs(b_k) <= 1 / 2 (1 / k^2 + A_k^2). $
  Összeadva:
  $ abs(a_k) + abs(b_k) <= 1 / k^2 + 1 / 2 (A_k^2 + B_k^2). $

  *3. lépés: a majoráns számsor konvergenciája.* \
  $ sum_(k=1)^infinity (abs(a_k) + abs(b_k)) <= sum_(k=1)^infinity 1 / k^2 + 1 / 2 sum_(k=1)^infinity (A_k^2 + B_k^2). $
  - A $sum 1 / k^2 = pi^2 / 6$ konvergens.
  - Mivel $f'$ folytonos, négyzetesen integrálható, így a Bessel-egyenlőtlenség szerint
    $ sum_(k=1)^infinity (A_k^2 + B_k^2) <= 1 / pi integral_(-pi)^pi (f'(x))^2 dif x < infinity. $
  Tehát $sum (abs(a_k) + abs(b_k))$ konvergens.

  *4. lépés: egyenletes konvergencia és a határfüggvény.* \
  Mivel $abs(a_k cos(k x) + b_k sin(k x)) <= abs(a_k) + abs(b_k)$, a Weierstrass-kritérium (11. tétel) szerint a Fourier-sor *abszolút és egyenletesen* konvergál egy $g$ függvényhez, amely folytonos. A tagonkénti integrálás miatt (14. tétel) $g$ Fourier-együtthatói $a_k, b_k$, vagyis megegyeznek $f$ együtthatóival. A sor Cesàro-közepei egyfelől $g$-hez tartanak (mert maga a sor egyenletesen $g$-hez konvergál), másfelől a Fejér-tétel szerint $f$-hez. Ezért $g = f$. $square$
])

#v(10pt)

= A Fejér-tétel és a Fejér-mag

A Fourier-részletösszegek $S_N (f, x)$ nem feltétlenül konvergálnak egyenletesen tetszőleges folytonos függvényre (létezik olyan $f in C_(2 pi)$, amelynek Fourier-sora egy pontban divergens). A részletösszegek *Cesàro-közepei* azonban minden folytonos függvényre egyenletesen konvergálnak.

#defbox("Cesàro-közepek és a Fejér-mag", [
  Legyen $S_k (f, x)$ az $f$ Fourier-sorának $k$-adik részletösszege. Az $N$-edik Cesàro-közép:
  $ sigma_N (f, x) := 1 / N sum_(k=0)^(N-1) S_k (f, x). $
  Ez integrál alakban a $K_N$ *Fejér-maggal* írható fel:
  $ sigma_N (f, x) = 1 / (2 pi) integral_(-pi)^pi f(x - t) K_N (t) dif t, $
  ahol (a $D_k = 1 / 2 + sum_(j=1)^k cos(j t)$ Dirichlet-maggal)
  $ K_N (t) = 2 / N sum_(k=0)^(N-1) D_k (t) = 1 / N (sin(N t / 2) / sin(t / 2))^2 quad (t != 2 k pi). $
])

#v(8pt)

#remarkbox("A Fejér-mag alaptulajdonságai", [
  1. *Nemnegativitás:* $K_N (t) >= 0$ minden $t$-re (ellentétben a Dirichlet-maggal).
  2. *Normáltság:* $1 / (2 pi) integral_(-pi)^pi K_N (t) dif t = 1$.
  3. *Koncentrálódás:* tetszőleges $0 < delta < pi$ esetén $K_N arrows.rr 0$ a $[-pi, pi] without (-delta, delta)$ halmazon, ha $N -> infinity$ (mert ott $K_N (t) <= 1 / (N sin^2 (delta / 2))$).
])

#v(8pt)

#theorembox("Fejér-tétel (1900)", [
  Ha $f in C_(2 pi)$, akkor $f$ Fourier-részletösszegeinek Cesàro-közepei egyenletesen konvergálnak $f$-hez $bb(R)$-en:
  $ sigma_N (f, x) arrows.rr f(x) quad (N -> infinity). $
])

#v(10pt)

= A trigonometrikus rendszer teljessége $C_(2 pi)$-ben

#defbox("Teljesség és sűrűség", [
  A ${1, cos(k x), sin(k x) : k >= 1}$ trigonometrikus rendszer *teljes* $C_(2 pi)$-ben a szupremum-normára nézve, ha a trigonometrikus polinomok $T$ halmaza sűrű $C_(2 pi)$-ben:
  $ forall f in C_(2 pi), forall epsilon > 0 quad exists P in T: quad norm(f - P)_infinity < epsilon. $
])

#v(8pt)

#theorembox("Weierstrass II. approximációs tétele (trigonometrikus alak)", [
  Minden $2 pi$-periodikus folytonos függvény tetszőleges pontossággal, egyenletesen megközelíthető trigonometrikus polinommal.
])

#v(8pt)

#proofbox("Bizonyítás (a Fejér-tételből)", [
  A Fejér-tétel szerint $sigma_N (f) arrows.rr f$. Mivel $sigma_N (f)$ maga is $(N-1)$-edfokú trigonometrikus polinom (Fourier-részletösszegek véges számtani közepe), tetszőleges $epsilon > 0$-hoz van olyan $N_0$, hogy
  $ norm(f - sigma_(N_0) (f))_infinity < epsilon. $
  A $P := sigma_(N_0) (f)$ választással megkaptuk a kívánt közelítést. $square$
])

#v(10pt)

= Parseval-azonosság és $L^2$-beli teljesség

A $C_(2 pi)$-beli teljességből következik az $L^2$-beli teljesség és a Parseval-azonosság.

#theorembox("Parseval-azonosság", [
  Minden $f in C_(2 pi)$ esetén fennáll
  $ a_0^2 / 2 + sum_(k=1)^infinity (a_k^2 + b_k^2) = 1 / pi integral_(-pi)^pi f^2 (x) dif x = 1 / pi norm(f)_2^2. $
  (Ugyanez igaz minden $L^2([-pi, pi])$-beli $f$-re, mert $C_(2 pi)$ sűrű $L^2$-ben.)
])

#v(8pt)

#proofbox("Bizonyítás vázlata", [
  1. A Weierstrass II. tétel szerint a trigonometrikus polinomok sűrűek $C_(2 pi)$-ben szupremum-normában. Mivel $norm(g)_2 <= sqrt(2 pi) norm(g)_infinity$, $L^2$-normában is sűrűek.
  2. A 14. tételből: az $S_N (f)$ részletösszeg a *legjobb $L^2$-közelítés* az $N$-edfokú trigonometrikus polinomok között, és a véges Bessel-azonosság:
    $ norm(f - S_N (f))_2^2 = norm(f)_2^2 - pi [a_0^2 / 2 + sum_(k=1)^N (a_k^2 + b_k^2)]. $
  3. Tetszőleges $epsilon > 0$-hoz van olyan $M$-edfokú $P_M$, hogy $norm(f - P_M)_2 < epsilon$. Ekkor $N >= M$-re $norm(f - S_N (f))_2 <= norm(f - P_M)_2 < epsilon$.
  4. Tehát $lim_(N -> infinity) norm(f - S_N (f))_2 = 0$, és a véges Bessel-azonosságban $N -> infinity$-t véve kapjuk a Parseval-azonosságot. $square$
])

#v(8pt)

#remarkbox("Összefoglaló táblázat: konvergenciatípusok Fourier-sorokra", [
  #table(
    columns: (1.5fr, 2fr, 2fr),
    align: (left, left, left),
    stroke: 0.5pt + luma(150),
    [*Feltétel $f$-re*], [*Konvergencia típusa*], [*Állítás*],
    [$f in C^1_(2 pi)$], [egyenletes és abszolút], [$S_N (f) arrows.rr f$],
    [$f in C_(2 pi)$], [Cesàro-közepek egyenletes konvergenciája], [$sigma_N (f) arrows.rr f$ (Fejér)],
    [$f in C_(2 pi)$ (vagy $L^2$)], [$L^2$-normabeli konvergencia], [$norm(f - S_N (f))_2 -> 0$, Parseval-azonosság],
    [szakadásos, szakaszonként sima $f$], [pontonkénti (Dirichlet-tétel)], [$S_N (f, x) -> (f(x + 0) + f(x - 0)) / 2$],
  )
])
