/ pelda:
$
  f_n (x) = x^n - x^(2n), "  " x in [0, 1]
$

/ a): $(C[0,1], norm(dot)_oo)$
pontonkenti hatarfuggveny:
$
  f(x) := lim_(n arrow +oo) f_n (x) "  " x in [0,1] "rogzitett"\
  = lim_(n arrow +oo) (underbrace(x^n, "mertani sorozat") - underbrace(x^(2n), "mertani sorozat")) = cases(
    1 - 1 = 0\, "  " x = 1,
    0 - 0 = 0\, "  " x in [0, 1)
  ) ==> f(x) = 0
$

Ha konvergens $norm(dot)_oo$-ban akkor $f$-hez tart.

$
  "Konvergens" <==> lim_(n arrow +oo) norm(f_n - f)_oo = 0
$

$
  norm(f_n - f)_oo = norm((x^n - x^(2n)) - 0)_oo = max_(x in [0,1]) abs(x^n - x^(2n))\
  x in [0,1] ==> x >= 1^2 ==> x^n >= x^(2n)\
  "VAGY"\
  "elojelet csak zerushelyben valthat fuggveny"\
  x^n - x^(2n) = abs(underbrace(x^n, >= 0) underbrace((1 - x^n), >= 0))\
$

most abszolut szelsoertek kereses
$
  f_n (0) = 0\
  f_n (1) = 0\
$
csak ezekben a pontokban lehet szelsoertek
$
  f_n '(x) = n x^(n - 1) - 2n dot x^(2n - 1) = 0 "  " x in (0, 1)\
  x^(n - 1) = 2x^(2n - 1)\
  1 = 2x^((2n - 1) - (n - 1))\
  1/2 = x^n <==> x = 1/(root(n, 2))
$
ekkor
$
  f_n (1/(root(n, 2))) = 1/2 - 1/4 = 1/4
$
ez az abszolut maximum
$
  norm(f_n - f)_oo = max_(x in [0,1]) (x^n - x^(2n)) = 1/4 arrow 1/4 "  " (n arrow +oo)\
  1/4 != 0 ==> "NEM konvergens" norm(dot)_oo"-ban!"
$

#pagebreak()
/ b): Allitas: konvergal $f$-hez $norm(dot)_1$-ben
Kell:
$
  lim_(n arrow +oo) norm(f_n - f)_1 = 0\
  norm(f_n - f)_1 = integral_0^1 abs(f_n - f) = integral_0^1 abs((x^n - x^(2n)) - 0) dif x = integral_0^1 x^n - x^(2n) dif x = [x^(n + 1)/(n + 1) - (x^(2n + 1))/(2n + 1)]^1_0 = 1/(n + 1) - 1/(2n + 1) arrow\ arrow 0 - 0 = 0 "  " (n arrow +oo)
$

#pagebreak()
= tobbvaltozos fuggvenyek (foleg $f in RR^2 arrow RR$)
fontos megjegyezni hogy olyan ertelemben gondolok rajuk hogy normalt terrol kepeznek normalt terre. tehat $(RR^2, norm(dot)) arrow (RR, abs(dot))$

gyakorlatilag mindegy milyen normat veszek a normak ekvilvalenciaja miatt

hogy ha egy norma szerint teljesul a konvergencia akkor minden normara teljesulni fog

/ folytonossag:
$
  f in RR^2 arrow RR, "  " a in cal(D)_f\
  f in C{a} <==> forall epsilon > 0: exists delta > 0: forall x in cal(D)_f: norm(x - a) < delta: abs(f(x) - f(a)) < epsilon
$

/ hatarertek:
$
  f in RR^2 arrow RR, "  " a in cal(D)'_f\
  lim_a f = A <==> forall epsilon > 0: exists delta > 0: forall x in cal(D)_f: underbrace(0 <, x != a) norm(x - a) < delta: abs(f(x) - A) < epsilon
$

/ megjegyzes: a ketto kozotti osszefugges
ha mindketto ertelmes akkor pontosan akkor folytonos a fuggveny ha hatarertek $f(a)$ fuggvenyertek

