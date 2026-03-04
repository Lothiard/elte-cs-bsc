= Metrikus terek
$(H, Rho)$ hetrikus ter, ha $H != nothing$ es $Rho: H times H arrow RR$, amire
+ $Rho(x, y) >= 0 "  " forall x, y in H$
+ $Rho(x, y) = 0 <==> x = y$
+ $Rho(x, y) = Rho(y, x)$
+ $Rho(x, y) + Rho(y, z) >= Rho(x, z)$

#set math.cases(reverse: false)
/ pl: Diszkret metrika: $H != nothing$ tetszoleges halmaz
$
  Rho(x, y) = cases(0\, x = y, 1\, x != y)
$
ugyanis
+ $Rho(x, y) = 0 "vagy" 1$
+ $Rho(x, y) = 0 <==> x = y$
+ $Rho(x, y) = 0 = Rho(y, x)$ ha $x = y "   " Rho(x, y) = 1 = Rho(y, x)$ ha $x != y$\
+
  - Ha $x = z: 0 = Rho(x, z) <= underbrace((x, y), >= 0) + underbrace(Rho(y, z), >= 0)$
  - Ha $x != y: 1 = Rho(x, z) <=^? Rho(x, y) + Rho(y, z)$
  $y$ csak max. $1$-el lehet egyenlo $x$ es $z$ kozul.\
  TFH $y != x: Rho(x, y) = 1$\
  $1 <= 1 + (Rho(y, z))/(0 "vagy" 1)$

/ pl: Hamming-tavolsag: $H = {0, 1}^n$ adott $n in NN^+$-ra (tehat tulajdonkeppen $n$ hosszu bitsorozatok)
$
  Rho_H (x, y) = sum_(i = 1)^n underbrace(Rho(x_i, y_i), "Diszkret metrika a"\ {0, 1}"-en")
$
ugyanis
+ $Rho_H (x, y) = sum_(i = 1)^n underbrace(Rho(x_i, y_i), >= 0) >= 0$
+ $Rho_H (x, y) = sum_(i = 1)^n Rho(x_i, y_i) = 0 <==> Rho(x_i, y_i) = 0 <==> forall i in {1, dots, n}: x_i = y_i <==> x = y$
+ $Rho_H (x, y) = sum_(i = 1)^n Rho(x_i, y_i) = sum_(i = 1)^n Rho(y_i, x_i) = Rho_H (y, x)$
+ $Rho_H (x, z) = sum_(i = 1)^n Rho(x_i, y_i) <= sum_(i = 1)^n (Rho(x_i, y_i) + Rho(y_i, x_i)) = sum_(i = 1)^n Rho(x_i, y_i) + sum_(i = 1)^n Rho(y_i, z_i) = Rho_H (x, y) + Rho_H (y, z)$

/ megjegyzes:
$
  Rho_H (x, y) = sum_(i = 1)^n abs(x_i - y_i) " is lehetett volna"
$

/ altalanosan:
$H != nothing$ es $(H, Rho)$ metrikus ter, akkor $(H^n, Rho^*)$ metrikus ter, ahol $Rho^* (x, y) = sum_(i = 1)^n Rho(x_i, y_i)$

#pagebreak()
/ altalanosan:
TFH $f: [0, +infinity) arrow [0, +infinity)$ fuggvenyre
+ $f$ monoton no
+ $f(x) = 0 <==> x = 0$
+ $f(x + y) <= f(x) + f(y) " " forall x, y >= 0$
Ekkor ha $(H, Rho)$ metrikus ter, akkor $(H, f circle.small Rho)$ is metrikus ter

/ pl: $(H, Rho)$ metrikus ter $==> (H, sqrt(Rho))$ is metrikus ter
ugyanis $f(x) = sqrt(x)$-re
+ $f: [0, +infinity) arrow [0, +infinity)$
+ $f$ monoton no
+ $sqrt(x) = 0 <==> x = 0$
+ $sqrt(x + y) <=^? sqrt(x) + sqrt(y)$\
  $x + y <= x + 2 sqrt(x y) + y$\
  $0 <= 2 sqrt(x y)$

/ pl: $(H, Rho)$ metrikus ter $==> (H, Rho/(1 + Rho))$ is metrikus ter
ugyanis $f(x) = x/(1 + x)$-re
+ $f: [0, +infinity) arrow [0, +infinity)$
+ $f$ monoton no: $f(x) = (x + 1 - 1)/(x + 1) = 1 - 1/(x + 1) ==> f arrow.t$
+ $f(x) = 0 <==> x/(x + 1) = 0 <==> x = 0$
+ $f(x + y) <=^? f(x) + f(y)$\
  $(x + y)/(1 + x + y) <=^? x/(1 + x) + y/(1 + y)$\
  $(x + y)/(1 + x + y) = x/(1 + x + y) + y/(1 + x + y) <=_(x, y >= 0) x/(1 + x) + y/(1 + y)$

