neztunk olyan peldakat ahol be kellett latni hogy a fuggveny folytonos vagy letezik hatererteke, de mi van akkor ha ezt tagadni kell?

Eddig a definiciot hasznaltuk, de a tagadasnal a definicio tagadasa nagyon bonyolult. Ilyenkor jon kepbe az atviteli elv.

Eleg mutassak egyetlen olyan sorozat letezeset amire igaz hogy a sorozat az $a$ ponthoz tart, de a fuggvenyertekek sorozata nem az $f(a)$-hoz tart.

Ilyenkor olyan sorozatokra kell gondolni amiben $x$ es $y$ kozott van valamilyen specialis osszefugges.

Olyanra gondolok hogy esetleg $x = 0$ es az y tart az origohoz, vagy forditva, vagy esetlet $x = y$.

/ pl:
$
  f(x, y) = cases(
    (2x y)/(x^2 + y^2)\, "  ha" (x, y) in RR^2 without {(0, 0)},
    0\, "        ha" (x, y) = (0, 0)
  )
$

gondoljuk vegig a lehetosegeket
+ ha $x = 0$: a szamlalo nulla $==>$ a fuggvenyertek is nulla $==>$ a hatarertek is nulla $==>$ nemjo
+ ha $y = 0$: ugyanaz mint $x = 0$
+ ha $x = y$:
$
  f(x, y) = f(x, x) = (2 x dot x)/(x^2 + x^2) = (2x^2)/(2x^2) = 1 "  " forall x in RR without {0}
$

ez ugy tunik mukodni fog mert ha veszunk egy sorozatot ezen az egyenesen ami az origohoz konvergal akkor a fuggvenyertekek sorozata is $1$-hez fog tartani.

egy ilyen sorozat:
$
  (x_n, y_n) = (1/n, 1/n) "  " (n in NN^+)
$

rola tudjuk hogy
$
  (x_n, y_n) = (1/n, 1/n) arrow (0, 0) " ha " n arrow +oo
$
de megis
$
  f(x_n, y_n) = 1 " " forall n in NN^+
$

az atvietli elv alapjan ez a fuggveny NEM folytonos az origoban

#pagebreak()
ez most jol ment mert gyorsan talaltunk ellenpeldat, de nyilvan nem mindig ilyen egyszeru a helyzet

/ pl:
$
  f(x, y) = cases(
    (x^2 y)/(x^4 + y^2)\, "  ha" (x, y) in RR^2 without {(0, 0)},
    0\, "        ha" (x, y) = (0, 0)
  )
$
lassuk be hogy $f in.not C{(0, 0)}$\ \

itt origon atmeno egyenesek nem fognak mukodni

ket felet vizsgalhatunk meredekseg szerint
- $x = 0$
$
  f(0, y) = cases(
    0/y^2\, "  ha" y != 0,
    0\, "    ha" y = 0
  )
$
a fuggveny erteke az $x = 0$ egyenes menten $0$ vagyis ennek a fuggvenynek a hatarerteke az origoban $0$ es hat ez nem jo

- $y = m x$
ezt is erdemes megtobb esetre bontani, pl
- - $m = 0$
ez az elozo esetnek a tukorkepe
$
  f(x, 0) = cases(
    0/x^4\, "  ha" x != 0,
    0\, "    ha" x = 0
  )
$

- - $m in RR without {0}$
$
  f(x, m x) = cases(
    (x^2 dot m x)/(x^4 + (m x)^2)\, "  ha" (x, m x) != (0, 0)\, " azaz " x != 0,
    0\, "            ha" x = 0
  ) =\
  = f(x, m x) = cases(
    (m x)/(x^2 + m^2)\, "  ha" x != 0,
    0\, "         ha" x = 0,
  )
$

de ha megnezzuk a hatarerteket
$
  lim_(x arrow 0) (m x)/(x^2 + m^2) = lim_(x arrow 0) 0/(m^2) = 0
$
beszoptuk tehat

igy belattuk hogy az osszes egyenesre folytonos fuggveny kapunk

az elozo alkalommal azert tudott mukodni a helyzet mert a polinom pont ugy egyszerusodott le hogy kaptunk egy nem nulla konstans erteket, es onnantol kezdve eleg trivialis volt az eredmeny

ebben az esetben amikor egyenest helyettesitettunk be akkor a szamlaloban lesz egy elso foku polinomunk, a nevezoben viszont lesz egy konstans tag ami nem nullahoz tart, es ez itt a problema

