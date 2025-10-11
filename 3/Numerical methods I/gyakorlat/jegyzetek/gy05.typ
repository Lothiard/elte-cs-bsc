==  gy04/6
$
  mat(
    l_1, 0, 0, 0;
    l_2, l_3, 0, 0;
    l_4, l_5, l_6, 0;
    l_7, l_8, l_9, l_10;
  ) dot
  mat(
    l_1, l_2, l_3, l_4;
    l_5, l_6, l_7, 0;
    l_8, l_9, 0, 0;
    l_10, 0, 0, 0;
  ) = 
  mat(
    4, -4, 12, 4;
    -4, 5, -13, -1;
    12, -13, 38, 8;
    4, -1, 8, 18;
  )
$

sorfolyt:
$
  4 = l_1^2 arrow l_1 = 2\
  -4 = l_2 dot l_1 = 2l_2 arrow l_1 = -2\
  5 = l_2^2 + l_3^2 = 4 + l_3^2 arrow l_3^2 = 1 arrow l_3 = 1\
  12 = l_4 dot l_1 = 2l_4 arrow l_4 = 6\
  -13 = l_4 dot l_2 + l_5 dot l_3 = -12 arrow l_5 = -1\
  38 = l_4^2 + l_5^2 + l_6^2 = 36 + 1 + l_6^2 arrow l_6^2 = 1 arrow l_6 = 1\
  4 = l_7 dot l_1 = 2l_7 arrow l_7 = 2\
  -1 = l_4 dot l_2 + l_8 dot l_3 = 2 dot (-2) + l_8 arrow l_8 = 3\
  8 = l_7 dot l_4 + l_8 dot l_5 + l_9 dot l_6 = 2 dot 6 + 3 dot (-1) + l_9 arrow l_9 = -1\
  18 = l_7^2 + l_8^2 + l_9^2 + l_10^2 = 4 + 9 + 1 + l_10^2 arrow l_10^2 = 4 arrow l_10 = 2\
$

== 1/a
$
  A = mat(
    4, -2;
    3, 1;
  ) =
  mat(
    q_1, q_2
  ) dot 
  mat(
    r_11, r_12;
    0, r_21;
  )\

  r_11 = norm(a_1)_2 = sqrt(4^2 + 3^2) = 5\
  q_1 = 1/5 dot mat(4; 3)\
  r_12 = <a_2; q_1> = <mat(-2; 1); 1/5 mat(4; 3)> = 1/5 dot ((-2) dot 4 + 1 dot 3) = -5/5 = -1\
  s_2 = a_2 - r_12q_1 = mat(-2; 1) - (-1) dot 1/5 dot mat(4; 3) = 1/5 (mat(-10; 5) + mat(4; 3)) = 1/5 dot mat(-6; 8) = 2/5 mat(-3; 4)\
  r_22 = norm(s_2)_2 = norm(2/5 dot mat(-3; 4))_2 = 2/5 norm(mat(-3; 4))_2 = 2/5 dot 5 = 2\
  q_2 = 1/(r_22) dot s_2 = 1/5 mat(-3; 4)\
$

