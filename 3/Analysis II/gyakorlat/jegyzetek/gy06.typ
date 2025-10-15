5. gyakorlat anyaga a switchup miatt

== 1/1
$
  arcsin 1/2 = ?
$

megbeszeltuk hogy $sin$ periodikus ezert nem invertalhato ezert le kell szukiteni egy intervallumra

$
  arcsin := (sin_(|[-pi/2, pi/2])))^(-1)\
  arcsin x = y <==> sin y = x "  " (x in [-1, 1], " " y in [-pi/2, pi/2])
$

Tehat
$
  arcsin 1/2 = y in [-pi/2, pi/2] <==> sin y = 1/2 <==> (y = 30 degree) " " y = pi/6 
$

tudom hogy $y$ milyen inyervallumon van

$k$ helyett azt a $k$-t kell kivalasztani ami benne van az intervallumban

== 1/4
$
  arctan 1 = y
$

tg sem invertalhato, ezt is szukiteni kell

$
  arctan x = (tg_(|(-pi/2, pi/2)))^(-1)\
  arctan x = y <==> tg y = x\
  arctan x = 1 <==> tg 1 = x <==> (y = 45 degree) " " y = pi/4
$

most jon a lenyeg
= fuggveny diszkusszio
== 3. teljes fuggvenyvizsgalat
$
  f(x) := (x^2 + 1)/(x + 1)^2 "  " (x in RR \\ {-1})
$

=== 1. ertelmezesi tartomany

$
  D_f = (- infinity, -1 ) union (-1, +infinity)
$

- tengelymetyszesi pontokat vizsgaljunk, hol metszi a tengelyeket

#set math.cases(reverse: true)
$
    cases(
        y "tengelyt ott ahol " x = 0\, " ami" f(0) = 1,
        x "tengelyt a zerushelyeinel, olyanok nincsenek mert a szamlalo mindig pozitiv"
    ) ==> "a fv atmegy a (0,1) ponton"
$

=== 1/a. paros vagy paratlan a fuggveny?
kiszamolom az $f(-x)$-et es ha egyenlo az eredetivel akkor paros, ha $-1$-szerese akkor paratlan, ha egyik se akkor egyik se

ha egyik sem akkor meg sem emlitjuk, mint most

=== 1/b. periodicitas
trigonometrikus fuggvenyeknel k, itt fel sem merul

=== 2. f' es elojele (monotonitas es lokalis szelsoertek) 
$
  forall x in R \\ {-1} ==> f in D{a} "es"\
  f'(x) = (2x(x + 1)^2 - (x^2 + 1) dot 2 dot (x + 1)^1 dot 1)/((x+1)^4)
$

/ trukk: ha nevezoben hatvany nagyobb mint $1$, a derivalas soran az elso tagban megmarad a negyzet, kovetkezo lepesnel eggyel csokken, a nevezo negyediken lesz. ki tudunk emelni es egyszerusiteni es mindig ajanlott tenni ha ilyen van

$
  f'(x) = (2x(x + 1)^1 - (x^2 + 1) dot 2 dot 1)/((x+1)^3) = (2 (x^2 + x - x^2 - 1))/((x + 1)^3) = (2(x - 1))/((x + 1)^3) "  " forall x in R \\ {-1}
$

/ derivalt elojele:
kitol fugg? szamlaloja linearis, nevezo kob. Eleg az elojelet vegyem mert paratlan kitevo
ugyeskedes: tort elojele mitol fugg?
$
  "sign" a/b = "sign" a dot b "  ha" b != 0\
  "igy egyszerubb mert igy parabola lesz"
$

$
    "sign" f'(x) = "sign" ((x - 1)(x + 1)) "  " forall x in RR \\ {-1} = "sign" (x^2 - 1)
    // illik ilyenkor kis grafikon: -1, 1 gyokok, es pozitiv basic parabola
$

