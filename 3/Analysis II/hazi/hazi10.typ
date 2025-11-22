= hazi
== a
$
  integral e^x/(1 + e^(2x)) dif x, "  " u = e^x ==> x = ln u ==> x' = 1/u,\
  integral u/(1 + u^2) 1/u dif u = integral 1/(1 + u^2) dif u = arctan (u) + C ==> underline(arctan(e^x) + C)
$

== b
$
  integral 1/(x - root(3, x + 1) + 1) dif x, "  " u = root(3, x + 1) ==> x = u^3 - 1 ==> x' = 3u^2,\
  integral 1/(u^3 - 1 - u + 1) dot 3u^2 dif u = 3 integral (u^2)/(u^3 - u) dif u = 3 integral u/(u^2 - 1) dif u = 3/2 integral (2u)/(u^2 - 1) dif u = 3/2 ln abs(u^2 - 1) + C ==>\ ==> underline(3/2 ln ((root(3, x + 1))^2 - 1) +C)
$

== c
$
  integral 1/x sqrt((2x - 3)/x) dif x, "  " u = sqrt((2x - 3)/x) ==> u^2 = 2 - 3/x ==> x = -3/(u^2 - 2) ==> x' = (6u)/((u^2 - 2)^2),\
  integral 1/(-(3)/(u^2 - 2)) dot u dot (6u)/((u^2 - 2)^2) dif u = integral u dot (-(2u)/(u^2 - 2)) = - 2 integral u^2/(u^2 - 2) dif u = -2 integral (u^2 - 2 + 2)/(u^2 - 2) dif u = -2 integral 1 + 2/(u^2 - 2) dif u =\ = -2 [integral 1 dif u + 2 integral 1/(u^2 - 2) dif u],\
  A/(u - sqrt(2)) + B/(u + sqrt(2)) = 1 ==> A(u + sqrt(2)) + B(u - sqrt(2)) = 1 ==> (A + B)u + (A - B)sqrt(2) = 1 ==> A = 1/(2 sqrt(2)), " " B = - 1/(2 sqrt(2)),\
  -2 u + -4 integral 1/(2 sqrt(2))/(u - sqrt(2)) - 1/(2 sqrt(2))/(u + sqrt(2)) dif u = -2u -4 ln abs(u - sqrt(2)) - 4 ln abs(u + sqrt(2)) " waa nemjo"
$

= gyakorlo
==  2
$
  integral (e^x + 4)/(e^(2x) + 4e^x + 3) dif x, "  " u = e^x ==> x = ln u ==> x' = 1/u,\
  integral (u + 4)/(u^2 + 4u + 3) 1/u dif u = integral (u + 4)/(u(u + 1)(u + 3)) dif u,\
  A/u + B/(u + 1) + C/(u + 3) = u + 4 ==> A(u + 1)(u + 3) + B(u)(u + 3) + C(u)(u + 1) = u + 4 ==>\
$
ha $u = 0$: $A = 4/3$\
ha $u = -1$: $B = - 3/2$\
ha $u = -3$: $C = 1/6$\
$
  integral (3/4)/u dif u - integral (3/2)/(u + 1) dif u + integral (1/6)/(u + 3) dif u = 4/3 integral 1/u dif u - 3/2 integral 1/(u + 1) dif u + 1/6 integral 1/(u + 3) dif u = 4/3 ln abs(u) - 3/2 ln abs(u + 1) + 1/6 ln abs(u + 3) + C ==>\ ==> underline(4/3 ln (e^x) - 3/2 ln (e^x + 1) + 1/6 ln (e^x + 3) + C)
$

== 3/b
$
  integral 1/((x + 1)^2) dot sqrt((x + 1)/x) dif x, "  " u = sqrt((x + 1)/x) ==> u^2 = 1 + 1/x ==> x = 1/(u^2 - 1) ==> x' = - (2u)/((u^2 - 1)^2),\
  integral 1/((1/(u^2 - 1) + 1)^2) dot u dot (- (2u)/(u^2 - 1)^2) dif u = integral 1/(((1 + u^2 - 1)/(u^2 - 1))^2) dot u dot (- (2u)/(u^2 - 1)^2) dif u = integral 1/(((u^2)/(u^2 - 1))^2) dot u dot (- (2u)/(u^2 - 1)^2) dif u =\ = integral u dot (- (2u)/(u^2 - 1)^2)(((u^2 - 1)^2)/(u^4)) dif u = - integral u dot 2/u^3 dif u = - integral 2/u^2 dif u = -2 integral 1/u^2 dif u = -2 (u^(-1))/(-1) = 2/u + C ==>\ ==> underline(2/(sqrt((x + 1)/x)) + C)
$