a szamlaloban $x$, a nevezoben $x^2$

ha ugy tudnank egyszerusiteni, hogy az osszes $x$-es tag kiessen, akkor nyernenk

tehat olyan $x$ vagy $y =$ valamiket kene vennem hogy utana ugy tudjak egyszerusiteni hogy kiessen az $x$

ebben az esetben az a kapcsolat $x$ es $y$ kozott hogy az $x$ fokszama ketszerese $y$ fokszamanak felul is alul is

tehat a nyero megmozdulas itt a $y = x^2$ helyettesites

$
  f(x, x^2) = (x^2 x^2)/(x^4 + x^4) = 1/2
$

ez meg is nyerte, mar csak egy sorozatot kell konstrualjak

annyira kell csak figyeljek hogy az $y = x^2$ gorben legyen
$
  (x_n, y_n) = (1/n, 1/n^2)
$

igy
$
  f(x_n, y_n) = 1/2 arrow.not 0
$
viszont
$
  (x_n, y_n) = (1/n, 1/n^2) arrow (0, 0)
$

#pagebreak()
hatarertekeknel egy kicsit mas a tema mert ott nem eleg hogy konstrualok egy sorozatot ami menten a fuggvenyertekek nem a fuggvenyertekhez tartanak. ez nem eleg mert a hatarertek fuggetlen a fuggvenyertektol

helyette az kell hogy mutassak ket darab sorozatot, hogy a ket sorozat ugyanahoz az $A$ ponthoz konvergal, de a fuggvenyertekek sorozata nem ugyanahoz konvergal, VAGY valamelyik hatarertek nem letezik

/ pl:
$
  f(x, y) = x^4/((x^2 + y^2)^2) "  " ((x, y) in RR^2 without {(0, 0)})
$
mutassuk be hogy nincs hatarerteke $(0,0)$-ban

latjuk hogy nincs is ertelmezve $(0,0)$-ban szoval nem tudok egy fuggvenyertekhez tartani vagy nem tartani a fuggvenyertekek sorozataval, hanem ugy fogom tudni ezt bizonyitani hogy konstrualok ket kulonbozo sorozatot amik az origohoz tartanak, de a fuggvenyertekek nem ugyanahoz az ertekhez tartanak

az elso sorozatot nem erdemes tulgondolni mert szinte lehet barmi, most gondolok egyet es azt mondom hogy nezzuk meg a hatarerteket az $x$ tengely menten

tehat $y = 0$
$
  (x_k, y_k) = (1/k, 0)
$
errol tudjuk hogy
$
  lim_(k arrow +oo) (x_k, y_k) = (0, 0)
$
es akkor
$
  lim_(k arrow +oo) f(x_k, y_k) = ((1/k)^4)/(((1/k)^2 + 0)^2) = 1
$

ezzel azt lattam be hogy ha lenne is hatarerteke az $f$ fuggvenynek, akkor az a hatarertek csak az $1$ lehetne

innentol mar adott a feladat: konstrualni kell megegy sorozatot ami mentem a fuggvenyertekek nem $1$-hez tartanak

ranezek a nevezore es latom hogy $x^2 + y^2$ kozott nincs nagy asszimetria tehat nem kell semmit trukkozzek, eleg ha csak mondok egy origon atmeno egyenest

most akar talalomra is mondhatom hogy
$
  (u_k, v_k) = (1/k, 1/k)\
  lim_(k arrow +oo) = f(u_k, v_k) = lim_(k arrow +oo) ((1/k)^2)/((1/k)^2 + (1/k)^2)^2 = 1/4
$
es akkor
$
  lim_(k arrow +oo) f(x_k, y_k) = 1 != 1/4 = lim_(k arrow +oo) f(u_k, v_k)
$

/ megyjegyzes:
eddig meg lehetett figyelni a feladatok mindig megmondtak hogy van hatarertek, nincs hatarertek, folytonos, nem folytonos, de az nem azt jelenti hogy ha ez nem lesz igy akkor meg vagyunk fozve

altalaban mukodo okolszabalynak lehet hasznalni azt hogy akkor fog letezni a hatarertek vagy a folyotonossag ha a szamlalo magasabb foku a nevezonel

