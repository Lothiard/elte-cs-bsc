= Diszkét Matematika II. - Szorgalmi feladat II.
== Feladat:
Legyen $F_n$ az $n$-edik Fibonacci-szám!
Mi lesz $(F_(n+2), F_n)$ ill. $(F_(n+3), F_n)$?

== Megoldás:
1. $(F_(n+2), F_n)$

  Euklideszi algoritmussal:

  Mivel $F_(n+2) = F_(n+1) + F_n$, ezért $F_(n+2) mod F_(n) = F_(n+1)$

  $
#table(
    columns: (auto, auto),
    [*osztandó*], [*osztó*],
    [$F_(n+2)$], [$F_(n)$],
    [$F_(n)$], [$F_(n+2) mod F_n = F_(n+1)$],
    [$F_(n+1)$], [$F_(n) mod F_(n+1) = F_(n-1)$],
    [$F_(n-1)$], [$F_(n+1) mod F_(n-1) = F_(n-2)$],
    [$dots$], [$dots$],
    [$F_3$], [$F_1$],
    [$F_2$], [$F_1$],
    [$F_1$], [$0$],
  )
  $

  Minden lépésnél a maradék $F_(k-1)$

  Így végül a legkisebb nem nulla maradék $F_1 = 1$, és
  $
    "gcd"(F_(n+2), F_n) = "gcd"(F_2, F_1) = "gcd"(1, 1) = 1
  $

2. $(F_(n+3), F_n)$

  Mivel
  $ F_(n+3) = F_(n+2) + F_(n+1) = (F_(n+1)+F_n) + F_(n+1) = 2 F_(n+1) + F_n. $

  ezért
  $ F_(n+3) mod F_n = (2 F_(n+1) + F_n) mod F_n = 2 F_(n+1) mod F_n $

  Így
  $
    #table(
      columns: (auto, auto),
      [*osztandó*], [*osztó*],
      [$F_(n+3)$], [$F_(n)$],
      [$F_(n)$], [$2 F_(n+1)$],
      [$2 F_(n+1)$], [$2 F_(n-1)$],
      [$2 F_(n-1)$], [$2 F_(n-2)$],
      [$2 F_(n-2)$], [$2 F_(n-3)$],
      [$dots$], [$dots$],
      [$2 F_r$], [$2 F_(r - 3)$],
      [$2 F_(r - 3)$], [$0$],
    )
  $

  Minden lépésnél a maradék $2 F_(k+1) mod 2 F_(k-1) = 2 F_(k-2)$ így hárommal csökken az index. Végül arra az $r$-re jutunk, amelyre $0 <= r < 3$ három lehetőség:
  - Ha $n equiv 0 (mod 3)$ akkor az utolsó nem nulla sor gcm$(2 F_3, 2 F_0) = "gcm"(2,1) = 2$
  - Ha $n equiv 1 (mod 3)$ akkor az utolsó nem nulla sor gcm$(2 F_1, 2 F_(-2)) = "gcm"(2 dot 1,2 dot 1) = 1$ (feltéve hogy negatív fibonaccik értelmesek és egyenlőek eggyel (?))
  - Ha $n equiv 2 (mod 3)$ akkor hasonlóan gcm$(2 F_3, 2 F_0) = "gcm"(2,1) = 2$

  Tehát:
  $
    "gcm"(F_(n+3), F_n) = cases(
      2\,"  " & 3 | n,
      1\, & 3  divides.not.rev n,
    )
  $

