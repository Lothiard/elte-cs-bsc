= Racionalis helyettesitesek
/ 1: tipus
$
  integral R (e^x) dif x,
$
== pl
=== 1
$
  integral e^(3x)/(e^x - 2) dif x "  " (x in RR)
$
== Masodik helyettesitesi szabaly:
TFH $I, J subset RR$ nyílt intervallumok,\ $f: I arrow RR, g: J arrow I$ bijekció,\ $g in D(J),\ g'(x) != 0 " " (forall x in J)$\ és az $f circle.small g dot g': J arrow RR$ függvényeknek van primitív függvénye.\ Ekkor az $f$ függvénynek is van primitív függvénye és
$
  integral f(x) dif x =_(x = g(t)) integral f(g(t)) dot g'(t) dif t_(| t = g^(-1)(x)) "  " (x in I)
$

masodik helyettesitei szabaly szerint
\
legyen
$
  t := e^x
$
$
  integral e^(3x)/(e^x - 2) dif x =_(t := e^x > 0\ x = ln t = g(t)\ g'(t) = 1/t > 0 ==> g arrow.t ==> exists g^(-1) = e^x) integral (t^3)/(t + 2) dot 1/t dif t_("  "| t = e^x = g^(-1)(x))
$
$
  = integral (t^2)/(t + 2) dif t = integral (t^2 - 4 + 4)/(t + 2) dif t = integral ((t - 2)(t + 2) + 4)/(t + 2) dif t = integral (t - 2 + 4/(t + 2)) dif t = t^2/2 - 2t + 4 integral ((t + 2)')/(t + 2) dif t =\ = t^2/2 - 2t + 4 ln abs(t + 2) + C = t^2/2 - 2t + 4 ln (t + 2) + C
$
vissza $x$-re
$
  integral e^(3x)/(e^x + 2) dif x = underline(e^(2x)/2 - 2e^x + 4 ln (e^x + 2) + C)
$

Egyezmenyes rovid jeloles:
$
  x = ln t ==>_(()') 1 dif x = 1/5 dif t
$

=== 2
$
  integral 4/(e^(2x) - 4) dif x\
  e^(2x) > 4 ==> 2x > ln 4 <==> x > 1/2 ln 4 = ln 2\
  e^(2x) = t > 4\
  (x > ln 2) | ==> 2x = ln t ==> 1/2 ln t = g(t) " " (t > 4) ==> g'(t) = 1/(2t) > 0 " " (forall t > 4) ==> g arrow.t (4; +infinity) ==>\ ==> exists g^(-1)(x) = e^(2x) " " (x > ln 2) " es g bijektiv"\
  = integral 4/(t - 4) dot 1/(2t) dif t = integral 2/(t(t - 4)) dif t = 2/4 integral (t - (t - 4))/(t(t - 4)) dif t = 1/2 integral 1/(t - 4) dif t - 1/2 integral 1/t dif t = 1/2 ln abs(t - 4) - 1/2 ln abs(t) + C =_(t > 4) =\ = 1/2 ln (t - 4) - 1/2 ln t + C = 1/2 ln (t - 4)/t + C
$

$
  integral 4/(e^(2x) - 4) dif x = 1/2 ln (e^(2x) - 4)/(e^(2x)) + C
$

/ 2: tipus
$
  integral R (x; root(n, (a x + b)/(c x + d))) dif x;
$
ilyenkor
$
  t := root(n, (a x + b)/(c x + d))
$

== pl
=== 1
$
  integral 1/(1 + sqrt(x)) " " (x > 0) =_(t = sqrt(x) > 0\ ==> x = t^2 = g(t) " " (t > 0) ==> g'(t) ==> t > 0 " ha" (t > 0)\ ==> g arrow.t (0, +infinity) ==> exists g^(-1)(x) = sqrt(x) " " (x > 0)) integral 1/(1 + t) 2t dif t
$
$
  ==> 2 integral t/(t + 1) dif t = 2 integral (t + 1 - 1)/(t + 1) dif t = 2 integral (1 - 1/(t + 1)) dif t = 2 integral 1 dif t - 2 integral 1/(1 + t) dif t = 2t - 2 ln abs (t + 1) + C =\ =_(t > 0) 2 t - 2 ln (t + 1) + C
$
$
  integral 1/(1 + sqrt(x)) = underline(2 sqrt(x) - 2 ln (sqrt(x) + 1) + C)
$

=== 2
$
  integral x sqrt(5x + 3) dif x " " (x > -3/5)\
  integral x sqrt(5x + 3) dif x =_(t := sqrt(5x + 3) > 0, ==> x = (t^2 - 3)/5 = g(t) " " (t > 0)\ g'(t) = 2/5 t > 0 ==> " ha"(t > 0) ==> g arrow.t (0, +infinity) ==> R_g = (-3/5, +infinity);\ g " bijekcio" (0, +infinity) " es "a (-3/5; +infinity) " kozott ") integral (t^2 - 3)/5 dot t dot 2/5 t dif t_( | t = sqrt(5x + 3))
$
az uj integral:
$
  2/25 integral (t^2 - 3) t^2 dif t = 2/25 integral (t^4 - 3 t^2) dif t = 3/25 (t^5/5 - t^3) + C
$
$
  ==> integral x sqrt(5x + 3) dif x = underline(2/125 (sqrt(5x + 3))^5 - 3/25 (sqrt(5x + 3))^3 + C)
$

=== 3
$
  integral 1/(x^2) root(3, (x + 1)/x) dif x " " (x > 0) =_(t := root(3, (x + 1)/x) = root(3, 1 + 1/x) > root(3, 1 + 0) "ha" x > 0\ ==> t^3 = 1 + 1/x ==> x = 1/(t^3 - 1) = g(t) " " (t > 1) ==>\ ==> g'(t) = - 1/((t^3 - 1)^2) dot (3t^2) = - (3t^2)/((t^3 - 1)^2) < 0 " " (forall t > 0) ==>\ ==> g arrow.b (1; + infinity), "es " R_g = (0, +infinity) = D_f = I,\ exists g^(-1)(x) = root(3, (x + 1)/x)) = integral 1/((1/(t^3 - 1))^2) dot t dot (-3 t^2)/((t^3 - 1)^2) dif t_(|_(t = root(3, (x + 1)/x)))
$
$
  = -3 integral t^3 dif t = -3 [t^4/4 + C]_(t = root(3, (x + 1)/x)) = underline(-3/4 (root(3, (x + 1)/x))^4 + C)
$

=== megjegyzes
$
  - integral  (1 + 1/x)'(1 + 1/x)^(1/3) dif x = -((1 + 1/x)^(1/3 + 1))/(1/3 + 1) + C = underline(-3/4 (root(3, (x + 1)/x))^4 + C)
$

=== 4
$
  integral 1/(sqrt(x) + root(3, x)) dif x =_(t := root(6, x) > root(6, 0) = 0\ ==> x = t^6 = g(t) ==> g'(t) = 6t^5 > 0 " ha"(t > 0) ==> g arrow.t (0; +infinity) " es " R_g = (0, +infinity)) integral 1/(t^3 + t^2) 6 t^5 dif t_( | root(6, x)) = 6 integral t^3/(t + 1) dif t_( | t = root(6, x))
$
uj integral:
$
  integral (t^3 + 1^3 - 1)/(t + 1) dif t = integral ((t + 1)(t^2 - t + 1) - 1)/(t + 1) dif t = integral (t^2 - t + 1 - 1/(t + 1)) dif t = t^3/3 - t^2/2 + t - ln(underbrace(t + 1, +)) + C
$
$
  integral 1/(sqrt(x) + root(3, x)) dif x = underline(((root(6, x))^3)/3 - ((root(6, x))^3)/2 + root(6, x) - ln(root(6, x) + 1) + C)
$

hazi a, b, c\
gyakorlo 2, 3b
