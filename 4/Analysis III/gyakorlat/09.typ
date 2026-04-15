= Tobbvaltozos Taylor-polinom
/ emlekezteto: $f in RR arrow RR, a in "int" cal(D)_f, f in D^n {a}$,
ekkor $f$ fuggveny $a$ kozeppontu Taylor-polinomja
$
  (T_(a, n)f)(a + h) = f(a) + f'(a) dot h + (f''(a))/(2!) dot h^2 + dots + (f^((n)) (a))/k! dot h^k = sum_(k=0)^n (f^((k))(a))/k! dot h^k\
  <==>_(x = a + h, "  " x - a = h)\
  (T_(a, n)f)(x) = sum_(k=0)^n (f^((k))(a))/k! dot (x - a)^k\
$

/ allitas: $(T_(a, n)f)^((k))(a) = f^((k))(a), "  " k = 0, 1, dots, n$
/ pl:
$k = 0$:
$
  (T_(a, n)f)(0) = f(a)\
$
$k = 1$:
$
  (T_(a, n)f)'(h) = f'(a) + (f''(a))/2! dot 2 dot h + dots\
$
$h = 0$-ra: $f'(a)$\
$k = 2$:
$
  (T_(a, n)f)''(h) = f''(a) + (f'''(a))/3! dot 3 dot 2 dot h + dots\
$
$h = 0$-ra: $f''(a)$\
$k = l$:
$
  (T_(a, n)f)^((l))(h) = 0 + 0 + dots + 0 + (f^((l))(a))/l! dot l(l - 1) dot dots dot 1 + h dot [dots]
$

== Tobbvaltozos esetben (n valtozo)
meg lehet forditani a dolgot
$
  (T_(a,s)f) (a + h): h = 0, 1, dots, s"-re az osszes " k"-ad rendu parcialis derivaltjai" equiv f " " k"-ad rendu parcialis derivaltjai"
$

/ pl:
$
  (T_(a, 0)f)(a + h) = f(a)\
  (T_(a, 1)f)(a + h) = f(a) + partial_1 f(a) dot h_1 + partial_2 f(a) dot h_2 + dots + partial_n f(a) dot h_n "  " (h = (h_1, h_2, dots, h_n))
$

/ pl:
$
  (T_(a, 2)f)(a + h) = f(a) + sum_(k = 1)^n partial_k f(a) dot h_k + (partial_11 f(a))/(2!) dot h_1^2 + dots + (partial_(n n) f(a))/(2!) dot h_n^2
$
igy
$
  partial_12 f(a) dot h_1 h_2
$
ezert $partial_21 f(a) dot h_2 h_1$ nem kell, mert a ketto ugyanaz\
igy minden valtozopart csak egyszer kell vennem
$
  = f(a) + sum_(k = 1)^n partial_k f(a) dot h_k + sum_(k = 1)^n (partial_(n n)f(a))/(2!) dot h_k^2 + sum_(i = 1)^(n - 1) sum_(j = i + 1)^(n) partial_(i j) f(a) h_i h_j
$
/ harmadfoku tagok:
$
  (partial_(k k k)f(a))/(3!) dot h_k^3, "   " (partial_(i i j)f(a))/(2! 1!) dot h_i^2 h_j, "  " (partial_(i j k)f(a))/(1!1!1!) dot h_i h_j h_k
$

/ altalanosan: $k$-ad foku tag: melyik valtozot hanyszor valasztjuk?
mivel $n$ darab valtozo van bevezethetek egy multiindexet:
$
  i = (i_1, i_2, i_3, dots, i_n) "  ahol  " abs(i) := i_1 + i_2 + i_3 + dots + i_n = k\
  (partial_1^(i_1) partial_2^(i_2) partial_n^(i_n))/(i_1 ! i_2 ! dots i_n !) dot underbrace(h_1^(i_1) dot h_2^(i_2) dot h_n^(i_n), h^i)
$
lehet igy is jelolni:
$
  i_1 ! i_2 ! dots i_n ! =: i!,\
  partial_1^(i_1) partial_2^(i_2) partial_n^(i_n) =: partial^(i) f(a)\
  ==> (T_(a, n)f)(a + h) = sum_(k = 0)^s sum_(abs(i) = k) (partial^((i)) f(a))/(i!) dot h^i
$

/ $underbrace(n = 2, i = (i_1, i_2)\ h = (h_1, h_2))$ valtozora:
$
  (T_(a, 3) f)(a + h) = f(a) + underbrace((partial_1 f(a))/(1! 0!) dot h_1 + (partial_2 f(a))/(0! 1!) dot h_2, abs(i) = i_1 + i_2 = 1\ (1, 0) " es " (0, 1)) + (partial_(1 1) f(a))/(2!) h_1^2 + partial_(1 2) f(a) h_1 h_2 + (partial_(2 2)f(a))/(2!) +\ + (partial_(1 1 1) f(a))/(3!) h_1^3+ (partial_(1 1 2) f(a))/(2!1!) h_1^2 h_2 + (partial_(1 2 2) f(a))/(1!2!) h_1 h_2^2 + (partial_(2 2 2) f(a))/(3!) h_2^3\
  #table(
    columns: 3,
    [$i$], [$(1, 0)$], [$(0, 1)$],
    [$i!$], [$1! dot 0! = 1$], [$0! dot 1! = 1$],
    [$h^i$], [$h_0^1 h_2^0 = h_1$], [$h_1^0 h_2^1 = h_2$],
  )\
  #table(
    columns: 4,
    [$i$], [$(2, 0)$], [$(1, 1)$], [$(0, 2)$],
    [$i!$], [$2!$], [$1!1!$], [$2!$],
    [$h^i$], [$h_1^2$], [$h_1 h_2$], [$h_2^2$],
    [$partial^i f$], [$partial_(1 1) f$], [$partial_(1 2) f$], [$partial_(2 2) f$],
  )\
  #table(
    columns: 5,
    [$i$], [$(3, 0)$], [$(2, 1)$], [$(1, 2)$], [$(0, 2)$],
    [$i!$], [$3!$], [$2!1!$], [$2!1!$], [$3!$],
    [$h^i$], [$h_1^3$], [$h_1^2 h_2$], [$h_1 h_2^2$], [$h_2^3$],
    [$partial^(i) f$], [$partial_(1 1 1) f$], [$partial_(1 1 2) f$], [$partial_(1 2 2) f$], [$partial_(2 2 2) f$],
  )
$

/ megjegyzes: $n$-valtozo, $2$ fokig:
$
  f(a) + sum_(i = 1)^n partial_i f(a) dot h_i + sum_(i = 1)^k (partial_(i i) f(a))/(2!) h_i^2 + underbrace(sum_(i, j = 1\ i < j)^n sum^n partial_(i j) f(a) h_i dot h_j, sum_(i, j = 1\ i != j)^n sum^n (partial_(i j) f(a))/(2) dot h_i h_j)\
  = f(a) = chevron.l f'(a), h chevron.r + 1/2 dot chevron.l f''(a) dot h, h chevron.r
$
ugyanis
$
  chevron.l mat(
    d_(1 1), d_(1 2), dots, d_(1 n);
    d_(2 1), d_(2 2), dots, d_(1 n);
    dots, dots, dots, dots;
    d_(n 1), d_(n 2), dots, d_(n n);
  ) dot
  mat(
    h_1;
    h_2;
    dots;
    h_n;
  ),
  mat(
    h_1;
    h_2;
    dots;
    h_n;
  )
  chevron.r = ?
$

/ pl: $f(x, y) = 2x^2 - x y - y^2 - 6 x - 3 y + 5 "  " (x, y) in RR^2 "  " a = (1, -2)$,
$
  f(a) = f(1, -2) = 2 + 2 - 4 - 6 + 6 + 5 = 5\
  partial_x f(x, y) = 4x - y - 6, "  " partial_x f(a) = 0\
  partial_y f(x, y) = -x -2y - 3, "  " partial_y f(a) = 0\
  partial_(x x) f(x, y) = 4 = partial_(x x) f(a)\
  partial_(x y) f(x, y) = -1\
  partial_(y x) f(x, y) = -1\
  partial_(y y) f(x, y) = -2\
  (T_(a, 2)f)(a + h) = f(a) + partial_x f(a) h_1 + partial_y f(a) dot h_2 +\ + 1/ 2 partial_(x x) f(a) dot h_1^2 + partial_(x y) f(a) h_1 h_2 + 1/2 partial_(y y) f(a) h_2^2 = 5 + 4/2 h_1^2 - 1 dot h_1 h_2 + -2/2 h_2^2 = 5 + 2h_1^2 - h_1 h_2 - h_2^2
$
vagy lehet ilyen formaban is irni
$
  = 5 + (chevron.l mat(0; 0), mat(h_1; h_2) chevron.r) = 1/2 chevron.l mat(4, -1; -1, 2) dot mat(h_1; h_2), mat(h_1; h_2) chevron.r\
$
$
  mat(h_1; h_2) = mat(x; y) - mat(1; -2) = mat(x - 1; y + 2)\
  (T_(a, 2)f)(x, y) = 5 + 2(x - 1)^2 - (x - 1)(y + 2) - (y + 2)^2
$

/ pl: $1,02^(3,01)$
$
  (1 + x)^(3,01) " nemjo"\
  1,02^(3 + x) " nemjo"
$
inkabb hasznaljunk ket valtozot
$
  1,02^(3,01) approx (1 + x)^(3 + y) = f(x, y)
  "vagy"\
  x^y = f(x, y) "  " a = (1, 3) "kozeppontu Taylor-polinomja"\
  partial_x f(x, y) y dot x^(y - 1), "  " (y in K(3))\
  partial_y f(x, y) = x^y ln(x), "  " (x in K(1))\
  dots
$
