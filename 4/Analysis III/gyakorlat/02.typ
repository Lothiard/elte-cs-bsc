/ emlekezteto: Newton-Leibniz tetel improprius integralokra
TFH $a, b in overline(RR), a < b$ es\
- $f in R[u, v]$ minden $a < u < v < b$\
- $f"-nek" exists F "primitiv fuggvenye" (a, b)"-n"$
Ekkor
$
  integral_a^b f(x) dif x " improprius integral konvergens " <==> exists F(a) := lim_(infinity + 0) F(x) in RR and exists F(b) := lim_(b - 0) F(x) in RR
$
es ekkor
$
  integral_a^b f(x) dif x = lim_(b - 0) F - lim_(a + 0) F
$

/ pl:
/ a): $ integral_(-1)^1 1/(sqrt(1 - x^2)) dif x $
improprius integralkent definicio szerint mindket pontban improprius
$
  integral_(-1)^0 1/(sqrt(1 - x^2)) dif x + integral_0^1 1/(sqrt(1 - x^2)) dif x\
  dots
$
ahhoz kepest nagyon maceras hogy ez tulajdonkeppen mint az $arcsin$ derivaltfuggvenye

hasznaljuk hat inkabb a Newton-Leibniz tetelt\
feltetelek:
- $ 1/(sqrt(1 - x^2)) in R[u, v], " " forall -1 < u < v < 1 $ mert $1/(sqrt(1 - x^2)) in C[u, v]$
- primitiv fuggveny $(-1, 1)$-en; $F(x) = arcsin(x)$

#set math.cases(reverse: true)
$
  cases(
    lim_(x arrow 1 - 0) arcsin(x) = pi/2,
    lim_(x arrow -1 + 0) arcsin(x) = -pi/2
  ) ==> integral_(-1)^1 1/(sqrt(1 - x^2)) dif x = pi/2 - (- pi/2) = underline(underline(pi))
$

#pagebreak()
/ b):
$
  integral_0^(+ infinity) e^(-2x) dot cos(3x) dif x\
  [0, +infinity) " tipus"
$
ezt eredetileg ketszer parcialisan kene integralni de nem celszeru

egyreszt megallapithatjuk hogy $f in C[0, u] ==> R[0, u]$ igy mar csak primitiv fuggvenyt kell keresni es robban a Newton-Leibniz
$
  I = (0, +infinity):\
  integral e^(-2x) dot cos(3x) dif x\
  integral u dot v' = u dot v - integral u' dot v\
  u(x) = e^(-2x) "   " v'(x) = cos(3x)\
  u'(x) = -2 e^(-2x) "   " v(x) = (sin(3x))/3\
  integral e^(-2x) dot cos(3x) dif x = (e^(-2x) dot sin(3x))/3 = integral (-2) e^(-2x) dot (sin(3x))/3 dif x = (e^(-2x) dot sin(3x))/3 + 2/3 dot integral e^(-2x) dot sin(3x) dif x =\
  = (e^(-2x) dot sin(3x))/3 +2/3 dot [(e^(-2x) dot (-cos(3x)))/3 - underbrace(integral (-2) e^(-2x) dot (-cos(3x))/3 dif x, -2/3 dot integral e^(-2x dot cos(3x) dif x))] =\
  = (e^(-2x) dot sin(3x))/3 - 2/9 dot e^(-2x) dot cos(3x) - 4/9 dot integral e^(-2x) dot cos(3x) dif x
$

Tehat ha $I(x)$ egy primitiv fuggveny:
$
  I(x) + C = (e^(-2x) dot sin(3x))/3 - (2 e^(-2x) dot cos(3x))/9 - 4/9 I(x)\
  I(x) = (3 e^(-2x) dot sin(3x))/13 - (2 e^(-2x) dot cos(3x))/13 + C
$

- $
    lim_(x arrow 0 + 0) I(x) = I(0) = -2/13
  $

- $
    lim_(x arrow + infinity) I(x) = lim_(x arrow +infinity) (3 sin(3x))/(13 e^(2x)) - (2 cos(3x))/(13 e^(2x)) = 0 - 0 = 0 ==>\ ==> integral_0^(+infinity) e^(-2x) dot cos(3x) dif x = 0 - (-2/13) = underline(underline(2/13))
  $

#pagebreak()
/ c):
$
  integral_(sqrt(3))^(+infinity) (x + 3)/((x - 1)(x^2 + 1)) dif x\
  [sqrt(3), +infinity) " tipus"
