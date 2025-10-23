
== Definiálja a primitív függvényt!
Legyen $I in RR$ nyílt intervallum és $f: I arrow RR$ egy adott függvény.\
AMH a $F: I arrow RR$ függvény $f$ primitív függvénye, ha
$
  F in D(I) "  és  " F'(x) = f(x) "  " (forall x in I)
$

== Adjon meg olyan függvényt, amelyiknek nincs primitív függvénye!
$
  f(x) = cases(
    0\, & "ha" x <= 0,
    1\, & "ha" x > 0,
  )
$

== Mit jelent egy függvény határozatlan integrálja?
Az $I$ intervallumon értelmezett $f$ függvény primitív függvényeinek a halmazát $f$ határozatlan integráljának nevezzük.\
Jelölés:
$
  integral f := integral f(x) d x := {F: I arrow RR | F in D " és " F' = f }
$

== Mit ért a határozatlan integrál linearitásán?
Legyen $I$ nyílt intervallum. Ha az $f, g: I arrow RR$ függvényeknek létezik primitív függvénye, akkor tetszőleges $alpha, beta in RR$ mellett $(alpha f + beta g)$-nek is létezik primitív függvénye és
$
  integral (alpha f(x) + beta g(x)) d x = alpha integral f(x) d x + beta integral g(x) d x "  " (x in I)
$

== Mit mond ki a primitív függvényekkel kapcsolatos parciális integrálás tétele?
Legyen $I$ nyílt intervallum.\
TFH $f, g in D(I)$ és az $f'g$ függvénynek létezik primitív függvénye $I$-n.\
Ekkor az $f g'$ függvénynek is van primitív függvénye és
$
  integral f(x) g'(x) d x = f(x)g(x) - integral f'(x)g(x) d x "  " (x in I)
$

== Hogyan szól a primitív függvényekkel kapcsolatos első helyettesı́tési szabály?
Legyenek adottak $I, J$ nyílt intervallumok és a $g: I arrow RR, f: J arrow RR$ függvények.\
TFH $g in D(I), cal(R)_g subset J$ és az f függvénynek van primitív függvénye.\
Ekkor az $(f circle.small g) dot g'$ függvénynek is van primitív függvénye és
$
  integral f(g(x)) dot g'(x) d x = F(g(x)) + c "  " (x in I)
$
ahol $F$ az $f$ egy primitív függvénye.

#pagebreak()
== Adja meg a következő függvények egy primitív függvényét:
=== $exp$
$
  integral exp d x = exp + C
$

=== $x^a "  " (x > 0, a in RR \\ {−1})$
$
  integral x^a d x = (x^(a + 1))/(a + 1) + C
$

=== $1/x "  " (x > 0)$
$
  integral 1/x d x = ln x + C
$

=== $sin$
$
  integral sin d x = -cos x + C
$

=== $cos$
$
  integral cos d x = sin x + C
$

=== $1/(1 + x^2) "  " (x in RR)$
$
  integral 1/(1 + x^2) d x = arctan x + C
$
