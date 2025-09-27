= Hazi
== 1.
$ f(x) := x^3 + x, "  " (x in RR) $
== megoldas

$ f'(x) = 3x^2 + 1 > 0 "  " (forall x in RR) $

tehat invertalhato, es

$ (f^(-1))'(2) = 1/(f'(1)) = 1/(3 dot 1^2 + 1) = 1/4 $

== 2.
$
  f(x) := sin((x-1)/(x^2+1)) "  " (x in RR), "  " a = 1/2
$
== megoldas
Mivel
$
  f(a) = sin((-1/2)/(5/4)) = sin(-4/10) = -sin(2/5)
$

$
  f'(x) = cos((x-1)/(x^2+1)) dot (x^2 + 1 - (x-1)(2x))/((x^2 + 1)^2) = cos((x-1)/(x^2+1)) dot (x^2 + 1 -2x^2 +2x)/((x^2 + 1)^2) = cos((x-1)/(x^2+1)) dot (-x^2 + 2x + 1)/((x^2 + 1)^2)
$

Ekkor

$
  f'(1/2) = -cos(2/5) dot (-4/25 + 2)/((4/25 + 1)^2) = -cos(2/5) dot (46/25)/((29/25)^2)
$
 hagyjuk inkabb oszinten

== 3.
$
  f(x) := cases(
    1-x\, & "  " x < 0,
    e^(-x)\, & "  " x >= 0,
  )
$

== megoldas
=== ha $x < 0$
$
  f'(x) = -1
$

=== ha $x >= 0$
$
  f'(x) = e^(-x)
$

=== ha $x = 0$
$
  (f(x) - f(0))/(x-0) = (f(x) - 1)/x = cases(
    (1 - x - 1)/(x) = -1,
    (e^(-x) - 1)/(x)
  )
$

$
  limits(lim)_(x arrow 0) (e^(-x) - 1)/(x) =
  limits(lim)_(x arrow 0) (e^(0) - e^0)/(x) =
  ? = -1
$

= Gyakorlo
== 1/d.
$
  f(x) := 1/(ln^2(x-1/x)) "  " (x > 1), "  " a = 2
$

$
  u(x) = x - 1/x "    " u(a) = 3/2\
  v(x) = ln(u(x)) "    " v(a) = ln(3/2)\
  f(a) = 1/[v(a)]^2 = 1/[ln(3/2)]^2
$

$
  f(x) = [v(x)]^(-2) ==> f'(x) = -2[v(x)]^(-3) dot v'(x)\
  v'(x) = 1/(x - 1/x) dot (1 + 1/x^2) = 1/((x^2-1)/x) dot (x^2 + 1)/x^2 = x/(x^2-1) dot (x^2 + 1)/x^2 = (x^2 + 1)/(x(x^2 - 1))\
  f'(x) = -2 dot [ln(x - 1/x)]^(-3) dot (x^2 + 1)/(x(x^2 - 1))\
  f'(2) = -2 dot [ln(3/2)]^(-3) dot 5/6 = -5/3 dot 1/(ln(3/2)^3)\
  y = f'(2)(x-2) + f(2) = -5/3 dot 1/(ln(3/2)^3) dot (x - 2) + 1/(ln^2(3/2))
$

== 1/e.
$
  f(x) := x^(ln x) "  " (x > 0) "  " a = e^2\
  u(x) = x "  " u'(x) = 1 "  " u(a) = e^2\
  v(x) = ln x "  " v'(x) = 1/x "  " v(a) = ln e^2\
  f(a) = e^(2 dot ln e^2) = e^4\
  f'(x) = e^(ln x)^2 dot [(ln x)^2]' = f(x) dot 2 ln x dot 1/x = x^(ln x) (2 ln x)/x\
  f(a) = e^4\
  f'(a) = e^4 (2 dot 2)/e^2 = e^4 4/e^2 = 4e^2\
  y = f'(a)(x-a) + f(a) = 4e^2(x-e^2) + e^4 = 4e^2x - 3e^4
$

== 3/c.
$
    sqrt(x) + sqrt(y) = 3, "  " (4,1)\
    sqrt(x) + sqrt(y) = 3 ==> sqrt(y) = 3 - sqrt(x) ==> y = (3 - sqrt(x))^2 ==> y = x - 6 sqrt(x) + 9\
    m = limits(lim)_(x arrow 4) (y(x) - y(4))/(x-4) = limits(lim)_(x arrow 4) (x - 6 sqrt(x) + 9 - 1)/(x-4) = limits(lim)_(x arrow 4) (x - 6 sqrt(x) + 8)/(x-4) = limits(lim)_(x arrow 4) ((sqrt(x) - 4)(sqrt(x) - 2))/(x-4) = limits(lim)_(x arrow 4) ((sqrt(x) - 4)(sqrt(x) - 2))/((sqrt(x) - 2)(sqrt(x) + 2)) = \
    = limits(lim)_(x arrow 4) (sqrt(x) - 4)/(sqrt(x) + 2) = -2/4 = -1/2\
    y = -1/2 x + 3
$

== 6/d.
$
    f(x) := cases(
        cos x\, & "  " x <= 0,
        a sin x + x + b\, & "  " x > 0,
    )
$

=== 1. x < 0:
$
    f'(x) = -sin x
$

