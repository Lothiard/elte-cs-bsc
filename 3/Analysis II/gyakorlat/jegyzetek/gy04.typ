lokalis szelsoertek koran reggel

== 1/a.
$
  f(x) := 3x^4 - 4x^3 - 12x^2 + 2\
  f'(x) = 12x^3 - 12x^2 - 24x = 12x(x^2 - x - 2) = 12x(x-2)(x+1) = 0 <==> x_1 = 0 or x_2 = 2 or x_3 = -1;
$

$
  #table(
    columns: 8,
    [$x$], [$-infinity$], [$-1$], [$-1 < x < 0$], [$0$], [$0 < x < 2$], [$2$], [$+infinity$],
    [$f'(x)$], [$-$], [$0$], [$+$], [$0$], [$-$], [$0$], [$+$],
    [$f(x)$], [$arrow.b$], [$(-3)$], [$arrow.t$], [$(2)$], [$arrow.b (-30)$], [], [$arrow.t$]
  )
$

lokalis minimum $-3$-nal, globalalis minimum a $-30$, lokalis max a $2$

$
  f(-1) = -3\
  f(0) = 2\
  f(1) = -30\

  f arrow.b: (-infinity; -1); f arrow.b (0; 2);\
  f arrow.t (-1; 0); f arrow.t (2; +infinity);
$

== 1/b.
$
  f(x) := x/(x^2 - 10x + 16) "  " (x in RR \\ {2, 8})\
  f(x) = x/(x^2 - 10x + 16) = x/((x - 2)(x - 8))\
  f'(x) = (x(x^2 - 10x + 16) - x(2x - 10))/((x-2)^2(x-8)^2) = (16 - x^2)/((x-2)^2(x-8)^2) "  "(forall x in RR \\ {2, 8})\
  "sign" f'(x) = "sign"(16 - x^2)
$

$
  #table(
    columns: 10,
    [$x$], [$-infinity$], [$-4$], [$-4 < x < 2$], [$2$], [$2 < x < 4$], [$4$], [$4 < x < 8$], [$8$], [$+infinity$],
    [$f'(x)$], [$-$], [$0$], [$+$], [$|$], [$+$], [$0$], [$-$], [$|$], [$-$],
    [$f(x)$], [$arrow.b$], [$$], [$arrow.t$], [$|$], [$arrow.t$], [$$], [$arrow.b$], [$|$], [$arrow.b$]
  )
$

$-4$ lokalis min, $4$ lokalis max, global min/max nem letezik (mert van benne $plus.minus infinity$)

$
  f(-4) = (-4)/(-6 dot (-12)) = -1/18\
  f(4) = 4/(2 dot (-4)) = -1/2
$

Tehat:
$
  f arrow.b: (-infinity; 4); (4,8); (8, +infinity);\
  f arrow.t: (-4; 2); (2, 4);
$

#pagebreak()
= abszolut szelsoertek
== 2/a.
$
  f(x) := x^4 - 4x^3 + 10 " " (x in [-1, 4])\
  cal(D)_f = [-1,4] " korlatos es zart (kompakt), es " f in C[-1, 4] ==> exists min cal(R)_f, exists max cal(R)_f
$

$
"hol lehetnek?" cases(
    "- " x in (-1, 4) "belso pontban ott ahol" f'(x) = 0\
    "- vegpontokban: " x = -1 "ill." x = 4
  )
$

=== ha a)
$
  x in (-1, 4) ==> f in D{a} " es " f'(x) = 4x^3 -12^2 = 4x^2 (x-3) = 0 <==>\ <==> x_1 = 0 in (-1, 4), x_2 = 3 in (-1, 4)\
$

=== ha b) osszevetes
$
  f(0) = 10,\ f(-1) = 15, " abszolut max "\ f(3) = -17, " abszolut min "\ f(4) = 10\
$

== 2/b.
$
  f(x) := x/(x^2 + 1) "  " (x in [-3/2, 2] = cal(D)_f) ==> D_f "kompakt", f in C[-3/2, 2] ==> exists min cal(R)_f; exists max cal(R)_f ==>\ ==> f in D "es" f'(x) = ((x)/(x^2 + 1))' = (1 dot (x^2 + 1) - x dot 2x)/((x^2 + 1)^2) = (1-x^2)/((x^2 + 1)^2)
$

$
  (x in (-3/2, 2)) "es " f'(x) = 0 <==> 1 - x^2 = 0 <==> x = plus.minus 1 in (-3/2, 2) !
$

