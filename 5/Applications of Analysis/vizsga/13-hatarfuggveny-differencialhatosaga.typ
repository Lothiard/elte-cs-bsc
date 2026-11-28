// Typst source document for Exam Topic 13
// Analízis Alkalmazásai - 13. Tétel
// "A határfüggvény differenciálhatóságára, ill. a deriválás és a határátmenet felcserélhetőségére vonatkozó tétel."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (13. Tétel)
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
    #text(weight: "bold")[13. Tétel:]
    _„A határfüggvény differenciálhatóságára, ill. a deriválás és a határátmenet felcserélhetőségére vonatkozó tétel.”_
  ]
]

#v(15pt)

= Bevezetés és a probléma megfogalmazása

A függvénysorozatok és függvénysorok elméletében az egyik legérzékenyebb kérdés a *differenciálhatóság átöröklődése* a határátmenet során. Míg az integrálás "simító" művelet, és az egyenletes konvergenciával jól viselkedik (12. tétel), a deriválás felerősíti a függvények ingadozásait.

Ezért önmagában az $f_n arrows.rr f$ egyenletes konvergencia *nem elegendő* ahhoz, hogy a határfüggvény differenciálható legyen, vagy hogy a deriválás és a határátmenet felcserélhető legyen:
$ (lim_(n -> oo) f_n)' eq.quest lim_(n -> oo) f'_n. $

#defbox("Problémafelvetés", [
  Adott egy $f_n: I -> bb(R)$ differenciálható függvénysorozat, amely konvergál egy $f: I -> bb(R)$ függvényhez.
  1. Milyen feltételek mellett differenciálható az $f$ határfüggvény?
  2. Milyen feltételek mellett igaz, hogy $f'(x) = lim_(n -> oo) f'_n (x)$?
])

#v(8pt)

== Ellenpéldák az egyszerű egyenletes konvergenciára

Az alábbi ellenpéldák szemléltetik, miért van szükség a *deriváltak sorozatának egyenletes konvergenciájára*.

#remarkbox("1. ellenpélda: az egyenletes konvergenciából nem következik a határfüggvény deriválhatósága", [
  Tekintsük az $f_n: [-1, 1] -> bb(R)$, $f_n (x) := sqrt(x^2 + 1 / n)$ függvénysorozatot.
  - *Sima függvények:* minden $n in bb(N)^+$ esetén $f_n in C^oo ([-1, 1])$, és $f'_n (x) = x / sqrt(x^2 + 1 / n)$.
  - *Egyenletes konvergencia:* $lim_(n -> oo) f_n (x) = abs(x) =: f(x)$. Mivel
    $ abs(f_n (x) - f(x)) = sqrt(x^2 + 1 / n) - abs(x) = (1 / n) / (sqrt(x^2 + 1 / n) + abs(x)) <= 1 / sqrt(n) -> 0, $
    ezért $f_n arrows.rr f$ a $[-1, 1]$-en.
  - *Konklúzió:* az $f(x) = abs(x)$ határfüggvény az $x = 0$ pontban *nem differenciálható*.
])

#v(8pt)

#remarkbox("2. ellenpélda: egyenletesen konvergens sor tagonkénti deriváltja divergens", [
  Tekintsük a $sum_(n=1)^oo sin(n^2 x) / n^2$ függvénysort $bb(R)$-en.
  - A sor a Weierstrass-kritérium alapján ($abs(sin(n^2 x) / n^2) <= 1 / n^2$) abszolút és egyenletesen konvergens.
  - A tagonkénti deriváltja $sum_(n=1)^oo cos(n^2 x)$, amely például az $x = 0$ pontban ($sum 1 = oo$) *divergens*.
])

#v(8pt)

#remarkbox("3. ellenpélda: a deriváltak nem konvergálnak a határfüggvény deriváltjához", [
  Legyen $f_n (x) = sin(n x) / sqrt(n)$ $bb(R)$-en.
  - Mivel $abs(f_n (x)) <= 1 / sqrt(n) -> 0$, ezért $f_n arrows.rr 0$, a határfüggvény deriváltja pedig $f' equiv 0$.
  - Viszont $f'_n (x) = sqrt(n) cos(n x)$, amely nem konvergál (például $x = 0$-ban $sqrt(n) -> oo$).
])

