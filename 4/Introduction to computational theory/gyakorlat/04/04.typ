/ ropzh:
$
  G = ({S, X, Y, Z}, {a, b, c}, S, R)\
  R = {S arrow a X b | b Y Z, " " X arrow a X c | Y Z, " " Y arrow a b Z | epsilon, " " Z arrow X Y X | Y Y}\
  epsilon "mentesites"\
  G' = ({S, X, Y, Z}, {a, b, c}, S, R')\
  E_1 = {Y}, " " E_2 = {Y, Z}, " " E_3 = {X, Y, Z}, " " E_4 = {X, Y, Z}\
  R' = {S arrow a X b | a b | b Y Z | b Y | b Z | b,\ X arrow a X c | a c | Y Z | Y | Z,\ Y arrow a b Z | a b,\ Z arrow X Y X | X Y | X X | Y X | X | Y}
$

/ 4) Lancmentesites:
$
  G = ({S, X, Y, Z}, {a, b}, S, {\
      S arrow a | X,\
      X arrow b | Y | Z,\
      Y arrow X X,\
      Z arrow S Y
    })\
  #table(
    columns: 5,
    [$N$], [$S$], [$X$], [$Y$], [$Z$],
    [$L(N)$], [${S, X, Y, Z}$], [${X, Y, Z}$], [${Y}$], [${Z}$],
  )\
  G' = ({S, X, Y, Z}, {a, b}, S, {\
      S arrow a | b | X X | S Y,\
      X arrow b | X X | S Y,\
      Y arrow X X,\
      Z arrow S Y
    })\
$

/ Chomsky-normalforma:
#set math.cases(reverse: true)
$
  cases(
    1\, "  " A arrow B C,
    2\, "  " A arrow t,
  )\
  3, K E S: S arrow epsilon, S " nincs szabaly jobb oldalan"\
$

#pagebreak()
/ CYK-algoritmus:
$
  S arrow A B,\
  A arrow B B | C C | a,\
  B arrow S B | C A | b,\
  C arrow A S | B C | a | b,\
  "szo": a b b a
$
piramist nem fogok rajzolni typstban amugy is trivialis az algoritmus
