// Typst source document for Exam Topic 14
// Analízis Alkalmazásai - 14. Tétel
// "A trigonometrikus rendszer ortogonalitása. Egyenletesen konvergens trigonometrikus sor az összegfüggvényének a Fourier-sora. Bessel-azonosság, Bessel-egyenlőtlenség."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (14. Tétel)
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
    #text(weight: "bold")[14. Tétel:]
    _„A trigonometrikus rendszer ortogonalitása. Egyenletesen konvergens trigonometrikus sor az összegfüggvényének a Fourier-sora. Bessel-azonosság, Bessel-egyenlőtlenség.”_
  ]
]

#v(15pt)

= A trigonometrikus rendszer és ortogonalitása

A Fourier-sorok elméletének alapja a trigonometrikus függvényrendszer ortogonalitása a $[-pi, pi]$ intervallumon, az $L^2$-belső szorzatra nézve.

#defbox("Definíció: trigonometrikus rendszer és belső szorzat", [
  1. A *trigonometrikus rendszer* a $[-pi, pi]$ intervallumon az alábbi valós értékű függvényekből áll:
    $ {1, cos(x), sin(x), cos(2 x), sin(2 x), dots, cos(n x), sin(n x), dots}. $
  2. Két négyzetesen integrálható $f, g$ függvény *belső szorzata*:
    $ chevron.l f, g chevron.r := integral_(-pi)^pi f(x) g(x) dif x. $
  3. Az $f$ függvény *$L^2$-normája*:
    $ norm(f)_2 := sqrt(chevron.l f\, f chevron.r) = sqrt(integral_(-pi)^pi f^2 (x) dif x). $
])

#v(8pt)

#theorembox("Tétel: a trigonometrikus rendszer ortogonalitási összefüggései", [
  A trigonometrikus rendszer elemei páronként ortogonálisak a $[-pi, pi]$ intervallumon. Részletesen, minden $n, m in bb(N)^+$ esetén:

  1. $chevron.l 1, cos(n x) chevron.r = integral_(-pi)^pi cos(n x) dif x = 0$;
  2. $chevron.l 1, sin(n x) chevron.r = integral_(-pi)^pi sin(n x) dif x = 0$;
  3. $chevron.l cos(n x), sin(m x) chevron.r = integral_(-pi)^pi cos(n x) sin(m x) dif x = 0$ minden $n, m >= 1$ esetén;
  4. $chevron.l cos(n x), cos(m x) chevron.r = integral_(-pi)^pi cos(n x) cos(m x) dif x = cases(0 quad "ha" n != m, pi quad "ha" n = m >= 1)$;
  5. $chevron.l sin(n x), sin(m x) chevron.r = integral_(-pi)^pi sin(n x) sin(m x) dif x = cases(0 quad "ha" n != m, pi quad "ha" n = m >= 1)$;
  6. $chevron.l 1, 1 chevron.r = integral_(-pi)^pi 1^2 dif x = 2 pi$.
])

#v(8pt)

#proofbox("A bizonyítás részletezése", [
  Az integrálok a trigonometrikus addíciós azonosságokkal számolhatók ki:

  - Az 1. és 2. pont azért nyilvánvaló, mert $cos(n x)$ és $sin(n x)$ primitív függvényei $1 / n sin(n x)$ és $-1 / n cos(n x)$, amelyek a $-pi$ és $pi$ pontban azonos értéket vesznek fel (mert $sin(n pi) = 0$ és $cos(n pi) = cos(-n pi)$).
  - A 3. pontnál:
    $ cos(n x) sin(m x) = 1 / 2 [sin((m + n) x) + sin((m - n) x)]. $
    A szinuszfüggvények integrálja a $[-pi, pi]$ intervallumon nulla (ha $m = n$, a második tag azonosan nulla). Másképp: páratlan függvény integrálja szimmetrikus intervallumon $0$.
  - A 4. pontnál:
    $ cos(n x) cos(m x) = 1 / 2 [cos((n + m) x) + cos((n - m) x)]. $
    - Ha $n != m$, akkor mindkét tag nemkonstans koszinusz-függvény, amelynek integrálja $[-pi, pi]$-n nulla.
    - Ha $n = m$, akkor $cos^2 (n x) = 1 / 2 [1 + cos(2 n x)]$, így
      $
        integral_(-pi)^pi cos^2 (n x) dif x = 1 / 2 integral_(-pi)^pi 1 dif x + 1 / 2 integral_(-pi)^pi cos(2 n x) dif x = 1 / 2 (2 pi) + 0 = pi.
      $
  - Az 5. pont hasonlóan igazolható a $sin(n x) sin(m x) = 1 / 2 [cos((n - m) x) - cos((n + m) x)]$ azonossággal.
])

#v(8pt)

