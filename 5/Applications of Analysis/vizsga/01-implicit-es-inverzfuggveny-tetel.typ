// Typst source document for Exam Topic 1
// Analízis Alkalmazásai - 1. Tétel
// "Az implicitfüggvény fogalma, kapcsolata a feltételes szélsőérték problémával és az inverzfüggvénnyel. Implicitfüggvény-tétel, inverzfüggvény-tétel (a bizonyítás vázlata)."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (1. Tétel)
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
    #text(weight: "bold")[1. Tétel:]
    _„Az implicitfüggvény fogalma, kapcsolata a feltételes szélsőérték problémával és az inverzfüggvénnyel. Implicitfüggvény-tétel, inverzfüggvény-tétel (a bizonyítás vázlata).”_
  ]
]

#v(15pt)

= Az implicitfüggvény fogalma és motivációja

A többváltozós analízisben gyakran találkozunk olyan egyenletekkel vagy egyenletrendszerekkel, amelyekben a változók nem explicit, $y = g(x)$ alakban vannak megadva, hanem egy összefüggésként:
$ F(x_1, dots, x_(n-m), y_1, dots, y_m) = 0 quad "vagy röviden" quad F(x, y) = 0 $
ahol $F: RR^(n-m) times RR^m -> RR^m$.

A kérdés az, hogy ez a $0$-ra rendezett egyenlet(rendszer) egy adott $(a, b)$ megoldáspont környezetében egyértelműen meghatároz-e egy $y = phi.alt(x)$ folytonos/differenciálható függvénykapcsolatot.

#defbox("Definíció: Implicitfüggvény")[
  Legyen $n, m in NN$, $2 <= n$ és $1 <= m < n$. Jelölje a térbeli pontokat $xi = (x, y) in RR^n$, ahol $x in RR^(n-m)$ és $y in RR^m$.

  Legyen $f: RR^(n-m) times RR^m -> RR^m$ egy függvény, és tételezzük fel, hogy az $(a, b) in "int"(D_f)$ pont zérushelye az $f$-nek, azaz:
  $ f(a, b) = 0. $

  Azt mondjuk, hogy az $f$ által az $(a, b)$ pont körül meghatározott *implicitfüggvény* létezik, ha létezik az $a in RR^(n-m)$ pontnak egy $K(a)$ környezete és a $b in RR^m$ pontnak egy $K(b)$ környezete úgy, hogy minden $x in K(a)$ esetén *egyértelműen létezik* olyan $y in K(b)$, amelyre:
  $ f(x, y) = 0. $

  Ekkor a $phi.alt(x) := y$ hozzárendeléssel értelmezett $phi.alt: K(a) -> K(b)$ függvényt az $f$ által $(a, b)$ körül meghatározott *implicitfüggvénynek* nevezzük. Ekkor:
  1. $phi.alt(a) = b$,
  2. $f(x, phi.alt(x)) = 0$ minden $x in K(a)$ esetén,
  3. A $K(a) times K(b)$ hengeren az $f(x, y) = 0$ egyenlet megoldáshalmaza pontosan a $phi.alt$ függvény grafikonja:
  $ (K(a) inter K(b)) inter \{ (x, y) in D_f : f(x, y) = 0 \} = "graf"(phi.alt). $
]

#v(8pt)

#remarkbox("Szemléltetés 2D-ben")[
  Kétváltozós esetben ($n = 2$, $m = 1$) tekintsük az egységkörvonal egyenletét:
  $ f(x, y) = x^2 + y^2 - 1 = 0. $
  - Az $(a, b) = (0, 1)$ felső pont körül $y$ kifejezhető: $phi.alt(x) = sqrt(1 - x^2)$ ($x in (-1, 1)$).
  - Az $(a, b) = (0, -1)$ alsó pont körül: $phi.alt(x) = -sqrt(1 - x^2)$.
  - A $(-1, 0)$ és $(1, 0)$ pontok körül viszont *nem létezik* $y = phi.alt(x)$ implicitfüggvény, mert ott a második változó szerinti parciális derivált $partial_2 f(plus.minus 1, 0) = 2 dot 0 = 0$.
]

#v(10pt)

= Kapcsolat a feltételes szélsőérték problémával

A feltételes szélsőérték-számítás célja az $f: RR^n -> RR$ célfüggvény lokális szélsőértékeinek meghatározása a $g(x) = 0$ ($g: RR^n -> RR^m$) feltétel mellett.

