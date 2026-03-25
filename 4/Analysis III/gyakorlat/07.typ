/ emlekezteto: $f in RR^2 arrow RR, a in "int" cal(D)_f, norm(v) = 1$
az ertelmezesi tartomanyban az a pontbol a v iranyu egyenest vesszuk.\ legyen ez $e$, ekkor $e = {a + t v | t in RR}$\
ekkor $t = 0$-ra kapjuk az $a$ pontot\
alakithatjuk ezt fuggvennye ugy hogy leszukitjuk az $e$ egyenesre: $g(t) = f(a + t v), t in k(0)$, ez un. iranymenti fuggveny, es $delta_v f(a) := g'(0)$

/ Tetel:
$
  "ha" delta_x f, delta_y f " leteznek az" a "pont kornyezeteben es folytonosak" a"-ban akkor"\
  delta_v f(a) = delta_x f(a) dot v_1 + delta_y f(a) dot v_2 " ahol" v = (v_1, v_2)
$

/ pl:
$
  f(x, y) = y^3/(e^(2x + 1)), " " ((x, y) in RR^2) "  " a = (-1/2, 1), " pontban az " u = (1,2) " irany szeriti derivaltja?"\
  delta_x f(x, y) = delta_x (y^3 dot e^(-2x - 1)) = y^3 dot e^(-2x-1) dot (-2)\
  delta_y f(x, y) = (3y^2 dot e^(-2x - 1))
$
az eredeti fuggveny mindenhol ertelmezve van szoval a ket derivaltja is, ugyanez igaz folytonossagra
$
  delta_x f, delta_y f in C(RR^2)
$
hasznalhatjuk a tetelt
$
  delta_v f(a) = delta_x f(a) dot v_1 + delta_y f(a) dot v_2\
  delta_x f(-1/2, 1) = 1^3 dot e^(-2 dot (-1/2) - 1) dot (-2) = -2\
  delta_y f(-1/2, 1) = 3 dot 1^2 dot e^0 = 3
$
a vektorunk nem egyseghosszu, amire figyelni kell kulonben a derivalt es megszorzodik valamilyen normatol fuggo szammal
$
  v = u/norm(u) = 1/(sqrt(1^2 + w^2)) dot (1,2) = (1/sqrt(5), 2/sqrt(5))
$
folytatva
$
  d_v f(a) = (-2) dot 1/sqrt(5) + 3 dot 2/(sqrt(5)) = underline(underline(4/sqrt(5)))
$

haladjunk tovabb az utolso es harmadik fajta derivaltra ami mult oran lemaradt
#pagebreak()
== totalis derivalt
/ emlekezteto: $f in RR arrow RR, a in "int" cal(D)_f$, es $f in D{a}, f'(a) = A in RR <==> lim_(h arrow 0) (f(a + h) + f(a))/(h) = A$
erdemes megemliteni ezt az ekvivalenciat is
$
  "f derivalhato es letezik derivaltja" <==>^"linearis"_"kozelites" exists epsilon in RR arrow RR " es " lim_0 epsilon = 0\
  f(a + h) = underbrace(f(a) + A dot h, "erintoegyenes erteke"\ (a + h)"-ban") + epsilon(h) dot h
$

most pedig
$
  f in RR^n arrow RR^m, a in "int" cal(D)_f\
  f in D{a} "es" f'(a) = A in RR^(m times m) <==> lim_(h arrow norm(dot)) (norm(f(a + h) - f(a) - A dot h))/(norm(h)) = 0\
  <==>\
  exists epsilon: RR^n arrow RR^m " " lim_(norm(dot)) epsilon = 0 "es" f(a + h) = underbrace(f(a) + A dot h, "erintosik") + epsilon(h) dot norm(h)
$

specialisan
$
  f in RR^2 arrow RR "  " A = mat(delim: "[", d_1, d_2) in RR^(1 times 2) " es" f(a + h) = underbrace(f(a) + mat(delim: "[", d_1, d_2) dot mat(h_1; h_2), f(a) + d_1 dot h_1 + d_2 dot h_2\ = f(a_1, a_2) + d_1 dot (x - a_1)\ +d_2 dot (y - a_2)\ "sik iranyvektoros alakja") + epsilon(h) dot norm(h)
