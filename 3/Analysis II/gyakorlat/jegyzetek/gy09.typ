= 1. Racionalis tortek integralasa

cel: $integral (P(x))/(Q(x)) dif x " " (x in I, Q(x) != 0) " " P, Q "polinom"$

minden ilyen tort felbonthato elemi tortek linearis kombinaciojara

Alaptort tipusok
== 1
$
  integral (1/(a x + b)^n) dif x " " (n in NN^+, a,b != 0)
$

pl
$
  integral 1/((3x - 2)^5) dif x = 1/3 integral (3x-2)' dot (3x - 2)^5 = 1/3 dot ((3x - 2)^(-5 + 1))/(-5 + 1) + C
$

$
  integral 1/(7x + 5) dif x " " (x > -5/7) = 1/7 integral ((7x + 5)')/(7x + 5) = 1/7 ln abs(7x + 5) + C = 1/7 ln (7x + 5) + C
$

== 2
$
  integral (A x + B)/(a x^2 + b x + c) dif x " " (A,B, a, b, c in RR, a != 0 "es nincs valos gyoke a nevezonek")
$

pl
$
  integral (3x - 1)/(x^2 + 4x + 7) dif x, "  " D =  16 - 28 < 0, "  " (x^2 + 4x + 7)' = 2x + 4\
  3/2 integral (2x + 2/3)/(x^2 + 4x + 7) dif x = 3/2 integral (2x + 4 - 4 + 2/3)/(x^2 + 4x + 7) dif x = 3/2 integral ((x^2 + 4x +7)')/(x^2 + 4x + 7) dif x = 3/2 dot 10/3 integral 1/(x^2 + 4x + 7) dif x =\ = 3/2 ln abs(x^2 + 4x + 7) - 5 integral 1/((x + 2)^2 + 3) dif x = 3/2 ln (x^2 + 4x + 7) - 5/3 integral 1/(1 + ((x + 2)/(sqrt(3)))^2) dif x =\ = 3/2 ln (x^2 + 4x + 7) - 5/3 (arctan((x+2)/(sqrt(3))))/(1/(sqrt(3))) + C
$

== 3
$
  integral (A x + B)/((a x^2 + b x + c)^n) dif x "  " (A,B,a,b,c in RR, a != 0, b^2 - 4a < 0, n in NN, n >= 2)
$

#pagebreak()
= 2. Racionalis tortek felbontasa
== a
$
  integral (7x + 1)/(x^2 - 6x + 8) dif x, "  " D = 36 - 32 = 4
$
1. lepes, nevezo fakotorizacioja
$
  x^2 - 6x + 8 = (x - 2)(x - 4)
$

$
  integral (7x + 1)/((x - 2)(x - 4)) dif x
$

1. modszer, egyenlo egyutthatok
$
  (7x + 1)/((x - 2)(x - 4)) = (A)/(x-2) + (B)/(x-4) "  " (x in (2,4))\
  7x + 1 = A(x - 4) + B(x - 2) "  " (forall x in RR)\
  7x + 1 = (A + B)x + (-4A - 2B)\
  x^1 "egyutthatoi": A + B = 7\
  x^2 "egyutthatoi": -4A - 2B = 1\
  A = -15/2, B = 7 + 15/2 = 29/2
$

2. modszer, ertekadas
$
  "Ha" x = 4 ==> 29 = 2B ==> B = 29/2\
  "Ha" x = 2 ==> 15 = -2A ==> A = -15/2
$

$
  ==> integral ((-15/2)/(x - 2) + (29/2)/(x - 4)) dif x = 29/2 integral 1/(x - 4) dif x - 15/2 integral 1/(x - 2) dif x =\ = 29/2 ln abs(x - 4) - 15/2 ln abs(x - 2) + C =_(2 < x < 4) = 29/2 ln (4 - x) - 15/2 ln(x - 2) + C
$

#pagebreak()
== b
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

== c
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

#pagebreak()
== d
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

== e
$
  integral (x^3 + 9x - 9)/(x^2 (x^2 + 9)) dif x\
  (A)/x + (B)/(x^2) + (C x + B)/(x^2 + 9) = "hazi feladat"\
  integral (x(x^2 + 9) - (9 + x^2) + x^2)/(x^2 (x^2 + 9)) dif x = integral 1/x dif x - integral 1/x^2 dif x + integral 1/(x^2 + 9) dif x =_(x > 0) ln x - (x^1)/(-1) + 1/9 (arctan(x/3))/(1/3) + C =\ = ln x + 1/x + 1/3 arctan(x/3) + C
$

hazi:
orai peldak barmelyike\
hazi: 1
