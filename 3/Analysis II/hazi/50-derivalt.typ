= Restye János Barnabás - F8U9I2 --- Analízis II. - 50 derivált
== 1. (845.)
$
  f(x) := (2x)/(1-x^2)\
  u(x) = 2x "  " u'(x) = 2\
  v(x) = 1-x^2 "  " v'(x) = -2x\
  f'(x) = (u'(x)v(x) - u(x)v'(x))/(v^2(x)) = (2(1-x^2) - 2x dot (-2x))/((1-x^2)^2) = (2 + 2x^2)/((1-x^2)^2)
$

== 2. (846.)
$
  f(x) := (1+x-x^2)/(1-x+x^2)\
  u(x) = 1+x-x^2 "  " u'(x) = -2x+1\
  v(x) = 1-x+x^2 "  " v'(x) = 2x-1\
  f'(x) = ((-2x+1)(1-x+x^2) - (1+x-x^2)(2x-1))/((1-x+x^2)^2) =\ = (-2x + 2x^2 -2x^3 + 1 - x + x^2 - 2x + 1 - 2x^2 + x + 2x^3 -x^2)/((1-x+x^2)^2) =\ = (-4x + 2)/((1-x+x^2)^2)
$

== 3. (847.)
$
  f(x) := (x)/((1-x)^2(1+x)^3)\
  u(x) = x "  " u'(x) = 1\
  v(x) = (1-x)^2(1+x)^3\
  v'(x) = 2(1-x)(-1)(1+x)^3 + 3(1+x)^2(1)(1-x)^2 = (1-x)(1+x)^2[(-2)(1+x) + 3(1-x)] =\
  = -2(1-x)(1+x)^3 + 3(1-x)^2(1+x)^2\
  f'(x) = ((1-x)^2(1+x)^3 - x[-2(1-x)(1+x)^3 + 3(1-x)^2(1+x)^2])/([(1-x)^2(1+x)^3]^2) =\
  = ((1-x)^2(1+x)^3 2x(1-x)(1+x)^3 - 3x(1-x)^2(1+x)^2)/((1-x)^4(1+x)^6) =\
  = ((1-x)(1+x)^2 [(1-x)(1+x) + 2x(1+x) - 3x (1-x)])/((1-x)^4(1+x)^6) =\
  = ((1-x)(1+x)^2 (1-x+4x^2))/((1-x)^4(1+x)^6) = (1-x+4x^2)/((1-x)^3(1+x)^4) = \
$

== 4. (849.)
$
  f(x) := ((1-x)^p)/((1+x)^q)\
  u(x) = (1-x)^p "  " u'(x) = p(1-x)^(p-1)\
  v(x) = (1+x)^q "  " v'(x) = q(1+x)^(q-1)\
  f'(x) = (p(1-x)^(p-1)(-1)(1+x)^q - (1-x)^p q(1+x)^(q-1))/((1+x)^(2q))
$

== 5. (853.)
$
  f(x) := root(3, x^2) - 2/sqrt(x)\
  (root(3, x^2))' = 2/(3 root(3, x)) \
  (-2/sqrt(x))' = (2 1/(2 sqrt(x)))/(x) = 1/(sqrt(x))/(x) = 1/(x sqrt(x))\
  f'(x) = 2/(3 root(3,x)) + 1/(x sqrt(x))
$

== 6. (855.)
$
  f(x) := (1+x)sqrt(2+x^2)root(3, 3 + x^3)\
  u(x) = 1 + x "  " u'(x) = 1\
  v(x) = sqrt(2+x^2) "  " v'(x) = 1/(2 sqrt(2+x^2)) dot 2x = x/(sqrt(2+x^2))\
  w(x) = root(3, 3+x^3) "  " w'(x) = 1/(3 root(3, (3+x^3)^2)) dot 3x^2 = (x^2)/(root(3, (3 + x^3)^2))\
  f'(x) = u'(x)v(x)w(x) + u(x)v'(x)w(x) + u(x)v(x)w'(x) =\
  = sqrt(2+x^2)root(3, 3+x^3) + (1+x)x/(sqrt(2 + x^2))root(3, 3 + x^3) + (1+x)sqrt(2+x^2)(x^2)/(root(3, (3 + x^3)^2))
$

