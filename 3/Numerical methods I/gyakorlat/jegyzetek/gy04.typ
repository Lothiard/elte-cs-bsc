= 1.

$
  mat(
    4, 2, 6, -2;
    2, 10, 9, 5;
    6, 9, 14, 2;
    -2, 5, 2, 7;
  ) arrow
  mat(
    4, 2, 6, -2;
    0, 9, 6, 6;
    0, 6, 5, 5;
    0, 6, 5, 6;
  ) arrow
  mat(
    4, 2, 6, -2;
    0, 9, 6, 6;
    0, 0, 1, 1;
    0, 0, 1, 2;
  ) arrow
  mat(
    4, 2, 6, -2;
    0, 9, 6, 6;
    0, 0, 1, 1;
    0, 0, 0, 1;
  ) = U
$

$
  L_1^(-1) = mat(
    1, 0, 0, 0;
    1/2, 1, 0, 0;
    3/2, 0, 1, 0;
    -1/2, 0, 0, 1;
  ), " "
  L_2^(-1) = mat(
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 2/3, 1, 0;
    0, 2/3, 0, 1;
  ), " "
  L_3^(-1) = mat(
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 1, 1;
  )\
  L = L_1^(-1) L_2^(-1) L_3^(-1) = 
  mat(
    1, 0, 0, 0;
    1/2, 1, 0, 0;
    3/2, 2/3, 1, 0;
    -1/2, 2/3, 1, 1;
  )
$

$
  mat(
    4, 2, 6, -2;
    2, 10, 9, 5;
    6, 9, 14, 2;
    -2, 5, 2, 7;
  ) arrow
  mat(
    4, 2, 6, -2;
    1/2, 9, 6, 6;
    3/2, 6, 5, 5;
    -1/2, 6, 5, 6;
  ) arrow
  mat(
    4, 2, 6, -2;
    1/2, 9, 6, 6;
    3/2, 2/3, 1, 1;
    -1/2, 2/3, 1, 2;
  ) arrow
  mat(
    4, 2, 6, -2;
    1/2, 9, 6, 6;
    3/2, 2/3, 1, 1;
    -1/2, 2/3, 1, 1;
  ) = U
$

$
  det(A) = 4 dot 9 dot 1 dot 1 = 36
$

== 1/c.
$
  L dot U = A =
  mat(
    1, 0, 0, 0;
    l_1, 1, 0, 0;
    l_2, l_3, 1, 0;
    l_4, l_5, l_5, 1;
  ) dot
  mat(
    4, 2, 6, -2;
    0, u_1, u_2, u_3;
    0, 0, u_4, u_5;
    0, 0, 0, u_6;
  ) =
  mat(
    4, 2, 6, -2;
    2, 10, 9, 5;
    6, 9, 14, 2;
    -2, 5, 2, 7;
  )
$

sorfolytonsoan haladok vegig A elemein
$
  2 = l_1 dot 4 arrow l_1 = 1/2\
  10 = l_1 dot 2 + 1 dot u_1 = 1 + u_1 arrow u_1 = 9\
  9 = l_1 dot 6 + 1 dot u_1 = 1/2 dot 6 + u_2 = 3 + u_2 arrow u_2 = 6\
  5 = l_1 dot (-2) + 1 dot u_3 = 1/2 (-2) + u_3 = -1 + u_3 arrow u_3 = 6\
$

#line(length: 100%)

$
  6 = l_2 dot 4 arrow l_2 = 3/2\
  9 = l_2 dot 2 + l_3 dot u_1 = 3 + l_3 dot 9 arrow l_3 dot 9 = 6 arrow l_3 = 2/3\
  "nem csinaljuk tovabb"
$

#pagebreak()
= 2/a.
tarolos ge-val
$
  A = mat(
    1, 2, -1;
    1, 3, 0;
    2, 0, 0;
  ) arrow
  mat(
    1, 2, -1;
    1, 1, 1;
    2, -4, 2;
  ) arrow
  mat(
    1, 2, -1;
    1, 1, 1;
    2, -4, 6;
  )
$

$
  L = mat(
    1, 0, 0;
    1, 1, 0;
    2, -4, 1;
  ) "  "
  U = mat(
    1, 2, -1;
    0, 1, 1;
    0, 0, 6;
  )
$

== 2/b.
$
  B = mat(
    2, 4, 6;
    4, 8, 2;
    8, 12, 14;
  ) arrow
  mat(
    2, 4, 6;
    2, 0, -10;
    4, -4, -10;
  ) arrow "sorcsere nelkul a ge nem folytathato. " det(D_2) = 0
$

ideaig jutottunk volna:
$
  mat(
    1, 0, 0;
    2, 1, 0;
    4, , 1;
  ) dot
  mat(
    2, 4, 6;
    0, 0, -10;
    0, 0, ;
  ) = 
  mat(
    2, 4, 6;
    4, 8, 2;
    8, 12, ;
  )
$

na de itt a baj mert 
$
  12 = 4 dot 4 + l dot 0 "baj"
$

de
$
  16 = 4 dot 4 + l dot 0 " tehat " l in RR "tetszoleges" infinity "sok LU felbontas "
$

== 2/c.
$
  A = L D U
$
man i ain doin allat