#remarkbox("Ortonormált rendszer", [
  Ha a rendszer minden elemét elosztjuk a saját $L^2$-normájával, az *ortonormált rendszert* kapjuk:
  $
    {1 / sqrt(2 pi), 1 / sqrt(pi) cos(x), 1 / sqrt(pi) sin(x), dots, 1 / sqrt(pi) cos(n x), 1 / sqrt(pi) sin(n x), dots}.
  $
])

#v(10pt)

= Egyenletesen konvergens trigonometrikus sor és a Fourier-sor

A következő tétel azt mondja ki, hogy ha egy trigonometrikus sor egyenletesen konvergál egy $f$ függvényhez, akkor a sor együtthatói szükségképpen $f$ Fourier-együtthatói.

#defbox("Definíció: trigonometrikus sor és Fourier-sor", [
  1. A valós *trigonometrikus sor* általános alakja:
    $ S(x) = a_0 / 2 + sum_(k=1)^oo (a_k cos(k x) + b_k sin(k x)). $
  2. Ha $f: [-pi, pi] -> bb(R)$ Riemann-integrálható, akkor az $f$ *Fourier-együtthatói*:
    $ a_0 = 1 / pi integral_(-pi)^pi f(x) dif x, $
    $ a_k = 1 / pi integral_(-pi)^pi f(x) cos(k x) dif x quad (k >= 1), $
    $ b_k = 1 / pi integral_(-pi)^pi f(x) sin(k x) dif x quad (k >= 1). $
  3. Az ezen együtthatókkal felírt trigonometrikus sort az $f$ *Fourier-sorának* nevezzük, és így jelöljük:
    $ f(x) tilde.op a_0 / 2 + sum_(k=1)^oo (a_k cos(k x) + b_k sin(k x)). $
])

#v(8pt)

#theorembox("Főtétel: egyenletesen konvergens trigonometrikus sor Fourier-sora", [
  Tegyük fel, hogy az $S(x) = a_0 / 2 + sum_(k=1)^oo (a_k cos(k x) + b_k sin(k x))$ trigonometrikus sor a $[-pi, pi]$ intervallumon *egyenletesen konvergál* az $f$ összegfüggvényhez.

  Ekkor a sor $a_0, a_k, b_k$ együtthatói *egyértelműen meghatározottak*, és megegyeznek az $f$ Fourier-együtthatóival.
])

#v(8pt)

#proofbox("A tétel bizonyítása (tagonkénti integrálás a 12. tétel alapján)", [
  Legyen $S_n (x) = a_0 / 2 + sum_(k=1)^n (a_k cos(k x) + b_k sin(k x))$ a sor $n$-edik részletösszege. A feltétel szerint $S_n arrows.rr f$ a $[-pi, pi]$-n. Mivel $S_n$ folytonos, az egyenletes határfüggvény, $f$ is folytonos, tehát integrálható.

  *1. lépés: az $a_0$ meghatározása.* \
  A 12. tétel szerint az integrálás és a határérték felcserélhető:
  $ integral_(-pi)^pi f(x) dif x = lim_(n -> oo) integral_(-pi)^pi S_n (x) dif x. $
  Véges összeget tagonként integrálhatunk, és az ortogonalitás miatt ($integral cos(k x) = integral sin(k x) = 0$, $k >= 1$):
  $ integral_(-pi)^pi S_n (x) dif x = a_0 / 2 (2 pi) = pi a_0. $
  Ezért $a_0 = 1 / pi integral_(-pi)^pi f(x) dif x$.

  *2. lépés: az $a_m$ ($m >= 1$) meghatározása.* \
  A $cos(m x)$ korlátos, ezért $S_n (x) cos(m x) arrows.rr f(x) cos(m x)$. A 12. tétel szerint
  $ integral_(-pi)^pi f(x) cos(m x) dif x = lim_(n -> oo) integral_(-pi)^pi S_n (x) cos(m x) dif x. $
  Az ortogonalitás miatt:
  - $integral_(-pi)^pi (a_0 / 2) cos(m x) dif x = 0$;
  - $integral_(-pi)^pi sin(k x) cos(m x) dif x = 0$ minden $k, m$-re;
  - $integral_(-pi)^pi cos(k x) cos(m x) dif x = 0$, ha $k != m$, és $= pi$, ha $k = m$.

  Ezért $n >= m$ esetén $integral_(-pi)^pi S_n (x) cos(m x) dif x = a_m pi$, tehát
  $ integral_(-pi)^pi f(x) cos(m x) dif x = a_m pi quad ==> quad a_m = 1 / pi integral_(-pi)^pi f(x) cos(m x) dif x. $

  *3. lépés: a $b_m$ ($m >= 1$) meghatározása.* \
  Ugyanígy, a sort $sin(m x)$-szel szorozva és tagonként integrálva:
  $
    integral_(-pi)^pi f(x) sin(m x) dif x = b_m pi quad ==> quad b_m = 1 / pi integral_(-pi)^pi f(x) sin(m x) dif x. quad square
  $
])