== 7. (856.)
$
  f(x) := root(m+n, (1-x)^m (1+x)^n) = [(1-x)^m (1+x)^n)]^(1/(m+n))\
  f'(x) = 1/(m+n) [(1-x)^m (1+x)^n)]^(1/(m+n) - 1) dot [(1-x)^m (1+x)^n]'\
  [(1-x)^m (1+x)^n]' = -m(1-x)^(m-1)(1+x)^n + (1-x)^m n(1+x)^(n-1)\
  f'(x) = 1/(m+n) [(1-x)^m (1+x)^n)]^(1/(m+n) - 1) dot [-m(1-x)^(m-1)(1+x)^n + (1-x)^m n(1+x)^(n-1)]
$

== 8. (857.)
$
  f(x) := x/(sqrt(a^2 - x^2))\
  u(x) = x "  " u'(x) = 1\
  v(x) = sqrt(a^2 - x^2) "  " v'(x) = -(2x)/(2sqrt(a^2 - x^2)) = -x/(sqrt(a^2 - x^2))\
  f'(x) = (sqrt(a^2 - x^2) - x(-(x)/(sqrt(a^2 - x^2))))/(a^2 - x^2)
$

== 9. (858.)
$
  f(x) := root(3, (1+x^3)/(1-x^3))\
  ((1+x^3)/(1-x^3))' = (3x^2(1-x^3) - (1+x^3)(-3x^2))/((1-x^3)^2)\
  f'(x) = (1+x^3)/(1-x^3)/(3 root(3, (3x^2(1-x^3) - (1+x^3)(-3x^2))/((1-x^3)^2))^2)
$

== 10. (859.)
$
  f(x) := 1/(sqrt(1+x^2)(x + sqrt(1 + x^2)))\
  [sqrt(1+x^2)(x + sqrt(1 + x^2))]' = x/(sqrt(1+x^2))(x + sqrt(1 + x^2)) +sqrt(1+x^2)(1 + x/(sqrt(1+x^2)))\
  f'(x) = -(x/(sqrt(1+x^2))(x + sqrt(1 + x^2)) +sqrt(1+x^2)(1 + x/(sqrt(1+x^2))))/[(x/sqrt(1+x^2))(x + sqrt(1 + x^2)) +sqrt(1+x^2)(1 + x/(sqrt(1+x^2)))]^2
$

== 11. (860.)
$
  f(x) := sqrt(x + sqrt(x + sqrt(x))) = sqrt(x + sqrt(x dot x^(1/2))) = sqrt(x dot (x^(3/2))^(1/2)) = (x dot x^(3/2))^(1/2) = (x^(7/4))^(1/2) = x^(7/8) = root(8, x^7)\
  f'(x) = 7/(8 root(8, x))
$

== 12. (861.)
$
  f(x) := root(3, 1 + root(3, 1 + root(3, x)))\
  root(3, 1 + root(3, 1 + root(3, x))) = root(3, 1 + root(3, 1 + x^(1/3))) = root(3, 1 + (1 + x^(1/3))^(1/3)) = (1 + (1 + x^(1/3))^(1/3))^(1/3)\
  [(1 + x^(1/3))^(1/3)]' = 1/(9 root(3, (x + root(3, x))^2))\
  f'(x) = 1/(27 root(3, (x + x root(3, x) + x root(3, 1 + root(3, x)) + x root(3, x + root(3, x) x))^2))
$

== 13. (862.)
$
  f(x) := cos 2x - 2 sin x\
  f'(x) = -sin 2x - 2 cos x
$

== 14. (863.)
$
  f(x) := (2 - x^2) cos x + 2x sin x\
  [(2 - x^2) cos x]' = -2x cos x + (2 - x^2)(- sin x)\
  [2x sin x]' = 2 sin x + 2x cos x\
  f'(x) = -2x cos x + (2 - x^2)(- sin x) + 2 sin x + 2x cos x = (2 - x^2)(- sin x) + 2 sin x
$

== 15. (2.gy/gy1/a)
$
  f(x) := sin sqrt(1 + x^3)\
  [sqrt(1 + x^3)]' = (3x^2)/(2 sqrt(1 + x^3))\
  f'(x) = cos sqrt(1 + x^3) dot (3x^2)/(2 sqrt(1 + x^3))
$

== 16. (2.gy/gy1/b)
$
  f(x) := ((x+1)^3)/(x^(3/2))\
  [(x+1)^3]' = 3(x+1)^2 = 3x^2 + 6x + 3\
  [(x^(3/2))]' = 3/(2 x^(1/2)) = (3sqrt(x))/2\
  f'(x) = ((3x^2 + 6x + 3)x^(3/2) - (x+1)^3 (3 sqrt(x))/2)/(x^3)
$

