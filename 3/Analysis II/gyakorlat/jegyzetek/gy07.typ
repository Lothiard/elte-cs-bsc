ennyi volt a differencialas eleg is volt

tipusok:

\
1. alapintegralok es ezekre vezetheto tipusok

lasd tablazat

pl:\
- $sin'x = cos x (x in RR) ==> integral cos x dif x = sin x + C$\
- $arctan'x = 1/(1 + x^2) dif x ==> integral 1/(1 + x^2) dif x = arctan x + C$\
stb

a tablazatot fejbol kene tudni mert anelkul nem fog menni semmi

$
  integral (2x^4 - 3x^2 + x - 71) dif x = 2 integral x^4 dif x - 3 integral x^2 dif x + integral x dif x - 71 integral 1 dif x = 2 x^5/5 - 3 x^3/3 + x^2/2 - 71x + C "  " (C in RR)
$

$
  integral_((x > 0)) sqrt(x sqrt(x sqrt(x))) dif x = integral x^(1/2) dot x^(1/4) dot x^(1/8) dif x = integral x^(1/2 + 1/4 + 1/8) dif x = integral x^(7/8) dif x = x^(7/8 + 1)/(7/8 + 1) + C = 8/15 dot root(8, x^15) + C "  " (C in RR, x > 0)
$

$
  integral_((x > 0)) (x + 1)^2/(sqrt(x)) dif x = integral (x^2 + 2x + 1)/(x^(1/2)) dif x = "osszegre bontas" = integral x^(2-1/2) dif x + 2 integral x^(1-1/2) dif x + integral x^(-1/2) dif x =\ = integral x^(3/2) dif x + 2 integral x^(1/2) dif x + (x^(-1/2 + 1))/(-1/2 + 1) + C = (x^(3/2 + 1))/(3/2 + 1) + 2 (x^(1/2 + 1))/(1/2 + 1) + 2 sqrt(x) + C = 2/5 sqrt(x^5) + 4/3 sqrt(x^3) + 2 sqrt(x) + C "  " (C in RR)
$

$
  integral_(x in RR) (x^2)/(1 + x^2) dif x = integral (x^2 + 1 - 1)/(x^2 + 1) dif x = integral (1 - 1/(x^2 + 1)) dif x = integral 1 dif x - integral 1/(1 + x^2) dif x = x - arctan x + C "  " (x in RR, c in RR)
$

$
  integral_((-pi/2, pi/2)) (cos^2 x - 2)/(1 + cos 2x) = integral (cos^2 - 2)/((cos^2 x + sin^2 x) + (cos^2 x - sin^2 x)) dif x = integral (cos^2 - 2)/(2 cos^2 x) dif x =\ = 1/2 integral 1 - 2/(cos^2 x) dif x = 1/2 integral 1 dif x - integral 1/(cos^2 x) dif x = 1/2 dot x - tan x + C "  " (C in RR)
$

\
2. linearis helyettesites
bemelegites:

$integral sin x dif x = - cos x + C "  " (x, c in RR)$\
$integral sin(3x) dif x = - cos(3x)/3 + C "  " (x, c in RR)$\
$integral sin(7x - 8) dif x = -(cos(7x - 8))/(7) + C (x, c in RR)$\
$integral e^(3 - 5x) dif x = (e^(3 - 5x))/(-5) + C (x, c in RR)$\

tehat

$
  integral_(x in RR) sin^2 x dif x = integral (1 - cos 2x)/(2) dif x = 1/2 integral 1 dif x - 1/2 integral cos 2x  dif x = 1/2 x  - 1/2 dot (sin 2x)/2 + C
$

\ \ \
3. $integral f'(x) dot f^alpha (x) dif x$

ket dolgot hasznalhatunk ilyeknkor
$
  cases(
    (f^(alpha + 1)(x))/(alpha + 1) + c\, & "ha" alpha != 1,
    integral (f'(x))/(f(x)) dif x = ln f(x) + C
  )
$

pl:
$
  integral_(x in (0; +infinity)) 1/x dif x = ln x + C
$

$
  integral_(x in (-infinity; 0)) 1/x dif x = ln(-x) + C
$

tehat
$
  integral 1/x dif x = ln abs(x) + C "  " (x > 0 or x < 0, C in RR)
$

$
  integral_(x in RR) (x)/(x^2 + 3) dif x = integral 1/2 dif x integral (2x)/(x^2 + 3) dif x = 1/2 integral ((x^2 + 3)')/(x^2 + 3) dif x = 1/2 ln abs(x^2 + 3) + C = 1/2 ln (x^2 + 3) + C
$

$
  integral_(x in (0, 1) or x in (1, infinity)) (dif x)/(x ln x) = integral 1/(x ln x) dif x  = integral ((ln x)')/(ln x) dif x = ln abs(ln x) + C = cases(
    ln (ln x) + C\, & "ha" ln x > 0 <==> x in (1, infinity),
    ln (-ln x) + C\, & "ha" ln x < 0 <==> x in (0, 1)
  )
$

$
  integral_(x in (-pi/2, pi/2)) tan x dif x = integral (sin x)/(cos x) dif x = - integral (cos x)'/(cos x) dif x = - ln abs(cos x) + C = -ln(cos x) + C
$
