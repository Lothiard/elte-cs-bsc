// Typst source document for Exam Topic 10
// Analízis Alkalmazásai - 10. Tétel
// "Partikuláris megoldás kvázi-polinom jobb oldal esetén (a bizonyítás vázlata). A csillapítás nélküli kényszerrezgés vizsgálata, rezonancia."

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(120), style: "italic")[
      Analízis Alkalmazásai — Kidolgozott tételsor (10. Tétel)
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
    #text(weight: "bold")[10. Tétel:]
    _„Partikuláris megoldás kvázi-polinom jobb oldal esetén (a bizonyítás vázlata). A csillapítás nélküli kényszerrezgés vizsgálata, rezonancia.”_
  ]
]

#v(15pt)

= A kvázi-polinom jobb oldal és a rezonancia-szám fogalma

Az állandó együtthatós, $n$-edrendű inhomogén lineáris differenciálegyenletek alkalmazásaiban gyakran fordulnak elő olyan jobb oldali függvények, amelyek exponenciális, polinomiális és trigonometrikus függvények szorzataiból állnak.

#defbox("Definíció: kvázi-polinom", [
  Az $L(y) = y^((n)) + a_(n-1) y^((n-1)) + dots + a_1 y' + a_0 y = c(x)$ inhomogén lineáris differenciálegyenlet jobb oldalát *kvázi-polinomnak* nevezzük, ha
  $ c(x) = e^(alpha x) [P_m (x) cos(beta x) + Q_k (x) sin(beta x)] $
  alakú, ahol $alpha, beta in bb(R)$, $P_m$ egy $m$-edfokú, $Q_k$ pedig egy $k$-adfokú valós polinom ($m, k in bb(N)_0$).

  A kvázi-polinomhoz tartozó *gerjesztési komplex szám*:
  $ mu := alpha + i beta in bb(C). $
])

#v(8pt)

A komplex exponenciális ($e^(i beta x) = cos(beta x) + i sin(beta x)$) segítségével a kvázi-polinom egyetlen komplex kvázi-polinom valós részeként írható:
$ c(x) = Re(e^(mu x) T_N (x)), quad T_N (x) := P_m (x) - i Q_k (x), $
ahol $N = max(m, k)$, és $T_N$ legfeljebb $N$-edfokú komplex polinom. (Valóban, $Re((P - i Q)(cos + i sin)) = P cos + Q sin$.)

#v(8pt)

#defbox("Definíció: rezonancia-szám (multiplicitás)", [
  Legyen $P(lambda) = lambda^n + a_(n-1) lambda^(n-1) + dots + a_1 lambda + a_0$ az $L(y) = 0$ homogén egyenlet karakterisztikus polinomja.

  A kvázi-polinom jobb oldalhoz tartozó $s in bb(N)_0$ *rezonancia-szám* a $mu = alpha + i beta$ szám multiplicitása a $P(lambda) = 0$ karakterisztikus egyenletben:
  - ha $P(mu) != 0$, akkor $s = 0$ (nincs rezonancia);
  - ha $P(mu) = 0$, akkor $s >= 1$ a $mu$ gyök multiplicitása (rezonancia áll fenn).
])

#v(10pt)

= A határozatlan együtthatók módszere

#theorembox("Tétel: partikuláris megoldás alakja kvázi-polinom jobb oldal esetén", [
  Tekintsük az $L(y) = c(x)$ inhomogén lineáris differenciálegyenletet, ahol $c(x) = e^(alpha x) [P_m (x) cos(beta x) + Q_k (x) sin(beta x)]$.

  Legyen $N = max(m, k)$, és legyen $s >= 0$ a $mu = alpha + i beta$ szám multiplicitása a karakterisztikus egyenletben. Ekkor az egyenletnek létezik olyan $y_p$ partikuláris megoldása, amely
  $ y_p (x) = x^s e^(alpha x) [R_N (x) cos(beta x) + S_N (x) sin(beta x)] $
  alakú, ahol $R_N$ és $S_N$ ismeretlen, legfeljebb $N$-edfokú valós polinomok:
  $ R_N (x) = A_N x^N + A_(N-1) x^(N-1) + dots + A_1 x + A_0, $
  $ S_N (x) = B_N x^N + B_(N-1) x^(N-1) + dots + B_1 x + B_0. $

  Az $A_0, dots, A_N$ és $B_0, dots, B_N$ együtthatók az $L(y_p) = c$ egyenletbe való behelyettesítéssel és az azonos hatványok együtthatóinak összehasonlításával meghatározhatók.
])

