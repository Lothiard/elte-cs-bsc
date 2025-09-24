elso gyak vegen volt valami amit kihagytunk szoval most az jon sajnos szerencsere

== 2/i
$
    f(x) := (x+2)/(x^2-9) "    " (x in RR \\ {plus.minus 3}, a := -1),
$

$
limits(lim)_(x arrow -1)((x + 2)/(x^2 - 9) - (1)/(-8))/(x + 1) =
limits(lim)_(x arrow -1)((8x+16+x^2-9)/(8x^2-72))/(x+1) =
limits(lim)_(x arrow -1)(x^2+8x-7)/((x+1)(8x^2-72)) =
limits(lim)_(x arrow -1)((x+1)(x+7))/((x+1)(8x^2-72)) =
limits(lim)_(x arrow -1)(x+7)/(8x^2-72) = 6/(-64) = 3/(-32)
$

kiderult hogy fontos lenne pl ZH-n felirni a kovetkezot mindet:
$
    f in D{-1} " es " f'(-1) = -3/32; ==>\ ==> exists "erinto itt, melynek egyenlete: " y=f(-1) + f'(-1) dot (x + 1) = 1/8 - 3/32 (x+1) <==>\ <==> y = -3/32 x - 1/8 - 3/32 <==> y = -3/32 x - 7/32 (x in RR)
$

== 2/j
$
  f(x) = cases(
    x^4 (sqrt(2) + sin(1/x))\, & "ha" x in RR \\ {0},
    0\, & "ha" x = 0,
  ) "  és" a := 0
$

$
    limits(lim)_(x arrow a) (f(x) - f(a))/(x-a) =
    limits(lim)_(x arrow 0) (f(x) - f(0))/(x-0) =
    limits(lim)_(x arrow 0) (x^4 (sqrt(2) + sin(1/x)))/(x) =
    limits(lim)_(x arrow 0) x^3 (sqrt(2) + sin(1/x)) =
$

mivel korlatos, hiaba oszcillal mert egy $[-1+sqrt(2), 1+sqrt(2)]$ intervallumba kerul es ha emiatt letezik hatarertek es $= 0$

formalisabban: $|x^3 dot (sqrt(2) sin(1/x))| <= |x^3| (|sqrt(2)| |sin (1/x)|) = |x|^3 (sqrt(2) + 1) < epsilon$

vagy valami hasonlo

most extraba kiszamoljuk minden $a$ pontban
$
  f in D{0} " es " f'(0) = 0;
$

1. eset $(forall x in RR)$
$
  f'(x) = [x^4(sqrt(2) + sin 1/x)]' =
$
csak egy barati emlekezteto hogy ez a jeloles nagyon helytelen de mi most jol megallapodunk hogy megis jo
$
    = 4x^3 dot (sqrt(2) + sin 1/x) + x^4 dot sin'(1/x)(1/x)' = 4x^3(sqrt(2) +sin 1/x) +x^4 cos(1/x)(-1/x^2) =\ 4x^3(sqrt(2) + sin 1/x) - x^2 cos 1/x
$

#pagebreak()
valalmi ilyesmit mondott: "ez gyakran elofordul mert nem mukodik jo ez valami 'jo ellenpeldas tipus'"

errol volt szo:
$
  f(x) = x^alpha dot sin 1/x^beta
$

na hat vegre jon a harmadik gyakorlat anyaga
== 3
$
  f(x) := cases(
    (x)/(1+e^(1/x))\, & " ha " x in RR \\ {0},
    0\, & " ha " x = 0,
  )
$
kulonveszzuk a nulla es nem nulla eseteket


1. eset: $x in RR \\ {0}$
eloszor megallapitom hogy derivalhato

oda kell irni "(lasd muveleti szabalyok)" es akkor megusszuk a magyarazkodast
$
  f'(x) = (x)/(1+e^(1/x)) = ((x)'(1+e^(1/x) - x(1 +e^(1/x))))/(1+e^(1/x)) = (1+e^(1/x) + x dot e^(1/x) dot (-(1)/(x^2)))/(1+e^(1/x)) = (1+e^(1/x) + 1/x dot e^(1/x))/((1 + e^(1/x))^2)