== A dimenziócsökkentés elve implicitfüggvénnyel
Ha a $g(x, y) = 0$ feltételrendszer kielégíti az implicitfüggvény-tétel feltételeit a $c = (a, b)$ feltételes szélsőértékhely körül, akkor az $y in RR^m$ változóvektor lokálisan kifejezhető az $x in RR^(n-m)$ független változóvektor függvényeként: $y = h(x)$.

Ekkor a feltételes szélsőérték feladat redukálható egy feltétel nélküli szélsőérték feladatra a lecsökkentett $n-m$ dimenziós $K(a)$ környezeten:
$ Phi(x) := f(x, h(x)) quad (x in K(a)). $

== A Lagrange-féle sokszorozók módszerének származtatása
Amennyiben $Phi$-nek az $a$ pontban lokális szélsőértéke van, a feltétel nélküli szükséges feltétel alapján $Phi'(a) = 0$.

A láncszabályt alkalmazva:
$ Phi'(a) = partial_1 f(a, b) + partial_2 f(a, b) dot h'(a) = 0. $

Az implicitfüggvény-tételből ismert $h'(a) = -[partial_2 g(a, b)]^(-1) partial_1 g(a, b)$ képletet behelyettesítve:
$ partial_1 f(a, b) - partial_2 f(a, b) dot [partial_2 g(a, b)]^(-1) partial_1 g(a, b) = 0. $

Vezessük be a $lambda in RR^m$ Lagrange-szorzó vektort az alábbiak szerint:
$ lambda := -partial_2 f(a, b) dot [partial_2 g(a, b)]^(-1) quad <==> quad lambda dot partial_2 g(a, b) + partial_2 f(a, b) = 0. $

Ezzel az első $n-m$ komponensre is teljesül:
$ partial_1 f(a, b) + lambda dot partial_1 g(a, b) = 0. $

Összefoglalva, az $F(x, y) := f(x, y) + sum_(k=1)^m lambda_k g_k(x, y)$ Lagrange-függvényre a gradiens eltűnik a $c = (a, b)$ pontban:
$ "grad" F(c) = 0. $
Ez az I. rendű szükséges feltétel elméleti háttere.

#v(10pt)

= Kapcsolat az inverzfüggvénnyel

Az implicitfüggvény-tétel és az inverzfüggvény-tétel mély kapcsolatban állnak egymással:

1. *Az inverzfüggvény mint implicitfüggvény:* \
   Legyen $f: RR^n -> RR^n$ lokálisan invertálandó függvény az $a$ pont körül, ahol $b = f(a)$. Vezessük be a kétváltozós segédfüggvényt:
   $ F(y, x) := f(x) - y = 0. $
   Amennyiben az $F(y, x) = 0$ egyenletre alkalmazzuk az implicitfüggvény-tételt az $(y, x) = (b, a)$ pontban, az $x$ változót kifejezve $y$ függvényeként megkapjuk a lokális inverzet: $x = h(y) = f^(-1)(y)$.
   A deriválási képletből:
   $ h'(b) = -[partial_x F(b, a)]^(-1) dot partial_y F(b, a) = -[f'(a)]^(-1) dot (-I) = [f'(a)]^(-1). $

2. *Az implicitfüggvény-tétel bizonyítása inverzfüggvénnyel:* \
   A klasszikus bizonyítás során az $f(x, y) = 0$ ($f: RR^(n-m) times RR^m -> RR^m$) egyenletből kiindulva megkonstruáljuk az $F(x, y) := (x, f(x, y))$ transzformációt ($RR^n -> RR^n$). Erre alkalmazva az inverzfüggvény-tételt kapjuk meg az implicitfüggvény létezését és tulajdonságait.

#v(10pt)

= Az Implicitfüggvény-tétel

#theorembox("1. Tétel: Implicitfüggvény-tétel")[
  Adott $n, m in NN$, $2 <= n$, $1 <= m < n$. Tekintsük az
  $ f: RR^(n-m) times RR^m -> RR^m $
  vektorfüggvényt. Tételezzük fel a következőket:
  1. $f in C^1$ (folytonosan differenciálható az értelmezési tartományán),
  2. Az $(a, b) in "int"(D_f)$ pontban $f(a, b) = 0$,
  3. A második változócsoport szerinti Jacobi-mátrix determinánsa nem nulla a pontban:
     $ det partial_2 f(a, b) != 0 quad ("ahol " partial_2 f(a, b) in RR^(m times m)). $

  Ekkor léteznek olyan $K(a) subset RR^(n-m)$ és $K(b) subset RR^m$ nyílt környezetek, hogy létezik az $f$ által az $(a, b)$ körül meghatározott *egyértelmű* $phi.alt: K(a) -> K(b)$ implicitfüggvény, amelyre:
  - $phi.alt(a) = b$,
  - $phi.alt in C^1(K(a))$ (folytonosan differenciálható),
  - a deriváltmátrixa minden $x in K(a)$ pontban a következő képlettel számítható:
    $ phi.alt'(x) = -[partial_2 f(x, phi.alt(x))]^(-1) dot partial_1 f(x, phi.alt(x)). $
]

