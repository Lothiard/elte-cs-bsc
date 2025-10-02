= custom hazi
== 1. lokalis szelsoertek: $f(x) = x^2 dot e^(-x) "  " (x in RR)$
$
  f'(x) = 2x dot e^(-x) + x^2 dot (-e^(-x)) = 2x e^(-x) - x^2 e^(-x) = x e^(-x)(2 - x)\
  f'(x) = 0 <==> 2x e^(-x) = -x^2 e^(-x) ==> x_1 = 0, x_2 = 2
$

$
  #table(
    columns: 6,
    [$x$], [$x<0$], [$0$], [$0 < x < 2$], [$2$], [$x > 2$],
    [$f'(x)$], [$+$], [$0$], [$+$], [$0$], [$-$],
    [$f(x)$], [$arrow.b$], [$0$], [$arrow.t$], [$4/e^2$], [$arrow.b$],
  )
$

lokalis minimum: $f(0) = 0$\
lokalis maximum: $f(2) = 4/(e^2)$\

== 2. globalis szelsoertek: $f(x) = sin^4 x + cos^4 x "  " x in [-(2pi)/3, pi/2]$
// f(x)' = 4sin^3 x dot cos x - 4 cos^3 x dot sin x = (-4 sin x cos x)(-sin^2 x + cos^2 x) = -sin 4x\
$
  cal(D)_f = [-(2pi)/3, pi/2] "korlatos es zart (kompakt), es " f in C[-(2pi)/3, pi/2] ==> exists min cal(R)_f, exists max cal(R)_f
$

lehetnek:
- belso pontok: $x in (-(2pi)/3, pi/2)$ ahol $f'(x) = 0$
- vegpontok: $x = -(2pi)/3, x = pi/2$

=== ha 1)
$ x in (-(2pi)/3, pi/2) ==> f in D{a} " es " f'(x) = -sin 4x = 0 <==> x_1 = 0 + (k pi)/4 "  " (k in NN) $

=== ha 2)
kuka

= regular hazi
== 1
$
  f(x) := x^5 - 5x^4 + 5x^3 + 1 "  " (x in RR)\
  f'(x) = 5x^4 -20x^3+15x^2 = 5x^2(x^2 - 4x + 3) = 5x^2(x - 3)(x - 1) <==> x_1 = 0 or x_2 = 3 or x_3 = 1\
$
$
  #table(
    columns: 8,
    [$x$], [$x < 0$], [$0$], [$0 < x < 1$], [$1$], [$1 < x < 3$], [$3$], [$3 < x$],
    [$f'(x)$], [$-$], [$0$], [$+$], [$0$], [$-$], [$0$], [$+$],
    [$f(x)$], [$arrow.b$], [$1$], [$arrow.t$], [$2$], [$arrow.b$], [$-26$], [$arrow.t$]
  )
$
$
  f arrow.t: (0;1), (3; +infinity)\
  f arrow.b: (-infinity;0), (1; 3)\
  "lokalis max": 2\
  "lokalis min": -26\
$

#pagebreak()
== 2
$
  f(x) := (e^x)/x "  " (x in RR \\ {0})\
  f'(x) = (e^x x - e^x)/(x^2) = (e^x (x -  1))/(x^2) = 0 <==> x_1 = 0 " " (x in RR \\ {0}!) or x_2 = 1 ==> x = 1\
$
$
  #table(
    columns: 4,
    [$x$], [$x < 1$], [$1$], [$x < 1$],
    [$f'(x)$], [$-$], [$0$], [$+$],
    [$f(x)$], [$arrow.b$], [$e$], [$arrow.t$],
  )
$
$
  f arrow.t: (1;+infinity)\
  f arrow.b: (-infinity; 1)\
  "lokalis max": exists.not\
  "lokalis min": e\
$

== 3
$
  f(x) := x/(x^2 + x + 1) "  " (x in [-2, 0])\
  f'(x) = ((x^2 + x + 1) - x(2x + 1))/((x^2 + x + 1)^2) = (x^2 + x + 1 - 2x^2 - x)/((x^2 + x + 1)^2) = (-x^2 + 1)/((x^2 + x + 1)^2) = (1 - x^2)/((x^2 + x + 1)^2)
$
$
  #table(
    columns: 4,
    [$x$], [$-2$], [$-2 < x < 0$], [$0$],
    [$f'(x)$], [$-1$], [$+$], [$1$],
    [$f(x)$], [$-2/3$], [$arrow.t$], [$0$],
  )
$
$
  f arrow.t: [-2;0]\
  "lokalis max": -1\
  "lokalis min": -2/3\
$

== 4
$ 6x + y = 9 "legkozelebbi pont" (-3,1) $
$
  y = -6x + 9\
  d = sqrt((x + 3)^2 + (y - 1)^2) = sqrt((x + 3)^2 + (-6x + 8)^2)\
  f(x) = (x + 3)^2 + (-6x + 8)^2\
  f'(x) = 2(x+3) + 2(-6x+8) dot (-6) = 2x + 6 +72x -96 = 74x - 90\
  cases(
    x = 90/74\
    y = -6(90/74) + 9 = 63/37
  ) ==> "a legkozelebbi pont" (90/74, 63/37)
$

= gyakorlo
== 1/b
$
  f(x) := (x^2 - x + 1) e^(-x) "  " (x in [-2, 3])\
  cal(D)_f = [-2, 3] ==> f in C[-2, 3] ==> exists cal(R)_max, cal(R)_min
$
$
  x in (-2, 3) ==> f in D(-2, 3)\
  f'(x) = (2x - 1)e^(-x) - (x^2 - x + 1)e^(-x) = e^(-x)((2x-1) - (x^2 - x + 1)) = e^(-x)(2x-1-x^2+x-1)=\ = e^(-x)(-x^2+3x-2) = e^(-x)(-x + 1)(x - 2) = 0 <==> x_1 = 0 or x_2 = 1 or x_3 = 2
$
$
  f(-2) = 7e^(2), " "
  f(0) = 1, " "
  f(1) = 1/e, " "
  f(2) = 3/e^2, " "
  f(3) = 7/e^3\
  min "helye": 3, " erteke": 7/e^3\
  max "helye": -2, " erteke": 7e^2
$

== 1/c
$
  f(x) := x^2 e^(-x) "  " (x in RR)\
  f'(x) = 2x e^(-x) - x^2 e^(-x) = x e^(-x)(2 - x) = 0 <==> x_1 = 0 or x_2 = 2
$
$
  #table(
    columns: 6,
    [$x$], [$x<0$], [$0$], [$0 < x < 2$], [$2$], [$x > 2$],
    [$f'(x)$], [$+$], [$0$], [$+$], [$0$], [$-$],
    [$f(x)$], [$arrow.b$], [$0$], [$arrow.t$], [$4/e^2$], [$arrow.b$],
  )
$
lokalis minimum: $f(0) = 0$\
lokalis maximum: $f(2) = 4/(e^2)$\

== 3
$
  y^2 - x^2 = 4 "melyik a legkozelebb pontja " (2,0)"-hoz"\
  d = sqrt((x - 2)^2 + (y - 0)^2) = sqrt((x - 2)^2 + y^2)\
  d = sqrt((x - 2)^2 + 4 + x^2)\
  f(x) = 2x^2 - 4x + 8 = 2(x^2 - 2 + 4) = 2[(x-1)^2 + 3]\
  min: " ha x = 1": sqrt(5)
$
