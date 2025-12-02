$
  I_j (x) = (product_(i != j) (x - c_i))/(product_(i != j) (c_j - c_i))\ \ \

  c_0, c_1, dots, c_n in R " kulonbozo ertek " (R " test")\
  d_0, d_1, dots, d_n in R " tetszoleges ertek "\
  ==> exists "legfeljebb "n"-ed foku polinom, melyre " f(c_j) = d_j " " (j = 0 dots n)\
  f(x) = sum_(j = 0)^(n) d_j dot l_j (x)
$

== feladat
$
  f(underbrace(0, c_0)) = underbrace(1, d_0), f(3) = 0, f(5) = 2\
  cal(l)_(d = j) (x) = (product_(i != j) (x - c_i))/(product_(i != j) (c_j - c_i)) = ((x - 3)(x - 5))/((0 - 3)(0 - 5))\
  cal(l)_1 (x) = dots = ((x - 0)(x - 5))/((3 - 0)(3 - 5))\
  cal(l)_2 (x) = dots = ((x - 0)(x - 5))/((5 - 0)(5 - 3))\
  f(x) = sum_(j = 0)^(n) d_j dot l_j (x)\
  f(x) = 1 dot ((x - 3)(x - 5))/((0 - 3)(0 - 5)) + 0 dot ((x - 0)(x - 5))/((3 - 0)(3 - 5)) + 2 dot ((x - 0)(x - 5))/((5 - 0)(5 - 3))
$

== Hamming-távolság:
$
  A " véges " a b c, " " u, v in A^n. " " u " és " v " Hamming-távolsága":\
  d(u, v) = abs({i: 1 <= i <= n and u_i != v_i})\
  d (0010, 0110) = 1\
$

== 1
=== a
$
  d(01110, 10101) = 4\
$

=== b
$
  00 arrow.r.bar 00000, " " 01 arrow.r.bar 01110, " " 10 arrow.r.bar 10101, " " 11 arrow.r.bar 11011\
  d(00000, 01110) = 3\
  d(00000, 10101) = 3\
  d(00000, 11011) = 4\
  d(01110, 10101) = 4\
  d(01110, 11011) = 3\
  d(10101, 11011) = 3\
  min = 3 ==> d(B) = 3
$

=== c
Kódszó súlya: Nem $0$ koordinátájú száma
$
  w(11011) = 4\
$

=== d
Kód súlya
$
  w(B) = 3
$

=== e
$
  00000 " kódszóhoz legfeljebb " 1 " távolsűgra lévő " ZZ_2^5 " szavak"\
  E = {00000, 10000, 01000, 00100, 00010, 00001 }
$

== 2
=== a
Egy kód $d - 1 a:$ hibajelző, $t = floor((d - 1)/2)$ hiba esetén javító
$
  (c_1, c_2, c_3) arrow.r.bar (c_1, c_2, c_3, c_1 + c_2 + c_3 + 1)\
  (k_1, k_2, k_3) arrow.r.bar (k_1, k_2, k_3, k_1 + k_2 + k_3 + 1)\
  d(A) = 2 ==> 2 - 1 = 1 " hibajelző"\
  t = floor((2 - 1)/2) = 0 " hibajavító"\
$

=== b
$
  (c_1, c_2, c_3) arrow.r.bar (c_1, c_2, c_3, c_1 + c_2 + c_3)\
  d(B) = 2 ==> 2 - 1 = 1 " hibajelző"\
  t = floor((2 - 1)/2) = 0 " hibajavító"\
  \
  (0, 0, 1) arrow.r.bar (0, 0, 1, 0, 1)\
  (0, 0, 1) arrow.r.bar (1, 0, 1, 0, 1)\
$

Singleton kód:
$
  C subset sum^n " kód," d(C) = d, ==> abs(C) <= abs(sum)^(n - d + 1)
$

MDS kód:
$
  abs(C) = abs(sum)^(n - d + 1)
$

#pagebreak()
== 3
d = ?,\ hibajelző = ?,\ t = ?,\ MDS?
=== a
$
  (c_1, c_2) arrow.r.bar (c_1, c_2, c_1 + c_2), "  " c_1, c_2 in FF_5 = ZZ_5 "  " FF_p = ZZ_p, " ha " p " prím"\
  d(A) = 2, " hibajelző = 1", " " t = 0\
  n = 3, "  " underbrace(abs(C), 5^2 = abs(FF_5)^(3 - 2 + 1) ==> "MDS") = abs(sum)^(n - d + 1)
$

=== b
abszolut ugyanaz mint a

=== c
$
  (c_1, c_2) arrow.r.bar (c_1, c_2, c_1 + c_2, c_1 dot c_2), "  " c_1, c_2 in FF_7\
  d(C) = 2\
  d - 1 = 1 " hibajelző"\
  floor((d - 1)/2) = 0 = t\
  n = 4\
  abs(C) = 7^2 = 49\
  abs(sum) = 7\
  abs(C) = abs(sum)^(n - d + 1)\
  49 != 7^(4 - 2 + 1)\
  49 != 7^3 ==> "nem MDS"\
$

== 5
=== a
$
  x in {1, dots, 16}
$

=== b
egyszer elfelejt valaszolni

a hibajavito tavolsag akkor kell ha hazudna. ha egyszer hazudik 1 hibajavito kell. ha elfelejt valaszolni azert eleg csak hibajelzo mert tudjuk hol van a hiba

== 6
=== a
$
  x in {1, dots, 16}\
$
$1$ hazugsag $==> 1$ hibajavito $==> d = 3 ==> floor((3 - 1)/2) = 1$

$
  (a, b, c, d) arrow.r.bar (a, b, c, d, a + b, c + d, a + b + c + d)
$
=== b
$6$x hazugsag: $6 = floor((d - 1)/2) ==> d = 13$\
$
  abs(C) <= abs(sum)^(n - d + 1)\
  2^4 <= 2^(n - 13 + 1)\
  2^4 <= 2^(n - 12)\
  4 <= n - 12\
  16 <= n = "kérdések"\
$

=== c
$16$x hazugsag: $16 = floor((d - 1)/2) ==> d = 33$\
$
  2^4 <= 2^(n - 33 + 1)\
  4 <= n - 32\
  36 <= n "kérdések"\
$
