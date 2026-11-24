// Typst source document for Exam Topic 3
// Analízis Alkalmazásai - 3. Tétel
// "A differenciálegyenlet (rendszer) fogalma. Kezdetiérték-probléma (Cauchy-feladat). Egzakt egyenlet, szeparábilis egyenlet, a rakéta emelkedési idejének a kiszámítása."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (3. Tétel)
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
    #text(weight: "bold")[3. Tétel:]
    _„A differenciálegyenlet (rendszer) fogalma. Kezdetiérték-probléma (Cauchy-feladat). Egzakt egyenlet, szeparábilis egyenlet, a rakéta emelkedési idejének a kiszámítása.”_
  ]
]

#v(15pt)

= A közönséges differenciálegyenlet és differenciálegyenlet-rendszer fogalma

A természeti folyamatok, fizikai rendszerek és informatikai modellek dinamikájának leírására a matematikai analízis legfontosabb eszközei a közönséges differenciálegyenletek. Ezek olyan egyenletek, amelyekben az ismeretlen egy egyváltozós függvény, és az egyenletben szerepel ezen ismeretlen függvény legalább első deriváltja.

#defbox("Definíció: Explicit elsőrendű közönséges differenciálegyenlet (d.e.)", [
  Legyen $n in bb(N)^+$ pozitív egész szám, $I subset bb(R)$ nyílt intervallum (a független változó tartománya), és $Omega subset bb(R)^n$ nyílt és összefüggő halmaz (tartomány, a rendszer állapottere).

  Legyen $f: I times Omega -> bb(R)^n$ adott folytonos leképezés ($f in C(I times Omega, bb(R)^n)$), amelyet a differenciálegyenlet *jobb oldalának* nevezünk.

  Olyan $phi: D_phi -> Omega$ függvényt keresünk, amelyre teljesülnek az alábbiak:
  + $D_phi subset I$ nyílt intervallum;
  + $phi$ folytonosan differenciálható $D_phi$-n ($phi in C^1(D_phi, bb(R)^n)$);
  + minden $x in D_phi$ esetén fennáll a
    $ phi'(x) = f(x, phi(x)) $
    egyenlőség.

  Ezt a feladatot *explicit elsőrendű közönséges differenciálegyenletnek* (ha $n = 1$), illetve *differenciálegyenlet-rendszernek* (ha $n > 1$) nevezzük.
])

#v(8pt)

#remarkbox("Részletes koordinátás alak (differenciálegyenlet-rendszer)", [
  Ha $n > 1$, akkor a $phi = (phi_1, phi_2, dots, phi_n): D_phi -> bb(R)^n$ vektorértékű függvény és az $f = (f_1, f_2, dots, f_n): I times Omega -> bb(R)^n$ vektorértékű függvény koordinátáival kiírva az egyenlet $n$ darab csatolt skalár differenciálegyenletből álló rendszert alkot:
  $
    phi_1'(x) & = f_1(x, phi_1(x), phi_2(x), dots, phi_n(x)) \
    phi_2'(x) & = f_2(x, phi_1(x), phi_2(x), dots, phi_n(x)) \
              & dots.v \
    phi_n'(x) & = f_n (x, phi_1(x), phi_2(x), dots, phi_n(x))
  $
  minden $x in D_phi$ helyen. Az $f$ függvény $n + 1$ változós (mivel $I times Omega subset bb(R) times bb(R)^n = bb(R)^(n+1)$).
])

#v(10pt)

= Kezdetiérték-probléma (Cauchy-feladat) és a megoldás egyértelműsége

Önmagában egy differenciálegyenletnek végtelen sok megoldása van (az integrálásból származó konstansok miatt). Egy konkrét fizikai vagy geometriai folyamat egyértelmű leírásához rögzítenünk kell a rendszer állapotát egy kezdeti időpillanatban.

#defbox("Definíció: Kezdetiérték-probléma (Cauchy-feladat)", [
  Adott a $phi'(x) = f(x, phi(x))$ differenciálegyenlet, valamint adottak a $tau in I$ és $xi in Omega$ kezdeti adatok.

  Olyan $phi: D_phi -> Omega$ megoldásfüggvényt keresünk, amely eleget tesz a differenciálegyenletnek, és teljesíti a
  $ phi(tau) = xi $
  *kezdeti feltételt* is (ahol $tau in D_phi$). Ezt a kibővített feladatot *kezdetiérték-problémának* vagy *Cauchy-feladatnak* nevezzük (rövidítése: k.é.p.).
])

#v(8pt)

