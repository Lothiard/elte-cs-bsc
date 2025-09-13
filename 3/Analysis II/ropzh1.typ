- Mi a belso pont definicioja?

Legyen $emptyset != A subset bb(R)$. Az a $a in A$ pont az $A$ halmaz belso pontja, ha
$
  exists r > 0, #h(1cm) "hogy" K_r(a) = (a - r, a + r) subset A.
$
Jeloles: int $A := {a in A | "a belso pontja A-nak"}$.

\ \
- Mikor mondja azt, hogy egy $f in bb(R) arrow bb(R)$ fuggveny differencialhato valamely $a in "int" D_f$ pontban?

Az $f in bb(R) arrow bb(R)$ fuggveny az $a in "int" D_f$ pontban differencialhato (vagy derivalhato) ha
$
  exists "es veges a" limits(lim)_(h arrow 0)(f(a + h) - f(a))/(h) "hatarertek."
$

Ezt $f'(a)$-val jeloljuk, es az $f$ fuggveny a pontbeli derivaltjanak (vagy differenciahanyadosanak) nevezzuk, azaz
$
  f'(a) := limits(lim)_(h arrow 0)(f(a + h) - f(a))/(h) in bb(R)
$

jeloles: $f in D{a}$

\ \
- Mi a kapcsolat a pontbeli differencialhatosag es folytonossag kozott?
TFH, $f in bb(R) arrow bb(R)$ es $a in "int" D_f$. Ekkor
- 1. $f in D{a} ==> f in C{a}$
- 2. az allitas megforditasa nem igaz.

\ \
- Adjon peldat olyan fuggvenyre, ami az $a in bb(R)$ pontban folytonos, de nem differencialhato!
$ f(x) = |x| $

\ \
- Milyen tetelt ismer ket fuggveny szorzatanak valamely pontbeli differencialhatosagarol es a derivaltjarol?

TFH, $f, g in D{a}$ valamilyen $a in "int" (D_f inter D_g)$ pontban. Ekkor
$
  f dot g in D{a} " es " (f dot g)'(a) = f'(a) dot g(a) + f(a) dot g'(a)
$

\ \
- Milyen tetelt ismer ket fuggveny hanyadosanak valamely pontbeli differencialhatosagarol es a derivaltjarol?

TFH, $f, g in D{a}$ valamilyen $a in "int" (D_f inter D_g)$ pontban, es $g(a) != 0$. Ekkor
$
  f / g in D{a} " es " (f / g)'(a) = (f'(a) dot g(a) - f(a) dot g'(a))/(g^2(a))
$
