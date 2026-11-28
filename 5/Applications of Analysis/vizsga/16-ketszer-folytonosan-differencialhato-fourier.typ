// Typst source document for Exam Topic 16
// Analízis Alkalmazásai - 16. Tétel
// "Kétszer folytonosan differenciálható függvények Fourier-sora. Az f in C_2pi, f(x) := (x - pi)^2 (0 <= x <= 2pi) függvény Fourier-sora, a pi^2 / 6 = sum_(k=1)^infinity k^(-2) egyenlőség."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (16. Tétel)
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
    #text(weight: "bold")[16. Tétel:]
    _„Kétszer folytonosan differenciálható függvények Fourier-sora. Az $f in C_(2 pi)$, $f(x) := (x - pi)^2$ ($0 <= x <= 2 pi$) függvény Fourier-sora, a $pi^2 / 6 = sum_(k=1)^infinity k^(-2)$ egyenlőség.”_
  ]
]

#v(15pt)

= Bevezetés és alapfogalmak

A Fourier-sorok konvergenciájának vizsgálatában központi szerepet játszanak a függvények simasági tulajdonságai. Míg általános folytonos függvényre a Fourier-sor pontonkénti konvergenciája sem garantált, a kétszer differenciálható függvények Fourier-együtthatói olyan gyorsan tartanak nullához, hogy a sor abszolút és egyenletesen konvergál.

Ebben a tételben a Fourier-sort
$ f(x) tilde.op a_0 + sum_(k=1)^infinity (a_k cos(k x) + b_k sin(k x)), $
$
  a_0 = 1 / (2 pi) integral_0^(2 pi) f(x) dif x, quad a_k = 1 / pi integral_0^(2 pi) f(x) cos(k x) dif x, quad b_k = 1 / pi integral_0^(2 pi) f(x) sin(k x) dif x
$
alakban használjuk (itt a konstans tag $a_0$, nem $a_0 / 2$).

#defbox([A $C_(2 pi)$ tér], [
  A $C_(2 pi)$ tér a $2 pi$-periodikus, az egész $bb(R)$-en folytonos $f: bb(R) -> bb(R)$ függvények halmaza (azaz $f in C(bb(R))$ és $f(0) = f(2 pi)$).
])

#v(8pt)

#remarkbox("A simaság és az együtthatók lecsengésének kapcsolata", [
  Minél simább egy függvény, annál gyorsabban tartanak nullához a Fourier-együtthatói. Kétszer differenciálható függvényre kétszeri parciális integrálással $a_k = O(1 / k^2)$ és $b_k = O(1 / k^2)$ adódik. Mivel a $sum 1 / k^2$ konvergens, ez a Fourier-sor abszolút és egyenletes konvergenciáját adja.
])

#v(10pt)

= Kétszer folytonosan differenciálható függvények Fourier-sora

#theorembox("Főtétel: sima függvények Fourier-sorának egyenletes konvergenciája", [
  Tegyük fel, hogy $f in C_(2 pi)$, és az $F := f|_([0, 2 pi])$ leszűkítés kétszer differenciálható a $[0, 2 pi]$ intervallumon (a végpontokban egyoldali deriváltakkal), továbbá $F'' in cal(R)([0, 2 pi])$ (Riemann-integrálható). Ekkor $f$ Fourier-sora abszolút és egyenletesen konvergál $f$-hez $bb(R)$-en:
  $ f(x) = a_0 + sum_(k=1)^infinity (a_k cos(k x) + b_k sin(k x)) quad (x in bb(R)). $
])

#v(8pt)