$

/ pl:
$
  f(x, y) = 2x^2 + 3x y - y^2 "  " ((x, y) in RR^2)\
  a = (1,2)
$
- $f in D{a}?$
- $f'(a) = ?$
ez akkor lesz lehetseges ha letezik olyan $A = mat(delim: "[", d_1, d_2)$ amivel $ lim_(h arrow (0,0)) (abs(f(a + h) - f(a) - mat(delim: "[", d_1, d_2) mat(h_1; h_2)))/(norm(h)) = 0 $
kezdjuk el
$
  f(a + h) - f(a) = f(1 + h_1, 2 + h_2) - f(1, 2) = 2(1 + h_1)^2 + 3(1 + h_1)(2 + h_2) - (2 + h_2)^2 =\ = -(2 dot 1^2 + 3 dot 1 dot 2 - 2^2) = 2(1 + 2h_1 + h_1^2) + 3(2 + 2h_1 + h_2 + h_1 h_2) - (4 + 4h_2 + h_2^2) - 4 =\ = 10h_1 - h_2 + 2h_1^2 + 3h_1 h_2 - h_2^2
$
ahol
$
  a = (1, 2)\
  h = (h_1, h_2)
$
tehat
$
  0 <= (abs(10h_1 - h_2 + 2h_1^2 + 3h_1 h_2 - h_2^2 - d_1 h_1 - d_2 h_2))/(norm(h)) = (abs(2h_1^2 + 3h_1 h_2 - h_2^2))/(norm(h))
$
ha ugy valasztok hogy
$
  d_1 = 10\ d_2 = -1
$
a kiejtett tagokat muszaj kiejteni mert a normaval valo osztas miatt azok siman konstansokka egyszerusodnenek es akkor sosem tartananak nullahoz ami nagyon megneheziti a dolgunkat. Ez indokolja a valasztasunk, melynek celja az elsofoku tagok kiejtese

haromszog egyenlotlenseggel:
$
  (abs(2h_1^2 + 3h_1 h_2 - h_2^2))/(norm(h)) <= (2 abs(h_1)^2 + 3 abs(h_1) dot abs(h_2) + abs(h_2)^2)/(norm(h)) <= (2 norm(h)^2 + 3 norm(h)^2 + norm(h)^2)/(norm(h)) = 6 norm(h) arrow 0 " ha" h arrow (0, 0)\
  ==> f in D{a} "es" f'(a) = mat(delim: "[", 10, -1)
$

/ megjegyzes: ha
- $delta_x f, delta_y f$ letezik $h(a)$ kornyezetben
- $delta_x f, delta_y f in C{a}$
akkor
$
  f in D{a} "es" f'(a) = underbrace(mat(delim: "[", delta_x f(a), delta_y f(a)), "Jacobi-matrix")
$

ennek a tetelnek az alkalmaza az elozo feladattal
$
  delta_x f(x, y) = 4x + 3y\
  delta_y f(x, y) = 3x - 2y\
$
parcialis derivaltak valoban leteznek $forall (x, y) in RR^2$ es $delta_x f, delta_y f in C(RR^2)$
tehat
$
  ==> f in D{a} "es" f'(a) = mat(delim: "[", delta_x f(1,2), delta_y f(1,2)) = mat(delim: "[", 10, -1)
$

#pagebreak()
/ pl:
$
  f(x, y) = sqrt(abs(x dot y)), " " (x, y) in RR^2
$
+ $f in C{(0, 0)}?$
+ jacobi-matrix letezik, avagy $delta_x f(0, 0)?, delta_y f(0, 0)?$
+ $f in.not D{(0, 0)}$

/ 1.:
nem kell extrazni, a muveleti tetelek szempontjabol nincs kritikus eset, es mivel $x, y, abs(dot), sqrt(dot)$ mind folytonos ezert a kompozicio is folytonos, tehat $f$ is folytonos

/ 2.:
muveleti szabaly nem hasznalhato az $abs(dot)$ miatt. $abs(dot)$ nem derivalhato. hatarozzuk meg oket iranymenti derivaltkent, tehat definicioval

