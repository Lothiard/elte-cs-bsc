= Felszín és fluxus paraméterezett felületeken

== Paraméterezett felületek

Egy felületet azon túl, hogy egy függvény grafikonjaként el tudunk képzelni, paraméterezéssel is megadhatjuk: az $u, v$ változók minden lehetséges értékéhez egy térbeli pontot rendelünk. Ha
$
  Phi : [a, b] times [c, d] arrow RR^3
$
folytonos függvény, akkor beszélhetünk felületről:
$
  Phi(u, v) = (g_1(u, v), g_2(u, v), g_3(u, v)), " " (u, v) in [a, b] times [c, d]
$
Ebben az alakban sok mindent ki lehet számolni, amit korábban tanultunk, és olyan mennyiségeket is, amiket a korábbi alakban nem biztos, hogy ki tudtunk.

== Felületi normális és felszín

Az egyik ilyen mennyiség a felszín. A felszín elég fura lehet, nem biztos, hogy egyszerűen kifejezhető egy függvény grafikonjaként, de paraméteres alakban viszonylag egyszerűen kiszámolható.

A paraméterezés két parciális derivált függvénye két vektorértékű függvény:
$
  partial_u Phi(u, v) = (partial_u g_1, partial_u g_2, partial_u g_3)\
  partial_v Phi(u, v) = (partial_v g_1, partial_v g_2, partial_v g_3)
$

A *felületi normális* a felület minden pontjára egy rá merőleges (következetesen ugyanarra az oldalra mutató) vektort ad. Kiszámolható a vektoriális szorzattal:
$
  n_Phi (u, v) = partial_u Phi(u, v) times partial_v Phi(u, v) = mat(
    delim: "|",
    bold(i), bold(j), bold(k);
    partial_u g_1, partial_u g_2, partial_u g_3;
    partial_v g_1, partial_v g_2, partial_v g_3
  )
$
Ez annyit jelent, hogy az első koordináta egy $2 times 2$-es aldetermináns, a második koordináta a megfelelő aldetermináns mínusz egyszerese, a harmadik pedig a harmadik $2 times 2$-es rész aldeterminánsa:
$
  n_Phi (u, v) = (
    partial_u g_2 dot partial_v g_3 - partial_u g_3 dot partial_v g_2, " "
    partial_u g_3 dot partial_v g_1 - partial_u g_1 dot partial_v g_3, " "
    partial_u g_1 dot partial_v g_2 - partial_u g_2 dot partial_v g_1
  )
$

A felszínhez ennek a kettes normáját kell integrálni a paramétertartományon:
$
  A_Phi = integral.double_D norm(n_Phi (u, v))_2 dif u dif v = integral.double_D norm(partial_u Phi(u, v) times partial_v Phi(u, v))_2 dif u dif v
$

== Euler--Monge-féle paraméterezés (függvénygrafikonok)

Ha a felület egy $g$ folytonosan differenciálható függvény grafikonja:
$
  Phi(x, y) = (x, y, g(x, y)), " " (x, y) in I subset RR^2
$
akkor ezt a paraméterezést *Euler--Monge-féle paraméterezésnek* nevezzük. A parciális deriváltak:
$
  partial_x Phi(x, y) = (1, 0, partial_x g(x, y))\
  partial_y Phi(x, y) = (0, 1, partial_y g(x, y))
$
a felületi normális:
$
  n_Phi (x, y) = partial_x Phi times partial_y Phi = mat(
    delim: "|",
    bold(i), bold(j), bold(k);
    1, 0, partial_x g;
    0, 1, partial_y g
  ) = (-partial_x g, -partial_y g, 1)
$
a kettes normája:
$
  norm(n_Phi (x, y))_2 = sqrt((-partial_x g)^2 + (-partial_y g)^2 + 1^2) = sqrt(1 + (partial_x g)^2 + (partial_y g)^2)
$
így az Euler--Monge alakú felület felszíne:
$
  A = integral.double_I sqrt(1 + (partial_x g(x, y))^2 + (partial_y g(x, y))^2) dif x dif y
$

== Példák a felszínszámításra

=== 1. példa: $x^2 = 2y z$, $0 <= x <= 1$, $1 <= y <= 2$

