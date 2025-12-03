== bemelegites
$
  integral_0^pi e^(-x) cos^2 x dif x = integral_0^pi e^(-x) (1 + cos 2x)/2 dif x = 1/2 integral_0^pi e^(-x) dif x + 1/2 integral_0^pi e^(-x) cos x dif x =\ = 1/2 [e^(-x)]_0^pi + 1/2 integral_0^pi e^(-x) cos x dif x = 1/2 (1 - 1/(e^pi)) + 1/2 integral_0^pi e^(-x) cos x dif x = (e^pi - 1)/(2 e^pi) + 1/2 integral_0^pi e^(-x) cos x dif x\

  integral_0^pi e^(-x) cos x dif x = integral_0^pi e^(-x) cos 2x dif x = -e^(-x) cos 2 x - integral (-e^(-x))(cos 2x)' dif x =\ = [-e^(-x) cos 2x]_0^pi - integral_0^pi (-e^(-x))(cos 2x)' dif x = 1 - (cos 2 pi)/(e^pi) - 2 integral_0^pi e^(-x) sin 2 x dif x =\ = 1 - 1/e^pi - 2[[-e^(-x) sin 2x]_0^pi - integral_0^pi (-e^(-x) cos 2x dot 2 dif x)](-e^(-x))' = (e^pi - 1)/(e^pi) - 2 [0 - 4 integral_0^pi e^(-x) cos 2x dif x] ==>\ ==> integral_0^pi e^(-x) cos x dif x = (1 - e^pi)/(7 e^pi) ==> "Eredeti integral:" (e^pi - 1)/(2 e^pi) + (1 - e^pi)/(14 e^pi) = underline((e^pi - 3)/(7 e^pi))
$

= Alkalmazasok
== 1. Terulet
=== 1. pelda
$
  y = x - 1, " " y^2 = 2x + 6, " kozrefogott kozos terulet?"\
  // todo jo abra kene
$
/ 1:
$
  y = plus.minus sqrt(2x + 6) \
  (x - 1)^2 = 2x + 6 ==> x^2 - 2x + 1 - 2x - 6 = 0 ==> x^2 - 4x - 5 = 0 ==> (x - 5)(x + 1) = 0
  // ezt felrajzolni egy jobbra dolt parabola es egyenes metszespontokkal
  // T_1,2,3-ra bontas
  // mindig felso fuggveny - also fuggveny
$

/ 2:
$
  T_1 = integral_(-3)^(-1) sqrt(2x + 6) dif x "   " u = sqrt(2x + 6), " " x = (u^2 - 6)/2, " " x' = u\
  integral_(-3)^(-1) sqrt(2x + 6) dif x = integral_0^2 u u dif u [u^3/3]_0^2 = 8/3
$

\
$
  T_3 = integral_(-1)^5 [sqrt(2x + 6) - (x - 1)] dif x "   " u = sqrt(2x + 6), " " x = (u^2 - 6)/2, " " x' = u\
  integral_2^4 (u - (u^2 - 6)/2 + 1 ) u dif u = integral_2^4 (u^2 - 1/2 u^3 + 4u) dif u = [u^3/3 - u^4/8 + 2u^2]_2^4 = 4^3/3 - 4^3/2 + 2 dot 4^2 - 8/3 + 2 - 8 =\ = 56/3 + 26 - 32 = 56/3 - 6 = underline(38/3)
$

Tehat:
$
  T = 2 dot 8/3 + 38/3 = 54/3 = underline(underline(18))
$

=== 2. pelda
milyen aranyu reszekre osztja a $y^2 = 2x$ az $x^2 + y^2 = 8$ teruletet?
$
  x^2 + y^2 = 8 = (2 sqrt(2))^2\
  T = (T_1 + T_2)/(T_("felkor") - (T_1 + T_2))\
$

metszespontok
$
  x^2 + 2x = 8 <==> x^2 + 2x - 8 = 0 ==> x_1 = 2, x_2 = -4 "  (-4 nem felel meg)"