=== 3. f'' es elojele (konvxitas es inflexiok)
$
    forall x in RR \\ {-1} : f in D^2{x} "es" f''(x) = 2 dot (1 (x + 1)^2 - (x - 1) dot 3(x + 1)^2 dot 1)/((x + 1)^6)\
    f''(x) = 2 dot (x + 1 - 3x + 3)/((x + 1)^4) = 4 dot (2 - x)/((x + 1)^4)
$

/ elojele?:

ranezesre a nevezo pozitiv minden $-1$-tol kulonbozo $x$-re tehat $ +: forall x in D_f ==> "sign" f''(x) = "sign" (2 - x) $ // ide is egy grafikon. egy monoton csokkeno egyenes, ketto elott poz. 2ben 0, utana -

=== 4. hatarertek, aszimptota
egyenesek kozul megkeressuk ha van ugynevezett aszimptota\
olyan egyenes akinek vegtelenben vett limesze a fuggvenytol valo elteresben nulla
harom tipus van (ezen a targyon):
- vizsszintes (ha vegtelenben veges hatarerteke van)
- fuggoleges (ha vegesben vegtelen hatarerteke van)
- "ferde" (lehetseges ha nem letezik a feletti ketto)

azert is intervallumosan irtuk fel az elejen a $D_f$-et mert jobban latszik hol kell szamolni hatarerteket

$
    lim_(x arrow plus.minus infinity) (x^2 + 1)/((x + 1)^2) = (+infinity)/(+infinity) = L'H = lim_(x arrow plus.minus infinity) (2x)/(2(x + 1) dot 1) = (+infinity)/(+infinity) = lim_(x arrow plus.minus infinity) (1/1) = 1
$

mit jelent az hogy a hatarertek vegtelenben $1$? van neki egy vizsintes aszimptotaja

valahanyszor vegtelenben veges eredmenyt kapsz azt jelenti hogy $y = 1$ egyenletu egyenes vizszintes aszimptota mindket iranyba $plus.minus infinity$

$
    lim_(x arrow - 1) (x^2 + 1)/((x+1)^2) = 2/(plus.minus 0)^2 = 2/(+0) = +infinity
$

veges helyen vegtelen hatarertek $==>$ fuggoleges aszimptota $==> x = -1$ egyenes fuggveny aszimptota

=== 5. tablazat

$
  #table(
    columns: 8,
    [$x$],[$-infinity < x < -1$],[$-1$],[$-1 < x < 1$],[$1$],[$1 < x < 2$],[$2$],[$+infinity$],
    [$f'(x)$],[$+$],[$$],[$-$],[$0$],[$+$],[$$],[$+$],
    [$f(x)$],[$arrow.t$],[$$],[$arrow.b$],[lok.min $1/2$],[$arrow.t$],[inflexio $5/9$],[$arrow.t$],
    [$f''(x)$],[$union$],[$$],[$union$],[$$],[$inter$],[$0$],[$inter$],
  )
$

$
  f(1) = 1/2
$

abrazolasnal megnezem mekkora legyen a grafikon a tablazat alapjan. eloszor az aszimptotakat nezem, itt van egy fuggoleges es vizszintes, ezeket szaggatottal erdemes rajzolni. erdemes rairni a vonalakra melyik melyik

tudom hogy $1$-tol vegtelenbe megy konvex modon azt csak egyfelekeppen lehet

tudom hogy $1$-nel $1/2$-et vesz fel, latom hogy $1$-ben $0$ a derivalt, rajzolok egy kis vizszintes erintot. tudom hogy egynel metszi az $y$-t es ezt a harom dolgot osszevonva tudom ez is hogy nez ki kettoig

kettonel tudni kell mit vesz fel. az $5/9$-t.

kettonel gorbuletet valt es konkav modon tart az aszimptotahoz

a vegen azert irjuk ra a nevet, jeloljuk hogy van inflexio es jeloljuk a globalis es lokalis helyeket

zarasnak ertekkeszlet lehet meg erdekes, itt $[1/2, + infinity)$

== 4.
$
  f(x) := x dot ln^2 x "  " (x > 0)
$

=== 1.
$
    D_f in (0, +infinity), " " exists.not f(0); " " 0 in.not D_f; " " f(x) = 0 <==> x = 1
