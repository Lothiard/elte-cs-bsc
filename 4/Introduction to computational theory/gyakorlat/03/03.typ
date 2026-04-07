/ ropzh:
$
  L = {u in {a, b}^*: "'ab' es 'ba' benne van"}\
  G = ? ("harmas tipus")\
  G = ({S, X, Y, Z}, {a, b}, S,\ {S -> a S | b S | a b X | b a Y | a b a Z | b a b Z, X -> a X | b X | b a Z, Y -> a Y | b Y | a b Z, Z -> a Z | b Z | epsilon})
$

legyen harmas normalformaju es ne legyen olyan szabaly hogy a bal oldal megegyezik es a jobb terminalis szimbolum ugyanaz
$
  G_(1,2) = ({S, X, Y, Z, V, W}, {a, b}, S,\ {S -> a X | b Y, X -> a X | b Z, Y -> a V | b Y, Z -> a W | b Z, V -> a V | b W, W -> a W | b W | epsilon})
$

= regularis kifejezesek
specialis szavak amik nyelveket jelolnek
- $nothing: {}$, ures nyelv
- $epsilon: {epsilon}$, ures szot tartalmazo nyelv
- $a, "  " a in v: {a}$ egy darab szobol allo nyelv
- $(R dot Q), (R | Q), (R)^*:R Q, R union Q, R^*, L(R) L(Q), dots$

/ pl:
ez egy regularis kifejezes
$
  (a | b)^* a b (a | b)^* b a (a^* b^*)^*
$

/ $L_1$:
$
  L_1 = {u in {a, b}^*: "2 - 2 'a' kozott legalabb 2 'b' van"}\
  "tipp (kozel sem kerultem vele)": a (a | b)^* b (a | b)^* b (a | b)^* a\
  "megoldas": b^*(a b b b^*)^*(a | a b | a b b | a b b b^* | epsilon)
$

/ $L_2$:
$
  L_2 = {u in {a, b}^*: abs(u)_a equiv 0 (mod 2)}\
  b^*(a b^* a b^*)^*
$

/ $L_3$ (hazi):
$
  L_3 = {u in {a, b}^*: abs(u)_a equiv abs(u)_b equiv 0 (mod 2)}
$

#pagebreak()
= kettes tipusu gramatikak
== Chomsky-fele normal forma
#set math.cases(reverse: true)
- $
    cases(
      A -> B C,
      A -> t
    ) ==> cases(
      A\, B\, C in N,
      t in T
    )
  $
- $K E S: S -> epsilon, " " S "nincs szabaly jobb oldalan"$

1. Alterminalisok
2. Hosszredukcio
3. $epsilon$-mentesites
4. lancmentesites
0. uj startszimbolum bevezetese

\+ $S' -> S, " " N' := N union {S'}$
/ 1. Alterminalisok:
pl:
$
  ({S}, {a, b}, S, {S -> a S b | epsilon}) = G\
  G' := ({S, A, B}, {a, b}, S, {S -> A S B | epsilon, A -> a, B -> b})
$

/ 2. Hosszredukcio:
pl:
$
  A -> B C D E arrow.squiggly A -> B X, X -> C Y, Y -> D E\
  "vagy"\
  A -> X Y, X -> B C, Y -> D E
$
\+ $B -> C D E: B -> C Y, Y -> D E$

/ 3. $epsilon$-mentesites:
$
  G = ({S, X, Y, Z}, {a, b}, S, R)\
  R = {S -> X Y Z, X -> Y Y, Y -> a Z | epsilon, Z -> b}\
  E_1 = {Y}, " " E_2 = {Y, X}, " " E_3 = {X, Y} =: E\
  R' := {S -> X Y Z | Y Z | X Z | Z, X -> Y Y | Y, Y -> a Z, Z -> b}
$