Sokszor előfordul, hogy implicit alakban van megadva a felület:
$
  x^2 = 2y z, " " (0 <= x <= 1, " " 1 <= y <= 2)
$
Mivel $y >= 1 > 0$, ezért $2y$-nal le tudunk osztani:
$
  z = g(x, y) = x^2/(2y)
$
Ez közvetlen Euler--Monge-felület a $D = [0, 1] times [1, 2]$ téglalapon. A parciális deriváltak:
$
  partial_x g = (2x)/(2y) = x/y, " " partial_y g = x^2/2 dot (-1/y^2) = -x^2/(2y^2)
$
Behelyettesítve a felszínképletbe:
$
  A = integral_1^2 integral_0^1 sqrt(1 + (x/y)^2 + (-x^2/(2y^2))^2) dif x dif y = integral_1^2 integral_0^1 sqrt(1 + x^2/y^2 + x^4/(4y^4)) dif x dif y
$
A gyök alatt teljes négyzet áll:
$
  1 + x^2/y^2 + x^4/(4y^4) = (1 + x^2/(2y^2))^2
$
így a gyökvonás elvégezhető:
$
  A = integral_1^2 integral_0^1 (1 + x^2/(2y^2)) dif x dif y = integral_1^2 [x + x^3/(6y^2)]_(x=0)^(x=1) dif y = integral_1^2 1 + 1/(6y^2) dif y =\
  = [y - 1/(6y)]_1^2 = (2 - 1/12) - (1 - 1/6) = 1 - 1/12 + 2/12 = underline(underline(1 + 1/12 = 13/12))
$

=== 2. példa: $2z = 4 - x^2 - y^2$ forgásparaboloid palástja, $0 <= z <= 1$

$
  2z = 4 - x^2 - y^2 <==> z = 2 - (x^2 + y^2)/2, " " (0 <= z <= 1)
$
Ez egy lefelé nyíló forgásparaboloid; a $z = 0$ és $z = 1$ síkok közötti palást felszíne a kérdés. Síkmetszetek:
- $z = 0 arrow.double 0 = 2 - (x^2+y^2)/2 <==> x^2 + y^2 = 4$ (egy $r = 2$ sugarú kör az $x y$-síkon),
- $z = 1 arrow.double 1 = 2 - (x^2+y^2)/2 <==> x^2 + y^2 = 2$ (egy $r = sqrt(2)$ sugarú kör).

Tehát az $x y$-síkbeli vetület egy körgyűrű:
$
  D = {(x, y) in RR^2 : 2 <= x^2 + y^2 <= 4}
$
Áttérünk polárkoordinátákra:
$
  x = r cos(phi), " " y = r sin(phi), " " z = 2 - r^2/2, " ahol " r in [sqrt(2), 2], " " phi in [0, 2pi]
$
Euler--Monge alakban $g(x, y) = 2 - (x^2+y^2)/2$:
$
  partial_x g = -x, " " partial_y g = -y\
  sqrt(1 + (-x)^2 + (-y)^2) = sqrt(1 + x^2 + y^2) = sqrt(1 + r^2)
$
A felszín integrálja polártranszformációval (a Jacobi-szorzó $r$):
$
  A = integral_0^(2pi) integral_sqrt(2)^2 sqrt(1 + r^2) dot r dif r dif phi = 2pi integral_sqrt(2)^2 r sqrt(1 + r^2) dif r
$
A belső integrál az $u = 1 + r^2 arrow.double dif u = 2r dif r$ helyettesítéssel:
$
  integral r (1 + r^2)^(1/2) dif r = 1/2 dot ((1 + r^2)^(3/2))/(3/2) = 1/3 (1 + r^2)^(3/2)
$
$
  A = 2pi dot [1/3 (1 + r^2)^(3/2)]_sqrt(2)^2 = (2pi)/3 ((1 + 4)^(3/2) - (1 + 2)^(3/2)) = underline(underline((2pi)/3 (5 sqrt(5) - 3 sqrt(3))))
$

=== 3. példa: Viviani-féle levél felszíne

Számítsuk ki az $x^2 + y^2 + z^2 = R^2$ ($z >= 0$) félgömbfelületnek az $x^2 + y^2 - R x = 0$ hengerfelület által kimetszett részének felszínét!