== 17. (2.gy/gy1/c)
$
  f(x) := ln(e^(-x) sin x)\
  [e^(-x) sin x]' = -e^(-x) sin x + e^(-x) cos x\
  f'(x) = -1/(e^(-x) sin x) dot e^(-x) sin x + e^(-x) cos x = -1 + (cos x)/(sin x)
$

== 18. (2.gy/gy1/d)
$
  f(x) := sqrt(1 + sin^2x) dot cos x\
  [sin^2x]' = 2sin x cos x\
  [sqrt(1 + sin^2x)]' = 1/(2 sqrt(1 + sin^2 x)) dot 2 sin x cos x = (sin x cos x)/(sqrt(1 + sin^2x))\
  f'(x) = (sin x cos x)/(sqrt(1 + sin^2 x)) dot cos x + sqrt(1 + sin^2 x) dot (-sin x)
$

== 19. (2.gy/gy1/e)
$
  f(x) := e^x sin x\
  f'(x) = e^x cos x + e^x sin x
$

== 20. (2.gy/gy1/f)
$
  f(x) := x^2 root(3, x)\
  f'(x) = 2x root(3, x) + x^2 1/(3 root(3, x^2))
$

== 21. (2.gy/gy1/g)
$
  f(x) := (x+2)^8(x+3)^6\
  [(x+2)^8]' = 8(x+2)^7 "  " [(x+3)^6]' = 6(x+3)^5\
  f'(x) = 8(x+2)^7 (x+3)^6 + (x+2)^8 6(x+3)^5
$

== 22. (2.gy/gy1/h)
$
  f(x) := (sin^3 x) cos x\
  [sin^3 x]' = 3sin^2 x dot cos x\
  f'(x) = 3 sin^2 x cos x cos x + sin^3 x dot (-sin x) = 3sin^2 cos^2x- sin^4x
$

== 23. (2.gy/gy1/i)
$
  f(x) := 1/(root(3, x + sqrt(x)))\
  [root(3, x + sqrt(x))]' = [(x + sqrt(x))^(1/3)]' = (1 + 2 sqrt(x))/(6 root(6, x^3(x + sqrt(x))^4))\
  f'(x) = -((1 + 2 sqrt(x))/(6 root(6, x^3(x + sqrt(x))^4)))/((root(3, x + sqrt(x)))^2)
$

== 24. (2.gy/gy1/j)
$
  f(x) := (sin(2x^2))/(3 - cos(2x))\
  [sin(2x^2)]' = cos(2x^2) dot 4x\
  [cos(2x)]' = -sin(2x) dot 2\
  f'(x) = (cos(2x^2)(4x)(3 - cos(2x)) - sin(2x^2) dot (-sin(2x) dot 2))/((3 - cos(2x))^2)
$

== 25. (2.gy/gy1/k)
$
  f(x) := ln(x^2 e^x)\
  [x^2 e^x]' = 2x e^x + x^2 e^x\
  f'(x) = (2x e^x + x^2 e^x)/(x^2 e^x) = 2/x + 1
$

== 26. (2.gy/gy1/l)
$
  f(x) := e^(cos x) + cos(e^x)\
  [e^(cos x)]' = e^(cos x) dot (- sin x)\
  [cos(e^x)]' = -sin(e^x) dot e^x\
  f'(x) = -e^(cos x) dot sin(x) - sin(e^x) dot e^x
$

== 27. (2.gy/gy1/m)
$
  f(x) := (x + 1/(x^2))^(sqrt(7))\
  f'(x) = sqrt(7)(x + 1/(x^2))^(sqrt(7) - 1) dot (1 - 2/(x^3))
$

== 28. (2.gy/gy1/n)
$
  f(x) := ln(cos x)\
  f'(x) = -(sin x)/(cos x) = -tg x
$

== 30. (2.gy/gy1/o)
$
  f(x) := x^x\
  f'(x) = x^x + x^x ln(x)
$

== 31. (3.gy/gy1/a)
$
  f(x) := (x+1)/(x-1) "  " (x in RR \\ {1}) "  " a = 3\
  f'(x) = ((x - 1) - (x + 1))/((x-1)^2) = -2/(x-1)^2\
  f'(3) = -2/4 = -1/2\
  y = -1/2(x - 3) + 4/2 = -1/2x + 3/2 + 4/2 =\ y = -1/2x + 7/2
$

