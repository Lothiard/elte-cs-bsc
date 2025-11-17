== 1
$
  integral 1/((3x - 2)^5) dif x = 1/3 integral (3x-2)' dot (3x - 2)^5 = 1/3 dot ((3x - 2)^(-5 + 1))/(-5 + 1) + C
$

== 2
$
  integral 1/(7x + 5) dif x " " (x > -5/7) = 1/7 integral ((7x + 5)')/(7x + 5) = 1/7 ln abs(7x + 5) + C = 1/7 ln (7x + 5) + C
$

== 3
$
  integral (3x - 1)/(x^2 + 4x + 7) dif x, "  " D =  16 - 28 < 0, "  " (x^2 + 4x + 7)' = 2x + 4\
  3/2 integral (2x + 2/3)/(x^2 + 4x + 7) dif x = 3/2 integral (2x + 4 - 4 + 2/3)/(x^2 + 4x + 7) dif x = 3/2 integral ((x^2 + 4x +7)')/(x^2 + 4x + 7) dif x = 3/2 dot 10/3 integral 1/(x^2 + 4x + 7) dif x =\ = 3/2 ln abs(x^2 + 4x + 7) - 5 integral 1/((x + 2)^2 + 3) dif x = 3/2 ln (x^2 + 4x + 7) - 5/3 integral 1/(1 + ((x + 2)/(sqrt(3)))^2) dif x =\ = 3/2 ln (x^2 + 4x + 7) - 5/3 (arctan((x+2)/(sqrt(3))))/(1/(sqrt(3))) + C
$

== 4
$
  integral (7x + 1)/(x^2 - 6x + 8) dif x, "  " D = 36 - 32 = 4\
  x^2 - 6x + 8 = (x - 2)(x - 4)\
  integral (7x + 1)/((x - 2)(x - 4)) dif x
$

$
  (7x + 1)/((x - 2)(x - 4)) = (A)/(x-2) + (B)/(x-4) "  " (x in (2,4))\
  7x + 1 = A(x - 4) + B(x - 2) "  " (forall x in RR)\
  7x + 1 = (A + B)x + (-4A - 2B)\
  x^1 "egyutthatoi": A + B = 7\
  x^2 "egyutthatoi": -4A - 2B = 1\
  A = -15/2, B = 7 + 15/2 = 29/2
$

$
  ==> integral ((-15/2)/(x - 2) + (29/2)/(x - 4)) dif x = 29/2 integral 1/(x - 4) dif x - 15/2 integral 1/(x - 2) dif x =\ = 29/2 ln abs(x - 4) - 15/2 ln abs(x - 2) + C =_(2 < x < 4) = 29/2 ln (4 - x) - 15/2 ln(x - 2) + C
$