$

$(0,1)$ pont rajta van a grafikonon

csomo mindenrol szo sincs amiatt hogy $x$-ben ertelmes de $-x$-ben nem. Ezek paritas, pariodikussag, stb

=== 2.
$
    f'(x) = 1 ln^2 x + x dot 2 ln x dot 1/x = ln^2 + 2 ln x = ln x (ln x + 2) "  " (forall x > 0);\ f'(x) = 0 <==> ln x = 0 or ln x = -2 <==> x_1 = 1 or x_2 = e^(-2) = 1/(e^2);\ "opcionalis: ha" a = ln x ==> a(a + 2) = y(a) <==> // parabola grafikon
$

$
    <==> ln x < -2 or ln x > 0 " ez azt jelenti hogy "\ exp(ln x) < exp(-2) or exp(ln x) > exp(0) <==> x < e^2 = 1/(e^2) or x > 1 <==> f'(x) > 0
$

tudom hol $0$, tudom hol $+$, ezert a maradek helyen $-$, igy ezzel nem kell foglalkozni

=== 3.
$
    f''(x) = (ln^2 x + 2 ln x)' = 2 ln x dot 1/x + 2 dot 1/x = (2 (ln x + 1))/(x) "  " (forall x in (0, +infinity))
$

elojel: a nevezo itt is mindig pozitiv, ezert 
$
    "sign" f''(x) = "sign"(ln x + 1) "  " (forall x > 0)
$

Tehat

$
    ln x + 1 = 0 <==> ln x = -1 <==> x in e^(-1) = 1/e\
    ln x + 1 > 0 <==> ln x > -1 <==> exp " szig mon miatt " <==> exp(ln x) > exp(-1) <==> x > e^(-1) = 1/e\
    ln x + 1 < 0 <==> 0 < x < 1/e
$

4. hatarertek, aszimptotak
hol kell szamolnunk limeszt? $0 " es " +infinity$

$
    lim_(x arrow +infinity) (x ln^2 x) = +infinity dot (+infinity)^2 ==> "vegtelenben vegtelen nincs vizszintes aszimptota"\ "kerdes hogy van-e ferde aszimptota"\ "(nincs olyan vizsintes egyenes amihez tartana, de ekkor lehet ferde, ketto egyszerre lehetelen)"
$

hogyan keresunk ferdet?

$
    a := lim_(x arrow +infinity) (f(x))/x = lim_(x arrow +infinity) (x ln^2 x)/x = lim_(x arrow +infinity) (ln^2 x) = +infinity in.not RR ==> "nincs ferde aszimptota sem. a kereses leall"
$


lehet azert van parabolikus aszimptotaja de azt mi nem keressuk itt

$
    lim_(x arrow 0+) (x ln^2 x) = 0 dot (+infinity) = lim_(x arrow 0+) (ln^2 x)/(1/x) = (+infinity)/(+infinity) = L'H = lim_(x arrow 0+) (2 ln x dot 1/x)/(-1/x^2) = 2 lim_(x arrow 0+) (+infinity)/(+infinity) = 2 lim_(x arrow 0+) (1/x)/(1/x^2) = 2 lim_(x arrow 0+) x = 0
$

$
  #table(
    columns: 9,
    [$x$],[$0$],[$$],[$1/e^2$],[$$],[$1/e$],[$$],[$1$],[$+infinity$],
    [$f'(x)$],[x],[$+$],[$0$],[$-$],[$-$],[$-$],[$0$],[$+$],
    [$f(x)$],[x],[fel],[$4/e^2$],[le],[le],[le],[0],[fel],
    [$f''(x)$],[x],[$-$],[$-$],[$-$],[$0$],[$+$],[$+$],[$+$],
    [konv],[x],[$inter$],[$inter$],[$inter$],[$infinity$],[$union$],[$union$],[$union$]
  )
$
// grafikon meg ertekkeszlet a vegere

hf:
    elmelet tovabb\
    1, 2, 3, 4