#v(10pt)

= A határfüggvény differenciálhatóságára vonatkozó főtétel

A fenti problémák elkerülésére a *deriváltak sorozatára* ($f'_n$) írunk elő *egyenletes konvergenciát*.

#theorembox("Főtétel: a deriválás és a határátmenet felcserélhetősége", [
  Legyen $I = (a, b)$ korlátos nyílt intervallum (vagy korlátos zárt $[a, b]$ intervallum), és legyen $f_n: I -> bb(R)$ folytonosan differenciálható függvénysorozat ($f_n in C^1(I)$).

  Tegyük fel, hogy
  1. *pontbeli konvergencia:* létezik olyan $x_0 in I$, hogy az $(f_n (x_0))$ számsorozat konvergens;
  2. *a deriváltak egyenletes konvergenciája:* az $(f'_n)$ sorozat *egyenletesen konvergál* $I$-n egy $g: I -> bb(R)$ függvényhez ($f'_n arrows.rr g$).

  Ekkor
  - az $(f_n)$ sorozat az egész $I$-n *egyenletesen konvergál* egy $f: I -> bb(R)$ függvényhez ($f_n arrows.rr f$);
  - az $f$ határfüggvény differenciálható $I$-n;
  - $f' = g$, azaz a deriválás és a határátmenet felcserélhető:
    $ (lim_(n -> oo) f_n)' (x) = lim_(n -> oo) f'_n (x) quad (x in I). $
])

#v(8pt)

#remarkbox("Megjegyzés a korlátosságról", [
  Az I. lépés becslésében a $b - a$ hosszúság szerepel, ezért kell $I$ korlátosságát feltenni. Nem korlátos intervallumon a tételt minden korlátos részintervallumon lokálisan alkalmazzuk.
])

#v(10pt)

= A tétel bizonyítása

A bizonyítás két szakaszból áll:
1. a deriváltak egyenletes konvergenciájából és az $x_0$-beli konvergenciából következik, hogy $f_n arrows.rr f$;
2. a határfüggvény deriváltja $g$.

#proofbox("A tétel bizonyítása", [
  *I. lépés: az $(f_n)$ sorozat egyenletes konvergenciája.* \
  Az egyenletes Cauchy-kritériumot alkalmazzuk. Mivel $f'_n$ egyenletesen konvergens $I$-n, ezért egyenletesen Cauchy is: minden $epsilon > 0$-hoz van olyan $N_1$, hogy
  $ abs(f'_n (t) - f'_m (t)) < epsilon / (2 (b - a)) quad (m, n > N_1, t in I). $
  Mivel az $(f_n (x_0))$ konvergens, Cauchy-sorozat is: van olyan $N_2$, hogy
  $ abs(f_n (x_0) - f_m (x_0)) < epsilon / 2 quad (m, n > N_2). $
  Legyen $N := max(N_1, N_2)$, és rögzítsünk egy tetszőleges $x in I$, $x != x_0$ pontot. A $g_(n m) := f_n - f_m$ függvényre a Lagrange-féle középértéktétel szerint van olyan $xi$ az $x_0$ és $x$ között, hogy
  $ (f_n (x) - f_m (x)) - (f_n (x_0) - f_m (x_0)) = (f'_n (xi) - f'_m (xi)) (x - x_0). $
  A háromszög-egyenlőtlenséggel és $abs(x - x_0) <= b - a$ miatt, ha $m, n > N$:
  $
    abs(f_n (x) - f_m (x)) <= abs(f_n (x_0) - f_m (x_0)) + abs(f'_n (xi) - f'_m (xi)) abs(x - x_0) < epsilon / 2 + epsilon / (2 (b - a)) (b - a) = epsilon.
  $
  Ez a becslés $x$-től független, tehát $(f_n)$ egyenletesen Cauchy-sorozat $I$-n. Mivel $bb(R)$ teljes, létezik olyan $f$, hogy $f_n arrows.rr f$.

  #v(8pt)
  *II. lépés: $f' = g$.* \
  Mivel $f_n in C^1(I)$, az analízis alaptétele szerint minden $x in I$ esetén
  $ f_n (x) = f_n (x_0) + integral_(x_0)^x f'_n (t) dif t. $
  Képezzük a határértéket $n -> oo$ esetén:
  - a bal oldal $f(x)$-hez tart;
  - a jobb oldal első tagja $f(x_0)$-hoz tart;
  - az integrálnál a 12. tétel szerint (mivel $f'_n arrows.rr g$ az $x_0$ és $x$ közötti zárt intervallumon, és $f'_n$ folytonos) az integrálás és a határátmenet felcserélhető:
    $ lim_(n -> oo) integral_(x_0)^x f'_n (t) dif t = integral_(x_0)^x g(t) dif t. $
  Így a határfüggvényre
  $ f(x) = f(x_0) + integral_(x_0)^x g(t) dif t. $
  Mivel $g$ folytonos függvények egyenletes határértéke, a 12. tétel szerint $g$ folytonos. Az analízis alaptétele szerint az $x |-> integral_(x_0)^x g(t) dif t$ függvény differenciálható, deriváltja $g(x)$. Tehát $f$ differenciálható, és $f'(x) = g(x)$. $square$
])

