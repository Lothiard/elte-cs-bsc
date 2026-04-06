/ emlekezteto:
$
  f in RR^2 arrow RR, a in "int" cal(D)_f\
$
ha
- $partial_x f, partial_y$ leteznek $k(a)$ kornyezeteben
- folytonosokat $a$-ban
akkor $f in D{a}$ es $f'(a) = [partial_x f(a), partial_y f(a)]$

/ emlekezteto:
ha $f in D{a} ==> exists partial_x f(a), partial_y f(a)$ es $f'(a) = [partial_x f(a), partial_y f(a)]$

/ megjegyzes:
lehetseges hogy $partial_x f, partial_y f$ nem folytonos $a$-ban, de $f in D{a}$

/ emlekezteto:
$
  f(x) = x^2 dot sin 1/x, " ill." x^2 dot sin 1/x^2 in D, " es " f' in.not C{0}
$

/ otlet: forgassuk meg a $z$ tengely korul $(x arrow.l sqrt(x^2 + y^2))$\
$
  f(x, y) = cases(
    (x^2 + y^2) dot sin 1/(sqrt(x^2 + y^2))\, " ha" (x, y) != (0,0),
    0\, "                           ha" (x, y) = (0,0)
  )
$
+ parcialis derivaltak leteznek de nem folytonosak $(0, 0)$-ban
  / $partial_x f(0, 0)$:
    $
      g(t) = cases(
        t^2 dot sin 1/t^2\, " ha" t != 0,
        0\, "           ha" t = 0
      ), "   "
      g in D{RR}, " de" g' in.not C{0}
    $

  / $partial_y f(0, 0)$:
    $
      h(t) = cases(
        t^2 dot sin 1/t^2\, " ha" t != 0,
        0\, "           ha" t = 0
      ), "   "
      h in D{RR}, " de" h' in.not C{0}
    $

+ $f in D{(0, 0)}$
  / allitas: f'(0, 0) = [0, 0]
  ugyanis:
  $
    lim_(h arrow (0, 0)) (abs(f((0, 0) + h) - f(0, 0) - [0, 0] dot h))/(norm(h)) = lim_(h arrow (0, 0)) (abs((h_1^2 + h_2^2) sin 1/(h_1^2 h_2^2)))/(norm(h)) = lim_(h arrow (0, 0)) (norm(h)^2 dot sin (1/(norm(h)^2)))/(norm(h)) =\ = lim_(h arrow (0, 0)) underbrace(norm(h), arrow 0) dot underbrace(sin(1/(norm(h)^2)), "korlatos") = 0
  $

#pagebreak()
= lancszabaly (osszetett fuggveny derivaltja)
$
  "TFH" g in RR^n arrow RR^k " es " f in RR^k arrow RR^m, a in "int" cal(D)_g " es " g(a) in "int" cal(D)_f\
  "ha" g in D{a} " es " f in D{g(a)} " akkor " f circle.small g in D{a} " es " (f circle.small g)'(a) = underbrace(f'(g(a)), in RR^(m times k)) dot underbrace((g'(a)), in RR^(k times n))
$
ezek szerint
$
  f circle.small g in RR^n arrow RR^m ==> f circle.small (a) in RR^(m times n)
$

/ pl:
$
  g(x, y) = mat(
    delim: "[",
    e^(3x);
    1 - e^(-3x)
  ), "   "
  f(f, y) = x^4 + 2x y^2 + y^3\
  g in RR^2 arrow RR^2, "   " f in RR^2 arrow RR\
  (f circle.small g)' = ?
$
/ 1. lehetseges megoldas:
vegyuk eszre hogy
$
  (f circle.small g)(x, y) = f(g(x, y)) = f(e^(3x), 1 - e^(-3x)) = e^(3x)^4 + 2e^(3x) (1 - e^(-3x))^2 + (1 - e^(-3x))^3\
  h := f circle.small g, "  " h in RR^2 arrow RR\
  partial_x h(x, y) = 12 e^(12x) + 6e^(3x) (1 - e^(-3x))^2 + 2e^(3x) dot 2(1 - e^(-3x)) (-3) + 3(1 - e^(-3x))^2 dot (-e^(-3x))(-3)\
  partial_y h(x, y) = 0\
  " es " partial_x h, partial_y h in C(RR^2) ==> h in D(RR^2), " " h'(x, y) = [partial_x h(x, y), partial_y h(x, y)]
$

/ 2. lehetseges megoldas: lancszabaly
$
  g'(x, y) = [partial_x g(x, y), partial_y g(x, y)] = mat(
    delim: "[",
    3e^(3x), 0;
    -e^(-3x) (-3), 0
  ) = mat(
    delim: "[",
    3e^(3x), 0;
    3e^(-3x), 0
  )\
  f'(x, y) = [4x^3 + 2y^2, 4x y + 3y^2]\
  (f circle.small g)'(x, y) = underbrace(f'(g(x, y)), f'(e^(3x), 1- e^(-3x))) dot g'(x, y) = [4 e^(9x) + 2(1 - e^(-3x))^2, 4e^(3x)(1-e^(-3x)) + 3(1 - e^(-3x))^2] dot mat(delim: "[", 3e^(3x), 0; 3e^(-3x), 0) =\ = mat(delim: "[", 12e^(12x) + 6e^(3x)(1 - e^(-3x))^2 + 12 (1 - e^(-3x)) + 9e^(-3x)(1 - e^(-3x))^2, 0)
$

#pagebreak()
= automatikus differencialas
$
  f(x_1, x_2, x_3) = (x_1 x_2 sin x_3 + e^(x_1 x_2))/(x_3), "  " f in RR^3 arrow RR
$
Derivalt (es fuggveny) ertekenek kiszamitasa adott $a in "int" cal(D)_f$ pontokban:
/ kiertekeles szamitogepen: (iterativan):
+ $x_1 x_2 = x_4$\
+ $sin x_3 = x_5$\
+ $exp(x_4) = x_6$\
+ $x_6 dot x_4 = x_7$\
+ $x_6 + x_7 = x_8$\
+ $x_8 / x_3 = x_9$
ha pl $a = (1, 1, pi)$ ugyanez megtortenik csak $x_1 = 1, x_2 = 1, x_3 = pi$

derivalthoz ugyanez az otlet csak ott minden csucs egy fuggveny, a derivaltja meghatarozhato a kozvetlen bemenetenek az ertekebol es derivaltjabol.

pl: $x_4$ fuggvenyt felfoghatom ugy hogy $x_4(x_1, x_2) = x_1 x_2$.\ ez alapjan a derivaltja $x_4 '(x_1, x_2) = x_1 ' x_2 + x_1 x_2 '$. igy tovabb