ez azert van igy mert ha a szamlalo magasabb foku a nevezonel akkor arra szamitok hogy a szamlalot a normaval pl 5. hatvanyaval, a nevezot a norma negyzetevel tudom becsulni, akkor menni fog a bizonyitas mivel a $("norma magasabb hatvanya")/("norma alacsonyabb hatvanya")$ nullahoz tart, viszont akar mar ha a fokszamok egyenloek ez a bizonyitas nem mukodik

#pagebreak()
ennyit errol, most jojjenek a deriveltak

ebben a kontextusban haromfele derivaltrol beszelhetunk
1. parcialis derivaltak
az a lenyege hogy a valos derivaltat valami nagyon egyszeru elemi modon kiterjeszteni a tobbvaltozos esetre

/ pl:
$
  f(x, y) = (x^2 - y^3)/(x y) "  " (x, y > 0)
$
szamoljuk ki a parcialis derivaltakat
$
  delta_x ((x^2 - y^3)/(x y)) = delta_x (x/y - y^2/x) = delta_x (x/y) - delta_x (y^2/x) = 1/y delta_x (x) - y^2 delta_x (1/x) = 1/y - y^2 (-1/x^2) = underline(underline(1/y + y^2/x^2))
$
$
  delta_y ((x^2 - y^3)/(x y)) = delta_y (x/y) - delta_y (y^2/x) = x delta_y (1/y) - 1/x delta_y (y^2) = x (-1/(y^2)) - 1/x 2y = underline(underline(-x/y^2 - (2y)/x))
$

\ \ \
2. iranymenti derivalt
$a$ pontbran rogzitek egy $v$ iranyt ugy hogy rogzitek egy $1$ hosszu vektort, es azt csinalom hogy az $a + t v$ egyenes menten veszem a fuggvenyertekeket. technikailag ez egy egyvaltozos fuggvenyt ad

ez annyival nehezebb hogy nem tudjuk most fejbol derivalni mint ha a $t$ parameter valtozik akkor valtozni fog mind ket valtozo tehat emiatt ketfelekeppen tudjuk ezt megoldani
+ definicio szerint: felirjuk az iranymenti fuggvenyt es behelyettesitem a fuggvenyembe az $a + t v$-t es aztan $t$ szerint derivalok
+ (nem mindig alkalmazhato) ha a parcialis derivaltak az $a$ pont kornyezeteben leteznek es az $a$ pontban folytonosak akkor az iranymenti derivalt az a parcialis derivaltak linearis kombinacioja ugy hogy a megfelelo parcialis derivaltakat a $v$ vektor megfelelo komponensevel kell szorozni
/ pl: legyen
$
  f(x, y) = x^2 - x y + y^2 "  " ((x, y) in RR^2)
$
$a := (a_1, a_2) = (1, 1)$ es a $v$ az $x$ tengely pozitiv agaval $alpha$ szoget bezaro euklideszi normaban vett egysegvektor

/ fontos: ha azt mondom hogy $alpha$ szoget zar be a vektor az ugyanaz mint ha azt mondanam hogy $ v = (v_1, v_2) = (cos alpha, sin alpha) $

nezzuk eloszor a trukk alapjan:

szuksegunk van a parcialis derivaltakra, ennel a peldanal pont konnyuek
$
  delta_x (x^2 - x y + y^2) = 2x - y "      " delta_y (x^2 - x y + y^2) = -x + 2y
$
ez a ket fuggveny nyilvan folytonos, minden pontban leteznek, tudom alkalmazni a tanult tetelt

igy fog kinezni a tortenet
$
  delta_v f(a) = delta_x f(a) dot v_1 + delta_y f(a) dot v_2\
  delta_v f(1, 1) = delta_x f(1, 1) dot cos alpha + delta_y f(1, 1) dot sin alpha = underline(underline(cos alpha + sin alpha))
$

most meg nezzuk meg hogy ment volna ez definicio alapjan

a fuggvenyertekeket kene vegyem az $a + t v$ pontokban
$
  F_v (t) = f(a, t v) = f(a_1 + t v_1, a_2 + t v_2) = f(1 + t cos alpha, 1 + t sin alpha) =\ = (1 + t cos alpha)^2 - (1 + t cos alpha)(1 - t sin alpha) + (1 - t sin alpha)^2 =\ = (1 - (sin alpha)(cos alpha)) dot t^2 + (sin alpha + cos alpha) dot t + 1
$

ezt $t$ szerint kell derivaljam
$
  delta_v f(1, 1) = sin alpha + cos alpha
$

\ \
3. totalis derivalt
majd jovo oran
