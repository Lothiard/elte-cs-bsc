/ ABC: karakterek veges nem ures halmaza,
pl: $ V = {a, b, c} $

/ szo: ABC elemeibol alkotott veges sorozat,
pl: $ a b, c c c, epsilon " (ures szo)" $

/ szonak hossza: trivialis

pl: $ u = a b c "  " abs(u) = 3 $

/ tukrozes: reverse tulajdonkeppen

$ u^(-1) = c b a $

/ konkatenalas:

$ v := b b, "  " u v = a b c b b "  " v u = b b a b c $

/ $V^*$:: V felett osszes lehetseges szo

/ $V^+$:: $V^* without epsilon$

$ forall w in V^*: epsilon w = w epsilon = w $

$ forall u, v in V^*: (u v)^(-1) = v^(-1) u^(-1) $

/ iteralt (hatvany): $i$-edik hatvanya egy szonak az onmagaval vett $i$-szeres konkatenaltja

$ u^0 := epsilon, "  " u^i := u u^(i-1) "  " (i >= 1) $

pl: $ u = a b c, "  " u^0 = epsilon, "  " u^1 = a b c, "  " u^2 = a b c a b c, "  " u^3 = a b c a b c a b c, "  " dots $

/ nyelv: szavak tetszoleges halmaza

$ L subset.eq V^* $

pl: $ L_1 = {a, a b}, "  " L_2 = {c}, "  " L_3 = {b c}, "  " L_4 = {a^n b^n | n >= 0}, "  " L_5 = {(a b)^n | n >= 0} $

ezeken lehet ertelmezni muveleteket:

$ L_4 inter L_5 = {epsilon, a b} $

/ nyelvek konkatenaltja: a nyelvbeli szavakat konkatenealjuk es osszevetjuk az eredmenyt

pl: $ L, L' subset.eq V^*: L L' = {w v, u in L, v in L'} $

$ L_1 L_2 inter L_1 L_3 = {a b c} $

$ L_1 L_2 union L_1 L_3 = {a c, a b c, a b b c} $

/ kiegeszites:

$ Phi L = L Phi = Phi "(ures nyelv + L)" $

$ {epsilon} L = L {epsilon} = L "(ures szobol allo nyelv + L)" $

/ Nyelv iteraltja: hasonlo az elozo iteralthoz

$ L^0 := {epsilon}, "  " L^i := L L^(i - 1) "  " (i >= 1) $

#pagebreak()
/ Lezart:

$ L^* = union.big_(i >= 0) L^i, "  " L^+ = union.big_(i >= 1) L^i $

$ L^+ =^? L^* without {epsilon} $

$ L^* = underbrace(L^0, {epsilon}) union underbrace(union.big_(i >= 1) L^i, L^+) $

$ L^+ = L^* without {epsilon} <==> epsilon in.not L $

= generativ grammatika
egy modszer arra hogy tudjunk nyelveket megadni

hivatalosan ez egy NTSR rendezett negyes

$G = (N, T, S, R)$

#set math.cases(reverse: true)
$
    cases(
        N - "nemterminalis abc, veges nem ures halmaz" (0 < abs(N) < +infinity),
        T - "terminalis abc, veges nem ures halmaz" (0 < abs(T) < +infinity)
    ) N "es" T "diszjunktak " (N inter T = nothing)\
$

    S - startszimbolum, $(S in N)$

    R - atirasi szabalyok halmaza $(R subset.eq (N union T)^* N (N union T)^* times (N union T)^*, "  " abs(R) < +infinity)$


$(x, y) in R ~ x arrow y$

#pagebreak()
$ alpha, beta in (N union T)^*, "  " alpha ==>_G beta: exists u, v in (N union T)^*, "  " (x, y) in R, "  " alpha = u x v, "  " beta = u y v $

pl:
$ G_1 = ({S}, {a, b}, S, R) $

$ R = {S arrow a S b, "  " S arrow epsilon} $

$a S a S b ==>_G_1 a a S b a S b$

$a S a S b ==>_G_1 a a S b$

$a S a S b ==>_G_1 a S a a S b b$

$a S a S b ==>_G_1 a S a b$

$ alpha ==>_G^* beta : alpha = beta "  vagy  " exists gamma_1, gamma_2, dots, gamma_n in (N union T)^*: alpha = gamma_1, beta = gamma_n, gamma_i ==>_G gamma_(i + 1) "  " (i = 1, dots, n - 1) $

$L(G) = {u in T^*: S ==>_G^* u}$

== 1
$L(G_1) = ?$

$S ==>_G_1 underline(underline(epsilon))$

$S ==>_G_1 a S b ==>_G_1 underline(underline(a b))$

$S ==>_G_1 a S b ==>_G_1 a a S b b ==>_G_1 underline(underline(a a b b))$

$S ==>_G_1 a S b ==>_G_1 a a S b b ==>_G_1 a a a S b b b ==>_G_1 underline(underline(a a a b b b))$

$dots.v$

$L(G_1) = {a^n b^n | n >= 0}$

== 2
$G_2 = ({A, B}, {a, b}, A, {A arrow a B | epsilon, B arrow b A })$

$L(G_2) = ?$

$A ==> epsilon$

$A ==> a B ==> a b A ==> a b$

$A ==> a B ==> a b A ==> a b a B ==> a b a b A ==> a b a b$

$A ==> a B ==> a b A ==> a b a B ==> a b a b A ==> a b a b a B ==> a b a b a b$

$dots.v$

$L(G_2) = {(a, b)^n | n >= 0}$

#pagebreak()
== 3
$G_3 = ({S, X, Y}, {a, b, c}, S, {S arrow a b c | a X b c, X b arrow b X, X c arrow Y b c c, b Y arrow Y b, a Y arrow a a X | a a})$

$S ==> underline(underline(a b c))$

$S ==> a X b c ==> a b X c ==> a b Y b c c ==> a Y b b c c ==> underline(underline(a a b b c c))$

$S ==> a X b c ==> a b X c ==> a b Y b c c ==> a Y b b c c ==> a a X b b c c ==> a a b X b c c ==> a a b b X c c ==> a a b b Y b c c c ==> a a b Y b b c c c ==> a a Y b b b c c c ==> underline(underline(a a a b b b c c c))$

$dots.v$

$L(G_3) = {a^n b^n c^n | n >= 1}$
