hatodik gyakorlat anyaga switchup
ropzhra is a hatodikbol kell keszulni

= taylor formula a lagrange-fele maradekkal
Legyen $n in NN$\
TFH $f in D^(n + 1)(K(a))$\
Ekkor
$
  forall x in dot(K)(a) " ponthoz " exists xi " " a " es " x " kozott ":\
  f(x) - T_(a, n)(f, x) = f(x) - sum_(k = 0)^n (f^((k))(a))/(k!) (x - a)^k = (f^((n + 1)) (xi))/((n + 1)!) (x - a)^(n + 1).
$

== 1/a
$
  f(x) := 1/(root(3, x + 1)) "  " x in (-1, +infinity) =: I; "  " a = 0; "  " T_3 f(x) = ?; "  " x in (0, 1/10]; "  hiba?"
  \
  T_3 f(x) = f(0) + f'(0) x + ((f''(0))/2!) x^2 + ((f'''(0))/3!) x^3\
  f(x) = (x+1)^(-1/3) ==> f(0) = 1\
  f'(x) = -1/3 (x+1)^(-4/3) dot 1 ==> f'(0) = -1/3\
  f''(x) = 4/9 (x+1)^(-7/3) dot 1 ==> f''(0) = 4/9\
  f'''(x) = -28/27 (x+1)^(-10/3) dot 1 ==> f'''(0) = -28/27\
  "eleg lenne de a hiba miatt kell n+1 edik derivalt is"\

  f^((4))(x) = 280/81 (x+1)^(-13/3) dot 1\
  T_3 f(x) = T_3 (x) = 1 - 1/3 x + (4/9)/2 x^2 - (28/27)/6 x^3 = 1 - 1/3 x + 2/9 x^2 - 14/81 x^3 " " (x in RR)\
  // "1 - 1/3 x a nullaban az erinto"
  // megjegyzes: a konstans 1 kozeliti meg a legjobban

$
$
  f(x) - T = abs((f^((4))(xi))/(4!) x^4)\
  0 < xi < x <= 1/10\
  abs(f(x) - T_(0, 3)(f, x)) = 1/24 dot 280/81 dot abs(1/(root(3, x + 1))) dot abs(x^4) = 70/681\
  "tehat a vegeredmeny"\
  35/243 dot 1/10^4 = 7/(486 dot 10^3)\
$
== 1/b
$
  "adjunk egy kozelitoerteket:"
  A := 1/root(3, 1.03) approx ? " es hiba"\
  1/root(3, 1.03) = 1/root(3, x+1) = f(x) <==> x + 1 = 1 + 3/100 <==> x = 3/100 in (0, 1/10]\
  A = f(3/100) approx T_3 f(3/100) = 1 - 1/3 dot 3/100 + 2/9 dot 9/10000 - 14/81 dot 27/10^6 = 1485293/1500000 = 0,99153\
  "Hiba:"\
  abs(1/root(3, 1.03) - T_3 f(3/100)) <= 1/4! dot abs(f^((4)) (2/3?)) dot (3/100)^4 <= 7/6 dot 10^(-7)
$

== 2 hazi

L'Hospital szabaly
$
  lim (tg x - x)/(x - sin x) = 0/0\
  "akkor mukodik a hospital ha" 0/0 "vagy "infinity/infinity". altalaban jobb oldali hatarertekre mondjak ki"\
  lim_0 f/g = lim_0 f'/g'\
  lim_(x arrow 0) (tg x - x)/(x - sin x) = 0/0 = L'H = lim_(x arrow 0) (1/(cos^2 x) - 1)/(1 - cos x) =\
  = lim_(x arrow 0) (1-cos^2 x)/(cos^2 x (1 - cos x)) = lim_(x arrow 0) ((1-cos x)(1 + cos x))/(cos^2 x (1 - cos x)) = 2/1 = 2\
$

== 2
$
  lim_(x arrow 0) (1/x - 1/(e^x - 1)) = lim_(x arrow 0) (e^x - 1 - x)/(x(e^x - 1)) = 0/0 = L'H = lim_(x arrow 0) (e^x - 1)/(1(e^x - 1) + x e^x) =\ = e^x - 1 + x e^x = 0/0 = L'H = lim (e^x)/(e^x + e^x + x  e^x) = 1/2
$

== 3
// hf hogy jobbrol tartson nullahoz
// alapbol csak 0-1 intervallumon ertelmes
$
  lim_(x arrow 1-0) ln x dot ln (1-x) = 0 dot (-infinity)\
  f dot g = f/(1/g) = g/(1/f)\ // az egyszerubbet erdemes levinni
  lim_(x arrow 1-0) ln x dot ln (1-x) = (ln (1-x))/((1)/(ln x)) = (-infinity)/(-infinity) = L'H = lim_(x arrow 1-0) ((1)/(1 - x) dot (-1))/((-1) dot (ln x)^2 dot 1/x) =\ = lim_(x arrow 1-0) x dot lim_(x arrow 1-0) ((ln x)^2)/(1 - x) = 0/0 = L'H = lim_(x arrow 1-0) (2 ln x dot 1/x)/(-1) = (2 ln 1 dot 1)/(-1) = 0
$

#pagebreak()
== e
$1^infinity$-rol az euler szamoknak kellett volna eszunkbe jutnia
$
  lim_(x arrow 0) ((a^x + b^x + c^x)/3)^(1/x) "  " (a, b, c > 0) =\
  = 1^(infinity) = e^(ln(f(x)^g(x))) = e^(g(x) dot ln f(x)) 

  lim_(x arrow 0) e^(1/x dot ln((a^x + b^x + c^x)/3))\

  "kitevo":
  lim_(x arrow 0) ln((a^x + b^x + c^x)/3)/x = 0/0 = L'H = (ln((a^x + b^x + c^x)/3))' = 1/((a^x + b^x + c^x)/3) dot ((a^x ln a + b^x ln b + c^x ln c)/3) =\ = (a^x ln a + b^x ln b + c^x ln c)/(a^x + b^x + c^x),

  \
  "kitevo hatarerteke":
  lim_(x arrow 0) (ln((a^x + b^x + c^x)/3))/(x) = 0/0 = L'H = lim_(x arrow 0) (a^x ln a + b^x ln b + c^x ln c)/3 = (ln a + ln b + ln c)/3 = ln root(3, a b c)\

  "Mivel " exp " fuggveny folytonos " RR "-en, ezert":\
  lim_(x arrow 0) ((a^x + b^x + c^x)/3)^(1/x) = exp (ln root(3, a b c)) = root(3, a b c)
$