#v(10pt)

= A tétel bizonyításának vázlata

A bizonyítás a differenciáloperátor algebrai tulajdonságain és az *eltolási tételen* alapul.

#proofbox("A bizonyítás vázlata", [
  1. *Operátoros felírás és komplexifikáció.* \
    Az $L = P(D)$ operátor, ahol $D = (dif) / (dif x)$. Elég a komplex $c_C (x) = e^(mu x) T_N (x)$ jobb oldalt vizsgálni, mert ha $P(D) y_C = c_C$, akkor $L$ valós együtthatói miatt $y_p := Re(y_C)$ megoldja az $L(y) = Re(c_C) = c$ egyenletet. Az egyenlet tehát:
    $ P(D) y_C (x) = e^(mu x) T_N (x). $

  2. *Az eltolási tétel.* \
    Tetszőleges, elegendően sima $g$ függvényre és $mu in bb(C)$-re:
    $ P(D) (e^(mu x) g(x)) = e^(mu x) P(D + mu I) g(x). $

  3. *A karakterisztikus polinom faktorizációja.* \
    Mivel $mu$ a $P$ $s$-szeres gyöke, $P(lambda) = (lambda - mu)^s Q(lambda)$ alakú, ahol $Q(mu) != 0$. Ezért
    $ P(D + mu I) = ((D + mu I) - mu I)^s Q(D + mu I) = D^s Q(D + mu I). $

  4. *A megoldás keresése.* \
    Keressük $y_C (x) = e^(mu x) v(x)$ alakban. Az eltolási tétellel és $e^(mu x) != 0$ miatt:
    $ D^s Q(D + mu I) v(x) = T_N (x). $

  5. *Megoldás polinomok között.* \
    A $Q(D + mu I)$ operátor polinomokon hat, konstans tagja $Q(mu) != 0$, így $Q(D + mu I) = Q(mu)(I + "nilpotens")$, ami a polinomok terén invertálható és a fokszámot megőrzi. Legyen $w$ az az $N$-edfokú polinom, amelyre $Q(D + mu I) w = T_N$. Legyen $v$ a $w$ $s$-szeres primitívje nulla integrálási konstansokkal, azaz $D^s v = w$ és $v(0) = dots = v^((s-1))(0) = 0$. Ekkor $v (x) = x^s U_N (x)$ alkalmas, legfeljebb $N$-edfokú $U_N$ polinommal. Mivel $D^s$ és $Q(D + mu I)$ felcserélhető:
    $ D^s Q(D + mu I) v = Q(D + mu I) D^s v = Q(D + mu I) w = T_N. $

  6. *Következtetés.* \
    Tehát $y_C (x) = x^s e^(mu x) U_N (x)$, és ennek valós része, $y_p = Re(y_C)$, éppen a tételbeli $x^s e^(alpha x) [R_N cos(beta x) + S_N sin(beta x)]$ alakú (az $U_N = R_N^* + i S_N^*$ felbontással $R_N = R_N^*$, $S_N = -S_N^*$). $square$
])

#v(10pt)

= A csillapítás nélküli kényszerrezgés vizsgálata

A tömegpont csillapítás nélküli, harmonikusan gerjesztett rezgését az alábbi másodrendű állandó együtthatós inhomogén lineáris egyenlet írja le:

#defbox("A kényszerrezgés differenciálegyenlete", [
  $ m x'' + k x = F_0 cos(omega t), $
  ahol:
  - $m > 0$: a rezgő test tömege,
  - $k > 0$: a rugóállandó,
  - $F_0 > 0$: a külső gerjesztőerő amplitúdója,
  - $omega > 0$: a külső gerjesztőerő körfrekvenciája.
])

#v(8pt)

Átosztva $m$-mel, bevezetjük a sajátkörfrekvenciát és a fajlagos erőt:
$ omega_0 := sqrt(k / m) > 0 quad "(sajátkörfrekvencia)", quad f_0 := F_0 / m. $

Ezzel az egyenlet:
$ x'' + omega_0^2 x = f_0 cos(omega t). $

== A homogén egyenlet megoldása (szabadrezgés)

A homogén egyenlet: $x'' + omega_0^2 x = 0$.
- Karakterisztikus egyenlet: $lambda^2 + omega_0^2 = 0$, azaz $lambda_(1,2) = plus.minus i omega_0$.
- A homogén egyenlet általános megoldása:
  $ x_h (t) = C_1 cos(omega_0 t) + C_2 sin(omega_0 t). $

== A gerjesztőfüggvény és a rezonancia-szám

A jobb oldal $c(t) = f_0 cos(omega t)$, így $mu = i omega$ ($alpha = 0$, $beta = omega$, $N = 0$). A karakterisztikus gyökök $plus.minus i omega_0$. Két lényegesen eltérő esetet kell megkülönböztetnünk.

#v(10pt)

= A két fizikai eset elemzése

== Nincs rezonancia ($omega != omega_0$)

Ha $omega != omega_0$, akkor $mu = i omega$ nem gyöke a karakterisztikus egyenletnek (mert $omega, omega_0 > 0$), tehát a rezonancia-szám $s = 0$.

- *Próbafüggvény* ($s = 0$):
  $ x_p (t) = A cos(omega t) + B sin(omega t). $
- *Deriváltak:*
  $ x'_p (t) = -A omega sin(omega t) + B omega cos(omega t), $
  $ x''_p (t) = -A omega^2 cos(omega t) - B omega^2 sin(omega t). $
- *Behelyettesítés az egyenletbe:*
  $ (omega_0^2 - omega^2) A cos(omega t) + (omega_0^2 - omega^2) B sin(omega t) = f_0 cos(omega t). $
- *Együtthatók azonosítása:*
  $ (omega_0^2 - omega^2) A = f_0 quad ==> quad A = f_0 / (omega_0^2 - omega^2), $
  $ (omega_0^2 - omega^2) B = 0 quad ==> quad B = 0. $
- *Általános megoldás* ($omega != omega_0$):
  $ x(t) = C_1 cos(omega_0 t) + C_2 sin(omega_0 t) + f_0 / (omega_0^2 - omega^2) cos(omega t). $

#v(8pt)

#remarkbox("Fizikai jelenség: lebegés", [
  Ha a rendszert nyugalmi állapotból indítjuk ($x(0) = 0$, $x'(0) = 0$), akkor $C_1 = -f_0 / (omega_0^2 - omega^2)$ és $C_2 = 0$, így
  $
    x(t) = f_0 / (omega_0^2 - omega^2) (cos(omega t) - cos(omega_0 t)) = (2 f_0) / (omega_0^2 - omega^2) sin((omega_0 - omega) / 2 t) sin((omega_0 + omega) / 2 t).
  $
  Ha $omega approx omega_0$, ez egy gyors rezgés (körfrekvencia $(omega_0 + omega) / 2$), amelynek amplitúdója lassan változik, a $sin((omega_0 - omega) / 2 t)$ burkológörbe szerint. Ezt nevezzük *lebegésnek*.
])

#v(8pt)

#line(length: 100%, stroke: 0.5pt + luma(180))

== Rezonancia ($omega = omega_0$)

