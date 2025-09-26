== 1. oldjuk meg az $A x = b$ LER-t

$
  mat(
    2, 1, 3, 1, 1, 0, 0;
    4, 4, 7, 1, 0, 1, 0;
    2, 5, 9, 3, 0, 0, 1;
    augment: #3,
    delim: "["
  )
$

eloszor felso-/alsoharomszogre hozas a cel utana a ket helyettesites kozul az egyik helyettesites

fontos hogy az elso egyenletet valtozatlanul hagyjuk es nem csinalunk vele semmit es az elso egyenlettel fogunk eliminalni

eloadas jegyzetbol a nagyon ijeszto keplet magyarazza meg hogy itt most mit fogunk csinalni de vizualisan sokkal egyszerubb meg amugy sem muszaj megtanulni azt a nagy bullshitet

ha ezt megcsinaljuk elkeszul a felso haromszog

ekkor tudjuk hogy determinanstarto muveleteket vegeztunk eddig

innen a visszahelyettesitest ketfelekeppen lehet csinalunk

1.
  moge teszem a linearis egyenletresrndszert

  leoszotom az $a_(n n+1)$-et az $a_(n n)$-nel

2.
  ugyanugy sormuveletekkel dolgozik mint gauss eliminaicional

  addig csinalom meg egysegmatrix nem lesz

  fontos hogy itt az osztas a visszahelyettesitesben van es nem az eliminacional

#pagebreak()
= szamolas
== 1
az a) es d)-t egyszerre csinaljuk hogy gyorsabb legyen mert akkor csak egyszer kell elliminalni

=== a) + d)
(ugy invertalunk hogy melle teszunk egy egysegmatrixot)

kurvara nem szabad leosztani kettovel meg ilyenek azert mert ugy konnyebb szamolni type beat mert onnantol kezdve kuka az egesz

$
  mat(
    2, 3, 1, 1, 1, 0, 0;
    4, 4, 7, 1, 0, 1, 0;
    2, 5, 9, 1, 0, 0, 1;
    augment: #3,
  )
$

elso sor valtozatlan
masodik sor $- 2 dot$ elso sor
harmadik sor 1 elso sor

$
  mat(
    2, 3, 1, 1, 1, 0, 0;
    0, 2, 1, -1, -2, 1, 0;
    0, 4, 6, 2, -1, 0, 1;
    augment: #3,
  )
$

1 es 2 valtozatlan

3 sor $- 2 dot 2$ sor

$
  mat(
    2, 3, 1, 1, 1, 0, 0;
    0, 2, 1, -1, -2, 1, 0;
    0, 0, 4, 4, 3, -2, 1;
    augment: #3,
  )
$

itt megvan a felsoharomszog alak

ezek determinanstarto atalakitasok voltak ugye

$ det(A) = det(triangle) = 2 dot 2 dot 4 = 16 $

ha inverzzel dolgozunk nagyon latvanyos hogy az elso oszlopot nem kell szamolni optimalis esetben hanem cask nullakat rakunk, es megfigyeljuk akkor csak az $I$ valtozott.

tehat az algoritmust tekintve $n+1$-ig mentunk oszlopban mindig de valojaban inverznel $n + k$-ig megyunk csak.

masik dolog:

sok esetben egyseru kitalalni hogy mennyit kell kivonni, de machanikusan ezt ugy lehet kitalalni hogy lefele osztok le, ugy hogy (fontos elem) / (fontos elem alatt levo elem)

ket fele visszahelyettesites van

1. lehetoseg: az ijeszto kepletes (nem kell megtanulni hala istennek)

a jobb oldali vektorral fogjuk csinalni es kiolvassuk a matrixot egyenletresrndszerkent

$ 4x_3 = 4 arrow x_3 = 1 $
$ 2x_2 + x_3 = 2x_2 + 1 = -1 arrow x_2 = -1 $
$ 2x_1 + x_2 + 3x_3 = 2x_2 -1 + 3 = 1 arrow x_1 = -1/2 $

$
  mat(
    -1/2;
    -1;
    1;
  )
$

2. lehetsoeg: folyatjuk az eliminaciot

$
  mat(
    2, 3, 1, 1;
    0, 2, 1, -1;
    0, 0, 4, 4;
    augment: #3
  )
$

itt tablazatban dolgozok es visszafele eliminalok

alulrol felfele, a cel az hogy a bal oldalon egysegmatrix legyen. ugyanugy sormuveletekkel

$
  mat(
    2, 3, 1, 1, 1, 0, 0;
    0, 2, 1, -1, -2, 1, 0;
    0, 0, 1, 1, -3/4, -2/4, 1/4;
    augment: #3
  )
  arrow
  mat(
    2, 3, 1, 1, 1, 0, 0;
    0, 2, 0, -2, -11/4, 6/4, -1/4;
    0, 0, 1, 1, 3/4, -2/4, 1/4;
    augment: #3
  )
  arrow\
