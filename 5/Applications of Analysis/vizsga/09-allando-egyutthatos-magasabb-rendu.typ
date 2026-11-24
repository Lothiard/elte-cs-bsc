// Typst source document for Exam Topic 9
// Analízis Alkalmazásai - 9. Tétel
// "Állandó együtthatós magasabb rendű homogén lineáris differenciálegyenlet egy alaprendszerének az előállítása, a karakterisztikus polinom szerepe (a bizonyítás vázlata)."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (9. Tétel)
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
    #text(weight: "bold")[9. Tétel:]
    _„Állandó együtthatós magasabb rendű homogén lineáris differenciálegyenlet egy alaprendszerének az előállítása, a karakterisztikus polinom szerepe (a bizonyítás vázlata).”_
  ]
]

#v(15pt)

= Állandó együtthatós homogén lineáris differenciálegyenlet

#defbox("Állandó együtthatós n-edrendű homogén lineáris differenciálegyenlet", [
  Legyenek $a_0, a_1, dots, a_(n-1) in bb(K)$ (ahol $bb(K) = bb(R)$ vagy $bb(C)$) konstans együtthatók. Az
  $ y^((n)) + a_(n-1) y^((n-1)) + dots + a_1 y' + a_0 y = 0 $
  egyenletet *állandó együtthatós $n$-edrendű homogén lineáris differenciálegyenletnek* nevezzük.

  Vezessük be a $D = (dif) / (dif x)$ differenciáloperátort. Ekkor az egyenlet felírható az
  $ L(y) := (D^n + a_(n-1) D^(n-1) + dots + a_1 D + a_0 I) y = 0 $
  operátoros alakban, ahol $L$ egy $n$-edfokú polinomiális differenciáloperátor.
])

#v(8pt)

A korábbi tételekből (8. tétel) tudjuk, hogy az $L(y) = 0$ egyenlet megoldáshalmaza a $C^n (bb(R))$ függvénytér egy $n$-dimenziós altere. A célunk ezen altér egy bázisának (azaz egy *alaprendszerének*) explicit előállítása az együtthatókból.

#v(10pt)

= A karakterisztikus polinom és a karakterisztikus egyenlet

Próbálkozzunk az $y(x) = e^(lambda x)$ exponenciális próbafüggvénnyel, ahol $lambda in bb(C)$ egy meghatározandó paraméter. Alkalmazzuk az $L$ operátort:
$
  D e^(lambda x) = lambda e^(lambda x), quad D^2 e^(lambda x) = lambda^2 e^(lambda x), quad dots, quad D^k e^(lambda x) = lambda^k e^(lambda x).
$

Ebből a linearitás miatt:
$ L(e^(lambda x)) = (lambda^n + a_(n-1) lambda^(n-1) + dots + a_1 lambda + a_0) e^(lambda x). $

#defbox("Karakterisztikus polinom és egyenlet", [
  Az $L$ operátorhoz tartozó
  $ P(lambda) := lambda^n + a_(n-1) lambda^(n-1) + dots + a_1 lambda + a_0 $
  $n$-edfokú polinomot a differenciálegyenlet *karakterisztikus polinomjának*, a
  $ P(lambda) = 0 $
  egyenletet pedig a *karakterisztikus egyenletnek* nevezzük.
])

#v(8pt)

#remarkbox("Kulcsösszefüggés", [
  Mivel $e^(lambda x) != 0$ minden $x in bb(R)$ esetén, ezért:
  $ L(e^(lambda x)) = 0 <==> P(lambda) = 0. $
  Tehát az $y(x) = e^(lambda x)$ függvény pontosan akkor megoldása a differenciálegyenletnek, ha $lambda$ gyöke a karakterisztikus polinomnak.
])

Az algebra alaptétele szerint a $P(lambda)$ polinomnak a multiplicitásokat figyelembe véve pontosan $n$ komplex gyöke van. Jelöljük a különböző gyököket $lambda_1, lambda_2, dots, lambda_k$-val, multiplicitásukat $m_1, m_2, dots, m_k$-val, ahol:
$ sum_(j=1)^k m_j = n. $

Gyöktényezős alakban:
$ P(lambda) = (lambda - lambda_1)^(m_1) (lambda - lambda_2)^(m_2) dots.c (lambda - lambda_k)^(m_k). $

#v(10pt)

= Az alaprendszer előállítása (főtétel)

