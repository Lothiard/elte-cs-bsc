== Linearis kodok
=== mit jelent?
definicio: $C subset FF_q^n$ linearis, ha $C$ egy alter $FF_q^n$-ben. Ekkor $k = dim(C)$ a kod dimenzioja.\ Specialisan $abs(C) = q^k$. Ekkor $C$ egy $(n, k)$ kod.

=== linearis kodoknal
Singleton-korlat: $k <= n - d + 1$\
kodsuly: $w(C) = d(C)$\
Hamming-korlat: $C subset FF_q^n$ egy linearis $(n, k)$ kod, amely $t$ hibat tud javitani.\ Ekkor
$
  sum^n_(i = 0) binom(n, i)(q - 1)^i <= q^(m - k)
$

== 1.
Legyen $V$ egy vektorter. $W subset V$ egy linearis alter, ha
/ 1: $V != nothing$\
/ 2: $w_1, w_2 in W, " " a, b in underbrace(KK, KK = RR or CC) ==> a dot w_1 + b dot w_2 in W$\
/ 3: $O in W$

=== a
$
  (c_1, c_2, c_3) arrow (c_1, c_2, c_3, c_1 + c_2 + c_3) "  " c_1, c_2, c_3 in FF_2\
$

/ 1:
$
  (0,0,0) arrow (0,0,0,0)
$

/ 2:
$
  a(u_1, u_2, u_3, u_1 + u_2 + u_3) + b(v_1, v_2, v_3, v_1 + v_2 + v_3) = (a dot u_1 + b dot v_1, a dot u_2 + b dot v_2 a dot c_3 + b dot c_3, c_1 + c_2 + c_3)
$
inkabb engedjuk el

=== b
$
  (c_1, c_2) arrow (c_1, c_2, c_1 + c_2, max{c_1, c_2})
$

$
  C != nothing\
  (0,0) arrow (0, 0, 0, 0)\
  a dot (u_1, u_2, u_1 + u_2, max{u_1, u_2}) + b(v_1, v_2, v_1 + v_2, max{v_1, v_2}) = (dots, a dot max{u_1, u_2} + b dot max{v_1, v_2}) =\ = (1, 1, 0, 1) + (1, 0, 1, 1) = (0, 1, 1, 0) ==> "ellentmondas"
$

== 2.
$C$ linearis $(n, k)$ kod $==> C$ alter $==> c_1, dots, c_n in C$ szavak, melyek generaljak a $C$ alteret.
$
  <c_1, dots, c_k> = {a_1 dot c_1 + a_2 dot c_2 + dots + a_n dot c_n in FF_q} = C
$

Generator matrix:\
$C$ egy linearis $(n, k)$ kod $c_1, dots, c_k$ generatorokkal.\ Ekkor $C$ egy generatormatrixa $G = (c_1, dots, c_k) in FF_q^(n times k)$

$n$-szeres ismetles kod: $G = (1, 1, dots, 1)^T = 1^T in FF_q^(n times 1)$\
paritasbites kod: $G = mat(I; 1,) in FF_n^((k + 1) times k)$

Egy $u arrow G_u$ kodolas szisztematikus, ha a kodszavak utolso $n - k$ elemet elhagyva a kodolando szot kapjuk.\
$G = mat(I; B), B in FF_q^((n - k) times k)$

== pelda
$
  (c_1, c_2) arrow (c_1, c_2, c_1 + c_2)
$
ez egy paritasbites kodolas
$
  G = mat(
    1, 0;
    0, 1;
    1, 1;
  )\
  
  G dot c = mat(
    c_1;
    c_2;
    c_1 + c_2;
  )\
$

Ellenorzo matrix:
$C$ egy $(n, k)$ kod. $C$ egy ellenorzo matrix. $H in FF_q^((n - k) times n)$\
$H_c = 0$ pontosan akkor ha $c in C$\

$n$-szeres ismetles kod: $H = (I_(n - 1), -1) in FF_q^((n - 1) times n)$

paritasbites: $H = 1 = (1, dots, 1) in FF_q^(1 times (k + 1))$