#v(10pt)

= Bessel-azonosság és Bessel-egyenlőtlenség

A Fourier-részletösszegek geometriai tulajdonsága, hogy a véges trigonometrikus polinomok között a Fourier-részletösszeg adja az $f$ *legjobb $L^2$-közelítését*.

#theorembox("Tétel: véges Bessel-azonosság", [
  Legyen $f$ négyzetesen integrálható a $[-pi, pi]$-n, és legyen $S_N (f, x) = a_0 / 2 + sum_(k=1)^N (a_k cos(k x) + b_k sin(k x))$ az $f$ $N$-edik Fourier-részletösszege. Ekkor
  $
    norm(f - S_N (f))_2^2 = integral_(-pi)^pi (f(x) - S_N (f, x))^2 dif x = integral_(-pi)^pi f^2 (x) dif x - pi [a_0^2 / 2 + sum_(k=1)^N (a_k^2 + b_k^2)].
  $
])

#v(8pt)

#proofbox("A véges Bessel-azonosság levezetése", [
  Fejtsük ki a négyzetet az integrál alatt (az $S_N (f, x)$ helyett röviden $S_N (x)$):
  $
    integral_(-pi)^pi (f(x) - S_N (x))^2 dif x = integral_(-pi)^pi f^2 (x) dif x - 2 integral_(-pi)^pi f(x) S_N (x) dif x + integral_(-pi)^pi S_N^2 (x) dif x.
  $

  1. A középső tag a Fourier-együtthatók definíciója ($integral f cos(k x) = pi a_k$, $integral f sin(k x) = pi b_k$) szerint:
    $
      integral_(-pi)^pi f(x) S_N (x) dif x = a_0 / 2 (pi a_0) + sum_(k=1)^N [a_k (pi a_k) + b_k (pi b_k)] = pi [a_0^2 / 2 + sum_(k=1)^N (a_k^2 + b_k^2)].
    $

  2. Az utolsó tag az ortogonalitás miatt:
    $
      integral_(-pi)^pi S_N^2 (x) dif x = (a_0 / 2)^2 (2 pi) + sum_(k=1)^N [a_k^2 pi + b_k^2 pi] = pi [a_0^2 / 2 + sum_(k=1)^N (a_k^2 + b_k^2)].
    $

  Összevonva:
  $
    integral_(-pi)^pi (f - S_N)^2 dif x = integral_(-pi)^pi f^2 (x) dif x - 2 pi [dots] + pi [dots] = integral_(-pi)^pi f^2 (x) dif x - pi [a_0^2 / 2 + sum_(k=1)^N (a_k^2 + b_k^2)]. quad square
  $
])

#v(8pt)

#theorembox("Tétel: Bessel-egyenlőtlenség", [
  Bármely négyzetesen integrálható $f$ Fourier-együtthatóira teljesül a *Bessel-egyenlőtlenség*:

  1. véges $N$ esetén:
    $ a_0^2 / 2 + sum_(k=1)^N (a_k^2 + b_k^2) <= 1 / pi integral_(-pi)^pi f^2 (x) dif x; $
  2. a végtelen sorra ($N -> oo$):
    $ a_0^2 / 2 + sum_(k=1)^oo (a_k^2 + b_k^2) <= 1 / pi integral_(-pi)^pi f^2 (x) dif x = 1 / pi norm(f)_2^2. $
])

#v(8pt)

#proofbox("A Bessel-egyenlőtlenség bizonyítása", [
  Mivel egy valós függvény négyzetének integrálja nemnegatív:
  $ norm(f - S_N (f))_2^2 = integral_(-pi)^pi (f(x) - S_N (f, x))^2 dif x >= 0. $
  A véges Bessel-azonosságból:
  $ integral_(-pi)^pi f^2 (x) dif x - pi [a_0^2 / 2 + sum_(k=1)^N (a_k^2 + b_k^2)] >= 0. $
  Rendezve és $pi$-vel osztva a véges egyenlőtlenséget kapjuk. A bal oldali részletösszegek monoton növekvők és felülről korlátosak, ezért a sor konvergens, és $N -> oo$ esetén a korlát megmarad. $square$
])

#v(8pt)

#remarkbox("Következmény: Riemann–Lebesgue-lemma", [
  A Bessel-egyenlőtlenség szerint az $a_0^2 / 2 + sum_(k=1)^oo (a_k^2 + b_k^2)$ sor konvergens. A sorkonvergencia szükséges feltétele miatt a tagok nullához tartanak:
  $ lim_(k -> oo) a_k = 0 quad "és" quad lim_(k -> oo) b_k = 0. $
  Azaz bármely négyzetesen integrálható függvény Fourier-együtthatói $0$-hoz tartanak, ha $k -> oo$.
])
