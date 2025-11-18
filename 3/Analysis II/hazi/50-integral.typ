= Restye János Barnabás - F8U9I2 - 50 integrál
== 1
$
  integral (cos^2 x - 5)/(1 + cos 2x) dif x = integral (cos^2 x - 5)/(2 cos^2 x) dif x = integral 1/2 (cos^2 x)/(cos^2 x) - 5/(cos^2 x) dif x = integral 1/2 - 5/2 1/(cos^2 x ) dif x = integral 1/2 dif x - 5/2 integral 1/(cos^2 x) dif x =\ = underline(1/2x - 5/2 tg x + C)
$

== 2
$
  integral (8x + 14)/(root(4, (2x^2 + 7x + 8)^5)) dif x = integral (8x + 14)/(2x^2 + 7x + 8)^(5/4) dif x,\
  (2x^2 + 7x + 8)' = 4x + 7,\
  2 integral (4x+7)/(2x^2 + 7x + 8)^(5/4) dif x = 2 integral (4x+7)(2x^2 + 7x + 8)^(-5/4) dif x = 2 ((2x^2 + 7x + 8)^(-1/4))/(-1/4) + C = underline(- (8)/(root(4, 2x^2 + 7x + 8)) + C)
$

== 3
$
  integral x dot ln^2 x dif x = integral (x^2/2)' dot ln^2 x dif x = x^2/2 dot ln^2 x - integral x^2/2 dot (2 ln x)/x dif x = x^2/2 dot ln^2 x - integral x dot ln x dif x,\
  integral x dot ln x dif x = integral (x^2/2)' dot ln x dif x = x^2/2 dot ln x - integral x^2/2 dot 1/x dif x = x^2/2 dot ln x - integral x/2 dif x = x^2/2 dot ln x - 1/2 x^2/2 + C,\
  x^2/2 dot ln^2 x - integral x dot ln x dif x = x^2/2 dot ln^2 x - x^2/2 dot ln x + x^2/4 + C = underline(x^2/2(ln^2 x - ln x + 1/2) + C)
$

== 4
$
  integral (cos 2x)/(sin x + cos x) dif x = integral (cos^2 x - sin^2 x)/(cos x + sin x) dif x = integral ((cos x - sin x)(cos x + sin x))/(cos x + sin x) dif x = integral cos x - sin x dif x =\ = integral cos x dif x - integral sin x dif x = underline(cos x + sin x + C)
$

== 5
$
  integral (x^2 + 1)/(x^4 - x^2 + 1) dif x = integral (1 + 1/(x^2))/(x^2 - 1 + 1/x^2) dif x,\
  x^2 - 1 + 1/x^2 = x^2 - 2 + 1/x^2 + 1 = (x - 1/x)^2 + 1,\
  integral (1 + 1/(x^2))/(x^2 - 1 + 1/x^2) dif x = underline(arctan(x - 1/x) + C)
$

== 6
$
  integral (x + e^x)^2 dif x = integral x^2 + 2x e^x + e^(2x) dif x = x^3/3 + 2x e^x - 2 e^x + e^(2x)/2  + C
$

== 7
$
  integral csc^3 x sec x dif x = integral 1/(sin^3 x cos x) dif x = integral (sin^2 x + cos^2 x)/(sin^3 x cos x) dif x = integral (sin^2 x)/(sin^3 x cos x) + (cos^2 x)/(sin^3 x cos x) dif x =\ =  integral (sin^2 x)/(sin x cos x) + (cos^2 x)/(sin x cos x) + (cos x)/(sin^3 x) dif x = integral (sin x)/(cos x) dif x + integral (cos x)/(sin x) dif x + integral (cos x)/(sin^3 x) dif x = ln abs(sec x) + ln abs(sin x) - 1/(2 sin ^2 x) + C =\ = underline(ln abs(tan x) - 1/2 csc^2 x + C)
$

