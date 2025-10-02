= a)
$3x equiv 1 mod 7$

$
  #table(
    columns: 4,
    [7],[x],[1],[0],
    [3],[x],[0],[1],
    [1],[2],[1],[-2],
    [0],[3],[-3],[7],
  )
$

elso sor: $7 = 1 dot 7 + 0 dot 3$\
masodik sor: $3 = 0 dot 7 + 1 dot 3$\
harmadik sor: $1 = 1 dot 7 + (-2) dot 3$\

$ 1 = (1 - 3k) dot 7 + (-2 + 7k)3 $
$ 3x equiv underbrace((1 -3k)7, 0) + (-2 + 7k)3 "  " mod 7 $
$ 3x equiv (-2 + 7k)3 "  " mod 7 $
$ x equiv -2 + 7k "  " mod 7/((7,3) = 1) = 7 $
$ x equiv -2 "  " mod 7 $
$ x equiv 5 + 7k "  " (k in ZZ) $

van ehelyett egy algoritmus:

$ 3x equiv 1 "  " mod 7 $
ez illeszkedik erre
$ a x equiv b "  " mod n $
es igaz hogy
1.
$
  a x equiv b "  " mod n <==> a x + n y = b
$

2.
$
  a x + n y = (a, n)
$

3.
$
  "ha " (a, n) | b "  " (a, n) "megoldas van"
$

4.
$
  x_i = b/((a, n)) x + k n/((a, n)) "  " (k = 0, dots, (a, n) - 1)
$

ezt ugy kell alkalmazni hogy

$
  #table(
    columns: 3,
    [7],[x],[0],
    [3],[x],[1],
    [1],[2],[-2 = x],
    [0],[3],[],
  )
$
// mindenkepp az a soraba kell irni az egyest

$
  x_i = 1/1 dot (-2) + 0 dot dots = -2
$

= b
$
  3 x equiv 1 "  " mod 8
$

$
  #table(
    columns: 4,
    [8],[x],[1],[0],
    [3],[x],[0],[1],
    [2],[2],[1],[-2],
    [1],[1],[-1],[3 (ez)],
    [0],[2],[-3],[-8],
  )
$

$
  1 = (-1 + 3k)8 + (3 - 8k)3\
  3x equiv underbrace((-1 + 3k)8, 0) + underbrace((3 - 8k)3, 0) "  " mod 8\
  3x equiv 3 dot 3 "  " mod 8\
  x equiv 3 "  " mod 8
$

az algoritmussal:

$
  x_i = 1/1 dot 3 + underbrace(k, 0) dot 8/1\
  x_1 = 3
$

== c
$
  2x equiv 1 "  " mod 8
$
$
  #table(
    columns: 4,
    [8],[x],[1],[0],
    [2],[x],[0],[1],
    [0],[4],[1],[-4],
  )
$

szabaly szerint: $(a,n) | b$ es $2 !| 1$ tehat nincs megoldas

== e
$
  31 x equiv 4 "  " mod 17
$
$
  #table(
    columns: 4,
    [31],[x],[1],[0],
    [17],[x],[0],[1],
    [14],[1],[1],[-1],
    [3],[1],[-1],[2],
    [2],[4],[5],[-9],
    [1],[1],[-6 (ez kell)],[11],
    [0],[2],[17],[-31],
  )
$
$
  x_i = 4/1 dot (-6) + k dot 17/1\
  x_i = -24 + 17k\
  x_1 = -24 equiv dots
$

== 2/a
$
  a = 2, n = 4\
  a^0 = 2^0 = 1 = 1 "  " mod 4\
  a^1 = 2^1 = 2  "  " mod 4\
  2^2 = 4 equiv 0  "  " mod 4\
  2^3 = 8 equiv 0  "  " mod 4\
$

== 2/b
$
  a = 3, n = 5\
  3^0 = 1 equiv 1 "  " mod 5
  3^1 = 3 equiv 3 "  " mod 5
  3^2 = 9 equiv 4 "  " mod 5
  3^3 equiv 12 equiv 2 "  " mod 5
  3^4 equiv 6 equiv 1 "  " mod 5
$

megoldasok: 1, 3, 4, 2

== 3
euler fele freaky fuggveny
$
  phi(n) = "#"{1 <= a <= n : (a,b) = 1} = |{1 <= a <= n : (a,b) = 1}| "  " (n in NN)
$

irjuk fel a $phi(n) 1 <= n <= 16$
$
  phi(1) = 1\
  phi(2) = 2\
  phi(3) = 2\
  phi(4) = 2\
  phi(5) = 4\
  phi(6) = 2\
  phi(7) = 6\
  phi(8) = 4\
  phi(9) = 6\
  phi(10) = 4\
  phi(11) = 10\
  phi(12) = 4\
  phi(13) = 12\
  phi(14) = 6\
  phi(15) = 8\
  phi(16) = 8\
$

$
  n = p_1^(e_1) dot p_2^(e_2) dot dots dot p_k^(e_k) ==> phi(n) = n dot product^k_(i = 1)(1 - 1/p_i) "  (p az prim) es " phi(p) = p = 1
$

Euler-Fernat

$
  a, n in ZZ, (a, n) = 1 ==> a^(phi(n)) equiv 1 "  " mod n
$

Fernat tetel
$
  "p prim, " a in ZZ ==> a^p equiv a "  " mod p
$

== 4/a
$
  2^6 mod 7\
  2^6 mod 7 = 2^(phi(7)) mod 7 = 1
$

== 4/b
$
  2^7 mod 7 = 2
$

== 4/c
$
  2^8 mod 7 = 2^6 dot 2^2 mod 7 = 1 dot 2^2 mod 7 = 4
$

== 4/f
$
  2^13 mod 13 = 2^p mod p = 2
$

== 5
$
  n = ?, " " a = 13n\
  13n = a equiv 4 dot 7^1 + 3 dot 7^0 "  " mod 7^2 = 49\
  13n equiv 31 "  " mod 49
$