Ha $omega = omega_0$, akkor $mu = i omega_0$ egyszeres gyöke a karakterisztikus egyenletnek, tehát a rezonancia-szám $s = 1$.

- *Próbafüggvény* ($s = 1$):
  $ x_p (t) = t [A cos(omega_0 t) + B sin(omega_0 t)]. $
- *Deriváltak:*
  $ x'_p (t) = A cos(omega_0 t) + B sin(omega_0 t) + t [-A omega_0 sin(omega_0 t) + B omega_0 cos(omega_0 t)], $
  $
    x''_p (t) = -2 A omega_0 sin(omega_0 t) + 2 B omega_0 cos(omega_0 t) + t [-A omega_0^2 cos(omega_0 t) - B omega_0^2 sin(omega_0 t)].
  $
- *Behelyettesítés az $x'' + omega_0^2 x = f_0 cos(omega_0 t)$ egyenletbe:* \
  A $t$-vel arányos tagok kiejtik egymást:
  $ -2 A omega_0 sin(omega_0 t) + 2 B omega_0 cos(omega_0 t) = f_0 cos(omega_0 t). $
- *Együtthatók azonosítása:*
  $ -2 A omega_0 = 0 quad ==> quad A = 0, $
  $ 2 B omega_0 = f_0 quad ==> quad B = f_0 / (2 omega_0). $
- *A rezonanciás partikuláris megoldás:*
  $ x_p (t) = f_0 / (2 omega_0) t sin(omega_0 t). $
- *Általános megoldás rezonancia esetén:*
  $ x(t) = C_1 cos(omega_0 t) + C_2 sin(omega_0 t) + f_0 / (2 omega_0) t sin(omega_0 t). $

#v(8pt)

#theorembox("Következmény: korlátlanul növekvő amplitúdó", [
  Rezonancia esetén a partikuláris megoldásban megjelenő $t$ szorzótényező miatt a rezgés *amplitúdója lineárisan nő*: az amplitúdó $f_0 t / (2 omega_0)$, ezért
  $ limsup_(t -> oo) abs(x(t)) = oo. $
  (A kitérés $sin(omega_0 t)$ szerint ingadozik, ezért $abs(x(t))$ nem tart monoton végtelenhez, de a maximumai minden határon túl nőnek.) Csillapítás hiányában a modell szerint a kitérés korlátlanul nő, ami a valóságban a szerkezet töréséhez, *rezonanciakatasztrófához* vezethet.
])

#v(10pt)

= Összefoglaló táblázat a két esetről

#align(center)[
  #table(
    columns: (3cm, 4.5cm, 4.5cm, 3.5cm),
    inset: 8pt,
    align: center + horizon,
    fill: (x, y) => if y == 0 { rgb("e6ecf2") } else if calc.even(y) { rgb("f9fbfd") } else { none },
    stroke: 0.5pt + luma(150),
    [*Jellemző*], [*Nincs rezonancia ($omega != omega_0$)*], [*Rezonancia ($omega = omega_0$)*], [*Fizikai tartalom*],
    [*Rezonancia-szám ($s$)*], [$s = 0$], [$s = 1$], [gyökmultiplicitás],
    [*Próbafüggvény alakja*],
    [$A cos(omega t) + B sin(omega t)$],
    [$t (A cos(omega_0 t) + B sin(omega_0 t))$],
    [az $x^s$ szorzó hatása],

    [*Partikuláris megoldás*],
    [$f_0 / (omega_0^2 - omega^2) cos(omega t)$],
    [$f_0 / (2 omega_0) t sin(omega_0 t)$],
    [kitérés],

    [*Amplitúdó viselkedése*], [korlátos (állandó)], [korlátlan ($prop t$)], [katasztrófa veszélye],
    [*Tipikus jelenség*], [lebegés (ha $omega approx omega_0$)], [rezonanciakatasztrófa], [szerkezeti válasz],
  )
]