== 8
$
  integral (cos x)/(sin^2 x - 5 sin x - 6) dif x =_(y = sin x\ dif y = cos x dif x) integral 1/(y^2 - 5y - 6) dif y,\
  D = 25 + 24 > 0, "  " y^2 - 5y - 6 = (y - 6)(y + 1),\
  integral (1/7)/(y - 6) + (-1/7)/(y + 1) dif y = 1/7 integral (y - 6)^(-1) dif y -1/7 integral (y + 1)^(-1) dif y = 1/7 ln abs(y - 6) - 1/7 ln abs(y + 1) = underline(1/7(ln abs((sin x - 6)/(sin x + 1))) + C)
$

== 9
$
  integral 1/(sqrt(e^x)) dif x = integral e^(-x/2) dif x = -2 e^(-x/2) = underline((-2)/(sqrt(e^x)) + C)
$

== 10
$
  integral 1/(x + sqrt(x)) dif x = integral 1/(sqrt(x)(sqrt(x) + 1)) dif x,\
  A/sqrt(x) + B/(sqrt(x) + 1) = 1 ==> A(sqrt(x) + 1) + B(sqrt(x)) = 1 ==> (A + B)sqrt(x) + A = 1 ==> A = 1, " " B = -1,\
  integral 1/(sqrt(x)) - 1/(sqrt(x) + 1) dif x = integral 1/(sqrt(x)) dif x - integral 1/(sqrt(x) + 1) dif x = underline(2 ln abs(sqrt(x) + 1) + C)
$

== 11
$
  integral (2 sin x)/(sin 2x) dif x = integral (2 sin x)/(2 sin x cos x) dif x = integral 1/(cos x) dif x = integral sec  x dif x = underline(ln abs(sec x + tan x) + C)
$

== 12
$
  integral cos^2 2x dif x = integral (1 + cos 4x)/2 dif x = 1/2 integral 1 + cos 4x dif x = 1/2(x + 1/4 sin(4x)) = underline(x/2 + (sin 4x)/8 + C)
$

== 13
$
  integral 1/(x^3 + 1) dif x = integral 1/((x + 1)(x^2 - x + 1)) dif x,\
  A/(x + 1) + (B x + C)/(x^2 - x + 1) = 1 ==> A(x^2 - x + 1) + (B x + C)(x + 1) ==> A x^2 - A x + A + B x^2 + B x + C x +C =\ = (A + B)x^2 + (B + C - A)x + (A + C) = 1 ==> A = 1/3, " " C = 2/3, " " B = -1/3,\
  integral (1/3)/(x + 1) + (-1/3 x + 2/3)/(x^2 - x + 1) dif x = 1/3 integral 1/(x + 1) dif x - 1/3 integral (x - 2)/(x^2 - x + 1) dif x,\
  (x^2 - x + 1)' = 2x - 1,\
  1/3 integral 1/(x + 1) dif x - 1/3 1/2 integral (2(x - 2) - 3)/(x^2 - x + 1) dif x = 1/3 integral 1/(x + 1) dif x - 1/6 [integral (2x - 1)/(x^2 - x + 1) dif x - integral 3/((x - 1/2)^2 + (sqrt(3)/2)^2) dif x] =\ = 1/3 ln abs(x + 1) - 1/6 ln (x^2 - x + 1) + 1/2 dot 2/sqrt(3) arctan((x - 1/2)/(sqrt(3)/2)) = underline(1/3 ln abs(x + 1) - 1/6 ln (x^2 - x + 1) + 1/sqrt(3) arctan(2/sqrt(3) x - 1/sqrt(3)) + C)
$

== 14
$
  integral x sin^2 x dif x = integral x + (1 - cos(2x))/2 dif x = 1/2 integral x (1 - cos 2x) dif x = 1/2 [integral x dif x + integral - x cos 2x dif x] =\ = 1/2 [1/2 x^2 - 1/2 x sin 2x - 1/4 cos 2x] = underline(1/4 x^2 - 1/4 x sin 2x - 1/8 cos 2x + C)