#defbox("Definíció: Egyértelmű megoldhatóság és teljes megoldás", [
  Jelölje $M$ a k.é.p. összes megoldásának halmazát.

  1. *Lokális egyértelműség:* Azt mondjuk, hogy a Cauchy-feladat *lokálisan egyértelműen* oldható meg, ha létezik olyan $Phi in M$ megoldás, hogy a feladat bármely $phi in M$ megoldására $phi(x) = Phi(x)$ teljesül minden $x in D_phi inter D_Phi$ helyen.

  2. *Egyértelműség:* A Cauchy-feladat *egyértelműen* oldható meg, ha bármely két $phi, psi in M$ megoldásra $phi(x) = psi(x)$ fennáll a teljes $D_phi inter D_psi$ közös értelmezési tartományon.

  3. *Teljes (maximális) megoldás:* Ha a k.é.p. egyértelműen megoldható, akkor az összes $phi in M$ megoldás értelmezési tartományainak uniója, $J := union.big_(phi in M) D_phi$ is nyílt intervallum, és az erre kiterjesztett $Phi: J -> Omega$ függvény a Cauchy-feladat *teljes (vagy nem folytatható) megoldása*.
])

#v(8pt)

#remarkbox("Példa a nem egyértelmű megoldhatóságra (Peano-jelenség)", [
  Tekintsük a $phi'(x) = sqrt(abs(phi(x)))$ differenciálegyenletet a $tau = 0$, $xi = 0$ kezdeti feltétellel ($phi(0) = 0$).
  - A $phi_1(x) = 0$ ($x in bb(R)$) triviálisan megoldás.
  - A $phi_2(x) = cases(x^2 / 4 quad "ha " x >= 0, -x^2 / 4 quad "ha " x < 0)$ függvény szintén $C^1$-beli és megoldása a Cauchy-feladatnak.

  Mivel $phi_1(x) != phi_2(x)$ minden $x != 0$ helyen, a megoldás a $0$ pont környezetében *nem egyértelmű*. Ennek oka, hogy az $f(x, y) = sqrt(abs(y))$ jobb oldal az $y = 0$ pontban nem teljesíti a Lipschitz-feltételt.
])

#v(10pt)

= Szeparábilis (szétválasztható változójú) differenciálegyenletek

A szeparábilis differenciálegyenletek az elsőrendű közönséges differenciálegyenletek egyik legfontosabb, explicit módon integrálható osztályát alkotják.

#defbox("Definíció: Szeparábilis differenciálegyenlet", [
  Legyen $n = 1$, $I, J subset bb(R)$ nyílt intervallumok, $g: I -> bb(R)$ és $h: J -> bb(R) without {0}$ folytonos függvények (ahol $h$ sehol sem veszi fel a $0$ értéket).

  A $phi'(t) = g(t) dot h(phi(t))$ alakú egyenletet *szeparábilis (szétválasztható változójú) differenciálegyenletnek* nevezzük.

  Adott $tau in I$, $xi in J$ esetén a $phi(tau) = xi$ feltétellel kiegészített feladat a szeparábilis differenciálegyenletre vonatkozó Cauchy-feladat.
])

#v(8pt)

#theorembox("Tétel: Szeparábilis Cauchy-feladat megoldhatósága és egyértelműsége", [
  Minden, a $g in C(I)$, $h in C(J)$, $0 in.not h(J)$ feltételeknek eleget tevő szeparábilis differenciálegyenletre vonatkozó Cauchy-feladat *egyértelműen megoldható*.

  A $phi(tau) = xi$ feltételt kielégítő $phi$ megoldást implicit alakban a
  $ integral_xi^(phi(x)) 1 / h(y) dif y = integral_tau^x g(t) dif t $
  egyenlet határozza meg, ahonnan $phi(x)$ a bal oldal inverzével explicit módon is kifejezhető.
])

#v(8pt)

