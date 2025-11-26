van meg egy ilyen tipus amit nem beszeltunk meg
$
  integral R (sin x, cos x) dif x;
$

== cheat kodok:
$
  sin 2x = 2 sin x cos x\
  sin x = 2 sin x/2 cos x/2 = 2 tg x/2 cos^2 x/2 = underline((2 tg x/2)/(1 + tg^2 x/2))\
  1 + tg^2 alpha = 1 + (sin^2 alpha)/(cos^2 alpha) = (1)/(cos^2 alpha) ==> cos^2 alpha = 1/(1 + tg^2 alpha)\
  cos x = cos^2 x/2 - sin^2 x/2 = cos^2 x/2 (1 - tg^2 x/2) = underline((1 - tg^2 x/2)/(1 + tg^2 x/2))\
$

== a)
$
  integral 1/(sin x) dif x "  " x in (0, pi)\
  u = tg x/2 ==> x = 2 arctan u ==> x' = 2/(1 + u^2)\
  integral 1/((2u)/(1 + u^2)) 2/(1 + u^2) dif u = integral 1/u dif u = underline(ln abs(tg x/2) + C)
$

== b)
$
  integral (1 + sin x)/(1 - cos x) dif x "  " x in (0, pi)\
  u = tg x/2 > 0 ==> x = 2 arctan = g(u) > 0 ==> g arrow.t ==> g'(u) = 2/(1 + u^2) ==> exists g^(-1)(x) = tg x/2\
  integral (1 + (2u)/(1 + u^2))/(1 - (1 - u^2)/(1 + u^2)) 2/(1 + u^2) dif u = integral (1 + u^2 + 2u)/(1 + u^2 - 1 + u^2) 2/(1 + u^2) dif u = integral (u^2 + 2u + 1)/(u^2(u^2 + 1)) dif u = integral (1)/(u^2 - 1) dif u + integral (2u + 1)/(u^2(u^2 + 1)) dif u =\ = arctan u + integral 1/u^2 dif u + 2 integral 1/(u^2(u^2 + 1)) dif u - integral 1/(1 + u^2) dif u =\ = -1/u + 2 integral 1/u dif u - integral (2u)/(u^2 + 1) dif u = -1/u + 2 ln u - ln (u^2 + 1) ==> underline(-1/(tg x/2) + 2 ln(tg x/2) - ln (1 + tg^2 x/2) + C)
$

=== megjegyzes
$
  (u^2 + 2u + 1)/(u^2(u^2 + 1)) = A/u + B/u^2 + (C u + D)/(u^2 + 1)
$

=== masik mod
$
  integral (1 + sin x)/(1 - cos x) dif x = integral ((1 + sin x)(1 + cos x))/((1 - cos x)(1 + cos x)) dif x = integral (1 + cos x + sin x + sin x cos x)/(1 - cos^2 x) dif x =\ = integral 1/(sin^2 x) dif x + integral (cos x)/(sin x) dif x + integral 1/(sin x) dif x + integral (cos x)/(sin x) dif x =\ = -ctg x + integral (sin x)' (sin x)^(-2) dif x + ln (tg x/2) + integral ((sin x)')/(sin x) dif x =\ = - ctg x + ((sin x)^(-1))/(-1) + ln (tg x/2) + ln abs(sin x) + C = underline(- (cos x + 1)/(sin x) + ln(tg x/2) + ln (sin x) + C)
$

nem nez ki ugyanyugy a ket megoldas de szorgalmikent bemutathato hogy ekvivalensek

=== harmadik mod
$
  integral (1 + sin x)/(1 - cos x) dif x = "(felszogre teres)" = integral (1 + 2 sin x/2 cos x/2)/(cos^2 x/2 + sin^2 x/2 - (cos^2 x/2 - sin^2 x/2)) dif x =\ = integral (1)/(2 sin^2 x/2) dif x + integral (cos x/2)/(sin x/2) dif x = underline(- ctg x/2 + 2 ln (sin x/2) + C)
$

#pagebreak()
= hatarozott integral
== a)
$
  integral_10^66 1/(x - root(3, x - 2) - 2) dif x\
  x in [10, 66] ==> f in R[10, 66]\
  u = root(3, x - 2) ==> x = u^3 + 2 = g(u) ==> g'(u) = 3u^2 > 0\
  "Ha " 10 <= x <= 66 ==> 8 <= x - 2 <= 64 ==> root(3, 8) <= root(3, x - 2) <= root(3, 64)\
  "tehat" 2 <= u <= 4\
  integral_2^4 1/(u^3 + 2 - u - 2) 3u^2 dif u = integral_2^4 (3u^2)/(u(u^2 - 1)) dif u = 3 integral_2^4 (3u^2)/(u(u - 1)(u + 1)) dif u = 3 integral_2^4 u/((u - 1)(u + 1)) dif u =\ = 3/2 integral_2^4 ((u - 1) + (u + 1))/((u - 1)(u + 1)) dif u = 3/2 integral_2^4 1/(u + 1) + 1/(u - 1) dif u = 3/2 [ln abs(u + 1) + ln abs(u - 1)]_2^4 =\ = 3/2 (ln abs(5) + ln abs(3) - ln abs(3) - ln abs(1)) = underline(3/2 ln 5)
$

== b)
$
  integral_1^e (sin (ln x))/x dif x\
  f in C[1, e] ==> f in R[1, e]\
  integral_1^e (sin (ln x))/x dif x = integral_1^e (ln x)' dot sin (ln x) dif x = [- cos (ln x)]_1^e = -cos (ln e) + cos (ln 1) = underline(1 - cos 1)
$

=== vagy ha nem veszed eszre:
$
  integral_1^e (sin (ln x))/x dif x\
  u = ln x\
  "ha" x = 1 ==> u = ln 1 = 0\
  "ha" x = e ==> u = ln e = 1\
  x = e^u ==> x' = e^u\
  integral_1^e (sin (u))/e^u dot e^u dif u = integral_0^1 sin u dif u = [-cos u]_0^1 = -cos 1 + cos 0 = underline(1 - cos 1)
$

== c)
$
  integral_(-2)^(sqrt(3) - 2) (dif x)/(x^2 + 4x + 5)\
  f in C[-2, sqrt(3) - 2] ==> f in R[-2, sqrt(3) - 2]\
  integral_(-2)^(sqrt(3) - 2) (dif x)/(x^2 + 4x + 5) = integral_(-2)^(sqrt(3) - 2) 1/((x + 2)^2 + 1) dif x = [(arctan (x + 2))/1]_(-2)^(sqrt(3) - 2) = arctan sqrt(3) - arctan 0 = pi/3
$

== d)
$
  integral_3^4 1/(x^2 - 3x + 2) dif x\
  f in C[3, 4] ==> f in R[3, 4]\
  integral_3^4 1/(x^2 - 3x + 2) dif x = integral_3^4 1/((x - 2)(x - 1)) dif x = integral_3^4 ((x - 1) - (x - 2))/((x - 2)(x - 1)) dif x = integral_3^4 1/(x - 2) - 1/(x - 1) dif x = [ln abs(x - 2) - ln abs(x - 1)]_3^4 =\ = [ln (abs(x - 2))/(abs(x - 1))]_3^4 = ln 2/3 - ln 1/2 = ln (2/3 dot 2/1) = underline(ln 4/3)
$