== 5
$
  integral (3x - 5)/(x^2 + 2x + 1) dif x = integral (3x - 5)/((x + 1)^2) dif x\
  (3x - 5)/((x + 1)^2) = A/(x + 1) + B/((x + 1)^2)\
  (3x - 5) = A(x - 1) + B\
  A = 3, B = -8\
  integral 3/(x + 1) - 8/((x + 1)^2) dif x = 3 integral ((x + 1)')/(x + 1) dif x - 8 integral (x + 1)'(x + 1)^(-2) dif x = 3 ln abs(x + 1) - 8 ((x + 1)^(-1))/(-1) + C =\ = 3 ln (x + 1) + 8/(x + 1) + C
$

megjegyzes:
$
  (3x - 5)/((x + 1)^2) = (3x + 3 - 8)/((x + 1)^2) = 3/(x + 1) - 8/((x + 1)^2)
$

== 6
$
  integral (x^3 + x^2 - x + 3)/(x^2 - 1) dif x "  " x in (-1, 1)
$
Ha $integral (P(x))/(Q(x)) dif x: deg(P) >= deg(Q) ==>$ polinomosztas

$
  integral (x(x^2 - 1) + (x^2 - 1) + 4)/(x^2 - 1) dif x = integral (x + 1 + 4/(x^2 - 1)) dif x = (x^2)/2 + x + 4 integral 1/((x - 1)(x + 1)) dif x,
$

$
  integral 1/((x - 1)(x + 1)) dif x = 1/2 integral ((x + 1) - (x - 1))/((x - 1)(x + 1)) dif x = 1/2 integral 1/(x - 1)  dif x - 1/2 integral 1/(x + 1) dif x = 1/2 ln abs(x - 1) - 1/2 ln abs(x + 1) + C =\ =_(-1 < x < 1) 1/2 ln (1 - x) - 1/2 ln ( x - 1) + C
$

== 7
$
  integral 1/(x^3 + 4x) dif x = integral 1/(x (x^2 + 4)) dif x "  " (D < 0)\
  integral (A)/x + (B x + C)/(x^2 + 4)\
  1 = A(x^2 + 4) + x(B x + C)\
  1 = (A + B)x^2 + (C)x + (4A)\
  x^2: A + B = 0\
  x^1: C = 0\
  x^0: 4A = 0\
  A = 1/4, " " B = -1/4\

  integral ((1/4)/x + (-(1/4)x + 0)/(x^2 + 4)) dif x = 1/4 integral 1/x dif x - 1/4 1/2 integral (2x)/(x^2 + 4) dif x =\ = 1/4 ln(x) - 1/8 ln (x^2 + 4) + C
$

== 8
$
  integral (x^3 + 9x - 9)/(x^2 (x^2 + 9)) dif x\
  (A)/x + (B)/(x^2) + (C x + B)/(x^2 + 9) = "hazi feladat"\
  integral (x(x^2 + 9) - (9 + x^2) + x^2)/(x^2 (x^2 + 9)) dif x = integral 1/x dif x - integral 1/x^2 dif x + integral 1/(x^2 + 9) dif x =_(x > 0) ln x - (x^1)/(-1) + 1/9 (arctan(x/3))/(1/3) + C =\ = ln x + 1/x + 1/3 arctan(x/3) + C
$

== 9
$
  integral (7x + 5)/(x^2 + 2x - 3) dif x, "  " D = 4 + 12 = 16, "  " integral (7x + 5)/((x - 1)(x + 3))\
  A/(x - 1) + B/(x + 3) = 7x + 5 <==> A(x + 3) + B(x - 1) = 7x + 5 <==> (A + B)x + (3A - B) = 7x + 5 ==>\ ==> A = 3, " " B = 4\
  integral (3/(x - 1) + 4/(x + 3)) dif x = 3 integral 1/(x - 1) dif x + 4 integral 1/(x + 3) dif x = 3 ln abs(x - 1) + 4 ln abs(x + 3) + C =\ = 3 ln (1 - x) + 4 ln (x + 3) + C
$

== 10
$
  integral (2 - x)/(x^2 - 2x + 10) dif x, "  " D = 4 - 40, "  " (x^2 - 2x + 10)' = 2x - 2\
  2 - x = -1/2(2x + 2) + 1 ==> -1/2 integral (2x - 2)/(x^2 - 2x + 10) + 1/(x^2 - 2x + 10) dif x = -1/2 ln abs(x^2 - 2x + 10) + C + integral 1/(x^2 - 2x + 10) dif x\
  integral 1/(x^2 - 2x + 10) dif x = integral 1/((x - 1)^2 + 3^2) dif x = 1/3 arctan((x - 1)/3)\
  ==> -1/2 ln (x^2 - 2x + 10) + 1/3 arctan ((x - 1)/3) + C
$

== 11
$
  integral (x^3 - 4)/(x^3 + x) dif x = integral ((x^3 + x) - x - 4)/(x^3 + x) dif x = integral 1 dif x - integral (x + 4)/(x^3 + x) dif x\
  (x + 4)/(x^3 + x) = (x + 4)/(x(x^2 + 1)) ==> A/x + (B x + C)/(x^2 + 1) = x + 4 ==> A(x^2 + 1) + (B x + C)x = x + 4 ==> x^2(A + B) + C x + A = x + 4 ==>\ ==> A = 4, " " B = -4, " " C = 1\
  integral 1 dif x - 4 integral 1/x dif x - integral (1 - 4x)/(x^2 + 1) dif x =_(x > 0) x - 4 ln x - integral 1/(x^2 + 1) dif x + 2 integral (2x)/(x^2 + 1) dif x + C =\ = x - 4 ln x - arctan x + 2 ln (x^2 + 1) + C
$