#proofbox("A főtétel bizonyítása", [
  A jelölés egyszerűsítésére $f$ helyett a $[0, 2 pi]$-n értelmezett $F$-et is $f$-fel jelöljük, és legyen $D := f'(2 pi) - f'(0)$ (egyoldali deriváltakkal).

  *1. lépés: az $a_k$ együtthatók ($k >= 1$).* \
  Parciális integrálással ($u = f$, $v' = cos(k x)$, $v = sin(k x) / k$):
  $
    pi a_k = integral_0^(2 pi) f(x) cos(k x) dif x =\ = [f(x) sin(k x) / k]_0^(2 pi) - 1 / k integral_0^(2 pi) f'(x) sin(k x) dif x = -1 / k integral_0^(2 pi) f'(x) sin(k x) dif x,
  $
  mert $sin(2 k pi) = sin 0 = 0$. Még egyszer integrálva ($u = f'$, $v' = sin(k x)$, $v = -cos(k x) / k$):
  $
    integral_0^(2 pi) f'(x) sin(k x) dif x =\ = [-f'(x) cos(k x) / k]_0^(2 pi) + 1 / k integral_0^(2 pi) f''(x) cos(k x) dif x = -D / k + 1 / k integral_0^(2 pi) f''(x) cos(k x) dif x,
  $
  hiszen $cos(2 k pi) = cos 0 = 1$. Ezért
  $ a_k = D / (pi k^2) - 1 / (pi k^2) integral_0^(2 pi) f''(x) cos(k x) dif x. $
  (Ha $f'$ is periodikus, akkor $D = 0$.)

  *2. lépés: a $b_k$ együtthatók ($k >= 1$).* \
  Hasonlóan, a peremtagok ($f(2 pi) = f(0)$ és $cos(2 k pi) = cos 0$ miatt, valamint mert a második parciális integrálásnál $sin$ szerepel) eltűnnek:
  $
    pi b_k = integral_0^(2 pi) f(x) sin(k x) dif x =\ = [-f(x) cos(k x) / k]_0^(2 pi) + 1 / k integral_0^(2 pi) f'(x) cos(k x) dif x = 1 / k integral_0^(2 pi) f'(x) cos(k x) dif x,
  $
  $
    integral_0^(2 pi) f'(x) cos(k x) dif x =\ = [f'(x) sin(k x) / k]_0^(2 pi) - 1 / k integral_0^(2 pi) f''(x) sin(k x) dif x = -1 / k integral_0^(2 pi) f''(x) sin(k x) dif x,
  $
  tehát
  $ b_k = -1 / (pi k^2) integral_0^(2 pi) f''(x) sin(k x) dif x. $

  *3. lépés: becslés.* \
  Mivel $f'' in cal(R)([0, 2 pi])$, az $abs(f'')$ is integrálható; legyen $C := integral_0^(2 pi) abs(f''(x)) dif x < infinity$. Mivel $abs(cos(k x)), abs(sin(k x)) <= 1$:
  $ abs(a_k) <= (abs(D) + C) / (pi k^2), quad abs(b_k) <= C / (pi k^2). $

  *4. lépés: egyenletes konvergencia.* \
  Így
  $ abs(a_k cos(k x) + b_k sin(k x)) <= abs(a_k) + abs(b_k) <= (abs(D) + 2 C) / pi dot 1 / k^2. $
  Mivel $sum 1 / k^2$ konvergens, a Weierstrass-féle majoráns kritérium szerint a Fourier-sor az egész $bb(R)$-en abszolút és egyenletesen konvergál egy $g$ függvényhez, amely folytonos (folytonos tagok egyenletes határértéke).

  *5. lépés: $g = f$.* \
  Az egyenletesen konvergens trigonometrikus sor együtthatói az összegfüggvény Fourier-együtthatói (14. tétel), tehát $g$ Fourier-együtthatói megegyeznek $f$ együtthatóival. Ezért az $f - g in C_(2 pi)$ függvény minden Fourier-együtthatója nulla, így a Fourier-sorának Cesàro-közepei is nullák. A Fejér-tétel (15. tétel) szerint ezek egyenletesen $f - g$-hez tartanak, tehát $f - g equiv 0$. $square$
])

#v(10pt)

= Az $f(x) = (x - pi)^2$ ($0 <= x <= 2 pi$) függvény Fourier-sora

Alkalmazzuk a tételt a vizsgán kiemelten kért függvényre.

#defbox("A függvény és a tétel feltételei", [
  Legyen $f: bb(R) -> bb(R)$ a $2 pi$-periodikus függvény, amelyre
  $ f(x) := (x - pi)^2 quad (0 <= x <= 2 pi). $
  - *Folytonosság a végpontokban:* $f(0) = pi^2 = f(2 pi)$, tehát $f in C_(2 pi)$.
  - *Deriváltak:* $f'(x) = 2 (x - pi)$ és $f''(x) = 2$ a $[0, 2 pi]$-n. Itt $f'(0) = -2 pi$ és $f'(2 pi) = 2 pi$, vagyis a periodikus kiterjesztés deriváltja a végpontban ugrik, de a főtétel ezt nem követeli meg ($D = 4 pi$). Az $f'' equiv 2$ integrálható, így a főtétel feltételei teljesülnek.
])

#v(8pt)

#theorembox([Tétel: az $f(x) = (x - pi)^2$ függvény Fourier-sora], [
  Minden $0 <= x <= 2 pi$ esetén
  $ (x - pi)^2 = pi^2 / 3 + sum_(k=1)^infinity 4 / k^2 cos(k x). $
])

#pagebreak()

