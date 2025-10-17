householder matrixot altalaban sosem szamoljuk ki es sosem szorzunk vele ezert nem fogjuk sosem felirni

hasonlit a ge-hez, mert itt is csak sormuveleteket fogunk vegezni

ez es csak ez nagyon kelleni fog:
$
  x in RR^n H(v)x = (I - 2v v^T)x = x - 2v underbrace((v^T x), in RR)
$

vizualisan az $x$ es $v$ a ket szelen es kozepen a skalaris szorzatuk ketszereset vonjuk ki.

tulajdonsagok:
$
  H^T = H ("szimmetrikus")
$

$
  H^2 = I, "azaz" H^(-1) = H ("ortogonalis")
$

$
  H(v) dot v = -v
$

$
  forall y perp v : H(v) dot y = y
$

tetel
$
  "legyen" a,b in RR^n, a != b, norm(a)_2 = norm(b)_2 !+ 0:
$

$
  v = plus.minus (a - b)/(norm(a - b)_2) // TODO
$

== 3
a =
$
  mat(2;0;1)
$
b = 
$
  mat(1;2;0)
$
$
  v "melyre" H(v)a = b
$

$
  norm(a)_2 = norm(b)_2 = sqrt(5)
$

$
  a - b = mat(1;-2;1) arrow norm(a-b)_2 = sqrt(6)
$

$
  v = 1/sqrt(6) mat(1;-2;1)
$

ellenorzo lepes (nem kell ha jol csinaltuk ig)
$
  H(v) dot a = a - 2(v^T a) dot v = mat(2;0;1) - 2 1/sqrt(6) mat(1, -2, 1) dot mat(2;0;1) dot 1/sqrt(6) mat(1;-2;1) = mat(2;0;1) dot 2/6 dot 3 dot mat(1;-2;1) = mat(1;2;0)
$

== 4
a = 
$
  mat(-1;1;-1;1)
$

$
  k dot e_1 = mat(k;0;0;0)
$

$
  2 = norm(a)_2 = norm(k dot e_1)_2 = norm(k)_2 arrow k = +2
$
pozitiv mert az elso elem a-ban negativ

$
  a - k dot e_1 = mat(-1 - 2;1;-1;1) = mat(-3;1;-1;1)\
  norm(a - k dot e_1)_2 = sqrt(12) ==> v = 1/sqrt(12) dot mat(-3;1;-1;1)
$

= HF: ell: $H(v) dot a = k dot e_1 = mat(2;0;0;0)$

$
  H(v) dot b = b - 2(v^T b) dot v = mat(2;1;1;0) - 2 dot 1/sqrt(12) dot mat(-3,1,-1,1) dot mat(2;1;1;0) dot 1/sqrt(12) dot mat(-3;1;-1;1) = mat(2;1;1;0) - 2/12 dot (-6) mat(-3;1;-1;1) = mat(-1;2;0;1)
$

#pagebreak()
== 5
$
  mat(
    4, -2 , |, 0;
    3, 1, |, 5;
  ) arrow "householder" arrow
  mat(
    -5, 1, |, -3;
    0, 2, |, 4;
  ) ==>\ ==> 2x_2 = 4 arrow x_2 = 2\ x_1 = 1
$

mert
$
  norm(a_1)_2 = 5 arrow sigma_1 = -5\
  a_1 - sigma_1 e_1 = mat(
    5, -(-5);
    3, ;
  ) - 
  mat(9;3)
  = 3 dot mat(
    3;1
  ) ==> norm(dots)_2 = 3 dot 1/sqrt(10)\

  v_1 = 1/sqrt(10) mat(3;1)
$

Tudjuk hogy $H(v_1) dot a_1 = -5 dot a_1$

$
  H(v_1)"-et" "alkalmazzuk" a_2"-re":\ H(v_1) dot a_22 = a_2 - 2(v_1^T dot a_2) v_1 = mat(-2;1) - 2 dot 1/sqrt(10) mat(3,1) dot mat(-2;1) dot 1/sqrt(10) mat(3;1) = mat(-2;1) - 2/10 dot (-5) dot mat(3;1) = mat(-2 + 3; 1 + 1) = mat(1;2)
$

$
  H(v_1)"-et" "alkalmazzuk" b"-re":\ mat(0;5) - 2 dot 1/sqrt(10) mat(3,1) dot mat(0;5) dot 1/sqrt(10) dot mat(3;1) = mat(0;5) - 2/10 dot 5 dot mat(3;1) = mat(-3; 4)
$

#pagebreak()
== 6
$
  mat(
    1, 0, 1, |, 2;
    0, 2, 0, |, 2;
    1, 0, 3, |, 4;
  ) arrow "householder" arrow
  mat(
    -sqrt(2), 0, -2 sqrt(2), |, -3 sqrt(2);
    0, 2, 0, |, 2;
    0, 0, sqrt(2), |, sqrt(2);
  )
$