$

2. eset $x = 0$
$
  f'(0) = limits(lim)_(x arrow 0) ((x)/(1 + e^(1/x)))/(x) = limits(lim)_(x arrow 0) (1)/(1+e^(1/x))
$

jobb/bal oldalra bontom
- $ limits(lim)_(x arrow 0-0) 1/(1 + e^(1/x)) = 1/(1+e^(-infinity)) = 1/(1+0) = 1 $
- $ limits(lim)_(x arrow 0+0) 1/(1 + e^(1/x)) = 1/(1+e^(+infinity)) = 1/(+infinity) = +0 = 0 in RR ==> exists f'_+(0) = 0 $

$f in.not D{0}$

= 4
$
  f(x) := cases(
    a x^2 + b x + x\, & " ha"  x in (-infinity, 0),
    e^x\, & " ha" x in [0, +infinity),
  )
$

ZH-n altalaban nem szoktak olyat kerni hogy itt egy szuper trivialis kifejezes es derivald, mert akkor tul konnyu lenne. kb a derivalasi szabalyok 70%at szamonkerik, azt pedig ugy kivitelezik hogy telerakjak minden szarral szoval tudni kell a derivalttablazatot kivulrol mese nincs

ha felrajzoljuk a grafikont (de ha nem is) akkor latjuk hogy nullaban van egy torespont

nullanal $y = e^x$-t vesz fel, $0$ elott pedig parabola van szoval azt rajzolom/kepzelem el valahogy. majd kesobb kiderul hogy konvex vagy konkav vagy pozitiv vagy negativ a parabola, most senkit sem erdekel

az szokott lenni a feladat hogy keress egy kifejezest hogy derivalhato lehessen. ez azt jelenti hogy folytonosnak kene lennie mivel a folytonossag feltetele a derivalhatosagnak. ezutan jo lenne ha a nullapontban a felerintok megegyeznenek

1. eset: $x in (-infinity, 0)$
$
  f(x) = a x^2 + b x + c
$
derivalhato mindenhol
$
  f in D{x}, "  " f'(x) = 2a x + b
$

\
2. eset: $x in (0, +infinity)$
$
  f(x) = e^x = exp(x)
$
mindenhol derivalhato ez is
$
  f in D{x}, "  " f'(x) = e^x
$
ez eddig 1-1 pontot er ZH-n

3. eset: $x = 0$
most jon a lenyeg

megallapitjuk hogy elagazasos fuggveny eseten a fuggvenyt differencialhato a valtas eseten ha folytonos es $f'_-(0) = f'_+(0)$

$
  limits(lim)_(x arrow 0-0) (a x^2 + b x + c) = 0 ==> f in C{a} <==> c = 1 "es" a + b in RR
$
$
  limits(lim)_(x arrow 0-0) (e^x) = 1
$

$
  f'_-(0) = 2 a x + b "nezzuk meg" x = 0-0"-ban" = b
$
$
  f'_+(0) = e^x "nezzuk meg" x = 0+0"-ban" = e^0 = 1
$

ezert az a feltetel hogy $b = 1 "es" a in RR$

tehat
$
  f in D{a} <==> a in RR, b = 1, c = 1 ==> 
  f(x) = cases(
    a x^2 + x + 1,
    e^x
  )
$

es akkor ez mar derivalhato lesz

irjuk fel a derivaltat

$
  f'(x) = cases(
    2a x + 1\, & " ha" < 0,
    1\, & " ha" =0,
    e^x\, & " ha" >0,
  )
$

#pagebreak()
== 2
hagyjuk el az $ln$-t mert ugy latvanyosabb es nehezebb
$
  f(x) = (sqrt(1+x))/((x^2+1)^5) "    " (x > -1)
$
erinto az $a = 0$ pontban

eloszor is $ forall x in (-1; +infinity): f in D{x} ("lasd miveleti szabalyok") $

