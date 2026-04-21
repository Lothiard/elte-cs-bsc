/ emlekezteto:
$1.02^(3.01)$ nem szepen fejezheto ki egyvaltozos fuggveny helyettesitesi ertekekent
$
  1.02^(3.01) approx (1 + x)^(3 + y) "fuggveny " (0,0)"-kozeppontu Taylor polinomjaval"\
  1.02^(3.01) approx x^y "fuggveny" (1,3)"-kozeppontu Taylor polinomjaval"\
$
az utobbit valasztva (teljesen onkenyesen)
$
  f(x, y) = x^y "  " x > 0, " " y > 0,\
  a = (1,3) "kozeppontu elsofoku Taylor polinom kell"\
  f(1,3) = 1^3 = 1\
  partial_x f(x, y) = y x^(y - 1), "   " partial_x f(1, 3) = 3\
  partial_y f(x, y) = x^y ln x, "   " partial_y f(1, 3) = 0\
  (T_(a, 1)f)(a + h) = f(a) + underbrace(partial_x f(a) dot h_1 + partial_y f(a) dot h_2, chevron.l gradient f(a)"," h chevron.r) = 1 + 3 h_1\
  1.02^(3.01) = f(1.02, 3,01) approx (T_((1,3), 1)f)(1.02, 3.01) = 1 + 3 dot 0.02 = 1.06
$

/ Hibabecsles: $f i RR^n arrow RR, "  " a in "int" cal(D)_f, "  " f in cal(D)^(s + 1)(K(a)) " es " a + k in K(a)$,
Ekkor $exists mu in [0, 1]$ amivel
- peano (vagy milyen)-fele Hibabecsles
$
  f(a + h) = (T_(a, s)f)(a + h) + epsilon (a + h) norm(h)^s, "   " lim_a epsilon = 0
$
fos

- lagrange-fele (a goated)
$
  f(a + h) = (T_(a, s)f)(a + h) + sum_(abs(i) = s + 1) (partial^(abs(i)) f(a + mu dot h))/(i!) dot h^i
$
ez hogy nez ki?\
$s = 1$-re:
$
  (partial_(x x) f(a + mu dot h))/(2! dot 0!) h_1^2 + (partial_(x y) f(a + mu dot h))/(1! dot 1!) h_1 h_2 + (partial_(y y) f(a + mu dot h))/(0! dot 2!) h_2^2
$

becsleshez:
$
  abs(f(a + h) - (T_(a, 1)f)(a + h)) = abs((partial_(x x) f(a + mu h))/(2) h_1^2 + partial_(x y) f(a + mu h) h_1 h_2 + (partial_(y y) f(a + mu h))/(2)h_2^2) <=_("haromszog egyenlotlenseg")\ <= (6.2)/(2) dot 0.02^2 + c_(1 2) dot 0.02 dot 0.01 + (c_(2 2))/2 dot 0.01^2\
  partial_(x x) f(x, y) = y(y - 1)x^(y - 2)\
  partial_(x y) f(x, y) = x^(y - 1) + y x^(y - 1) ln (x)\
  partial_(y y) f(x, y) = x^y ln^2(x)
$
#pagebreak()
ha ez van akkor
$
  abs(partial_(1 1) f(a + mu h)) = abs((3 + mu h_1)(2 + mu h_2)(1 + mu h_1)^(1 + mu h_2)) <=_(mu >= 1) 3.01 dot 2.01 dot 1.02^(1.01) < 6.2
$
mert
$
  a + mu h = (1, 3) + mu (h_1, h_2) = (1 + mu h_1, 3 + mu h_2),\
  (h_1, h_2) = (0.02, 0.01)
$

/ pl:
$
  f(x, y) = ln(1 + x + y), "   " a = (0, 0) " kozeppontu, " 1 "foku Taylor es hibabecsles az " abs(x), abs(y) <= 0.01 " esetre"\
  f(0, 0) = ln(1 + 0 + 0) = 0\
  partial_x f(x, y) = 1/(1 + x + y) (0 + 1 + 0)\
  partial_y f(x, y) = 1/(1 + x + y) (0 + 0 + 1)\
  partial_y f(0, 0) = 1/(1 + 0 + 0) = 1\
  (T_((0, 0), 1)f)(0 + h) = 0 + 1 h_1 + 1 h_2 = h_1 + h_2