#v(8pt)

#proofbox("Alternatív bizonyítás: a különbségi hányadosok egyenletes konvergenciájával", [
  Ez a gondolatmenet akkor is működik, ha $f'_n$ csak létezik (nem feltétlenül folytonos). Rögzítsünk egy $x in I$ pontot, és legyen $h != 0$, $x + h in I$:
  $ phi_n (h) := (f_n (x + h) - f_n (x)) / h, quad phi (h) := (f(x + h) - f(x)) / h. $
  A Lagrange-középértéktétel szerint $phi_n (h) - phi_m (h) = f'_n (xi) - f'_m (xi)$ alkalmas $xi$-vel, ezért $(phi_n)$ egyenletesen Cauchy-sorozat a $h$ változóban, vagyis $phi_n arrows.rr phi$. Mivel minden $n$-re létezik $lim_(h -> 0) phi_n (h) = f'_n (x)$, a kettős határérték felcserélhetősége (Moore–Osgood-tétel) alapján:
  $
    f'(x) = lim_(h -> 0) lim_(n -> oo) phi_n (h) = lim_(n -> oo) lim_(h -> 0) phi_n (h) = lim_(n -> oo) f'_n (x) = g(x).
  $
])

#v(10pt)

= Alkalmazás függvénysorokra: tagonkénti deriválhatóság

A függvénysorozatokra vonatkozó tétel az $s_n (x) = sum_(k=1)^n u_k (x)$ részletösszegekre alkalmazva átfogalmazható függvénysorokra.

#theorembox("Tétel: függvénysorok tagonkénti deriválhatósága", [
  Legyen $I subset bb(R)$ korlátos nyílt intervallum, és legyenek $u_k in C^1(I)$. Tegyük fel, hogy
  1. a $sum_(k=1)^oo u_k (x_0)$ számsor konvergens legalább egy $x_0 in I$ pontban;
  2. a deriváltak sora, $sum_(k=1)^oo u'_k (x)$ *egyenletesen konvergens* $I$-n.

  Ekkor
  - a $sum u_k$ függvénysor is egyenletesen konvergál $I$-n egy $S$ összegfüggvényhez;
  - $S$ differenciálható $I$-n;
  - a sor *tagonként deriválható*:
    $ (sum_(k=1)^oo u_k (x))' = sum_(k=1)^oo u'_k (x) quad (x in I). $
])

#v(10pt)

= Hatványsorok tagonkénti deriválhatósága

A tagonkénti deriválhatóság legfontosabb alkalmazási területe a *hatványsorok* elmélete.