$ f'(x) = ((sqrt(x+1))/((x^2 + 1)^5))' $
ez az egyik eljaras de tudunk most jobbat

menobb megoldas:

akarhanyszor hatvanyok vannak akkor az ln leegyszerusiti ezeket. ez logaritmikus derivalas. szetszedi oket ugy hogy konnyebb legyen dolgozni. pont ezt meg meg lehetne csinalni nelkule is de igy konnyebb

$
  ln f(x) = ln (sqrt(1 + x))/((1 +x^2)^5)
$

$
  ln f(x) = ln(sqrt(x+1) - ln(x^2 + 1)^5) = 1/2 ln(x+1) - 5ln(x^2 +1)
$
es most derivaljuk

$
  1/f(x) dot f'(x) = 1/x dot 1/(x+1) dot 1 - 5 dot 1/(x^2 + 1) dot 2x ==> (f'(x))/(f(x)) = 1/(2(x+1)) - (10x)/(x^2 + 1)
$

$
  f'(x) = f(x) dot [(1)/(2(x+1)) - (10x)/(x^2+1)]
$

$
  f'(x) = (sqrt(x+1))/((x^2+1)^5) dot [(1)/(2(x+1)) - (10x)/(x^2 + 1)]
$

$
  f'(0) = 1 dot (1/2 - 0/1) = 1/2
$

$
  f(0) = 1
$

erinto $a = 0$-ban:
$
  y := f(0) + f'(0) dot x = 1 + 1/2 x "   "(x in RR)
$

#pagebreak()
== 5
$
  f(x) = sqrt(e^(2x-1) + 1) (x in RR)
$
invertalhato? inverze differencialhato? szamold ki $sqrt(2)$ helyen

$
  f in D{RR} " (lasd elemi muveletek)"
$

$
  f'(x) = (sqrt(e^(2x-1) + 1))' = 1/(2sqrt(e^(2x+1) + 1)) dot (e^(2x-1) + 1)' = (e^(2x-1) dot 2^x)/(2 sqrt(e^(2x-1) + 1)) = (e^(2x-1))/(sqrt(e^(x-1)) + 1) > 0
$

tehat szigoruan monoton no $RR$-en $==> f$ invertalhato (injektiv)

idezzuk fel a tetelt:

Legyen $I subset bb(R)$ nyilt intervalllum, es $f: I arrow bb(R)$

TFH
- (a) $f$ szigoruan monoton es folytonos $I$-n
- (b) egy $a in I$ pontban $f in D{a}$ es $f'(a) != 0$

Ekkor az $f^(-1)$ inverz fuggveny derivalhato a $b := f(a)$ pontban, es
$ (f^(-1))'(b) = 1/(f'(a)) = 1/(f'(f^(-1)(b))) $

olyan mint ha azt mondanam hogy az inverz derivaltja az a derivalt inverze, csak az egyik a ponton van $a$-n masik a $b$-n

mivel megallapitottuk hogy derivalhato $RR$-n ezert fix folytonos is es igy teljesulnek a feltetlek
$
  f'(sqrt(2)) = 1/(f'(f^(-1)(sqrt(2)))) 
$

itt
$
  f^(-1)(sqrt(2)) = x <==> sqrt(2) = f(x) = sqrt(e^(2x-1) + 1) <==> 2 = e^(2x-1) + 1
$

$
  e^(2x-1) = 1 = e^0 <==> 2x-1=0 <==> x = 1/2 ==> f(1/2) = sqrt(2)
$

$
  f^(-1)(sqrt(2)) = 1/2
$

tetelt folytatva:
$
  1/(f'(1/2)) = (sqrt(e^(2x-1) + 1))/(e^(2x-1))
$

hazibol barmit kerdezhet

gyakorlobol:
- 1 - d,e
- 3 - c
- 6 - d

50 derivalt kell jovohetre papiron. A canvasra feltoltott  Gyemidovics peldatar segit (ugyanebben a commitban lesz)