== 1/b
$
  mat(
    2, 1, 0;
    -1, 1, 0;
    0, 0, 2;
  ) = mat(q_1, q_2, q_3) dot
  mat(
    r_11, r_12, r_13;
    0, r_22, r_23;
    0, 0, r_33;
  )\

  r_11 = norm(a_1)_2 = sqrt(4 + 1) = sqrt(5)\
  q_1 = 1/(r_11)a_1 = 1/sqrt(5) mat(2; - 1;0)\
  r_12 = <q_1, a_2> = 1/sqrt(5) mat(2 - 1) = 1/sqrt(5)\
  s_2 = a_2 - q_1r_12 = mat(1;1;0) - 1/sqrt(5) mat(2;-1;0) dot 1/sqrt(5) = 1/5 mat(3;6;0) = 3/5 mat(1;2;0)\
  r_22 = norm(s_2)_2 = 3/5 sqrt(1^2 + 2^2) = 3/5 sqrt(5) = 3/sqrt(5)\
  q_2 = 1/r_22 s_2 = sqrt(5)/3 dot 3/5 mat(1;2;0) = sqrt(5)/5 mat(1;2;0) = 1/sqrt(5) mat(1;2;0)\
  r_13 = <q_1, a_3> = <1/sqrt(5) mat(2;-1;0), mat(0;0;2)> = 0\
  r_23 = <q_2, a_3> = <1/sqrt(5) mat(1;2;0), mat(0;0;2)> = 0\
  s_3 = a_3 - q_1r_13 - q_2r_23 = a_3 = mat(0;0;2)\
  r_33 = norm(s_3)_2 = 2\
  q_3 = 1/r_33 s_3 = 1/2 mat(0;0;2) = mat(0;0;1)\

  mat(
    2, 1, 0;
    -1, 1, 0;
    0, 0, 2;
  ) = mat(
    2/sqrt(5), 1/sqrt(5), 0;
    -1/sqrt(5), 2/sqrt(5), 0;
    0, 0, 1;
  ) dot
  mat(
    sqrt(5), 1/sqrt(5), 0;
    0, 3/sqrt(5), 0;
    0, 0, 2;
  )\
$

== custom
$
  A = mat(
    2, 6, 5;
    -1, -4, 1;
    -1, -2, -3;
  ) = mat(tilde(q_1), tilde(q_2), tilde(q_3)) dot
  mat(
    1, tilde(r_12), tilde(r_13);
    0, 1, tilde(r_23);
    0, 0, 1;
  )\

  tilde(q_1) = tilde(a_1)\
  tilde(r_12) = (<a_2; tilde(q_1)>)/(<tilde(q_1); tilde(q_2)>) = (<mat(6;-4;-2); mat(2;-1;-1)>)/6 = 18/6 = 3\
  tilde(q_2) = a_2 - tilde(r_12)tilde(q_1)= mat(6;-4;-2) - 3 dot mat(2;-1;-1) = mat(0;-1;1)\
  tilde(r_13) = (<a_3, tilde(q_1)>)/(<tilde(q_1), tilde(q_1)>) = (2 dot 5 + (-1) dot 1 + (-1) dot (-3))/6 = 12/6 = 2\
  tilde(r_23) = (<a_3, tilde(q_2)>)/(<tilde(q_2), tilde(q_2)>) = (<mat(5;1;-3), mat(0;-1;1)>)/(2) = (-4)/(2) = -2\
  tilde(q_3) = a_3 - tilde(r_13)tilde(q_1) - tilde(r_23)tilde(q_2) = mat(5;1;-3) - 2 mat(2;-1;-1) - (-2) mat(0;-1;1) = mat(1;1;1)\


  A = mat(
    2, 6, 5;
    -1, -4, 1;
    -1, -2, -3;
  ) = mat(tilde(q_1), tilde(q_2), tilde(q_3)) dot
  mat(
    1, tilde(r_12), tilde(r_13);
    0, 1, tilde(r_23);
    0, 0, 1;
  ) = 
  mat(
    2, 0, 1;
    -1, -1, 1;
    -1, 1, 1;
  ) dot
  mat(
    1, 3, 2;
    0, 1, -2;
    0, 0, 1;
  )\
  "// mindegyik oszlopot leosztom a hosszaval."\ "minden osztast az egyik oldalon szorzassal kompenzalom a masik oldalon"\
  A = Q R = (Q D^(-1))(D R)\
  Q = mat(
    2/sqrt(6), 0, 1/sqrt(3);
    -1/sqrt(6), 1/sqrt(2), 1/sqrt(3);
    -1/sqrt(6), 1/sqrt(2), 1/sqrt(3);
  )\
  R = mat(
    sqrt(6), 3 sqrt(6), 2sqrt(6);
    0, sqrt(2), -2sqrt(2);
    0, 0, sqrt(3);
  )
$