#theorembox("Tétel: hatványsorok tagonkénti deriválása", [
  Tekintsük a $sum_(k=0)^oo a_k (x - a)^k$ hatványsort, amelynek konvergenciasugara $R > 0$. Ekkor
  1. a hatványsor az $(a - R, a + R)$ nyílt intervallumon tetszőleges sokszor tagonként deriválható;
  2. a tagonkénti deriválással kapott
    $ sum_(k=1)^oo k a_k (x - a)^(k-1) $
    hatványsor konvergenciasugara *pontosan megegyezik* az eredeti sor $R$ konvergenciasugarával;
  3. az $f$ összegfüggvény $C^oo$-beli az $(a - R, a + R)$ intervallumon, és minden $p in bb(N)$ esetén
    $ f^((p)) (x) = sum_(k=p)^oo k (k - 1) dots.c (k - p + 1) a_k (x - a)^(k - p). $
])

#v(8pt)

#proofbox("A konvergenciasugarak egyezésének vázlata", [
  A Cauchy–Hadamard-tétel szerint (a $sum k a_k (x - a)^(k-1)$ és a $sum k a_k (x - a)^k$ sor konvergenciasugara megegyezik, mert csak $x - a$-val szorzunk):
  $ 1 / R' = limsup_(k -> oo) root(k, abs(k a_k)) = limsup_(k -> oo) (root(k, k) dot root(k, abs(a_k))). $
  Mivel $lim_(k -> oo) root(k, k) = 1$, a $limsup$ és a pozitív határértékkel való szorzás felcserélhető:
  $ 1 / R' = 1 dot limsup_(k -> oo) root(k, abs(a_k)) = 1 / R, quad "azaz" quad R' = R. $
  Ezért a deriváltsor minden $(a - r, a + r)$ ($0 < r < R$) intervallumon, sőt a $[a - r, a + r]$ zárt intervallumon egyenletesen konvergens (Weierstrass-kritérium). A függvénysorokra vonatkozó tételt így minden ilyen $(a - r, a + r)$ intervallumra alkalmazva kapjuk a tagonkénti deriválhatóságot az egész $(a - R, a + R)$ intervallumon, majd indukcióval a magasabb deriváltakat.
])

#v(10pt)

= Összefoglaló táblázat

Az alábbi táblázat összefoglalja a határátmenet és az analitikus műveletek felcserélhetőségének feltételeit.

#align(center)[
  #table(
    columns: (3cm, 4.5cm, 6.5cm),
    align: (center + horizon, left + horizon, left + horizon),
    stroke: 0.5pt + luma(150),
    fill: (x, y) => if y == 0 { rgb("e6f2ff") } else if calc.even(y) { rgb("f9f9f9") } else { white },
    [*Művelet*], [*Kérdés / egyenlet*], [*Elégséges feltétel*],
    [*Folytonosság* (12. tétel)],
    [$lim_(x -> x_0) lim_(n -> oo) f_n (x) eq.quest lim_(n -> oo) lim_(x -> x_0) f_n (x)$],
    [$f_n in C$ és $f_n arrows.rr f$],

    [*Integrálás* (12. tétel)],
    [$integral_a^b lim_(n -> oo) f_n dif x eq.quest lim_(n -> oo) integral_a^b f_n dif x$],
    [$f_n in cal(R)([a, b])$ és $f_n arrows.rr f$],

    [*Deriválás* (13. tétel)],
    [$(lim_(n -> oo) f_n)' eq.quest lim_(n -> oo) f'_n$],
    [$f_n in C^1$, $(f_n (x_0))$ konvergens, *és $f'_n arrows.rr g$*],
  )
]

#v(8pt)

#remarkbox("Vizsgatippek és kulcsfogalmak", [
  - *Mire figyelj a vizsgán?* Ne mondd, hogy az $f_n arrows.rr f$ egyenletes konvergenciából következik a deriválhatóság. A kulcs a *deriváltak* egyenletes konvergenciája ($f'_n arrows.rr g$).
  - *Miért kell az $x_0$-beli konvergencia?* A deriváltak csak a függvények alakját (meredekségét) határozzák meg, a függőleges eltolást nem. Ha $f_n (x) = n$, akkor $f'_n equiv 0 arrows.rr 0$, de az $f_n$ a végtelenbe tart. Az $x_0$-beli konvergencia rögzíti a függőleges eltolást (az integrálási konstanst).
])