*A geometria.* Van a félgömbfelület, és ezt elmetsszük a hengerfelülettel. Alakítsuk teljes négyzetté a henger egyenletét:
$
  x^2 - R x + y^2 = 0 <==> (x - R/2)^2 - R^2/4 + y^2 = 0 <==> (x - R/2)^2 + y^2 = (R/2)^2
$
Ez az $x y$-síkon egy $(R/2, 0)$ középpontú, $R/2$ sugarú körlemezt jelent, $z$ pedig tetszőleges. Tehát a hengeren belüli tartomány az $x y$-síkon:
$
  D = {(x, y) in RR^2 : x^2 + y^2 <= R x}
$

*A félgömb mint függvénygrafikon.*
$
  z = f(x, y) = sqrt(R^2 - x^2 - y^2)\
  partial_x f = (-2x)/(2 sqrt(R^2 - x^2 - y^2)) = (-x)/sqrt(R^2 - x^2 - y^2), " " partial_y f = (-y)/sqrt(R^2 - x^2 - y^2)
$

*A felszínelem.*
$
  sqrt(1 + (partial_x f)^2 + (partial_y f)^2) = sqrt(1 + x^2/(R^2 - x^2 - y^2) + y^2/(R^2 - x^2 - y^2)) = sqrt((R^2 - x^2 - y^2 + x^2 + y^2)/(R^2 - x^2 - y^2)) = R/sqrt(R^2 - x^2 - y^2)
$

*A polártartomány.* $x = r cos(phi)$, $y = r sin(phi)$:
$
  x^2 + y^2 <= R x <==> r^2 <= R r cos(phi) <==> r <= R cos(phi)
$
Mivel $r >= 0$, ehhez szükséges, hogy $cos(phi) >= 0$, vagyis $phi in [-pi/2, pi/2]$. Így a polárhatárok:
$
  -pi/2 <= phi <= pi/2, " " 0 <= r <= R cos(phi)
$

*Az integrál.*
$
  A = integral_(-pi/2)^(pi/2) integral_0^(R cos(phi)) R/sqrt(R^2 - r^2) dot r dif r dif phi
$
A belső $r$ szerinti integrál (az $u = R^2 - r^2 arrow.double dif u = -2r dif r$ helyettesítéssel):
$
  integral_0^(R cos(phi)) (R r)/sqrt(R^2 - r^2) dif r = [-R sqrt(R^2 - r^2)]_(r=0)^(r=R cos(phi)) = -R sqrt(R^2 - R^2 cos^2(phi)) + R sqrt(R^2) =\
  = R^2 - R dot R sqrt(sin^2(phi)) = R^2 (1 - |sin(phi)|)
$
Kihasználva az értelmezési tartomány szimmetriáját ($phi in [0, pi/2]$ esetén $|sin(phi)| = sin(phi)$):
$
  A = 2 integral_0^(pi/2) R^2 (1 - sin(phi)) dif phi = 2R^2 [phi + cos(phi)]_0^(pi/2) =\
  = 2R^2 ((pi/2 + 0) - (0 + 1)) = 2R^2 (pi/2 - 1) = underline(underline(R^2 (pi - 2)))
$

=== 4. példa: a tóruszfelület felszíne és a tórusztest térfogata

*Paraméterezés.* Vegyük az $x z$-síkon az $(x - R)^2 + z^2 = r^2$ ($0 < r < R$) egyenletű körvonalat, és forgassuk meg a $z$-tengely körül. Az $x z$-síkbeli alapkör paraméterezése $u in [0, 2pi]$ szöggel:
$
  x(u) = R + r cos(u), " " z(u) = r sin(u)
$
Ezt elforgatva a $z$-tengely körül $v in [0, 2pi]$ szöggel:
$
  Phi(u, v) = ((R + r cos(u)) cos(v), " " (R + r cos(u)) sin(v), " " r sin(u)), " " (u, v) in [0, 2pi] times [0, 2pi]
$

*Parciális deriváltak és felületi normális.*
$
  partial_u Phi = (-r sin(u) cos(v), " " -r sin(u) sin(v), " " r cos(u))\
  partial_v Phi = (-(R + r cos(u)) sin(v), " " (R + r cos(u)) cos(v), " " 0)