#v(8pt)

#proofbox("A bizonyítás vázlata (Implicitfüggvény-tétel)")[
  *1. Lépés: Kiterjesztett függvény megkonstruálása* \
  Definiáljuk az $F: D_f -> RR^n$ segédfüggvényt:
  $ F(x, y) := (x, f(x, y)) quad (x in RR^(n-m), y in RR^m). $

  *2. Lépés: $F$ deriváltmátrixának szerkezete* \
  Nyilvánvalóan $F(a, b) = (a, 0)$. Mivel $f in C^1$, így $F in C^1$ is teljesül. Az $F$ Jacobi-mátrixa blokkmátrix alakban:
  $ F'(x, y) = mat(I_(n-m), Theta; partial_1 f(x, y), partial_2 f(x, y)) $
  ahol $I_(n-m)$ az $(n-m) times (n-m)$-es egységmátrix, $Theta$ a nullmátrix.
  A blokkmátrix determinánsa:
  $ det F'(a, b) = det I_(n-m) dot det partial_2 f(a, b) = det partial_2 f(a, b) != 0. $

  *3. Lépés: Az inverzfüggvény-tétel alkalmazása* \
  Mivel $F in C^1$ és $det F'(a, b) != 0$, az inverzfüggvény-tétel értelmében az $F$ leképezés az $(a, b)$ pont egy környezetében lokálisan invertálható. Jelölje $Phi = F^(-1)$ a lokális inverzet, amely az $(a, 0)$ pont egy környezetén van értelmezve, és $Phi in C^1$.

  *4. Lépés: Az implicitfüggvény előállítása* \
  A $Phi = (Phi_1, Phi_2)$ komponenseit tekintve, mivel $F(x, y) = (x, f(x, y)) = (u, v)$, ezért $u = x$, amiből $Phi_1(x, v) = x$.
  A második komponensben rögzítsük a második argumentumot $v = 0$-ra:
  $ phi.alt(x) := Phi_2(x, 0) quad (x in K(a)). $

  Ekkor $F(x, phi.alt(x)) = F(Phi(x, 0)) = (x, 0)$, amiből az $F$ definíciója alapján kapjuk:
  $ (x, f(x, phi.alt(x))) = (x, 0) ==> f(x, phi.alt(x)) = 0. $

  *5. Lépés: A derivált képletének levezetése* \
  Mivel $phi.alt in C^1$, az $f(x, phi.alt(x)) equiv 0$ azonosságot az $x$ változó szerint deriválva a láncszabállyal:
  $ partial_1 f(x, phi.alt(x)) + partial_2 f(x, phi.alt(x)) dot phi.alt'(x) = 0. $
  A $partial_2 f(x, phi.alt(x))$ mátrix invertálhatóságát kihasználva (ami a folytonosság miatt $a$ környezetében megmarad):
  $ phi.alt'(x) = -[partial_2 f(x, phi.alt(x))]^(-1) dot partial_1 f(x, phi.alt(x)). quad square.stroked $
]

#v(10pt)

= Az Inverzfüggvény-tétel

#theorembox("2. Tétel: Inverzfüggvény-tétel")[
  Legyen $n in NN$, $n >= 1$, és tekintsük az $f: RR^n -> RR^n$ vektorfüggvényt. Tételezzük fel, hogy:
  1. $f in C^1$ az $a in "int"(D_f)$ pont egy környezetében,
  2. az $a$-beli Jacobi-mátrix determinánsa nem nulla:
     $ det f'(a) != 0. $

  Ekkor:
  - Az $f$ függvény az $a$ pontban *lokálisan invertálható*, azaz létezik olyan $K(a) subset D_f$ nyílt környezet, hogy $f|_(K(a))$ injektív.
  - A $h := (f|_(K(a)))^(-1)$ lokális inverzfüggvény értelmezve van a $b = f(a)$ pont egy nyílt $D_h$ környezetén.
  - A $h$ lokális inverz folytonosan differenciálható ($h in C^1(D_h)$), és deriváltmátrixa minden $y in D_h$ helyen:
    $ h'(y) = [f'(h(y))]^(-1). $
    Különösen a $b = f(a)$ képpontban:
    $ h'(b) = [f'(a)]^(-1). $
]

