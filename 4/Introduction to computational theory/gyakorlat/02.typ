== ropzh:
$
    G = ({S, X}, {a, b}, S, {S -> a x | b S | b b, " " X -> a S | b X})\
    L(G) = {u in {a, b}^* : abs(u)_a equiv 0 " " (mod 2) and exists x in {a, b}^*: u = x b b}
$

== feladat
3-as tipus: $A -> u B$ vagy $a -> u " " (A, B in N, u in T^*)$\
2-es tipus: $A -> v " " (A in N, v in (N union T)^*)$
// a harmas eygben kettes is

$
    G_1 = ({S}, {a, b}, S, {S -> a S b | b S a | S S | epsilon})\
    L(G_1) = {u in {a, b}^* : abs(u)_a = abs(u)_b }\
$
2-es tipusu mert bal oldalt mindig S

$
    a a a b a b b a b b\
    S -> a S b -> a a S b b -> a a S S b b -> a a a S b S b b -> a a a b S a b S b b -> a a a b a b S b b -> a a a b a b b S a b b -> a a a b a b b a b b
$

== feladat
$
    L = {w | w "tartalmazza az" \"a a\" "reszszot"} = {u in {a, b}^*: exists x,y in {a, b}^*: u = x a a y}\
$
$G_(2.1) = ({S, X}, {a, b}, S, {S -> X a a X, X -> a X | b X | epsilon})$

$G_(2.2) = ({S, X}, {a, b}, S, {S -> a S | b S | a a X, X -> a X | b X | epsilon})$

/ harmas normal forma: egy harmas tipusu harmas normal formaban van hogyha minden szabalya $A -> t B, a -> epsilon " " (A, B in N, " " t in T)$

a fenti nem normal formaju mert az $S -> a a X$-ben ket terminalis karakter is szerepel

$G_(2.3) = ({S, X, Y}, {a, b}, S, {S -> b S | a X, X -> a Y | b S, Y -> a Y | b Y | epsilon})$

$G_(2.4) = ({S, X, Y}, {a, b}, S, {s -> a S | b S | a Y, Y -> a X, X -> a X | b X | epsilon})$

== advanced feladat
$
    L_3 = {u in {a, b}^*: abs(u)_b equiv 2 " " (mod 3) or exists x in {a, b}^*: u = a b b X}\
    G_3 = ({S, X, U, V, W}, {a, b}, S, {S -> a a b X, X -> a X | b X | epsilon, S -> U, U -> a U | b V, V -> a V | b W, W -> a W | b U | epsilon})
$

== feladat
$
    L_4 = {u in {a, b}^*: abs(u)_a <=  2 and abs(u)_b >= 2}\
    G_4 = ({C, D, E, F, G, H, I, J, K}, {a, b}, C, {\ C -> a D | b F, D -> a E | b G, E -> b H,\ F -> a G | b I, G -> a H | b J, H -> b K,\ I -> a J | b I | epsilon, J -> a K | b J | epsilon, K -> b K | epsilon})
$
