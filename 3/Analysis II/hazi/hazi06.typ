= 1
== a)
$
  arccos ((sqrt(3))/(2))\
  arccos x "  " (x in [-1, 1]) = y "  " (y in [0, pi]) <==> cos y = x\
  arccos ((sqrt(3))/(2)) = y in [0, pi] <==> cos y = (sqrt(3))/(2) <==> (y = 30degree) "  " y = pi/6
$

== b)
$
  log_(1/4) (1/1024) = (ln(1/1024))/(ln(1/4)) = (- ln 1024)/(- ln 4) = (ln 1024)/(ln 4) = (10 ln 2)/(2 ln 2) = 5
$

== c)
$
  e^(-2 ln 3) = e^(ln(3^(-2))) = 3^(-2) = 1/9
$

== d)
$
  8^(log_4 9) = (2^3)^(log_4 9) = (2^3)^(log_2 3) = 2^(3 log_2 3) = (2^(log_2 3))^3 = 3^3 = 27
$

= 2
$
  f(x) := ((x - 3)/(x + 1))^2 "  " (x in RR \\ {-1})\
$
/ 1: ÉT:
$D_f = (-infinity, -1) union (-1, +infinity)$\
$x = 0: (-3/1)^2 = 9$\
$y = 0: x = 3$
A fv atmegy a $(0, 9)$ es $(3, 0)$ pontokon

/ 2: $f'$ elojele:
$
  f'(x) = 2((x - 3)/(x + 1)) dot (x + 1 - (x - 3))/((x + 1)^2) = 2((x - 3)/(x + 1)) dot (4)/((x + 1)^2) = (8(x - 3))/((x + 1)^3)\
  f' = 0 <==> x = 3\
  "sign" f'(x) = "sign"(8(x - 3)(x + 1)^3)
$
- $(-infinity, -1): +$
- $(-1, 3): -$
- $(3, +infinity): +$

#pagebreak()
/ 3: $f''$ elojele:
nevezo': $8x - 24$\
$
  f''(x) = (8(x + 1)^3 - (8x - 24)3(x + 1)^2)/((x + 1)^6) = (8(x + 1) - (8x - 24)3)/((x + 1)^4) = (8x + 8 - 24x + 72)/((x + 1)^4) = (-16x + 80)/((x + 1)^4) = (-16(x + 5))/((x + 1)^4)\
  f'' = 0 <==> x = -5\
  "sign" f''(x) = "sign" (-16(x + 5)(x + 1)^4) = (forall x in RR \\ {-1}) "sign"(-16(x + 5))
$
- $(-infinity, 5) \\ {-1}: +$
- $(5, +infinity): -$

/ 4: aszimptota:
$
  lim_(x arrow plus.minus infinity) ((x - 3)/(x + 1))^2 = (+infinity)/(+infinity) = lim_(x arrow plus.minus infinity) ((1)/(1))^2 = 1 ==> "y = 1"
$
$
  lim_(x arrow -1) ((x - 3)/(x + 1))^2 = ((-4)/(0))^2 = +infinity
$

valami nem jo de nem fogom kideriteni

= 3
hell

= 4
na