#v(8pt)

#proofbox("A bizonyítás vázlata (Inverzfüggvény-tétel)")[
  *1. Lépés: Normalizálás (az általánosság megszorítása nélkül)* \
  A bizonyítás egyszerűsíthető, ha feltesszük, hogy $a = 0$, $f(a) = 0$ és $f'(0) = I$ (az egységmátrix). Ha ez nem állna fenn, áttérhetünk a $g(x) := [f'(a)]^(-1) (f(x + a) - f(a))$ transzformált függvényre.

  *2. Lépés: Fixpont-egyenlet felírása és kontrakció* \
  Rögzített $y in RR^n$ mellett keressük azt az $x$ vektort, amelyre $f(x) = y$. Ez ekvivalens az alábbi fixpont-egyenlettel:
  $ T_y (x) := x - f(x) + y = x. $

  A $T_y$ leképezés Jacobi-mátrixa: $T'_y (x) = I - f'(x)$.
  Mivel $f in C^1$ és $f'(0) = I$, így $T'_y (0) = 0$. A folytonosság miatt létezik egy $r > 0$ sugár, hogy a $K_r (0)$ zárt golyón $norm(T'_y (x)) <= 1/2$.
  A véges növekmények tétele miatt $T_y$ egy $q = 1/2$ együtthatójú *kontrakció* a $K_r (0)$ golyón.

  *3. Lépés: Banach-féle fixpont-tétel alkalmazása* \
  Mivel $T_y$ zárt golyót zárt golyóba képez le (elegendően kicsi $norm(y) < r/2$ esetén), a Banach-féle fixpont-tétel garantálja, hogy minden ilyen $y$ esetén egyértelműen létezik egyetlen $x = h(y) in K_r (0)$ fixpont, amelyre $f(x) = y$. Ez bizonyítja a lokális inverz $h = f^(-1)$ létezését és egyértelműségét.

  *4. Lépés: Lipschitz-tulajdonság és folytonosság* \
  A fixpont-tétel becsléséből következik, hogy $h$ kielégíti az alábbi Lipschitz-feltételt:
  $ norm(h(y_1) - h(y_2)) <= 2 norm(y_1 - y_2), $
  ami garantálja a $h$ lokális inverz folytonosságát.

  *5. Lépés: Differenciálhatóság és az inverz deriváltja* \
  Írjuk fel az $f$ megváltozását $x = h(y)$ és $a = h(b)$ körül:
  $ y - b = f(h(y)) - f(h(b)) = f'(a) (h(y) - h(b)) + omega(h(y) - h(b)) norm(h(y) - h(b)), $
  ahol $omega(u) -> 0$, ha $u -> 0$.
  Megszorozva mindkét oldalt $[f'(a)]^(-1)$-gyel és rendezve:
  $ h(y) - h(b) - [f'(a)]^(-1) (y - b) = -[f'(a)]^(-1) omega(h(y) - h(b)) norm(h(y) - h(b)). $
  Osztva $norm(y - b)$-vel, a jobb oldal $0$-hoz tart, mivel $norm(h(y) - h(b)) \/ norm(y - b) <= 2$ korlátos. Ez bizonyítja, hogy $h$ differenciálható $b$-ben, és:
  $ h'(b) = [f'(a)]^(-1). quad square.stroked $
]

#v(15pt)

#block(width: 100%, stroke: 0.5pt + rgb("2b5c8f"), inset: 10pt, radius: 4pt, fill: rgb("f4f7fa"))[
  #text(weight: "bold", fill: rgb("1b365d"))[Összefoglaló ellenőrző kérdések a felelethez:]
  + Mi az implicitfüggvény precíz definíciója? Milyen szerepet játszanak benne a nyílt környezetek?
  + Miért feltétel a $det partial_2 f(a, b) != 0$ az implicitfüggvény-tételben?
  + Hogyan vezethető le a Lagrange-szorzós szabály az implicitfüggvény-tételből?
  + Hogyan kapcsolódik össze az implicitfüggvény-tétel és az inverzfüggvény-tétel bizonyítása?
]