$

== 15
$
  integral (x + 1/x)^2 dif x = integral x^2 + 2 + 1/x^2 dif x = underline(x^3/3 + 2x - 1/x + C)
$

== 16
$
  integral 3/(x^2 + 4x + 29) dif x = integral 3/(x^2 + 4x + 4 + 25) dif x = integral 3/((x + 2)^2 + 5^2) dif x = 3 integral 1/((x + 2)^2 + 5^2) dif x = underline(3/5 arctan((x + 2)/5) + C)
$

== 17
$
  integral sin^3 x cos^2 x dif x = integral sin x sin^2 x cos^2 x dif x = integral underbrace(sin x, -(cos x)') (1 - cos^2 x) cos^2 x dif x =\ = - integral cos^2 x (cos x)' dif x + integral cos^4 x (cos x)' dif x = underline((cos^5 x)/5 - (cos^3 x)/3 + C)
$

== 18
$
  integral sin x sec x tan x dif x = integral sin x 1/(cos x) tan x dif x = integral tan^2 x dif x = integral (sec^2 - 1) dif x = underline(tan x - x + C)
$

== 19
$
  integral e^(2x) cos x dif x = e^(2x) "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$e^(2x)$], [$cos x$],
    [-], [$2e^(2x)$], [$sin x$],
    [+], [$4e^(2x)$], [$- cos x$],
  )\
  integral e^(2x) cos x dif x = e^(2x) sin x + 2e^(2x) cos x - 4 integral e^(2x) cos x dif x,\
  integral e^(2x) cos x dif x = underline(1/5 e^(2x) sin x + 2/5 e^(2x) cos x + C)
$

== 20
$
  integral (ln x)/sqrt(x) dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$ln x$], [$1/sqrt(x)$],
    [-], [$1/x$], [$2 sqrt(x)$],
  )\
  integral (ln x)/sqrt(x) dif x = 2 sqrt(x) ln x - 2 underbrace(integral 1/sqrt(x), 2 sqrt(x)) dif x = underline(2 sqrt(x) ln x - 4 sqrt(x) + C)
$

== 21
$
  integral 1/(e^x + e^(-x)) dif x = integral (e^x)/(e^(2x) + 1) dif x = underline(arctan (e^x) + C)
$

== 22
$
  integral log_2 x dif x = integral (ln x)/(ln 2) dif x = 1/(ln 2) integral ln x dif x,\
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$ln x$], [$1$],
    [-], [$1/x$], [$x$],
  )\
  = 1/(ln x) (x ln x - x) = (x ln x)/(ln 2) - x/(ln 2) = underline(x log_2 (x) - x/(ln x) + C)
$

== 23
$
  integral x^3 sin 2x dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$x^3$], [$sin 2x$],
    [-], [$3x^2$], [$-1/2 cos 2x$],
    [+], [$6x$], [$- 1/4 sin 2x$],
    [-], [$6$], [$1/8 cos 2x$],
    [+], [$0$], [$1/16 sin 2x$],
  )\
  = underline(-1/2 integral x^3 cos 2x dif x + 3/4 x^2 sin 2x + 3/4 x cos 2x - 3/8 sin 2x + C)
$

== 24
$
  integral sinh x dif x = underline(cosh x + C)
$

== 25
$
  integral sinh^2 x dif x,\
  sinh^2 x = ((e^x - e^(-x))/2)^2 = 1/4(e^x - 2 - e^(-2x)) = 1/4(-2) + 1/(2 dot 2)(e^(2x) + e^(-2x)) = - 1/2 + cosh(2x),\
  1/2 integral -1 + cosh 2x dif x = 1/2 (-x + 1/2 sinh 2x) = underline(-1/2x + 1/4 sinh 2x + C)
$

== 26
$
  integral sinh^3 x dif x = integral sinh^2 x sinh x dif x = integral (cosh^2 x - 1) sinh x dif x = integral cosh^2 x sinh x dif x - integral sinh x dif x =\ = underline((cosh^3 x)/3 - cosh x + C)