osszevetes
$
  f(1) = 1/2,\ f(-3/2) = (-3/2)/(9/4 + 1) = -6/13, "absz min"\ f(-1) = -1/2,\ f(2) = 2/5, "absz max"
$

= custom hazi
- 1. lokalis szelsoertek: $f(x) = x^2 dot e^(-x) (x in RR)$
- 2. globalis szelsoertek: $f(x) = sin^4 x + cos^4 x x in [-(2pi)/3, pi/2]$

#pagebreak()
= szoveges peldak
== 3.
tekintsunk egy $a$ oldalu negyzetet. $(a > 0)$.

a sarkokbol kivagunk $x$ oldalu negzeteket es eltavolitjuk. a maradekbol csinaljunk egy dobozt.

hol vagjunk (mekkora legyen az $x$), ugy hogy $V_"doboz"$ maximalis legyen?

$V_"doboz"$ a celfuggveny amit minimalizalni/maximalizalni kell

alap hossza: $a-x$, magassaga $x$

ebbol terfogat: $ (a-2x)^2 dot x = (2x - a)^2 dot x "  " (x in [0; a/2]) $

ezt a fuggvenyt kell maximalizalni

most ne wierstrassal csinaljuk mert ugy tul konnyu lenne

$
  forall x in (0, a/2) ==> V in D{x} "es" V'(x) = 2(2x - a)^1 dot x + (2x - a)^2 dot 1 = (2x - a)(4x + 2x - a) = (2x - a)(6x - a)\
  V'(x) = 0 <==> x_1 = a/2; " " x_2 = a/6
$

$
  #table(
    columns: 6,
    [$x$], [$0$], [$0 < x < a/6$], [$a/6$], [$a/6 < x < a/2$], [$a/2$],
    [$V'(x)$], [$0$], [$+$], [$0$], [$-$], [$0$],
    [$V(x)$], [$arrow.t$], [$arrow.t$], [], [$arrow.b$], [$arrow.b$],
  )\

  V(a/6) = (2 dot a/6 - a)^2 dot a/6 = (4a^2)/(9 dot 6) = (2a^3)/(27)
$

Tehat: $x = a/6$

== 4.
tekintsunk egy $1$ literes hengeralaku zart konzervet, minimalizaljuk a koltseget ugy hogy az ar az egyenesen aranyos a felszinnel

$ V = 1 "liter" = 1000 "cm"^3 $

$R, h = ?$ hogy a felszin minimalis legyen

$ F(R, h) = 2 pi R^2 + 2 pi R h "(celfuggveny) " (R, h > 0) $

nem tudunk ketvaltozos analizist ezert kene egy valtozo

$ V(R, h) = pi R^2 h = 1000 "(feltetel) " ==>\ ==> h = 1000/(pi R^2) ==>\ ==> f(R) = F(R, 1000/(pi R^2)) = 2 pi R^2 + 2 pi R 1000/(pi R^2) = 2 pi R^2 + 2000/R = 2[pi R^2 + 1000/R] "  " (R in (0; +infinity)) $ nem kompakt tehat nincs weierstrass!

$ ==> f in D "es" f'(R) = 2(2 pi R - 1000/(R^2)) = 0 <==> 2 pi R = 1000/(R^2) <==> R^3 = 1000/(2 pi) <==> R = 10/(root(3, 2 pi)) > 0 $

$ f'(R) > 0 <==> 2 R pi > 1000/(R^2) $

$ R^2 <==> R^3 > 1000/(2 pi) ==> R > 10/(root(3, 2 pi)) $

// kisatirozom ahol nem ertelmes
// todo tablazat
$
  #table(
    columns: 6,
    [$R$], [$0$], [$0 < R < 10/(root(3, 2 pi))$], [$10/(root(3, 2 pi))$], [$10/(root(3, 2 pi)) < R < +infinity$], [$+infinity$],
    [$f'(R)$], [n.e], [$-$], [$0$], [$+$], [n.e.],
    [$f(R)$], [$n.e$], [$arrow.b$], [], [$arrow.t$], [$n.e.$],
  )
$

$
  limits(lim)_(R arrow 0+0) f(R) = +infinity\
  limits(lim)_(R->+infinity) f(R) = +infinity
$

absz min: $a 10/(root(3, 2pi))$

$
  f(10/(root(3, 2 pi))) = 2pi dot 100/(root(3, (2pi)^2)) + 2000/((10)/(root(3, 2 pi))) = 100 root(3, 2 pi) + 200 root(3, 2 pi) = 300 root(3, 2 pi)
$

ropzh04:
- orai kozul barmi
- hf:
  - a ket custom
  - 1,2,3,4
- gyakorlo: 1/b,c es 3