$
hibabecsles
$
  abs(x), abs(y) <= 0.01 <==> abs(h_1), abs(h_2) <= 0.01\
  abs(f(a + h) - (T_(a, 1)f)(a + h)) = abs((partial_(1 1)f(a + mu h))/(2) h_1^2 + partial_(1 2) f(a + mu h) h_1 h_2 + (partial_(2 2)f(a + mu h))/2) <=\ <= (abs(partial_(1 1)f(a + mu h)))/(2) abs(h_1)^2 + abs(partial_(1 2)f(a + mu h)) abs(h_1) abs(h_2) + (abs(partial_(2 2)f(a + mu h)))/(2) abs(h_2)^2\
  partial_(x x)f(x, y) = -1/((1 + x + y)^2) dot (0 + 1 + 0) = -1/((1 + x + y)^2) = partial_(x y) f(x, y) = partial_(y y)f(x, y)\
  abs(partial_(1 1)f(a + mu h)) "   " a = (0,0), "   " h = (h_1, h_2)\
  abs(partial_(1 1)f(a + mu h)) = abs(partial_(1 1) f(mu h)) = abs(partial_(1 1) f(mu h_1, mu h_2)) = abs((-1)/((1 + mu h_1 + mu h_2)^2)) = (1)/((1 + mu h_1 + mu h_2)^2) <=\ <= 1/((1 - 1 dot 0.01 - 1 dot 0.01)^2) = 1/(0.98^2)
$
mert
$
  abs(h_1) <= 0.01, "   " abs(h_2) <= 0.01\
  <==>
  -0.01 <= h_1 <= 0.01, "   " -0.01 <= h_2 <= 0.01\
  mu in [0, 1]
$
es
$
  abs(partial_(1 2)f(a + mu h)) = abs(partial_(2 1)f(a + mu h)) = abs(partial_(1 2) f(mu h_1, mu h_2)) = abs((-1)/((1 + mu h_1 + mu h_2)^2)) <= 1/(0.98^2)
$
szoval
$
  abs(f(a + h) + (T_(a, 1)f)(a + h)) <= (1/(0.98^2))/(2) 0.01^2 + 1/(0.98^2) 0.01^2 + (1/(0.98^2))/(2) 0.01^2 = 2/(0.98^2) 0.01^2 =\ = (2 dot 100^2)/(98^2) (1/100)^2 = 2/(98^2)
$

vegre vege
/ megjegyzes:
$
  a = (1, 2) "  kozeppontu" 0.01 " sugaru kornyezeteben"\
  <==>\
  norm((a + h) - a) < 0.01\
  norm(h) < 0.01
$
vegyuk eszre hogy
$
  sqrt(h_1^2 + h_2^2) < 0.01 " helyett"\
  abs(h_1), abs(h_2) < 0.01"-re becsulhetunk"
$

#pagebreak()
= tobbvaltozos fuggvenyek szelsoerteke
csak $f in RR^n arrow RR$ (valos erteku) fv-re
/ emlekezteto: lokalis szelsoerteket ugyanugy ertelmezem
$
  f in RR^n arrow RR, "  " a in "int" cal(D)_f
$
Ekkor $f$-nek $a$-ban lokalis min/max van, ha $exists K(a) subset cal(D)_f$ kornyezet, hogy $forall x in K(a):$
$
  f(x) >= f(a) \/ f(x) <= f(a)
$

/ emlekezteto: elsorendo szukseges feltetel
$ f in RR^n arrow RR, "  " a in "int" cal(D)_f, "  " f in D{a} $ ekkor ha $a$-ban lokalis szelsoertek van, akkor
$
  f'(a) = 0 in RR^(1 times n)
$
(vagyis $partial_1 f(a) = partial_2 f(a) = dots = partial_n f(a) = 0$)
/ ugyanis: Peano-maradektag $1$. foku Taylor-polinomra:
!! feltetel: $f in D{a}$ es amugy ez $equiv$ linearis kozelites formulaja $D{a}$-ban
$
  f(a + h) - f(a) + partial_1 f(a) h_1_partial_2 f(a) h_2 + epsilon(a + h) dot norm(h), " ahol" lim_a epsilon = 0\
  f(a + h) = f(a) + [chevron.l gradient f(a), h/norm(h) chevron.r + epsilon(a + h)] norm(h) > f(a)
$
mert ha $gradient f(a) != 0: h/norm(h) = (gradient f(a))/(norm(gradient f(a)))$\
DE ha $h/norm(h) = - (gradient f(a))/(norm(gradient f(a)))$ akkor a fenti egesz $< f(a)$\
igy az ellentmondas miatt muszaj hogy $gradient f(a) = 0$\
be van bizonyitva amen