#proofbox("A tétel bizonyítása", [
  *1. Lépés: Átalakítás és primitív függvények.* \
  Mivel $h(y) != 0$ minden $y in J$ esetén, a $phi'(t) = g(t) h(phi(t))$ egyenlet mindkét oldalát eloszthatjuk $h(phi(t))$-vel:
  $ (phi'(t)) / (h(phi(t))) = g(t) quad (t in D_phi). $

  Mivel $g in C(I)$ és $1 / h in C(J)$ folytonosak nyílt intervallumokon, léteznek $G: I -> bb(R)$ és $H: J -> bb(R)$ folytonosan differenciálható primitív függvényeik:
  $ G'(t) = g(t) quad (t in I), quad quad H'(y) = 1 / h(y) quad (y in J). $

  *2. Lépés: Integrálás a láncszabállyal.* \
  Az összetett függvény deriválási szabálya alapján:
  $ (H compose phi)'(t) = H'(phi(t)) dot phi'(t) = 1 / h(phi(t)) dot phi'(t) = g(t) = G'(t). $
  Innen $(H compose phi - G)'(t) = 0$, így a $D_phi$ nyílt intervallumon fennáll:
  $ H(phi(t)) - G(t) = c quad (c in bb(R) "konstans"). $

  *3. Lépés: A kezdeti feltétel és az inverz létezése.* \
  A $phi(tau) = xi$ feltételből $c = H(xi) - G(tau)$.
  Mivel $H'(y) = 1 / h(y)$ folytonos és sehol sem $0$ a $J$ intervallumon, a Bolzano-tétel miatt állandó előjelű. Így $H$ szigorúan monoton, következésképpen $H$ invertálható a képén, és $H^(-1)$ is $C^1$-beli.

  Ezért a megoldás explicit alakja:
  $ phi(t) = H^(-1) (G(t) + H(xi) - G(tau)). $

  *4. Lépés: Létezés igazolása az implicitfüggvény-tétellel.* \
  Válasszuk a $G$, $H$ primitív függvényeket úgy, hogy $G(tau) = 0$ és $H(xi) = 0$.
  Definiáljuk az $F(t, y) := H(y) - G(t)$ kétváltozós függvényt.
  - $F(tau, xi) = H(xi) - G(tau) = 0$.
  - $F in C^1(I times J)$, mivel $partial_1 F(t, y) = -g(t)$ és $partial_2 F(t, y) = H'(y) = 1 / h(y)$ folytonosak.
  - $partial_2 F(tau, xi) = 1 / h(xi) != 0$.

  Az implicitfüggvény-tétel értelmében létezik $tau$-nak egy $K(tau)$ környezetében egyértelműen egy $phi: K(tau) -> J$ folytonosan differenciálható függvény, amelyre $phi(tau) = xi$, $F(t, phi(t)) = 0$, és
  $ phi'(t) = -(partial_1 F(t, phi(t))) / (partial_2 F(t, phi(t))) = -(-g(t)) / (1 / h(phi(t))) = g(t) h(phi(t)). $
  Ez bizonyítja a megoldás létezését és egyértelműségét.
])

#v(10pt)

= Egzakt differenciálegyenletek

#defbox("Definíció: Egzakt differenciálegyenlet", [
  Legyenek $I, J subset bb(R)$ nyílt intervallumok, $g, h: I times J -> bb(R)$ folytonos függvények, ahol $h(x, y) != 0$ a teljes $I times J$ tartományon.

  A $phi'(x) = -(g(x, phi(x))) / (h(x, phi(x)))$ differenciálegyenletet (azaz a $g(x, phi(x)) + h(x, phi(x)) phi'(x) = 0$ egyenletet) *egzakt differenciálegyenletnek* nevezzük, ha a $(g, h): I times J -> bb(R)^2$ vektorértékű függvénynek van $G: I times J -> bb(R)$ potenciálfüggvénye (primitív függvénye), azaz:
  $ nabla G = (partial_1 G, partial_2 G) = (g, h). $
])

#v(8pt)

#theorembox("Tétel: Egzakt Cauchy-feladat megoldhatósága", [
  Bármely egzakt differenciálegyenletre vonatkozó $phi(tau) = xi$ Cauchy-feladat lokálisan egyértelműen megoldható. A megoldásgörbét a $G(x, y) = c$ szintvonal adja meg, ahol $c = G(tau, xi)$.
])

#v(8pt)

#proofbox("A tétel bizonyítása", [
  Az egyenlet $g(x, phi(x)) + h(x, phi(x)) phi'(x) = 0$ alakú.
  Legyen $F_0(x) := G(x, phi(x))$. A láncszabály szerint:
  $ F_0'(x) = partial_1 G(x, phi(x)) + partial_2 G(x, phi(x)) phi'(x) = g(x, phi(x)) + h(x, phi(x)) phi'(x) = 0. $
  Mivel $F_0'(x) = 0$, így $G(x, phi(x)) = c$ konstans.
  A $phi(tau) = xi$ feltételből $c = G(tau, xi)$.

  Az $F(x, y) := G(x, y) - G(tau, xi) = 0$ egyenletre alkalmazható az implicitfüggvény-tétel a $(tau, xi)$ pontban:
  1. $F(tau, xi) = 0$;
  2. $F in C^1$, mivel $partial_1 F = g$ és $partial_2 F = h$ folytonosak;
  3. $partial_2 F(tau, xi) = h(tau, xi) != 0$.

  Így létezik egyértelmű $phi$ implicitfüggvény, amelyre $phi(tau) = xi$ és
  $ phi'(x) = -(partial_1 G(x, phi(x))) / (partial_2 G(x, phi(x))) = -(g(x, phi(x))) / (h(x, phi(x))). $
])

