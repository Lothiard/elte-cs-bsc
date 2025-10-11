$
  x equiv 43 mod 100 = 10^2 "  " (43 = 4 dot 10^1 + 3 dot 10^0)
$

== a:
$
  13n equiv 4 dot 7^1 + 3 dot 7^2 mod 7^2 = 49\
  13n equiv 31 mod 49\

  #table(
    columns: 4,
    [49],[x],[1],[0],
    [13],[x],[0],[1],
    [10],[3],[],[-3],
    [3],[1],[],[4],
    [$1 ==> 1$ db inkongurens megoldas van],[3],[],[(-15)],
    [0],[3],[],[49],
  )\

  x_1 = 31/1 dot (-15) + underbrace(k dot 49/1, 0) = 31 dot (-15) = (-465) ==> n equiv (-465) mod 49\
  n equiv 25 mod 49\
  n equiv 74 mod 49\
$

// nyolcas szamrendszerben utolso szamjegy 1 utolso elotti meg 2
== b:
$
  12 n equiv 2 dot 8 + 1 mod 8^2\
  12 n equiv 17 mod 64\

  #table(
    columns: 4,
    [64],[x],[1],[0],
    [13],[x],[0],[1],
    [(4)],[5],[],[-3],
    [0],[3],[],[4],
  )\

  4 divides.not 17 ==> "nincs megoldas"
$

// hatarozza meg az utolso ket szamjegyet a 7^3^47-nek
== 8
$
  x equiv 7^3^47 mod 100
$

=== harom tetel all rendelkezesunkre\
1.
  $ a, n in ZZ, (a, n) = 1: a^phi equiv 1 mod n $
2.
  $ p "prim", a in ZZ: a^p equiv a mod p $
3.
$
  phi(n) = n dot product_(i = 1)^k (1 - 1/p_i)\
  n = p_1^(e_1) dot p_2^(e_2) dot dots dot p_k^(e_k)\
$

$
100 = 2 dot 2 dot 5 dot 5\
phi(100) = 100 product_(i = 1)^2 (1 - 1/p_i) = 100 dot (1 - 1/2)(1 - 1/5) = 10(2 - 1)(5 - 1) = 10 dot 1 dot 4 = 40 ==> 7^40 equiv 1 mod 100 ==>\ ==> 7^(40n + k) equiv 7^k mod 100 ==> 7^n equiv 7^(n mod 40) ==> 7^3^47 equiv 7^(3^47 mod 40) mod 100\
3^47 mod 40 = 3^32 dot 3^8 dot 3^4 dot 3^2 dot 3^1 mod 40 = 1 dot 1 dot 1 dot 9 dot 3 mod 40 = 27\
$

mert\
$3^1 mod 40 = 3$\
$3^2 mod 40 = 9$\
$3^4 mod 40 = 81 mod 40 = 1$\
$3^8 mod 40 = 3^4 dot 3^4 mod 40 = 1 dot 1 mod 40$\
$3^16 mod 40 = 1$\
$3^32 mod 40 = 1$\
$7^3^47 mod 100 = 7^(3^47 mod 40) mod 100 = 7^27 mod 100 = 1 dot 1 dot 49 dot 7 mod 100 = 343 mod 100 = 43 mod 100$\


mert\

$7^27 mod 100 = 7^16 dot 7^8 dot 7^2 dot 7 mod 100$\
$7^1 mod 100 = 7$\
$7^2 mod 100 = 49$\
$7^4 mod 100 = 2401 mod 100 = 1$\
$7^8 mod 100 = 1^2 mod 100 = 1$\
$7^16 mod 100 = dots = 1$\



#set math.cases(reverse: true)
== 2/a
$
  27x + 35y = 3\
  a x equiv b mod n <==> a x + n y = b\
  27x equiv 3 mod 35 <==> 35y equiv 3 mod 27\

  #table(
    columns: 4,
    [35],[x],[1],[0],
    [27],[x],[0],[1],
    [8],[1],[1],[-1],
    [3],[3],[-3],[4],
    [2],[2],[7],[-9],
    [1],[1],[-10],[13],
    [0],[2],[27],[-35],
  )\
  cases(
    "negyedik sorbol latszodik hogy " & 3 - (-3) dot 35 + 4 dot 27,
    "utolso sorbol " & 0 = 27 dot 35 + (-35) dot 27,
  )
  ==> 3 = (-3 + 27k) dot 35 + (4 - 35k) dot 27\
$

== 2/d
$
  18 x + 14 y = 16\

  #table(
    columns: 4,
    [18],[x],[1],[0],
    [14],[x],[0],[1],
    [4],[1],[1],[-1],
    [2],[3],[-3],[4],
    [0],[2],[7],[-9],
  )\
  cases(
    "harmadik sorbol " & 1 dot 18 + (-1) dot 14 = 4 <==> 4 dot 18 + (-4) dot 14 = 16,
    "utolso sorbol " & 0 = 7 dot 18 - 9 dot 14,
  )
  ==> (4 +7k) dot 18 + (-4 - 9k) dot 14 = 16
$

== 3
$
  4 "ill. " 5 "hatvanyai " mod 7\
  4^0 mod 7 = 1\
  4^1 mod 7 = 4\
  4^2 mod 7 = 2\
  4^3 mod 7 = 1\
  4^4 mod 7 = 4\
  4^5 mod 7 = 2\
  4^6 mod 7 = 1\
$

a maradek "korbeer" es ismetlodik