#proofbox("A Fourier-együtthatók kiszámítása", [
  *1. A konstans tag.*
  $
    a_0 = 1 / (2 pi) integral_0^(2 pi) (x - pi)^2 dif x = 1 / (2 pi) [(x - pi)^3 / 3]_0^(2 pi) = 1 / (6 pi) (pi^3 - (-pi^3)) = (2 pi^3) / (6 pi) = pi^2 / 3.
  $

  *2. A szinuszos együtthatók.* Mivel $f(2 pi - x) = f(x)$, az $f$ a $pi$ körül szimmetrikus (az $x - pi = t$ helyettesítéssel $t^2$, $t in [-pi, pi]$, páros függvény). Ezért
  $ b_k = 1 / pi integral_0^(2 pi) (x - pi)^2 sin(k x) dif x = 0 quad (k >= 1). $

  *3. A koszinuszos együtthatók.*
  $ a_k = 1 / pi integral_0^(2 pi) (x - pi)^2 cos(k x) dif x. $
  Parciális integrálással ($u = (x - pi)^2$, $v = sin(k x) / k$), a peremtag nulla:
  $ a_k = -2 / (pi k) integral_0^(2 pi) (x - pi) sin(k x) dif x. $
  Még egyszer ($u = x - pi$, $v = -cos(k x) / k$):
  $
    integral_0^(2 pi) (x - pi) sin(k x) dif x = [-(x - pi) cos(k x) / k]_0^(2 pi) + 1 / k integral_0^(2 pi) cos(k x) dif x.
  $
  A második tag $[sin(k x) / k^2]_0^(2 pi) = 0$. A peremtag:
  $ -(pi) cos(2 k pi) / k + (-pi) cos(0) / k = -pi / k - pi / k = -(2 pi) / k. $
  Ezért
  $ a_k = -2 / (pi k) dot (-(2 pi) / k) = 4 / k^2. $

  *4. A sor.* A főtétel szerint $S f(x) = f(x)$ minden $x$-re:
  $ (x - pi)^2 = pi^2 / 3 + sum_(k=1)^infinity 4 / k^2 cos(k x) quad (0 <= x <= 2 pi). quad square $
])

#v(10pt)

= A Basel-probléma megoldása: $sum_(k=1)^infinity k^(-2) = pi^2 / 6$

A Basel-problémát Mengoli vetette fel 1644-ben, és Euler oldotta meg 1735-ben. A fenti sorfejtésből egyszerűen adódik.

#theorembox("Tétel: a Basel-egyenlőség", [
  $ sum_(k=1)^infinity 1 / k^2 = 1 + 1 / 4 + 1 / 9 + 1 / 16 + dots = pi^2 / 6. $
])

#v(8pt)

#proofbox("Bizonyítás", [
  Helyettesítsünk $x = 0$-t a sorfejtésbe. A bal oldal $f(0) = (0 - pi)^2 = pi^2$, a jobb oldal ($cos 0 = 1$):
  $ pi^2 / 3 + 4 sum_(k=1)^infinity 1 / k^2. $
  Tehát
  $
    pi^2 / 3 + 4 sum_(k=1)^infinity 1 / k^2 = pi^2 quad ==> quad 4 sum_(k=1)^infinity 1 / k^2 = pi^2 - pi^2 / 3 = (2 pi^2) / 3,
  $
  amiből
  $ sum_(k=1)^infinity 1 / k^2 = pi^2 / 6. quad square $
])

#v(10pt)

= További következmények

#remarkbox([1. A váltakozó előjelű reciprok négyzetsor ($x = pi$)], [
  Az $x = pi$ helyen $f(pi) = 0$ és $cos(k pi) = (-1)^k$:
  $ 0 = pi^2 / 3 + sum_(k=1)^infinity (4 (-1)^k) / k^2 quad ==> quad 4 sum_(k=1)^infinity (-1)^(k+1) / k^2 = pi^2 / 3, $
  azaz
  $ sum_(k=1)^infinity (-1)^(k+1) / k^2 = 1 - 1 / 4 + 1 / 9 - 1 / 16 + dots = pi^2 / 12. $
])

#v(8pt)

#remarkbox("2. A páros és páratlan tagok szétválasztása", [
  A páros tagok összege:
  $ sum_(j=1)^infinity 1 / (2 j)^2 = 1 / 4 sum_(j=1)^infinity 1 / j^2 = 1 / 4 dot pi^2 / 6 = pi^2 / 24. $
  A páratlan négyzetszámok reciprokösszege:
  $ sum_(j=0)^infinity 1 / (2 j + 1)^2 = pi^2 / 6 - pi^2 / 24 = (3 pi^2) / 24 = pi^2 / 8. $
])

#pagebreak()

#remarkbox([3. A negyedik hatványok reciprokösszege ($sum 1 / k^4 = pi^4 / 90$)], [
  A Parseval-azonosság (15. tétel) ebben a jelölésben ($a_0$ a konstans tag):
  $ 2 a_0^2 + sum_(k=1)^infinity (a_k^2 + b_k^2) = 1 / pi integral_0^(2 pi) f^2 (x) dif x. $
  Mivel $integral_0^(2 pi) (x - pi)^4 dif x = [(x - pi)^5 / 5]_0^(2 pi) = (2 pi^5) / 5$:
  $ 2 (pi^2 / 3)^2 + sum_(k=1)^infinity 16 / k^4 = 1 / pi dot (2 pi^5) / 5 = (2 pi^4) / 5. $
  $
    (2 pi^4) / 9 + 16 sum_(k=1)^infinity 1 / k^4 = (2 pi^4) / 5 quad ==> quad 16 sum_(k=1)^infinity 1 / k^4 = (2 pi^4) / 5 - (2 pi^4) / 9 = (8 pi^4) / 45.
  $
  Osztva 16-tal:
  $ sum_(k=1)^infinity 1 / k^4 = pi^4 / 90. $
])
