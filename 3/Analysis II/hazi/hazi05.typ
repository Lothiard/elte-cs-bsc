Rendezzük át a $2x^3 + 5x^2 + 3x + 1$ polinomot $(x + 1)$ hatványai szerint! A feladat általánosításaként mutassuk meg, hogy ha $P$ egy legfeljebb $n$-edfokú polinom és $a in RR$ tetszőleges, akkor minden $x in RR$ esetén
$
  P(x) = sum_(k = 0)^n (P^(k) (a))/(k!) (x - a)^k.
$

$
  P(x) := 2x^3 + 5x^2 + 3x + 1 "  " (x in RR) "  és  " a := -1\
$

$P'(x) = 6x^2 + 10x + 3$\
$P''(x) = 12x + 10$\
$P'''(x) = 12$\
$P^((4))(x) = 0$\

$P(-1) = 1$\
$P'(-1) = -1$\
$P''(-1) = -2$\
$P'''(-1) = 12$\
$P^((4))(-1) = 0$\

Mivel $P in D^(4)(RR)$
$
  forall x in RR \\ {-1} " ponthoz " exists xi " az " a = -1 " és " x " között":\
  P(x) = T_(-1, 4)(P, x) = P(x) - sum_(k = 0)^3 (P^((k))(-1))/k! (x + 1)^k = (P^((4))(-1))/(4!) (x + 1)^4 = 0
$

$
  P(x) = sum_(k = 0)^3 (P^((k))(-1))/k! (x + 1)^k = P(-1) + (P'(-1))/1! (x + 1) + (P''(-1))/(2!) (x + 1)^2 + (P'''(-1))/(3!) (x + 1)^3 =\ = 1 - (x + 1) - (x + 1)^2 + 2(x + 1)^3\
$

$
  P(x) = 2x^3 + 5x^2 + 3x + 1 = 1 - (x + 1) - (x + 1)^2 + 2(x + 1)^3\
$

== 1/a
$
  lim_(x arrow 0 + 0) sin x dot ln x\
  lim_(x arrow 0 + 0) sin x dot ln x = lim_(x arrow 0 + 0) (ln x)/(1/(sin x)) = 0/0 = L'H = lim_(x arrow 0 + 0) (1/x)/(-(cos x)/(sin^2 x)) = lim_(x arrow 0 + 0) -(sin^2 x)/(x cos x) = -(x^2)/(1 dot x) = -x arrow 0
$

== 1/b
$
  lim_(x arrow +infinity) e^(x - x^2) dot ln(x^2 - x + 1)\
  lim_(x arrow +infinity) e^(x - x^2) dot ln(x^2 - x + 1) = lim_(x arrow +infinity) (ln(x^2 - x + 1))/(e^(x^2 - x)) = (+infinity)/(+infinity) = L'H = lim_(x arrow +infinity) ((2x + 1)/(x^2 + x - 1))/(e^(x^2 - x)(2x - 1)) =\ = lim_(x arrow +infinity) 1/(e^(x^2 - x)(x^2 + x - 1)) = 0
$

== 1/c
$
  lim_(x arrow 0 + 0) (1/(arctan x) - 1/x)\
  lim_(x arrow 0 + 0) (1/(arctan x) - 1/x) = lim_(x arrow 0 + 0) (x - arctan x)/(x arctan x) = 0/0 = L'H = (1 - 1/(x^2 + 1))/(arctan x + x/(x^2 + 1))) = 0/0 = L'H =\ = lim_(x arrow 0 + 0) (-(2x)/((x^2 + 1)^2))/(1/(x^2 + 1) + ((x^2 + 1) - 2x^2)/((x^2 + 1)^2)) = lim_(x arrow 0 + 0) ((2x)/((x^2 + 1)^2))/(1/(x^2 + 1) + (1 - x^2)/((x^2 + 1)^2)) = lim_(x arrow 0 + 0) ((2x)/((x^2 + 1)^2))/(2/((x^2 + 1)^2)) = lim_(x arrow 0 + 0) (2x)/2 = lim_(x arrow 0 + 0) x = 0
$

== 1/d
$
  lim_(x arrow 0 + 0) (cos x)^(1/(x^2))\
  lim_(x arrow 0 + 0) (cos x)^(1/(x^2)) = lim_(x arrow 0 + 0) exp(ln((cos x)^(1/(x^2)))) = lim_(x arrow 0 + 0) exp(1/(x^2) ln(cos x))
$
Vizsgáljuk: $lim_(x arrow 0 + 0) = (ln(cos x))/(x^2)$
$
  lim_(x arrow 0 + 0) = (ln(cos x))/(x^2) = 0/0 = L'H = lim_(x arrow 0 + 0) ((- sin x)/(cos x))/(2x) = lim_(x arrow 0 + 0) -(sin x)/(2x cos x) = 0/0 = L'H = lim_(x arrow 0 + 0) - (cos x)/(2 cos x + 2x(- sin x)) = -1/2
$
Ekkor
$
  lim_(x arrow 0 + 0) exp(-1/2) = e^(-1/2)
$

== 2
Írja fel az
$
  root(3, 1 + x) "  " (x in (-1, +infinity))
$
függvény $0$ pont körüli második Taylor-polinomját, $T_(0,2) (f, x)$-et. Adjon becslést az
$
  abs(f(x) - T_(0, 2)(f, x))
$
hibára a $[0, 1/4]$ intervallumon.

$f(x) = root(3, 1 + x)$\
$f'(x) = 1/3 (1+x)^(-2/3) = 1/(3 root(3, (1 + x)^2))$\
$f''(x) = -2/9 (1+x)^(-5/3) = -2/(9 root(3, (1 + x)^5))$\
$f'''(x) = 10/27 (1+x)^(-8/3) = 10/(27 root(3, (1 + x)^8))$\

$f(0) = 1$\
$f'(0) = 1/3$\
$f''(0) = -2/9$\
$f'''(0) = 10/27$\

$
  T_(0, 2)(f, x) = f(0) + f'(0)x + f''(0)x^2 = 1 + 1/3x - 2/9x^2
$

$
  R_2(x) = (f'''(x)(xi))/(3!)x^3 = 10/27
$

not doin allat
