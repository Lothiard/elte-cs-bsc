= Analízis II. bizonyítandó tételek

== 1. A deriválhatóság ekvivalens átfogalmazása lineáris megközelítéssel

=== Tétel:

Legyen $f in bb(R) arrow bb(R)$ és $ a in "int" cal(D)_f$.\
Ekkor \
$ f in D{a} <==>
  exists A in bb(R) "és" exists epsilon:
cal(D)_f arrow bb(R) "," limits(lim)_a epsilon = 0:\
  f(x) - f(a) = A(x - a) + epsilon(x)(x - a) #h(1cm) (x in D_f),
$
és $A = f'(a)$.

\
=== Bizonyítás:

$==>$ :\
$ f in D{a} ==> limits(lim)_(x arrow a)(f(x) - f(a))/(x - a) = f'(a) in bb(R) <==> limits(lim)_(x arrow a)((f(x)-f(a))/(x - a) - f'(a)) = 0 $
Ha
$ epsilon(x) := (f(x) - f(a))/(x - a) - f'(a) #h(1cm) (x in D_f \\ {a}), $
akkor $limits(lim)_a epsilon = 0$ és 
$ f(x) - f(a) = f'(a) dot (x - a) + epsilon(x)(x - a) #h(1cm) (x in D_f), $
ezért a feltétel az $A = f'(a)$ választással teljesül.

\
$<==$ :\
TFH $exists A in bb(R)$ és $exists epsilon : D_f arrow bb(R), limits(lim)_a epsilon = 0$, hogy
$ f(x) - f(a) = A(x - a) + epsilon (x)(x - a) #h(1cm) (x in D_f). $
Ebből
$ (f(x) - f(a))/(x - a) = A + epsilon(x) arrow A, #h(1cm) "ha" x arrow x $
adódik, ami azt jelenti, hogy $f in D{a}$ és $f'(a) = A$.\ ◾