Minimalis tavolsag:
$C$ egy $(n, k)$ kod, $H in FF_q^((n - k) times n)$ a $C$ kod ellenorzo matrixa.\
Pontosan $d$ a kod minamalis tavolsaga, ha a $H$ minden $<= d - 1$ oszlopa linearisan fuggetlen.\
Van $H$-nak $d$ opszlopa, esek linearisan osszefuggoek\

Legyen $C$ egy $(n, k)$ kod, $G in FF_q^(n times k)$ a $C$ generatormatrixa, $H in FF_q^((n - k) times n)$ pontosan akkor az ellenorzomatrixa ha $H G = O in FF_q^((n - k) times k)$ rank $H = n - k$

Legyen $C$ egy $(n, k)$ kod, $G in FF_q^(n times k)$ a $C$ generatormatrixa. TFH: $u arrow G_u$ kodolas szisztematikus, azaz $G = mat(I_u; B) in FF_q^(n times k), B in FF_q^((n - k) times k)$. Ekkor $H = (-B, I_(n - k))$

== 3.
=== a.
$
  G_1 = mat(
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
    1, 1, 0, 0;
    1, 0, 0, 1;
    1, 1, 1, 0;
  )\
  n = 7, k = 4 ==> (7, 4) "kod"\
  B = mat(
    1, 1, 0, 0;
    1, 0, 0, 1;
    1, 1, 1, 0;
  )\
  H = (-B, I_(n - k)) = mat(
    -1, -1, 0, 0, 1, 0, 0;
    -1, 0, 0, -1, 0, 1, 0;
    -1, -1, -1, 0, 0, 0, 1;
  ) ==> H "minden" 1 <= d - 1 " oszlopa linearisan fuggetlen"\
$

=== b.
$
  G_2 = mat(
    1, 0, 0;
    0, 1, 0;
    0, 0, 1;
    1, 1, 1;
    1, 0, 0;
    1, 1, 1;
    0, 1, 0;
  )\
  n = 7, k = 3 ==> (7, 3) "kod"\
  B = mat(
    1, 1, 1;
    1, 0, 0;
    1, 1, 1;
    0, 1, 0;
  )\
  H = (-B, I_(n - k)) = mat(
    -1, -1, -1, 1, 0, 0, 0;
    -1, 0, 0, 0, 1, 0, 0;
    -1, -1, -1, 0, 0, 1, 0;
    0, -1, 0, 0, 0, 0 ,1;
  ) ==> H "minden" 1 <= d - 1 " oszlopa linearisan fuggetlen"\
$

== 4
=== a
$
  (c_1, c_2, c_3) arrow (c_1, c_2, c_3, c_1 + c_2 + c_3)\
  G = mat(
    1, 0, 0;
    1, 1, 0;
    1, 0, 1;
    1, 1, 1;
  )\
  H = [-1, -1, -1, 1]
$
hany darab linearisan fuggetlen oszlopa van legfeljebb?
$
  d = 2,\
  t = floor((d - 1)/2) = floor((2 - 1)/2) = 0\
  k =^? n - d + 1\
  3 = 4 - 2 + 1\
  3 = 3 ==> "MDS"
$
Hamming korlat:
$
  sum^t_(i = 1) binom(n, i)(q - 1)^i <= q^(n - k) ==> sum^0_(i = 0) binom(4, i)(2 - 1)^i =^? 2^(4 - 3) = binom(4, 0)(1)^0 = 2^1 ==> 1 != 2 ==> "nem perfekt kod"
$

=== c
$
  (c_1, c_2, c_3) arrow (c_1, c_2, c_3, 2 c_1 + 3 c_2, c_1 + 4 c_3) in FF_5\
  G = mat(
    1, 0, 0;
    0, 1, 0;
    0, 0, 1;
    2, 3, 0;
    1, 0, 4;
  )\
  H = mat(
    -2, -3, 0, 1, 0;
    -1, 0, -4, 0, 1;
  ) = mat(
    3, 2, 0, 1, 0;
    4, 0, 1, 0, 1;
  ) ==> d <= 2\
  k =^? n - d + 1 ==> 3 != 4 ==> "nem MDS"\
  "nem perfekt"
$

