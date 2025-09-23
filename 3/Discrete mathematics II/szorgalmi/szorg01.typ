= Diszkrét Matematika II. - I. szorgalmi feladat
== feladat:
Egy $8 * 8$-as sakktáblára szeretnénk harmincegy darab $2 * 1$-es téglalapot elhelyezni úgy,
hogy minden mező le legyen fedve, kivéve az A1-et és H8-at (azaz a bal alsót és jobb felsőt).

Lehetséges-e ez?

== megoldás:
Rajzoljuk fel a sakktáblát fekete‐fehér mezőkkel, kivéve az A1 es H8 mezőket. Őket színezzük pirosra. Ekkor a táblán pontosan $32$ fekete, $30$ fehér és $2$ piros mező van.

$ #table(
  fill: (x, y) =>
    if x == 0 and y == 7 or x == 7 and y == 0 { red }
    else if calc.odd(x + y) { white }
    else { black },
  columns: 8,
  [], [], [], [], [], [], [], [],
  [], [], [], [], [], [], [], [],
  [], [], [], [], [], [], [], [],
  [], [], [], [], [], [], [], [],
  [], [], [], [], [], [], [], [],
  [], [], [], [], [], [], [], [],
  [], [], [], [], [], [], [], [],
  [], [], [], [], [], [], [], [],
) $

Egy dominó mindig pontosan egy fekete és egy fehér mezőt fed le (pirosra tilos dominót rakni). Tehát a feltételünk arra hogy ki tudjuk rakni a 31 dominót az:
$
  |"fehér mező"| = |"fekete mező"|
$

Erdeti sakktáblán ez teljesül, mivel $32 = 32$.

Ebben az esetben viszont a $2$ piros mező $2$ fehér mező helyett van. Ez ellentmond a feltételünknek ($32 != 30$)

Következésképp a feladatban leírt lefedés NEM lehetséges.