$

$
  T_1 = integral_0^2 sqrt(2x) dif x = sqrt(2) integral_0^2 sqrt(x) dif x = sqrt(2) [(x^(3/2))/(3/2)]_0^2 = (2 sqrt(2))/3 [2^(3/2) - 0^(3/2)] = (2 sqrt(2))/3 dot 2 sqrt(2) = 8/3
$

\
$
  T_("felkor") = (pi (sqrt(8))^2)/2 = 4pi
$

\
$
  T_2 = T_(O A C) - T_(O A B) = T_("kor")/8 - (2 dot 2)/2 = (8 pi)/8 - 2 = pi - 2
$

A keresett arany:
$
  T = (T_1 + T_2)/(T_("felkor") - (T_1 + T_2)) = (8/3 + pi - 2)/(4 pi - (8/3 + pi - 2)) = (2/3 + pi)/(4 pi - pi - 2/3) = (2/3 + pi)/(3pi - 2/3) = underline(underline((3 pi + 2)/(9 pi - 2)))
$

== 2. forgastest terfogata/felszine
$
  0 <= f in R[a, b] ==> exists V = pi integral_a^b f^2(x) dif x
$

=== 1. pelda
$
  f(x) = sin^2x "  " x in [0, pi]\
  exists V =_(f in C[0, pi] ==> f in R[0, pi]) pi integral_0^pi f^2(x) dif x = pi integral_0^pi sin^4 x dif x = pi integral_0^pi (sin^2 x)^2 dif x = pi integral_0^pi ((1 - cos 2x)/2)^2 dif x =\ =  pi/4 integral_0^pi (1 - 2 cos 2x + cos^2 2x) dif x = pi/4 integral_0^pi (3/2 - 2 cos 2x + 1/2 cos 4x) dif x = pi/4 [3/2 x - sin 2x + (sin 4x)/2]_0^pi =\ = pi/4 ((3 pi)/2 - sin 2 pi + (sin 4 pi)/8 - 0) = pi/4 dot (3 pi)/2 = underline(underline((3 pi^2)/8))
$

#pagebreak()
== 3. ivhossz
$
  f in C^1[a, b] ==> exists l = integral_a^b sqrt(1 + (f'(x))^2) dif x\
$

=== 1. pelda
$
  f(x) := (2 (x - 1)^(3/2))/3 "  " 2 <= x <= 5\
  f in C^1 in [2, 5] ==> exists l = integral_2^5 sqrt(1 + [((2 (x - 1)^(3/2))/3)']^2) dif x = integral_2^5 sqrt(1 + (2/3 dot 3/2 dot (x + 1)^(1/2) dot 1)^2) dif x = integral_2^5 sqrt(1 + x - 1) dif x =\ = integral_2^5 sqrt(x) dif x = [(x^(3/2))/(3/2)]_2^5 = 2/3 (5 sqrt(5) - 2 sqrt(2))
$

== 4. hatarertek
$
  lim_(n arrow +infinity) (1/(n + 1) + 1/(n + 2) + dots + 1/(n + n)) = ?\
  lim_(n arrow +infinity) 1/n dot (underbrace(1/(n + 1/n) + 1/(n + 2/n) + dots + 1/(1 + k/n) + dots + 1/(1 + n/n), sum^n_(k = 1) 1/(1 + k/n)))\
  lim_(n arrow +infinity) 1/n dot sum^n_(k = 1) 1 + k/n =_(" ahol " f(x) = 1/(1 + x)) lim_(n arrow +infinity) 1/n sum^n_(k = 1) f(k/n) = lim_(n arrow +infinity) s(f, tau_n)\
  f in C[0, 1] ==> f in R[0, 1] and lim_(n arrow +infinity) (s_n, f) = integral_0^1 1/(1 + x) dif x = [ln(x + 1)]_0^1 = ln 2 - ln 1 = underline(ln 2)
$