$
$
  n_Phi (u, v) = partial_u Phi times partial_v Phi = mat(
    delim: "|",
    bold(i), bold(j), bold(k);
    -r sin(u) cos(v), -r sin(u) sin(v), r cos(u);
    -(R + r cos(u)) sin(v), (R + r cos(u)) cos(v), 0
  )
$
$
  n_Phi (u, v) = (-r (R + r cos(u)) cos(u) cos(v), " " -r (R + r cos(u)) cos(u) sin(v), " " -r (R + r cos(u)) sin(u) (cos^2(v) + sin^2(v)))\
  = -r (R + r cos(u)) (cos(u) cos(v), " " cos(u) sin(v), " " sin(u))
$
A normálvektor kettes normája:
$
  norm(n_Phi (u, v))_2 = r (R + r cos(u)) sqrt(cos^2(u) cos^2(v) + cos^2(u) sin^2(v) + sin^2(u)) = r (R + r cos(u))
$

*A tórusz felszíne.*
$
  A = integral_0^(2pi) integral_0^(2pi) r (R + r cos(u)) dif u dif v = r integral_0^(2pi) [R u + r sin(u)]_0^(2pi) dif v =\
  = r integral_0^(2pi) 2pi R dif v = 2pi R r dot 2pi = underline(underline(4 pi^2 R r))
$

*Kiegészítés: a tórusztest térfogata.* Ha nemcsak a tórusz felületét, hanem a teljes tömör tórusztest térfogatát akarjuk kiszámolni, akkor a sugár $0$-tól $r$-ig változó $rho$ paraméter lesz:
$
  Psi(rho, u, v) = ((R + rho cos(u)) cos(v), " " (R + rho cos(u)) sin(v), " " rho sin(u)), " " rho in [0, r], " " u, v in [0, 2pi]
$
A Jacobi-mátrix determinánsának abszolút értéke:
$
  |"det " Psi'(rho, u, v)| = rho (R + rho cos(u))
$
A térfogat:
$
  V = integral_0^r integral_0^(2pi) integral_0^(2pi) rho (R + rho cos(u)) dif v dif u dif rho = 2pi integral_0^r integral_0^(2pi) (rho R + rho^2 cos(u)) dif u dif rho =\
  = 2pi integral_0^r 2pi rho R dif rho = 4pi^2 R [rho^2/2]_0^r = underline(underline(2 pi^2 R r^2))
$

== Vektormezők fluxusa paraméterezett felületeken

Még egy alkalmazása van a paraméterezésnek: a *fluxus* kiszámolása. Nem kell megijedni, hasonlóan a felszínhez, a fluxusra is igazából csak egy képlet van, egy integrál, amit ki kell számolni.

A fluxust úgy képzelhetjük el, hogy van egy vektormennyiségünk (erőtér, áramlási mező) $f : RR^3 arrow RR^3$, és ki van jelölve egy felület ebben a mezőben. A fluxus azt adja meg, hogy ezen a felületen keresztül összesen mekkora erőhatás vagy áramlási mennyiség halad át:
$
  "Fluxus" = integral.double_D chevron.l f(Phi(u, v)), " " n_Phi (u, v) chevron.r dif u dif v
$

=== 1. feladat

$
  f(x, y, z) = (y, x, z^2), " " F: z = x^2 + y^2 " " (0 <= z <= 1)
$
Felfelé mutató felületi normálissal. Euler--Monge-paraméterezéssel:
$
  Phi(x, y) = (x, y, x^2 + y^2), " ahol " D = {(x, y) : x^2 + y^2 <= 1}
$
A felületi normálvektor:
$
  n_Phi (x, y) = (-partial_x g, -partial_y g, 1) = (-2x, -2y, 1)
$
Mivel a harmadik komponens $+1 > 0$, ez a vektor valóban felfelé mutat. A vektormező behelyettesítése és a skaláris szorzat:
$
  f(Phi(x, y)) = (y, x, (x^2 + y^2)^2)\
  chevron.l f(Phi(x, y)), n_Phi (x, y) chevron.r = chevron.l (y, x, (x^2 + y^2)^2), (-2x, -2y, 1) chevron.r = -2x y - 2x y + (x^2 + y^2)^2 = -4x y + (x^2 + y^2)^2
