$
  f = x^2 + 2 in ZZ_3[x]\
  g = 2x^2 + 4x + 1 in ZZ_3[x]\
  h = x^3 + x + 4 in ZZ_3[x]\
$

== b
$
  g dot h " mod " x^2 + 2x + 2\
  g h = (2x^2 + 4x + 1)(x^3 + x + 4) " mod " x^2 + 2x + 2 =\ = (2x^2 + 4 + 1 - 2(x^2 + 2x + 1))(x^3 + x + 4)\ = (0x^2 + 0x - 3)(x^3 + x + 4) mod x^2 + 2x + 2 = 0
$

== c
$
  (f - g)(g - h)(f - h) mod x^2 + 2x + 2\
  
$

lagrange freaky interpolacio
$
  c_0, c_1, dots, c_n in R " kulonbozo ertek " (R " test")\
  d_0, d_1, dots, d_n in R " tetszoleges ertek "\
  ==> exists "legfeljebb "n"-ed foku polinom, melyre " f(c_j) = d_j " " (j = 0 dots n)\
  l_j (x) = (product_(i != j) (x - c_i))/(product_(i != j) (c_j - c_i)) "  " f(x) = sum_(j = 0)^(n) d_j dot l_j (x)
$