== 32. (3.gy/gy1/b)
$
  f(x) := sqrt(1 + x^2) "  " (x in RR) "  " a = 1/2\
  f'(x) = x/( sqrt(1 + x^2))\
  f'(1/2) = (1/2)/(sqrt(1 + (1/2)^2)) = (1/2)/(sqrt(1 + 1/4)) = (1/2)/(sqrt(5)/2) = sqrt(5)/5\
  y = sqrt(5)/5(x - 1/2) + sqrt(5)/2 = sqrt(5)/5x - (3sqrt(5))/(10) + (5sqrt(5))/10 =\ y = sqrt(5)/5 + (2sqrt(5))/5
$

== 33.
$
  f(x) := (4x^2 - x)(x^3 - 8x^2 + 12)\
  f'(x) = (8x - 1)(x^3 - 8x^2 + 12) + (4x^2 - x)(3x^2 - 16x)
$

== 34.
$
  f(x) := (1 + sqrt(x^3))(x^(-3) - 2sqrt(x))\
  f'(x) = ((3x^2)/(2 sqrt(x^3)))(x^(-3) - 2sqrt(x)) + (1 + sqrt(x^3))(-3x^(-4) - 1/(sqrt(x)))
$

== 35.
$
  f(x) := (1 + 2x + 3x^2)(5x + 8x^2 - x^3)\
  f'(x) = (2 + 6x)(5x + 8x^2 - x^3) + (1 + 2x + 3x^2)(5 + 16x - 3x^2)
$

== 36.
$
  f(x) := (6x^2)/(2-x)\
  f'(x) = (12x (2-x) + 6x^2)/((2-x))
$

== 37.
$
  f(x) := (3x + x^4)/(2x^2 + 1)\
  f'(x) = ((3 + 4x^3)(2x^2 + 1) - (3x + x^4)(4x))/((2x^2 + 1)^2)
$

== 38.
$
  f(x) := (sqrt(x) + 2x)/(7x - 4x^2)\
  f'(x) = ((1/( sqrt(x)))(7x - 4x^2) - (sqrt(x) + 2x)(7 - 8x))/((7x - 4x^2)^2)
$

== 39.
$
  f(x) := 2e^x - 8^x\
  f'(x) = 2e^x - ln (8) dot 8^x
$

== 40.
$
  f(x) := 4 log_3(x) - ln(x)\
  f'(x) = 4/(x ln 3) - 1/x
$

== 41.
$
  f(x) := 3^x log(x)\
  f'(x) = 3^x ln(3) log(x) + (3^x)/(x ln 10)
$

== 42.
$
  f(x) := x^5 - e^x ln(x)\
  f'(x) = 5x^4 -(e^x/x + e^x ln(x))
$

== 43.
$
  f(x) := x/(1-e^x)\
  f'(x) = (-e^x - x(-e^x))/((1 - e^x)^2)
$

== 44.
$
  f(x) := (1 + 5x)/(ln(x))\
  f'(x) = (5 ln(x) - (1+5x)/x)/(ln^2 x)
$

== 45.
$
  f(x) := (1+4ln(x))/(5x^3)\
  f'(x) = (4/x dot 5x^3 - (1+4ln(x))(15x^2))/(25x^6)
$

== 46.
$
  f(x) := (x^2 + log_7(x))/(7^x)\
  f'(x) = (((2x)/x ln 7)(7^x) - (x^2 + log_7(x))(ln 7 dot 7^x))/(7^(2x))
$

== 47.
$
  f(x) := (x^4 e^x)/(ln(x))\
  f'(x) = ((4x^3 e^x)(ln(x)) - (x^4 e^x)/x)/(ln^2 x)
$

== 48.
$
  f(x) := (1 - 8x)e^x "  " a = -1\
  f'(x) = -8e^x + (1-8x)e^x\
  f'(-1) = -8e^(-1) + (1+8)e^(-1) = -8/e + 9/e = 1/e\
  y = 1/e (x + 1) + 9/e = 1/e x + 1/e + 9/e = 1/e x + 10/e
$

== 49.
$
  f(x) := 3x^2 ln(x) "  " a = 1\
  f'(x) = 6x ln(x) + (3x^2)/x = 6x ln(x) + 3x\
  f'(1) = 0 + 3\
  y = 3(x-1) + 0 <==> y = 3x - 3
$

== 50.
$
  f(x) := 3e^x + 8ln(x) "  " a = 2\
  f'(x) = 3e^x + 8/x\
  f'(2) = 3e^2 + 4\
  y = (3e^2 + 4)(x - 2) + (3e^2 + 8ln(2))\
  y = 3e^x - 3e^2 + 4x - 8 + 8ln(2)
$

