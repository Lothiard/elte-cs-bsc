= konvergencia metrikus- es normalt terekben
/ emlekezteto:
$
  H != nothing, (H, Rho) "metrikus ter"\
  (x_n): NN arrow H " konvergens es " lim(x_n) = A in H\
  <==>\
  forall epsilon > 0: exists N in NN: forall n in NN, n >= N: Rho(x_n, A) < epsilon
$

/ pl:
$
  H != nothing "tetszoleges halmaz, es" Rho(x, y) = cases(0\, " ha" x = y, 1\, " ha" x != y)\
$
Ekkor $(H, Rho)$ terben a konvergens sorozatok:

/ eszrevetel:
$
  epsilon = 1"-re" exists N in NN: forall n in NN, n >= N: Rho(x_n, A) < 1\
  "csak ugy lehet ha" Rho(x_n, A) = 0\
  "ez viszont pontosan akkor van ha" x_n = A\
  "roviden: " lim (x_n) = A <==> exists N in NN: forall n in NN, n >= N: x_n = A)
$

/ emlekezteto:
$
  (x_n): NN arrow H "Cauchy-sorozat" <==> forall epsilon > 0: exists N in NN: forall n, m in NN, " " n, m >= N: Rho(x_n, x_m) < epsilon
$

/ Allitas: ha $(x_n)$ konvergens $==>$ Cauchy-sorozat
/ ugyanis:
$
  Rho(x_n, x_m) <= Rho(x_n, A) + Rho(x_m, A) < exists N in NN: forall n >= N: Rho(x_n, A) < epsilon/2 + epsilon/2 = epsilon\
  "legyen" n, m >= N
$
/ DE:
$
  (x_n) "konvergens" arrow.l.double.not "Cauchy-sorozat"
$

/ Def: $(H, Rho)$ teljes metrikus ter, ha $forall$ Cauchy-sorozat konvergens

/ pl:
$
  (H, Rho), " " Rho "diszkret metrika. teljes-e?"\
  "legyen" (x_n): NN arrow H "Cauchy-sorozat": forall epsilon > 0: exists N in NN: forall n, m >= N: Rho(x_n, x_m) < epsilon\
  epsilon = 1"-re" exists N in NN: forall n, m >= N: Rho(x_n, x_m) < 1 ==> Rho(x_n, x_m) = 0 <==> x_n = x_m\
  "Roviden: " exists N in NN: forall n, m >= N: x_n = x_m ==>_(m := N) x_n = x_N " " (forall n >= N) ==>\ ==> (x_n) "konvergens es " lim(x_n) = x_N\
$
tehat minden Cauchy-sorozat konvergens $==>$ teljes ter

#pagebreak()
/ emlekezteto: $(H, norm(dot))$ normalt terben:
- $lim(x_n) = A <==> forall epsilon > 0 " " exists n in NN: forall n >= N: norm(x_n - A) < epsilon$
- $(x_n)$ Cauchy-sorozat $<==> forall epsilon > 0 " " exists N in NN: forall n, m >= N: norm(x_n - x_m) < epsilon$

/ emlekezteto:
- $(RR, abs(dot))$ teljes
- $(RR^n, norm(dot))$ teljes (minden normaval, barmely $2$ norma ekvivalens!)

/ emlekezteto:
$
  norm(f)_p = cases(
    (integral_a^b abs(f)^p)^(1/p)\, "       " 1 <= p < +infinity,
    max_(x in [a, b]) abs(f(x))\, " " p = +infinity
  )
$

- $(C[a, b], norm(dot)_infinity)$
$
  Rho(f, g) = norm(f - g)_infinity = max_(x in [a, b]) abs(f(x) - g(x))\
  g in K_epsilon (f) <==> f(x) - epsilon <= g(x) <= f(x) + epsilon " " forall x in [a, b]
$

/ emlekezteto: $(C[a, b], norm(dot)_infinity)$ teljes normalt ter

