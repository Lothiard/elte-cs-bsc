= 1. Számítsa ki az $f'(x)$-et, ha
== a) $f(x) := (2x^2 - 1)/(x sqrt(1+x^2)) "  " (x > 0)$

$
  u(x) = 2x^2-1 "    " v(x)=x sqrt(1 + x^2)\

  u'(x) = 4x\

  v'(x) = 1 (1 + x^2)^(1/2) + x dot 1/2(1+x^2)^(-1/2) dot 2x = (1+x^2)^(1/2) + (x^2)/(1+x^2)^(1/2) = (1 + x^2 + x^2)/(sqrt(1+x^2)) = (1 + 2x^2)/(sqrt(1+x^2))\

  f'(x) = (4x dot x sqrt(1 + x^2) - 2x^2 - 1 dot (1+2x^2)/(sqrt(1+x^2)))/(x sqrt(1 + x^2))^2\

  "szamlalo:" 4x dot x sqrt(1 + x^2) - 2x^2 - 1 dot (1+2x^2)/(sqrt(1+x^2)) = 4x^2 sqrt(1+x^2) - 2x^2 dot ((2x^2 - 1)(1 + 2x^2))/(sqrt(1+x^2)) =\
   = (4x^2(1+x^2) - (2x^2 - 1)(1 + 2x^2))/(sqrt(1+x^2))\

  "nevezo:" (x sqrt(1 + x^2))^2 = x^2(1+x^2)\

  f'(x) = ((4x^2 + 4x^4 - (2x^2 + 4x^4 - 1 - 2x^2))/(sqrt(1+x^2)))/(x^2(1+x^2)) = ((4x^2 + 4x^4 -2x^2 - 4x^4 + 1 + 2x^2)/(sqrt(1+x^2)))/(x^2(1+x^2)) = ((4x^2 + 1)/(sqrt(1+x^2)))/(x^2(1+x^2)) = (4x^2 + 1)/(x^2(1+x^2)sqrt(1+x^2))
$

== b) $f(x) := (e^x)/(1 + e^x) "  " (x in bb(R))$
$
  u(x) = e^x "    " u'(x) = e^x\

  v(x) = 1 + e^x "    " v'(x) = e^x\

  f'(x) = (e^x (1 + e^x) - e^x dot e^x)/((1+e^x)^2) = (e^x + e^(2x) - e^(2x))/((1+e^x)^2) = (e^x)/((1+e^x)^2)
$

== c) $f(x) := 3^x^2 "  " (x in bb(R))$
$
  u(x) = 3^x "    " u'(x) = ln 3 dot 3^x\
  v(x) = x^2 "    " v'(x) = 2x\

  f'(x) = ln 3 dot 3^(x^2) dot 2x
$

== d) $f(x) := 1/x + sqrt(1 + 1/(x^2)) "  " (x > 0)$
$
  u(x) = 1/x "    " u'(x) = -1/(x^2)\
  v(x) = 1 + 1/(x^2) "   " sqrt(v(x)) = (v(x))^(1/2) "    " v'(x) = -2/(x^3)\

  (sqrt(v(x)))' = 1/2 v(x)^(-1/2) dot v'(x) = -1/(x^3 sqrt(2/x^2))\

  f'(x) = -1/x^2 + 1/2 - 1/(x^3 sqrt(2/x^2))
$

== e) $f(x) := 2 tg x - 3 ctg x "  " (x in (0, pi/2))$
$
  tg' x = sec^2 x "    " ctg' x = -csc^2 x\

  f'(x) = 2 sec^2 x + 3 csc^2 x
$

== f) $f(x) := (2 + sin x)^(cos x) "  " (x in bb(R))$
$
  ln f(x) = cos x ln(2 + sin x)\

  f'(x) = - sin x ln(2 + sin x) + cos x (cos x)/(2 + sin x) = -sin x ln(2 + sin x) + (cos^2 x)/(2 + sin x)\
  f'(x) = (2 + sin x)^(cos x)(- sin x ln(2 + sin x) + (cos^2 x)/(2 + sin x))
$