#theorembox("Az állandó együtthatós egyenlet alaprendszerének tétele", [
  Legyen $P(lambda)$ a differenciálegyenlet karakterisztikus polinomja, amelynek különböző gyökei $lambda_1, dots, lambda_k$, $m_1, dots, m_k$ multiplicitásokkal ($sum m_j = n$).

  1. Ha $lambda_j$ a karakterisztikus polinom $m_j$-szeres gyöke, akkor a hozzá tartozó
    $ e^(lambda_j x), quad x e^(lambda_j x), quad x^2 e^(lambda_j x), quad dots, quad x^(m_j - 1) e^(lambda_j x) $
    függvények mind megoldásai az $L(y) = 0$ egyenletnek (összesen $m_j$ darab).

  2. A minden $lambda_j$ gyökhöz ($j = 1, dots, k$) tartozó fenti függvények együtt az $L(y) = 0$ egyenlet egy $n$ elemű *alaprendszerét* alkotják $C^n (bb(R))$-ben.
])

#v(8pt)

#proofbox("A bizonyítás vázlata", [
  A bizonyítás két részből áll: (A) az $x^s e^(lambda_j x)$ alakú függvények valóban megoldások; (B) ez az $n$ függvény lineárisan független.

  *A) A megadott függvények megoldások.* \
  Legyen $lambda_j$ $m_j$-szeres gyök. Ekkor $P(lambda) = Q(lambda) (lambda - lambda_j)^(m_j)$ alakú, ahol $Q(lambda_j) != 0$, és ennek megfelelően
  $ L = Q(D) compose (D - lambda_j I)^(m_j). $
  Mivel a konstans együtthatós differenciáloperátorok felcserélhetők, elég megmutatni, hogy $(D - lambda_j I)^(m_j)$ nullázza az $x^s e^(lambda_j x)$ függvényt, ha $0 <= s < m_j$.

  Tetszőleges sima $g$ függvényre a szorzatszabály szerint:
  $
    (D - lambda_j I)(g(x) e^(lambda_j x)) = g'(x) e^(lambda_j x) + lambda_j g(x) e^(lambda_j x) - lambda_j g(x) e^(lambda_j x) = g'(x) e^(lambda_j x).
  $
  Ezt $r$-szer alkalmazva:
  $ (D - lambda_j I)^r (g(x) e^(lambda_j x)) = g^((r))(x) e^(lambda_j x). $
  A $g(x) = x^s$ polinom $m_j$-edik deriváltja azonosan nulla, ha $s < m_j$:
  $ (D - lambda_j I)^(m_j) (x^s e^(lambda_j x)) = (x^s)^((m_j)) e^(lambda_j x) = 0. $
  Ezért $L(x^s e^(lambda_j x)) = Q(D)(0) = 0$.

  *B) A lineáris függetlenség.* \
  Tegyük fel, hogy
  $ sum_(j=1)^k P_j (x) e^(lambda_j x) = 0 quad (x in bb(R)), $
  ahol $P_j$ legfeljebb $(m_j - 1)$-edfokú polinom. Megmutatjuk, hogy minden $P_j equiv 0$, $k$ szerinti teljes indukcióval. A $k = 1$ eset triviális, mert $e^(lambda_1 x) != 0$.

  Legyen $k >= 2$. Osszuk el az egyenletet $e^(lambda_k x)$-szel:
  $ sum_(j=1)^(k-1) P_j (x) e^((lambda_j - lambda_k) x) + P_k (x) = 0. $
  Deriváljuk $m_k$-szor: a $P_k$ tag eltűnik, mert $deg P_k < m_k$. A $P_j (x) e^(mu x)$ ($mu = lambda_j - lambda_k != 0$) alakú tag deriváltja $(mu P_j + P_j') e^(mu x)$, ami ugyanolyan fokú polinom és ugyanolyan főegyütthatójú szorzata $mu$-vel, tehát a fok nem változik, és a nem azonosan nulla polinom nem lesz nullává. Így kapunk egy $k - 1$ tagú azonosságot:
  $ sum_(j=1)^(k-1) tilde(P)_j (x) e^((lambda_j - lambda_k) x) = 0, $
  ahol $deg tilde(P)_j = deg P_j$ (vagy $tilde(P)_j equiv 0$, ha $P_j equiv 0$). Az indukciós feltevés szerint (a kitevők páronként különbözők) minden $tilde(P)_j equiv 0$, így $P_j equiv 0$ ($j < k$). Ezután az eredeti egyenletből $P_k e^(lambda_k x) = 0$, vagyis $P_k equiv 0$.

  Mivel $n$ lineárisan független megoldást kaptunk az $n$-dimenziós megoldástérben, a függvényrendszer *alaprendszer*.
])

