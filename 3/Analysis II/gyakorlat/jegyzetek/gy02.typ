= emlekezteto
valamely $f in bb(R) arrow bb(R)$ fuggveny, es $a in "int" D_f$ eseten

$
    f in D{a} <==> exists f'(a) := limits(lim)_(x arrow a) (f(x) - f(a))/(x - a) in bb(R)
$

= feladatok
== 1.
egynel nagyon valos szamok halmazan ertelmes a kifejezes
$
    limits(lim)_(x arrow a) (f(x) - f(a))/(x - a) =
    limits(lim)_(x arrow a) (sqrt(x^2 - 1) - sqrt(a^2 - 1))/(x - a) =
$

$0/0$ lenne ezert gyoktelenitunk

$
    limits(lim)_(x arrow a) (sqrt(x^2 - 1) - sqrt(a^2 - 1))/(x - a) dot (sqrt(x^2 - 1) + sqrt(a^2 - 1))/(sqrt(x^2 - 1) + sqrt(a^2 - 1))
$

felsimerjuk az azonossagokat
$
    limits(lim)_(x arrow a) ((x^2 - 1) - (a^2 - 1))/((x - a)(sqrt(x^2 - 1) + sqrt(a^2 - 1))) =
    limits(lim)_(x arrow a) (x^2 - a^2)/((x - a)(sqrt(x^2 - 1) + sqrt(a^2 - 1))) =
    \ \ "mivel" (a^2 - b^2) = (a - b)(a + b) \ \
    limits(lim)_(x arrow a) ((x - a)(x + a))/((x - a)(sqrt(x^2 - 1) + sqrt(a^2 - 1))) =
    limits(lim)_(x arrow a) (x + a)/(sqrt(x^2 - 1) + sqrt(a^2 - 1)) =
    (a + a)/(sqrt(a^2 - 1) + sqrt(a^2 - 1)) =
    (2a)/(2sqrt(a^2 - 1)) =
    a/sqrt(a^2 - 1)
$

== 2/a
$ f(x) = 4x^3-2x^2+5x-3 "  " (x in bb(R)) $
$ f'(x) = 12x^2 - 4x + 5 $

== 2/b
$ f(x) = sqrt(x sqrt(x sqrt(x))) "  " (x > 0) $
$ f'(x) = x^(7/8) = 7/8 dot x^(-1/8) = 7/(8 root(8, x)) $

== 2/c
$ f(x) = x^3 + 1/x^2 - 1/(5x^5) "  " (x in bb(R) \\ {0}) $
$ f'(x) = 2x^2 -2/x^3 + 1/x^6 $

#pagebreak()
== 2/d
$ f(x) = x^a + a^x + a x + x/a + a/x "  " (x > 0), a > 0 "parameter" $
$ f'(x) = a dot x^(a - 1) + a^x ln a + a + 1/a - a/(x^2) $

== 2/e
szorzas azonossag
$ f(x) = x^2 dot sin x "  " (x in bb(R)) $
$ f'(x) = 2x dot sin x + x^2 dot cos x $

== 2/f
osztas azonossag
$ f(x) = (x^3 + 2)/(x^2 + x + 5) "  " (x in bb(R)) $
$ f'(x) = (2x^2 dot (x^2 + x + 5) - (x^3 + 2) dot (2x + 1))/(x^2 + x + 5)^2 $

== 2/g
kompozicio azonossag
$ f(x) = (5x^2 + 3x)^2023 "  " (x in bb(R)) $
$ f'(x) = 2023(5x^2 + 3x)^2022 dot (10x + 3) $

== 2/h
kompozicio azonossag
$ f(x) = sqrt(x + sqrt(x)) "  " (x > 0) $
$ f'(x) = 1/(2 sqrt(x + sqrt(x))) dot (1 + 1/(2sqrt(x))) $

== 2/i
megint kompozicio
$ f(x) = sin((x^2 + 1)/(x + 3)) "  " (x > -3) $
$ f'(x) = cos((x^2 + 1)/(x + 3)) dot (2x dot (x + 3) - (x^2 + 1))/((x + 3)^2) = cos((x^2 + 1)/(x + 3)) dot (x^2+6x-1)/(x^2 +6x+9) $

#pagebreak()
== 2/j
hat en ezt meg nem csinalom
$ f'(x) = -(sin(2(ln sqrt(1 + cos^2 x) + 1)))/(sqrt(2(1 + cos^2 x))) dot sin 2x $

= megjegyzes
lehetne a fentit ugy is megoldani hogy ne oregedjek meg kozen

van olyan dolog is hogy logaritmikus derivalas ami roviden annyi hogy vesszuk mind a ket oldal logarimusat es utana derivaljuk mind ket oldalt

ez akkor hasznos ha nagyon bonyolult a fuggveny es vannak hatvanyok es ha hanyados szerint derivalnank akkor eltelne az egesz zh mire vegeznenk vele