/ megjegyzes: $0 <= f(x) < 1 "  "$ Alkalmazott gepi tanulasban

/ hazi pl: $(H, Rho)$ metrikus ter $==> (H, ln(1 + Rho))$ is metrikus ter

/ furcsasag: $K_(epsilon)(a) = {x in H | Rho(a, x) < epsilon}$
  / megjegyzes: $(x_n): NN arrow H$ sorozat konvergens, ha $exists A in H: forall epsilon > 0: exists N in NN: forall n >= N$-re $x_n in K_epsilon (A)$
/ !: van olyan $K_(R) (a)$ es $K_r (b)$ amire $K_R (a) < K_r (b)$ es $r < R$
/ pl: $H = (-2, 5)$ es $Rho(x, y) = abs(x - y)$\
$K_3 (-1, 5) = (-2, 1,5) subset.neq K_2 (0) = (-2, 2)$

#pagebreak()
= Normalt terek
$H != nothing$ linearis ter es $norm(dot): H arrow RR$ fuggveny
+ $norm(x) >= 0 "  " forall x in H$
+ $norm(x) = 0 <==> x = 0 "  "$ (nullvektor)
+ $norm(lambda dot x) = abs(lambda) dot norm(x) "  " forall x in H, lambda in RR$
+ $norm(x + y) <= norm(x) + norm(y) "  " forall x, y in H$

/ megjegyzes: $Rho(x, y) = norm(x - y)$ metrika
ugyanis
+ $Rho(x, y) = norm(x - y) >= 0$
+ $Rho(x, y) = norm(x - y) <==>_((2.)) x - y = 0 <==> x = y$
+ $Rho(x, y) = norm(x - y) =^? Rho(y, x) = norm(y - x)$\
  $norm(x - y) = norm(-(y - x)) =_((3.)) abs(-1) dot norm(y - x)$
+ $Rho(x, z) <=^? Rho(x, y) + Rho(y, z)$\
  $norm(x - z) <=^? norm(x - y) + norm(y - z)$\
  ugyanis $norm(x - z) = norm((x - y) + (y - z)) <=_((4.)) norm(x - y) + norm(y - z)$

/ megjegyzes: $(H, norm(dot))$ normalt ter, $a, b in H$ es TFH $K_r (a) <= K_R (b) ==> r <= R$

/ emlekezteto: $(RR^n, norm(dot)_p)$ ahol $forall x = (x_1, dots, x_n) in RR^n$-re
$
  norm(x)_p = cases(
    (sum_(i = 1)^n abs(x_i)^p)^(1/p)\, 1 <= p < +infinity,
    max_(i = 1)^1 abs(x_i)\, p = +infinity
  )
$

/ megjegyzes: $forall x in RR^n$-re
$
  lim_(p arrow +infinity) norm(x)_p = norm(x)_infinity
$
ugyanis
$
  lim_(p arrow +infinity) root(p, sum_(i = 1)^n abs(x_i)^p) = lim_(p arrow +infinity) root(p, abs(x_1)^p + abs(x_2)^p + dots + abs(x_n)^p) =\ =_("TFH" abs(x_l) = max_(i = 1)^n abs(x_i))\ =lim_(p arrow +infinity) root(p, abs(x_l)^p dot ((abs(x_1)/abs(x_l))^p + (abs(x_2)/abs(x_l))^p + dots + (abs(x_n)/abs(x_l))^p)) = lim_(p arrow +infinity) abs(x_l) dot root(p, sum_(i = 1)^n abs((x_i)/(x_l))^p)
$
ahol
$
  sum_(i = 1)^n abs((x_i)/(x_l))^p\
  0 <= abs((x_i)/(x_l)) <= 1\
  0 <= abs((x_i)/(x_l))^p <= 1\
  abs((x_l)/(x_l)) = 1\
  root(p, 1) <= root(p, sum_(i = 1)^n abs((x_i)/(x_l))^p) <= root(p, n)\
  arrow.b_(p arrow +infinity)\
  1 ==> 1 <== 1
$

/ pl:
$(C[a, b], norm(dot)_p) "  " forall f in C[a, b]$-re
$
  norm(f)_p = cases((integral_a^b abs(f)^p)^(1/p)\, "  " 1 <= p < +infinity, max_(x in [a, b]) abs(f(x))\, "  " p = +infinity)
$