$

== 27
$
  integral 1/(sqrt(x^2 + 1)) dif x = integral 1/(sqrt(1 + x^2)) dif x = underline(sinh^(-1) + C)
$

== 28
$
  integral ln(x + sqrt(1 + x^2)) dif x = integral sinh^(-1) dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$sinh^(-1)$], [$1$],
    [-], [$1/(sqrt(1 + x^2)$], [$x$],
  )\
  = underline(x sinh^(-1) x - sqrt(1 + x^2) + C)
$

== 29
$
  tanh x dif x = integral (sinh x)/(cosh x) dif x = underline(ln abs(cosh x) + C)
$

== 30
$
  integral ln (1 + x^2) dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$ln (1 + x^2)$], [$1$],
    [-], [$(2x)/(1 + x^2)$], [$x$],
  )\
  = x ln (1 + x^2) - 2 integral (1 + x^2 - 1)/(1 + x^2) dif x = underline(x ln (1 + x^2) - 2x + 2arctan(x) + C)
$

== 31
$
  integral 1/(x^4 + x) dif x = integral 1/(x^4(1 + x^(-3))) dif x = integral (x^(-4))/(1 + x^(-3)) dif x = underline(-1/3 ln abs(1 + x^(-3)) + C)
$

== 32
$
  integral (1 - tan x)/(1 + tan x) dif x = integral (1 - (sin x)/(cos x))/(1 + (sin x)/(cos x)) dif x = integral (cos x - sin x)/(cos x + sin x) dif x = underline(ln abs(cos x + sin x) + C)
$

== 33
$
  integral x sec x tan x dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$x$], [$sec x tan x$],
    [-], [$1$], [$sec x$],
    [+], [$0$], [$ln abs(sec x tan x)$],
  )\
  = underline(x sec x - ln abs(sec x tan x) + C)
$

== 34
$
  integral x^3 e^x^2 dif x, " "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$x^2$], [$x e^x^2$],
    [-], [$2x$], [$1/2 e^x^2$],
  )\
  = x^2 1/2 e^x^2 - integral 2x 1/2 e^x^2 dif x = 1/2 x^2 e^x^2 - integral x e^x^2 dif x = underline(1/2 x^2 e^x^2 - 1/2 e^x^2 + C)
$

== 35
$
  integral 2^(ln x) dif x = integral e^(ln 2)^(ln x) dif x = integral e^(ln x)^(ln 2) dif x = integral x^(ln 2) dif x = integral 1/(1 + ln 2) x^((ln 2) + 1) dif x = integral 1/(1 + ln 2) x' x^(ln 2) dif x = underline((x 2^(ln x))/(1 + ln 2) + C)
$

== 36
$
  integral sqrt(1 + cos 2x) dif x = integral sqrt(2 cos^2 x) dif x = sqrt(2) integral cos dif x = underline(sqrt(2) sin x + C)
$

== 37
$
  integral 1/(1 + tan x) dif x = 1/2 integral (1 - tan x + 1 + tan x)/(1 + tan x) dif x = 1/2 (integral (1 - tan x)/(1 + tan x) dif x + (1 + tan x)/(1 + tan x) dif x) = underline(1/2 ln abs(cos x + sin x) + 1/2 x + C)
$

== 38
$
  integral (sin x + cos x)^2 dif x = integral (sin^2 x + 2 sin x cos x + cos^2 x) dif x = integral (1 + sin 2x) dif x = underline(x - 1/2 cos 2x + C)
$

== 39
$
  integral sqrt((1 - x)/(1 + x)) dif x = integral sqrt(((1 - x)(1 - x))/((1 + x)(1 - x))) dif x = integral (1 - x)/(sqrt(1 + x^2)) dif x = integral 1/(sqrt(1 + x^2)) dif x - integral x/(sqrt(1 + x^2)) dif x =\ = underline(arcsin x + sqrt(1 - x^2) + C)