$
- $f in R[sqrt(3), u], forall u in (sqrt(3), +infinity)$ mert $f in C[sqrt(3), u]$
- primitiv fuggveny:
$
  integral (x + 3)/((x - 1)(x^2 + 1)) dif x = integral (A)/(x - 1) + (B x + C)/(x^2 + 1) dif x\
  "kell": (x + 3)/((x - 1)(x^2 + 1)) = (A(x^2 + 1) + (B x + C)(x - 1))/((x - 1)(x^2 + 1)) " " forall x\
  0x^2 + x + 3 = (A + B)x^2 + (C - B)x + (A - C)\
  cases(
    A + B = 0,
    C - B = 1,
    A - C = 3,
  ) ==> cases(
    A = 2,
    B = -2,
    C = -1
  )
$
tehat
$
  integral (x + 3)/((x - 1)(x^2 + 1)) dif x = integral 2/(x - 1) + (-2x - 1)/(x^2 + 1) dif x = 2 dot integral 1/(x - 1) dif x - integral (2x + 1)/(x^2 + 1) dif x =\ = 2 dot integral ln(x - 1) - integral (2x)/(x^2 + 1) dif x - integral 1/(x^2 + 1) dif x =\ = 2 ln(x - 1) - ln(x^2 + 1) - arctan(x) + C
$

- $
    lim_(x arrow sqrt(3) + 0) F(x) = F(sqrt(3)) = 2 ln(sqrt(3) - 1) - ln(4) - arctan(sqrt(3))
  $
- $
    lim_(x arrow +infinity) F(x) = lim_(x arrow +infinity) (2 ln (x - 1) - ln(x^2 + 1) - arctan(x)) = (+infinity) - (+infinity) - pi/2 -> "kritikus hatarertek"\
  $
ezert
$
  lim_(x arrow +infinity) F(x) = lim_(x arrow +infinity) (2 ln (x - 1) - ln(x^2 + 1) - arctan(x)) =\ = lim_(x arrow +infinity) (ln((x - 1)^2/(x^2 + 1)) - arctan(x)) arrow 1 "  " (x arrow +infinity)
$
tehat
$
  lim_(x arrow +infinity) F(x) = ln(1) - pi/2 = pi/2
$
$
  integral_(sqrt(3))^(+infinity) (x + 3)/((x - 1)(x^2 + 1)) dif x= underline(underline((-pi/2) - (2 ln(sqrt(3) - 1) - ln(4) - pi/3)))
$

#pagebreak()
/ megjegyzes: improprius integral konvergenciaja
TFH $f, g: I arrow [0, +infinity)$, es TFH $f(x) <= g(x) " " forall x in I$\
Ekkor
- ha
$
  integral_(I) g(x) dif x " konvergens" => integral_I f(x) dif x " konvergens"\
  integral_(I) f(x) dif x " divergens" => integral_I g(x) dif x " divergens"
$

/ pl:
$
  integral_1^(+infinity) 1/(2x + root(3, x^2 + 1) + 5) dif x
$

/ otlet:
$
  1/(2x + root(3, x^2 + 1) + 5) approx 1/(x + x^(2/3) + 1) approx 1/x " es " integral_1^(+infinity) 1/x dif x " divergens"
$

/ sejtes: az integral divergens
csinaljunk also becslest aminek az integralja divergens

$
  f(x) = 1/(2x + root(3, x^2 + 1) + 5) >=_("NRA") (1)/(2x + root(3, x^3 + x^3) + 5x) = 1/(9x) "  ha " x >= 1
$

tehat $ [1, +infinity) f(x) >= 1/(9x) " es " integral_1^(+infinity) 1/(9x) dif x = +infinity " div " ==> integral_1^(+infinity) f(x) dif x " div " $

/ megjegyzes:
$
  integral_0^1 1/(root(3, x) + 2 root(4, x) + x^3) dif x " konvergens?" (0, 1]
$

ebben az esetben pont az a lenyeg hogy $(0, 1]$ intervallumon a legnagyobb kitevoju gyokos tag a dominans, ezert mindig tekintettel kell lenni milyen intervallumon nezzuk
$
  ~ integral_0^1 1/(x^(1/4)) dif x " konvergens"
$

/ sejtes:
$
  "konvergens " ==> " felso becsles konvergenssel"
$

$
  1/(root(3, x) + 2 root(4, x) + x^3) dif x <= 1/(0 + 2 root(4, x) + 0) = 1/(root(2 4, x)) " es " integral_0^1 1/(2 root(4, x)) dif x " konvergens"
$

#pagebreak()
/ megjegyzes:
$
  integral_1^(+infinity) (sin x)/x dif x
$
itt a primitiv fuggveny nem elemi, igy nem tudjuk kiszamitani ezt az erteket. ilyenkor. ilyenkor lehet becsulni hogy ez egy konvergens improprius integral