#v(8pt)

#remarkbox("Young-tétel szerinti egzaktsági feltétel", [
  Ha $g, h in C^1(I times J)$, akkor (mivel az $I times J$ téglalap konvex, így csillagszerű) a $nabla G = (g, h)$ potenciál létezésének, azaz az egzaktságnak szükséges és elégséges feltétele a Young-tétel értelmében a vegyes parciális deriváltak egyenlősége:
  $ partial_2 g(x, y) = partial_1 h(x, y) quad ((x, y) in I times J). $
])

#v(10pt)

= Fizikai alkalmazás: a rakéta emelkedési idejének kiszámítása

Tekintsük a fizika egy klasszikus problémáját: egy függőlegesen fellőtt rakéta mozgását a nehézségi erő és a közegellenállás jelenlétében.

#defbox("A fizikai modell felállítása", [
  - $m > 0$: a rakéta tömege (állandónak tekintve az emelkedés során);
  - $v_0 > 0$: a kezdősebesség a $t = 0$ időpillanatban;
  - $alpha = g > 0$: a nehézségi gyorsulás;
  - $beta > 0$: a közegellenállási tényező (a közegellenállási erő a pillanatnyi sebesség négyzetével arányos: $F_k = -beta v^2$).

  Newton II. törvénye alapján a rakétára ható eredő erő $m v'(t)$:
  $ m v'(t) = -m alpha - beta v^2(t) quad (t in [0, T]). $

  Azt a $T > 0$ *emelkedési időt* keressük, amelyre a rakéta eléri a legmagasabb pontot, azaz $v(T) = 0$.
])

#v(8pt)

#theorembox("Tétel: A rakéta emelkedési ideje", [
  A fenti modellből származó szeparábilis Cauchy-feladat pontos megoldásaként a rakéta emelkedési ideje:
  $ T = sqrt(m / (alpha beta)) arctan(sqrt(beta / (m alpha)) v_0). $
])

#v(8pt)

#proofbox("A levezetés és kiszámítás lépései", [
  *1. A differenciálegyenlet átrendezése szeparábilis alakra:*
  $ v'(t) = -alpha (1 + beta / (m alpha) v^2(t)). $

  Ez egy $v'(t) = g(t) h(v(t))$ szeparábilis egyenlet, ahol $g(t) = -alpha$ és $h(v) = 1 + beta / (m alpha) v^2 > 0$.

  *2. A változók szétválasztása és integrálás:*
  $ (v'(t)) / (1 + beta / (m alpha) v^2(t)) = -alpha. $

  Integráljuk mindkét oldalt $t = 0$-tól $t = T$-ig, figyelembe véve a $v(0) = v_0$ és $v(T) = 0$ értékeket (helyettesítés a $v = v(t)$ változóra):
  $ integral_(v_0)^0 1 / (1 + beta / (m alpha) v^2) dif v = integral_0^T (-alpha) dif t. $

  *3. Az integrálok kiszámítása:*
  A jobb oldal integrálja: $-alpha T$.

  A bal oldal integrálásához használjuk az $(dif) / (dif x) arctan(c x) = c / (1 + c^2 x^2)$ képletet a $c = sqrt(beta / (m alpha))$ választással:
  $ integral 1 / (1 + c^2 v^2) dif v = 1 / c arctan(c v). $

  Behelyettesítve a határokat:
  $ [1 / c arctan(c v)]_(v_0)^0 = 0 - 1 / c arctan(c v_0) = -sqrt(m alpha / beta) arctan(sqrt(beta / (m alpha)) v_0). $

  *4. A $T$ emelkedési idő kifejezése:*
  A két oldal egyenlőségéből:
  $ -sqrt(m alpha / beta) arctan(sqrt(beta / (m alpha)) v_0) = -alpha T. $

  Osztva $-alpha$-val (és kihasználva, hogy $sqrt(m alpha / beta) / alpha = sqrt(m / (alpha beta))$):
  $ T = sqrt(m / (alpha beta)) arctan(sqrt(beta / (m alpha)) v_0). $
  Ezzel a tételt beláttuk. #h(1fr) $square$
])