$

tortekkel azert latszik hogy nehezebb szamolni es tobb a hibalehetoseg, de erre van egy trukk

meg kell nezzem az elso sor hianyzo elemeit. a negy elemet kell kitoltsem, ugy hogy kiveszem az eredeti helyerol es felirom egyas ala es 

$
  1 - 3 dot 1 = -2\
  1 - 3 dot 3/4 = -5/4\
  0 - 3 dot (-2/4) = 6/4\
  0 - 3 dot 1/4 = -3/4\
$

es ezeket csak beirom

$
  arrow
  mat(
    2, 1, 0, -2, -5/4, 6/4, -3/4;
    0, 2, 0, -2, -11/4, 6/4, -1/4;
    0, 0, 1, 1, 3/4, -2/4, 1/4;
    augment: #3
  ) arrow
  mat(
    2, 0, 0, -1, 1/8, 6/8, -5/8;
    0, 1, 0, -1, -11/8, 6/8, -1/8;
    0, 0, 1, 1, 3/4, -2/4, 1/4;
    augment: #3
  ) arrow
$

mert

$
  -5/4 - (-11/8) = 1/8\
  6/4 - 6/8 = 6/8\
  -3/4 - (-1/8) = -5/8\
$
$
  mat(
    1, 0, 0, -1/2, 1/16, 6/16, -5/16;
    0, 1, 0, -1, -11/8, 6/8, -1/8;
    0, 0, 1, 1, 3/4, -2/4, 1/4;
    augment: #3
  )
$

ZH-nem kell leelenorizini, nem javasolt csak akkor ha mar minden massal keszen vagyunk. Az ido keves.

== b)
reszleges es teljes foemelem kivalasztas

ugye osztas problemas tud lenni es kicsi szammal nem szabad osztani

ge-n figyelni kell az osztasok stabilitasara

az elso hogy amin dolgozni fogok megnezem mi a legngyobb abszoluterteku elem es kicserelem

teljes csak annyibal kulonbozik hogy a teljes matrixot nezem nem csak sort

oszlopcsere valtoztat de sorcsere nem

elso lepes: elso oszlopban megkeresni a legnagyobb abszoluterteku elemet, ami itt $4$.

keruljon be az elso helyre, tehat 1. es 2. sor csere

$
  mat(
    2, 1, 3, 1;
    4, 4, 7, 1;
    2, 5, 9, 3;
    augment: #3
  ) arrow

  mat(
    4, 4, 7, 1;
    2, 1, 3, 1;
    2, 5, 9, 3;
    augment: #3
  )
$

most ge elso lepes

2. sor $- 1/2 dot$ 1.sor

$
  mat(
    4, 4, 7, 1;
    0, -1, -1/2, 1/2;
    2, 5, 9, 3;
    augment: #3
  )
$

3. sor $- 1/2 dot$ 1.sor

$
  mat(
    4, 4, 7, 1;
    0, -1, -1/2, 1/2;
    0, 3, 11/2, 5/2;
    augment: #3
  )
$

masodik lepes (mostmar csak a belso 2x2-t nezem)

memgint megkeresem a maxot

$
  mat(
    4, 4, 7, 1;
    0, 3, 11/2, 5/2;
    0, -1, -1/2, 1/2;
    augment: #3
  )
$

3. sor $+ 1/3 dot$ 2.sor

$
  mat(
    4, 4, 7, 1;
    0, 3, 11/2, 5/2;
    0, 0, 8/6, 8/6;
    augment: #3
  )
$

$ det(A) = 16 $

nem folytatjuk mert hell na hogy ezt csinalom

todo otthon gyakorlas

ha szimmetrikus a matrix szimmetrikus az inverz is

a ge bizonyos tulajdonsagokat megoriz, pl szimmetria

ebbol ra lehet jonni ha elrontjuk

== 2
ez egy kulonleges eset mert vagy vegtelen sok megoldas van vagy csak nincs megoldas, ezert numerikus szempontbol ez nem egy standard eset

$
  mat(
    1, -1, 2, 1, 3, 3;
    2, 3, 1, -1, 5, 5;
    3, 2, 3, 0, 8, 8;
    1, 4, -1, -2, 2, 0;
    augment: #4
  ) arrow
  mat(
    1, -1, 2, 1, 3, 3;
    0, 5, -3, -3, -1, -1;
    0, 5, -3, -3, -1, -1;
    0, 5, -3, -3, -1, -3;
    augment: #4
  ) arrow
  mat(
    1, -1, 2, 1, 3, 3;
    0, 5, -3, -3, -1, -1;
    0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, -2;
    augment: #4
  )
$

nem lehet tovabbmenni mert a belso 2x2-ben csak nullak vannak

- b2 eseten ellentmondasos $==>$ nincs megoldas
- b1 eseten $==>$ idk