#v(10pt)

= Valós együtthatós egyenlet valós alaprendszere

A gyakorlatban az együtthatók gyakran valósak ($a_k in bb(R)$). Ekkor a nem valós gyökök konjugált párokban jelennek meg.

#theorembox("Valós alaprendszer konstrukciója", [
  Ha a valós együtthatós karakterisztikus polinomnak $lambda = alpha + i beta$ ($beta != 0$) $m$-szeres gyöke, akkor a konjugáltja, $overline(lambda) = alpha - i beta$ is $m$-szeres gyök.

  A hozzájuk tartozó $2m$ komplex megoldás helyett a valós és képzetes részek szétválasztásával a következő $2m$ *valós, lineárisan független* megoldást kapjuk:
  $ x^s e^(alpha x) cos(beta x) quad "és" quad x^s e^(alpha x) sin(beta x) quad (s = 0, 1, dots, m - 1). $
])

#v(8pt)

#proofbox("A bizonyítás vázlata (Euler-formula)", [
  Az Euler-formula alapján:
  $ e^((alpha + i beta) x) = e^(alpha x) (cos(beta x) + i sin(beta x)). $

  Ha $y = u + i v$ komplex megoldása a valós együtthatós $L(y) = 0$ egyenletnek, akkor a linearitás és a valós együtthatók miatt:
  $ L(y) = L(u) + i L(v) = 0 <==> L(u) = 0 "és" L(v) = 0. $
  Tehát a valós és a képzetes rész külön-külön is megoldás. A komplex exponenciálisokból képzett lineáris kombinációkkal:
  $ u(x) = 1 / 2 (x^s e^((alpha + i beta) x) + x^s e^((alpha - i beta) x)) = x^s e^(alpha x) cos(beta x), $
  $ v(x) = 1 / (2 i) (x^s e^((alpha + i beta) x) - x^s e^((alpha - i beta) x)) = x^s e^(alpha x) sin(beta x). $
  Mivel a $(x^s e^(lambda x), x^s e^(overline(lambda) x))$ és az $(u, v)$ párok egymásból invertálható lineáris transzformációval kaphatók, a lineáris függetlenség megmarad.
])

#v(10pt)

= Összefoglaló táblázat és példa

#align(center)[
  #table(
    columns: (2fr, 1.5fr, 3fr),
    align: (center + horizon, center + horizon, left + horizon),
    fill: (x, y) => if y == 0 { rgb("e6ecf2") } else if calc.even(y) { rgb("f9f9f9") } else { white },
    stroke: 0.5pt + luma(150),
    [*Karakterisztikus gyök típusa*], [*Multiplicitás*], [*Elemek az alaprendszerben*],
    [Valós $lambda$], [$m = 1$ (egyszerű)], [$e^(lambda x)$],
    [Valós $lambda$], [$m > 1$ (többszörös)], [$e^(lambda x), x e^(lambda x), dots, x^(m-1) e^(lambda x)$],
    [Komplex $alpha plus.minus i beta$], [$m = 1$ (egyszerű)], [$e^(alpha x) cos(beta x), e^(alpha x) sin(beta x)$],
    [Komplex $alpha plus.minus i beta$],
    [$m > 1$ (többszörös)],
    [$x^s e^(alpha x) cos(beta x), x^s e^(alpha x) sin(beta x) quad (s < m)$],
  )
]

#v(10pt)

#remarkbox("Gyakorlati példa", [
  *Feladat:* Állítsuk elő az $y^((4)) - 4 y''' + 5 y'' = 0$ negyedrendű homogén egyenlet általános megoldását.

  *Megoldás:*
  1. Karakterisztikus egyenlet: $lambda^4 - 4 lambda^3 + 5 lambda^2 = 0 <==> lambda^2 (lambda^2 - 4 lambda + 5) = 0$.
  2. Gyökök:
    - $lambda_1 = 0$ kétszeres valós gyök ($m_1 = 2$). Elemei: $e^(0 x) = 1$ és $x e^(0 x) = x$.
    - $lambda_(2,3) = 2 plus.minus i$ egyszerű komplex konjugált gyökpár ($alpha = 2$, $beta = 1$). Elemei: $e^(2 x) cos x$ és $e^(2 x) sin x$.
  3. Alaprendszer: ${1, x, e^(2 x) cos x, e^(2 x) sin x}$.
  4. Általános megoldás:
    $ y(x) = c_1 + c_2 x + c_3 e^(2 x) cos x + c_4 e^(2 x) sin x quad (c_1, c_2, c_3, c_4 in bb(R)). $
])