ha $a = (0, 0)$ es $v = (1,0)$ akkor $e = {(t, 0), t in RR} ==> g(t) := f(t, 0)$ es $delta_x f(0, 0) = g'(0) = 0$
mivel
$g(t) = f(t, 0) = sqrt(abs(t dot 0)) = 0 = g'(t)$

ugyanez $delta_y f$-re, ez alkalommal az $y$ tengelyt veszem

$e = {(0, t) | t in RR} ==> h(t) := f(0, t) = sqrt(abs(0 dot t)) = 0 ==> h'(t) = 0$

tehat $A = mat(delim: "[", 0, 0)$

/ 3.:
megmondtuk hogy csak a 2.-ben kapott matrix-szal lehet derivalhato\
Ha $f in D{(0,0)}$ lenne, akkor $f'(0,0) = mat(delim: "[", 0, 0)$ lenne\

/ eleg: ha belatjuk, hogy
$
  lim_(n arrow (0, 0)) (abs(f(a + h) - f(a) - mat(delim: "[", 0, 0) dot h))/(norm(h)) " hatarertek NEM 0   VAGY   NEM letezik"
$
$a = (0, 0)$
$h = (h_1, h_2)$
$
  (abs(f(h_1, h_2) - f(0,0)))/(norm(h)) = (sqrt(abs(h_1 h_2)))/(sqrt(h_1^2 h_2^2))
$
itt az atviteli-elv alapjan eleg olyan $(x_n, y_n)$ sorozatot megadni hogy $(x_n, y_n) arrow (0, 0)$ DE $(sqrt(abs(x_n y_n)))/(sqrt(x_n^2 y_n^2)) arrow.not 0$

/ pl:
$
  (x_n, y_n) = (1/n, 1/n) arrow (0,0)\
$
DE
$
  (sqrt(abs(1/n dot 1/n)))/(sqrt(1/n^2 1/n^2)) = (1/n)/(sqrt(2)/n) = 1/sqrt(2) arrow^(n arrow +oo) 1/sqrt(2) != 0
$

#pagebreak()
kene meg ismerni erinteosik fogalmat zhra sajnos szerencsere
/ pl:
$
  f(x, y) = sqrt(x^2 - 2y^2) "  " (x^2 > 2y^2)
$
+ $delta_x f(x, y), delta_y f(x, y)?$
+ $a = (3, 2)$-beli erintosik egyenlete?

/ 1.:
$
  delta_x f(x, y) = 1/2 (x^2 - 2y^2)^(-1/2) dot (2x - 0) = x/(sqrt(x^2 - 2y^2))\
  delta_y f(x, y) = 1/2 (x^2 - 2y^2)^(-1/2) dot (0 - 4y) = (-2y)/(sqrt(x^2 - 2y^2))
$

/ 2.:
erintosik akkor letezik ha a fuggveny derivalhato\ eloszor meg kell indokolni hogy egyaltalan letezik azzal hogy derivalhato. itt $delta_x f, delta_y f$ letezik $h(a)$ kornyezetben, mert $3^2 > 2 dot 2^2, (x^2 > 2y^2)$ es $delta_x f, delta_y f in C{a} ==> f in D{a} ==>$ letezik erintosik
$
  z = f(a) + delta_x f(a) dot (x - a_1) + delta_y f(a) dot (y - a_2)\
  f(a) = sqrt(3^2 - 2 dot 2^2) = 1\
  delta_x f(a) = 3/sqrt(3^2 - 2 dot 2^2) = 3\
  delta_y f(a) = (-2 dot 2)/sqrt(3^2 - 2 dot 2^2) = -4\
$
tehat az erintosik
$
  z = 1 + 3(x - 3) - 4(y - 2) <==> 0 = 3x - 4y - z "  "("normalvektoros egyenlet")\
$
ezt felfoghatjuk ugy hogy
$
  chevron.l (3, -4, -1), (x, y, z) chevron.r
$
ebbol egyertelmuen latszik hogy ez tenyleg egy sik, es ennek az elso komponense a normalvektor