$

== 40
$
  integral x^(x/(ln x)) dif x,\
  integral e^(ln x)^(x/(ln x)) dif x = integral e^x dif x = underline(e^x + C),\
  integral x^(x/(ln x)) dif x = underline(x^(x/(ln x)) + C)
$

== 41
$
  integral arctan x dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$arctan x$], [$1$],
    [-], [$1/(1 + x^2)$], [$x$],
  )\
  = underline(x arctan x - 1/2 ln(1 + x^2) + C)
$

== 42
$
  integral (sin 1/x)/x^3 dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$1/x$], [$(sin 1/x)/x^2$],
    [-], [$-1/x^2$], [$cos 1/x$],
  )\
  = (cos 1/x)/x - integral -1/x^2 cos 1/x = underline((cos 1/x)/x - sin 1/x + C)
$

== 43
$
  integral (x - 1)/(x^4 - 1) dif x = integral (x - 1)/((x - 1)(x + 1)(x^2 + 1)) dif x = integral 1/((x + 1)(x^2 + 1)) dif x,\
  A/(x + 1) + (B x + C)/(x^2 + 1) = 1 ==> A(x^2 + 1) + (B x + C)(x + 1) = 1 ==> A x^2 + A + B x^2 + B x + C x + C = 1 ==>\ ==> (A + B)x^2 + (B + C)x + (A + C) = 1 ==> A = 1/2, " " B = -1/2, " " C = 1/2,\
  integral (1/2)/(x + 1) dif x - 1/2 integral (x)/(x^2 + 1) dif x + 1/2 integral 1/(x^2 + 1) dif x = underline(1/2 ln abs(x + 1) - 1/4 ln (x^2 + 1) + 1/2 arctan x + C)
$

== 44
$
  integral sqrt(1 + (x - 1/(4x))^2) dif x = integral sqrt(1 + x^2 - 1/2 + 1/(16 x^2)) dif x = integral sqrt(x^2 + 1/2 + 1/(16 x^2)) dif x = integral sqrt((x + 1/(4x))^2) dif x = integral x + 1/(4x) dif x =\ = underline(1/2 x^2 + 1/4 ln abs(x) + C)
$

== 45
$
  integral (e^(tan x))/(1 - sin^2 x) dif x = integral (e^(tan x))/(cos^2 x) dif x = integral e^(tan x) sec^2 x dif x = underline(e^(tan x) + C)
$

== 46
$
  integral (arctan x )/x^2 dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$arctan x$], [$1/x^2$],
    [-], [$1/(1 + x^2)$], [$-1/x$],
  )\
  = underline(-(arctan x)/x - 1/2 ln (x^(-2) + 1) + C)
$

== 47
$
  integral (arctan x)/(1 + x^2) dif x = underline(1/2 arctan^2 x + C)
$

== 48
$
  integral ln^2 x dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$ln^2 x$], [$1$],
    [-], [$(2 ln x)/x$], [$x$],
  )\
  = x ln^2 x - integral 2 ln x dif x, "  "
  #table(
    columns: 3,
    [], [D], [I],
    [+], [$2 ln x$], [$1$],
    [-], [$2/x$], [$x$],
  )\
  = x 2 ln x - integral 2 dif x = x 2 ln x - 2x,\
  integral ln^2 x dif x = underline(x ln^2 x - x 2 ln x + 2x + C)
$

== 49
$
  integral x/(1 + x^4) dif x = integral x/(1 + (x^2)^2) dif x = 1/2 integral (2x)/(1 + (x^2)^2) dif x = underline(1/2 arctan x^2 + C)
$

== 50
$
  integral sqrt(1 + sin 2x) dif x = integral sqrt(sin^2 x + cos^2 x + 2 sin x cos x) dif x = integral sqrt((sin x + cos x)^2) dif x = integral sin x dif x + integral cos x dif x =\ = underline(sin x - cos x + C)
$