tehat ha
$
  a in cal(D)_f inter cal(D')_f: f in C{a} <==> lim_a = f(a)
$

/ atviteli elv:
$
  f in C{a} <==> forall (u_n): NN arrow cal(D)_f,\ lim(u_n) = a ==> lim f(u_n) = f(a)
$

/ hatarertekre:
$
  lim_a f = A <==> forall (u_n): NN arrow cal(D)_f without {a},\ lim(u_n) = a ==> lim f(u_n) = A
$

#pagebreak()
/ folytonossag:
- muveleti tetel:
$
  f, g in C{a} ==> f + g, f dot g in C{a}\
  "ha" g(a) != 0 ==> f/g in C{a}
$
- kompozicio:
$
  g in C{a} " es " f in C{g(a)} ==> f circle.small g in C{a}
$
/ pl:
$
  f(x, y) = y^2 - x^2 in C(RR^2)
$

- alapfuggvenyek:
$
  f(x, y) = x\ g(x, y) = y\
  f, g in C(RR^2)
$

- kritikus esetek:
/ pl:
$
  f(x, y) = cases(
    (x^2 y^3)/(2x^2 + y^2)\, "  " (x, y) != (0, 0),
    0\, "         " (x, y) = (0, 0)
  )
$
allitas: $f in C(RR^2)$\
Ha $a != (0, 0):$
$
  x^2 y^3 in C{a}\
  2x^2 + y^2 in C{a}\
  x^2 y^3 != 0\
  ==>\
  (x^2 y^3)/(2x^2 + y^2) in C(RR^2, norm((0, 0)))
$
$
  exists k(a) subset RR^2: (0, 0) in.not k(a)\
  "ekkor" f_(k(a)) equiv (x^2 y^3)/(2x^2 + y^2) ==> f in C{a}
$

Ha $a = (0, 0):$

legyen $epsilon > 0$ tetszoleges
$
  delta = ? " amivel " forall norm((x, y) - (0, 0)) < delta: abs(f(x, y) - 0) < epsilon\
  "ha " norm((x, y)) < delta " akkor " abs((x^2 y^3)/(2x^2 + y^2) - 0) < epsilon\
  abs((x^2 y^3)/(2x^2 + y^2)) = (abs(x)^2 dot abs(y)^3)/(2x^2 + y^2) <= (norm((x, y))^2 dot norm((x, y))^3)/(norm((x, y))^2) =
$
elso lehetoseg:
$
  2x^2 + y^2 >= x^2 + y^2 = norm((x, y))^2
$
masodik lehetoseg:
$
  abs(x) <= norm((x, y))\
  abs(y) <= norm((x, y))\
  "ugyanis"\
  sqrt(x^2 + y^2) >= sqrt(x^2) = abs(x)
$
folytatva:
$
  = norm((x, y))^3 < delta^3 <_("kell") epsilon <==> delta < root(3, epsilon)
$

tehat
$
  delta := (root(3, epsilon))/2 " megfelelo"
$

\ \ \
allitas: $lim_((x, y) arrow (0, 0)) f(x, y) = 0$\
+ ugyanez a bizonyitas lenne megint hogy nulla a hatarertek
+ vagy lehet picit rovideni rajta kozrefogasi-elvvel: ($abs(f)$-re!!!)
$
  0 arrow.l 0 <= abs(f(x)) = abs((x^2 y^3)/(2x^2 + y^2)) <= dots <= norm((x, y))^3 arrow_((x, y) arrow (0, 0)) 0 "  (mert a " norm(dot) " folytonos fuggveny)"
$

#pagebreak()
hatarertekre pelda
$
  lim_((x, y) arrow (0, 0)) (x y)/(sqrt(x^2 + y^2)) = 0\
  0 arrow.l 0 <= abs(f(x, y)) = abs((x y)/(sqrt(x^2 + y^2))) = (abs(x) dot abs(y))/(sqrt(x^2 + y^2)) <=_(abs(x); abs(y) <= norm((x, y))) (norm((x, y))^2)/(norm((x, y))) = norm((x, y)) arrow 0 ==>\ ==> lim_((x, y) arrow (0, 0)) abs(f(x, y)) ==> lim_((0, 0)) f = 0
$

mi van akkor ha ezt nem tudjuk hasznalni?\
bizonyitsuk be:
$
  exists.not lim_((x, y) arrow (0, 0)) x^4/((x^2 + y^2)^2)\
$
ilyenkor lesz hasznos az atviteli-elv\ ezt relativ konnyu tagadni\ akkor nem fog letezni hatarertek ha letezni fog olyan sorozat ami nem tart $A$-hoz vagy valami ilyesmi
$
  exists.not lim_((0, 0)) f <==> exists (u_n), (v_n): NN arrow cal(D)_f without {(0, 0)}\
  lim (u_n) = (0,0)\
  lim (v_n) = (0,0)\
  lim f(u_n) != lim f(v_n)
$
tehat nem tart a ket sorozat kozos ertekhez\
/ $u_n$:
$x = 0"-ra"$:
$
  f(0, y) = 0^4/((0 + y^2)^2) = 0\
$
tehat $u_n = (0, 1/n) arrow (0, 0)$ eseten $lim f(u_n) = lim 0 = 0$

/ $v_n$:
$y = 0$-ra:
$
  f(x, 0) = (x^4)/((x^2 + 0^2)^2) = 1
$
tehat $v_n := (1/n, 0) arrow (0, 0)$ eseten $lim f(v_n) = lim 1 = 1 != 0 ==> exists.not lim_((0, 0)) f$