$
Polárkoordinátákra áttérve ($x = r cos(phi)$, $y = r sin(phi)$, $r in [0, 1]$, $phi in [0, 2pi]$):
$
  "Fluxus" = integral_0^(2pi) integral_0^1 (-4 r^2 cos(phi) sin(phi) + r^4) dot r dif r dif phi = integral_0^(2pi) integral_0^1 (-4 r^3 cos(phi) sin(phi) + r^5) dif r dif phi
$
$
  integral_0^1 (-4 r^3 cos(phi) sin(phi) + r^5) dif r = [-r^4 cos(phi) sin(phi) + r^6/6]_0^1 = -cos(phi) sin(phi) + 1/6
$
$
  "Fluxus" = integral_0^(2pi) (-1/2 sin(2phi) + 1/6) dif phi = [1/4 cos(2phi) + phi/6]_0^(2pi) = 0 + (2pi)/6 = underline(underline(pi/3))
$

=== 2. feladat

$
  f(x, y, z) = (x, y, z), " " F: z = 1 - sqrt(x^2 + y^2) " " (0 <= z <= 1)
$
Kifelé (felfelé) mutató normálissal. A kúp polárkoordinátás paraméterezése:
$
  Phi(r, phi) = (r cos(phi), " " r sin(phi), " " 1 - r), " ahol " r in [0, 1], " " phi in [0, 2pi]
$
A parciális deriváltak és a normálvektor:
$
  partial_r Phi = (cos(phi), sin(phi), -1), " " partial_phi Phi = (-r sin(phi), r cos(phi), 0)
$
$
  n_Phi (r, phi) = partial_r Phi times partial_phi Phi = mat(
    delim: "|",
    bold(i), bold(j), bold(k);
    cos(phi), sin(phi), -1;
    -r sin(phi), r cos(phi), 0
  ) = (r cos(phi), " " r sin(phi), " " r)
$
Mivel $r >= 0$, a harmadik komponens $r >= 0$, így ez a felületi normális felfelé (kifelé) mutat. A vektormező behelyettesítése és a skaláris szorzás:
$
  f(Phi(r, phi)) = (r cos(phi), " " r sin(phi), " " 1 - r)\
  chevron.l f(Phi(r, phi)), n_Phi (r, phi) chevron.r = r^2 cos^2(phi) + r^2 sin^2(phi) + r (1 - r) = r^2 + r - r^2 = r
$
A fluxus:
$
  "Fluxus" = integral_0^(2pi) integral_0^1 r dif r dif phi = 2pi dot [r^2/2]_0^1 = 2pi dot 1/2 = underline(underline(pi))
$

=== 3. feladat

$
  f(x, y, z) = (z^2, x y, -3y^2), " " F: z = 4 - y^2 " " (0 <= x <= 1, " " |y| <= 2)
$
Euler--Monge-paraméterezéssel a $D = [0, 1] times [-2, 2]$ téglalapon:
$
  Phi(x, y) = (x, y, 4 - y^2)\
  partial_x Phi = (1, 0, 0), " " partial_y Phi = (0, 1, -2y)\
  n_Phi (x, y) = (0, 2y, 1)
$
(A harmadik komponens $+1$, tehát a normális felfelé mutat.) A vektormező behelyettesítése:
$
  f(Phi(x, y)) = ((4 - y^2)^2, " " x y, " " -3y^2)\
  chevron.l f(Phi(x, y)), n_Phi (x, y) chevron.r = chevron.l ((4 - y^2)^2, x y, -3y^2), (0, 2y, 1) chevron.r = 0 + 2x y^2 - 3y^2 = (2x - 3) y^2
$
Az integrál:
$
  "Fluxus" = integral_0^1 integral_(-2)^2 (2x - 3) y^2 dif y dif x = (integral_0^1 (2x - 3) dif x) dot (integral_(-2)^2 y^2 dif y)
$
$
  integral_0^1 (2x - 3) dif x = [x^2 - 3x]_0^1 = 1 - 3 = -2, " " integral_(-2)^2 y^2 dif y = [y^3/3]_(-2)^2 = 8/3 - (-8/3) = 16/3
$
$
  "Fluxus" = (-2) dot 16/3 = underline(underline(-32/3))
$
