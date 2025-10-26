== korabbi kepletek:

$
  p "prim", 1 < a,b < p, n in ZZ, g "generator"\
  log_g (a dot b) = log_g a + log_g b "  " (mod p - 1)\
  log_g (a^n) = n dot log_g a "  " (mod p - 1)
$

== Deffie-Hellman

$
#table(
    columns: 3,
    [\ $A,\ a in ZZ_(p-1)$],
    [\ publikus\ $p, g$],
    [\ $B,\ b in ZZ_(p-1)$],
  )
$

$A$ elkuldi $g^a$-t, $B$ elkuldi $g^b$-t

$B$ kiszamolja: $(g^a mod p)^b mod p = g^(a b) mod p$\
$A$ kiszamolja: $(g^b mod p)^a mod p = g^(b a) mod p$\

== feladat
$ p = 11, g = 2, a = 3, b = 4 $

$
#table(
    columns: 3,
    [A:\ $2^3 mod 11 = 8,\ 5^3 mod 11 = 4$],
    [\ $$],
    [B:\ $2^4 mod 11 = 5,\ 8^3 mod 11 = 4$],
  )
$

// TODO
todo megoldas

== RSA

$p,q "primek", n = p dot q\ e >= 2, "lnko"(e, phi(n)) = 1\ (phi(n) = p dot q dot (1 - 1/p)(1 - 1/q) = (p - 1)(q - 1))$
$
  d: e dot d equiv 1 "  " mod phi(n)\ (a x equiv b mod n)\
  "Titkos kulcs": (p, q, d), "  publikus kulcs": (n, e)\
  n "uzenet", 1 <= m < n, "lnko"(m, n) = 1\
  c = m^e mod n "  " m = c^d mod n "  " ("c a cypher valami")\
$

#pagebreak()
== feladat
$p = 11, q = 13, e = 7\ b = ?, c = ? " ha " mod 4$

$
  n = p dot q = 11 dot 13 = 143\
  phi(n) = (11 - 1)(13 - 1) = 120\
d:\
  e dot d equiv 1 "  " mod phi(n)\
  7d equiv 1 "  " mod 110\

  #table(
    columns: 4,
    [120],[x],[1],[0],
    [7],[x],[0],[1],
    [1],[17],[1],[-17],
    [0],[7],[-7],[120],
  )\

  7d equiv (1 - 7k)120 + (-17 + 120k)7\
  7d equiv (- 17 + 120k)7 mod 120\
  7d equiv -17 dot 7 mod "  " 120\
  d equiv -17 "  " mod 120\
  d equiv 103\
$

== c = ?
$
  c = m^e mod n = 4^7 mod 143 = 4^4 dot 4^3 mod 143 = 256 dot 16 dot 4 mod 143 = 113 dot 64 mod 143 = 82
$

== gyakorlas
$
  205^(206^(207)) mod 103 = ?\
  a^(phi(n)) mod n\ phi(103) = 102 ==>\
  ==> 205^102 mod 103 = 1\
  205^207 mod 103 = 205^(102 + 102 + 1) mod 103 = 205^(2 dot 102 + 1) mod 103 = 205^(2 dot 202) dot 205 mod 103 = 105 mod 103 = 2
$

\ \
$
  a^k mod n =  a^(k mod phi(n)) mod n, " ha " (a, n) = 1
$

== 1
150 forint visszajaro, hanyfelekeppen kaphatjuk meg ha huszas es otvenes van csak
$
  150 = 20x + 50y\
  #table(
    columns: 4,
    [50],[x],[1],[0],
    [20],[x],[0],[1],
    [10],[2],[1],[-2],
    [0],[2],[-2],[5],
  )\
  10 = (1 - 2k)50 + (-2 + 5k)20\
  150 = (15 - 30k)50 + (-30 + 75k)20\
$

#pagebreak()
== 2
$13$ szorosat felirva $4$-es szamrendszerben $21$-re vegzodik a szam
$
  13x equiv 2 dot 4^1 + 1 dot 4^1 mod 4^1\
  13x equiv 9 mod 16\
  #table(
    columns: 4,
    [16],[x],[1],[0],
    [13],[x],[0],[1],
    [3],[1],[1],[-1],
    [1],[4],[-4],[5],
    [0],[3],[13],[-16],
  )\
  3 = (1 + 13k)16 + (-1 -16k)13\
  9 = (3 + 13k)16 + (-3 -16k)13\
  13x = (-3 - 16k)13 "  " mod 16\
  13 x equiv -3 dot 13 "  " mod 16\
  x equiv -3 "  " mod 16\
  x equiv 13 "  " mod 16\
  x equiv 13\
  x equiv 29
$