/ emlekezteto:
$
  (f_n): NN arrow C[a, b], lim(f_n) = f in C[a, b] <==> forall epsilon > 0: exists N in NN: forall n >= N: norm(f_n - f)_infinity < epsilon
$

/ pl:
$
  f_n(x) = (n^2 x^3)/(1 + n^2 x^4) in C[1, 2]\
$
$f_0(x) = 0$\
$f_1(x) = (x^3)/(1 + x^4)$\
$f_2(x) = (4x^3)/(1 + 4x^4)$\
$dots$\

/ otlet: barmely rogzitett $x in [1, 2]$-re $f(x) := lim_(n arrow +infinity) f_n(x)$ (valos szamsorozat hatarerteke)\ ez a pontonkenti hatarfuggveny

/ emlekezteto: Ha $(f_n)$ konvergens $norm(dot)_infinity$-ban $==> lim(f_n) =^(norm(dot)_infinity) f$ pontonkenti hatarfuggveny

/ !: most
$ f(x) := lim_(n arrow +infinity) (n^2 x^3)/(1 + n^2 x^4) " " x in [1, 2] "rogzitett" $
$f(1) = lim n^2/(1 + n^2) = 1$\
$f(2) = lim (8n^2)/(1 + 16n^2) = 1/2$

$
  f(x) := lim_(n arrow +infinity) (n^2 x^3)/(1 + n^2 x^4) =_("dominans tag kiemeles") lim_(n arrow +infinity) (n^2)/n^2 dot x^3/(1/n^2 + x^4) = x^3/x^4 = 1/x
$

$
  f(x) = 1/x, " " x in [1, 2] " pontonkenti hatarfuggveny"
$

nezzuk $norm(dot)_infinity$-ban:
nezzuk:
$
  forall epsilon > 0: exists N in NN: n >= N: underbrace(norm(f_n - f)_infinity, max_(x in [1,2]) abs((n^2 x^3)/(1 + n^2 x^4) - 1/x)) < epsilon\
  <==>\
  (lim_(n arrow +infinity) norm(f_n - f)_infinity = 0)\
  max_(x in [1,2]) abs((n^2 x^3)/(1 + n^2 x^4) - 1/x) = max_(x in [1, 2]) abs((n^2 x^4 - (1 + n^2 x^4))/(x(1 + n^2 x^4))) = max_(x in [1, 2]) abs((-1)/(x(1 + n^2 x^4))) = max_(x in [1, 2]) (-1)/(x(1 + n^2 x^4)) = 1/(1 + n^2) < epsilon ==>\ ==> "konvergens a " norm(dot)_infinity"-ban"
$

/ $norm(dot)_1$:
$
  norm(f)_1 = integral_a^b abs(f)\
  norm(f - g)_1 = integral_a^b abs(f - g)
$

/ emlekezteto: ez egy nem teljes ter.

konkret feladat folytatasa:
$
  f_n(x) = (n^2 x^3)/(1 + n^2 x^4) in C[1, 2]\
  norm(dot)_infinity -> f(x) = 1/x " pontonkenti hatarfuggveny"
  -> "" lim f_n =^(norm(dot)_infinity) f\
$
- $norm(dot)_1$-ban: mivel $norm(dot)_infinity$-ben konvergens $ ==> norm(f_n - f)_1 = integral_1^2 underbrace(abs(f_n(x) - f(x)), <= max_(x in [1, 2] abs(f_n(x) - f(x)) = norm(f_n - f)_infinity)) dif x <= integral_1^2 underbrace(norm(f_n - f)_infinity, 1/(1 + n^2) "konstans") dif x = norm(f_n - f)_infinity dot (2 - 1) arrow.long_(n arrow +infinity) 0 $

/ altalanosan:
$
  f_n "konvergal" norm(dot)_infinity"-ban" ==> lim(f_n) =^(norm(dot)_1) f
$
