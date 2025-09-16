1.
$ z^3, z^13, z^135 = ? #h(1cm) "ha" z = i $

$ z^3 = (z dot z) dot z = -1 dot i = -i $

$ z^13 = i^13 = i^(3 dot 4 + 1) = (i^4)^3 dot i = 1 dot i = i $

$ z^135 = i^(4 dot 33 + 2 + 1) = (i^4)^33 dot i^2 dot i = 1 dot (-1) dot i = -1 $

es ha $z = (1+i)/sqrt(2)$ ?

$ z^3 = ((1+i)/sqrt(2))^3 = ((1+i)/sqrt(2))^2 (1+i)/sqrt(2) = i dot (1+i)/sqrt(2) = -1/sqrt(2) + i/sqrt(2) $

$ z^13 = z^(2+4+1) = i^4 dot i^2 dot ((1+i)/sqrt(2)) = 1 dot (-1) dot ((1+i)/sqrt(2)) = -1/sqrt(2)-i/sqrt(2) $

$ z^135 = z^(16 dot 8 + 7) = 1 dot ((1 + i)/sqrt(2))^4 dot ((1 + i)/sqrt(2))^3 = +1/sqrt(2) + dots $

es ha $z = 1 - i = (1-i)/sqrt(2) dot sqrt(2)$ ?

\
2.
$M^2, M^5, M^123 = ?$ #h(1cm) ha $ M = mat(
    8, -21;
    3, -8;
)$

$
M^2 = mat(
    1, 0;
    0, 1;
)
$

$ M^5 = M^(2 dot 2 + 1) = I^2 dot M = M $

$ M^123 = M^(61 dot 2 + 1) = I^61 dot M = M $

\
$
M = mat(
    -3, 2;
    -5, 3;
)
$

$
M^2 = mat(
    -1, 0;
    0, -1;
) = -I
$

$ M^5 = I dot M = M $

$ M^123 = M^(30 dot 4 + 2 + 1) = I^30 dot (-I) dot M = -M $

\
3.
$a, b$ egeszek, ugy hogy $a, b != 0 #h(1cm) exists! q, r$ egeszek, hogy $a = b dot q = r$ es $0 <= r < |b|$

jel: r = a mod b

q = szar jeloles, a,b > 0

a + b mod m?

$ a = m dot q_1 + r_1 $
$ b = m dot q_2 + r_2 $

- osszeadas
$ a + b mod m = (q_1 + q_2) dot m + (r_1 + r_2) mod m = r_1 + r_2 mod m $

- szorzas
$ a dot b mod m = (m dot q_1 + r_1)(m dot q_2 + r_2) mod m = m^2 dot q_1 dot q_2 + m dot q_2 dot r_1 + m dot q_2 + r_1 + r_1 dot r_2 mod m = r_1 dot r_2 mod m $

- hatvany
$ a^n mod m = (m dot q = r)(dots) dots mod m = r dot r dot dots mod m =  r^n mod m $

\
5.
a:
$ 13 dot 15 + 31 dot 42 + 51^2 mod 2 = 1 dot 1 + 1 dot 0 + 1^2 mod 2 = 1 + 0 + 1 mod 2 = 2 mod 2 = 0 $

\
b:
$ 73 dot 82 + 17 dot 71 mod 4 = 1 dot 2 + 1 dot 3 mod 4 = 1 $

\
c:
$ 123 + 594 + 931 mod 10 = 3 + 4 + 1 mod 10 = 8 $

\
g:
$ 3^100 mod 7 $
gyorshatvanyozas kell mert ez cooked

$ 100 = 54 + 32 + 4 => 3^100 mod 7 = 3^64 dot 3^32 dot 3^4 mod 7 $

\
$ 3^1 mod 7 = 3 $
$ 3^2 mod 7 = 2 $
$ 3^4 mod 7 = 2^2 mod 7 = 4 $
$ 3^8 mod 7 = 4^2 mod 7 = 2 $
$ 3^16 mod 7 = 2^2 mod 7 = 4 $
$ 3^32 mod 7 = 4^2 mod 7 = 2 $
$ 3^64 mod 7 = 2^2 mod 7 = 4 $

igy
$ 100 = 54 + 32 + 4 => 3^100 mod 7 = 3^64 dot 3^32 dot 3^4 mod 7 = 4 dot 2 dot 4 mod 7 = 32 mod 7 = 4 $

\
i:
$ (583 + 57) dot 715 + 41^2 mod 7 = (2+1) dot (1 + 6^2) mod 7 = 3 + 1 mod 7 = 4 $

\
2

d
$ M = mat(
    0, 0, 1;
    1, 0, 0;
    0, 1, 0;
) $

$ M^2= mat(
    0, 1, 0;
    0, 0, 1;
    1, 0, 0;
) $

\
6

$ M = mat(
    0,1,0,0,0,0;
    0,0,1,0,0,0;
    0,0,0,1,0,0;
    0,0,0,0,1,0;
    0,0,0,0,0,1;
    1,0,0,0,0,0;
) $

$ M^2 = mat(
    0,1,0,0,0,0;
    0,0,1,0,0,0;
    0,0,0,1,0,0;
    0,0,0,0,1,0;
    0,0,0,0,0,1;
    1,0,0,0,0,0;
) dot mat(
    0,1,0,0,0,0;
    0,0,1,0,0,0;
    0,0,0,1,0,0;
    0,0,0,0,1,0;
    0,0,0,0,0,1;
    1,0,0,0,0,0;
) = mat(
    0,0,1,0,0,0;
    0,0,0,1,0,0;
    0,0,0,0,1,0;
    0,0,0,0,0,1;
    1,0,0,0,0,0;
    0,1,0,0,0,0;
) $
