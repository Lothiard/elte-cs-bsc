= Analízis II. bizonyítandó tételek

== 1. A deriválhatóság ekvivalens átfogalmazása lineáris megközelítéssel
=== Tétel:
Legyen $f in bb(R) arrow bb(R)$ és $ a in "int" cal(D)_f$.\
Ekkor \
$ f in D{a} <==>
  exists A in bb(R) "és" exists epsilon:
cal(D)_f arrow bb(R) "," limits(lim)_a epsilon = 0:\
  f(x) - f(a) = A(x - a) + epsilon(x)(x - a) #h(1cm) (x in cal(D)_f),
$
és $A = f'(a)$.

\
=== Bizonyítás:
$==>$ :\
$ f in D{a} ==> limits(lim)_(x arrow a)(f(x) - f(a))/(x - a) = f'(a) in bb(R) <==> limits(lim)_(x arrow a)((f(x)-f(a))/(x - a) - f'(a)) = 0 $
Ha
$ epsilon(x) := (f(x) - f(a))/(x - a) - f'(a) #h(1cm) (x in cal(D)_f \\ {a}), $
akkor $limits(lim)_a epsilon = 0$ és 
$ f(x) - f(a) = f'(a) dot (x - a) + epsilon(x)(x - a) #h(1cm) (x in cal(D)_f), $
ezért a feltétel az $A = f'(a)$ választással teljesül.

\
$<==$ :\
TFH $exists A in bb(R)$ és $exists epsilon : D_f arrow bb(R), limits(lim)_a epsilon = 0$, hogy
$ f(x) - f(a) = A(x - a) + epsilon (x)(x - a) #h(1cm) (x in D_f). $
Ebből
$ (f(x) - f(a))/(x - a) = A + epsilon(x) arrow A, #h(1cm) "ha" x arrow x $
adódik, ami azt jelenti, hogy $f in D{a}$ és $f'(a) = A$.\
$square$
#pagebreak()

== 2. A szorzatfüggvény deriválása
=== Tétel:
TFH, $f, g in D{a}$ valamilyen $a in "int" (cal(D)_f inter cal(D)_g)$ pontban. Ekkor
$
  f dot g in D{a} " és " (f dot g)'(a) = f'(a) dot g(a) + f(a) dot g'(a)
$
=== Bizonyítás:
Világos, hogy $a in "int"cal(D)_(f dot g)$.
Az $f dot g$ függvény különbséghányados-függvénye az $a$ pontban
$
  ((f g)(x) - (f g)(a))/(x - a) =
  (f(x) dot g(x) - f(a) dot g(a))/(x - a) =^!
  (f(x) dot g(x) - f(a) dot g(x) - f(a) dot g(a) + f(a) dot g(x))/(x - a) =\
  = (f(x) - f(a))/(x - a) dot g(x) + f(a) dot (g(x) - g(a))/(x - a) "   " (x in cal(D)_(f dot g) \\{a}).
$
Mivel $g in D{a}$, ezért $g in C{a}$, tehát $limits(lim)_(x arrow a) g(x) = g(a)$. Így
$
  limits(lim)_(x arrow a) ((f g)(x) - (f g)(a))/(x - a) =\
  = limits(lim)_(x arrow a) (f(x) - f(a))/(x - a) dot limits(lim)_(x arrow a) g(x) + limits(lim)_(x arrow a) f(a) dot limits(lim)_(x arrow a) (g(x) - g(a))/(x - a) =\
  = f'(a) dot g(a) + f(a) dot g'(a).
$
Ez azt jelenti, hogy $f, g in D{a}$ és
$
  (f dot g)'(a) = f'(a) dot g(a) + f(a) dot g'(a).
$

#pagebreak()
== 3. A hányadosfüggvény deriválása
=== Tétel:
TFH, $f, g in D{a}$ valamilyen $a in "int" (cal(D)_f inter cal(D)_g)$ pontban, és $g(a) != 0$. Ekkor
$
  f / g in D{a} " es " (f / g)'(a) = (f'(a) dot g(a) - f(a) dot g'(a))/(g^2(a))
$

=== Bizonyítás:
Először igazoljuk, hogy $a in "int"cal(D)_(f/g)$.

Valóban: $g in D{a} ==> g in C{a}$.\
Tehát $g(a) != 0 " " ==> " " exists K(a) subset cal(D)_f: g(x) != 0 " " (forall x in K(a)) " " ==> " " a in "int" cal(D)_(f/g)$

Az $f/g$ hányadosfüggvény különbséghányados-függvénye $a$-ban
$
  ((f/g)(x) - (f/g)(a))/(x-a) =
  (f(x)/g(x) - f(a)/g(a))/(x-a) =
  1/(g(a)g(x)) dot (f(x) dot g(a) - f(a) dot g(x))/(x-a) =\
  = 1/(g(a)g(x)) dot ((f(x) - f(a))/(x-a) dot g(a) - f(a) dot (g(x) - g(a))/(x-a))
$

Mivel $g in C{a} ==> limits(lim)_(x arrow a) g(x) = g(a) != 0$, ezért

$
  limits(lim)_(x arrow a)((f/g)(x) - (f/g)(a))/(x - a) =\
  = 1/(g(a) limits(lim)_(x arrow a) g(x))(limits(lim)_(x-a)(f(x) - f(a))/(x-a) dot g(a) - f(a) dot limits(lim)_(x arrow a)(g(x) - g(a))/(x-a)) =\
  = 1/(g^2(a))(f'(a)g(a) - f(a)g'(a)).
$
$square$

#pagebreak()
== 4. A lokális szélsőértékre vonatkozó elsőrendű szükséges feltétel
=== Tétel:
TFH az $f$ függvénynek az $a in "int" cal(D)_f$ pontban lokális szélsőértéke van és $f in D{a}$. Ekkor
$ f'(a) = 0 $

=== Bizonyítás:
TFH $f$-nek $a$-ban lokális maximuma van, azaz $exists r>0$:
$ forall x in (a-r,a+r):" " f(x) <= f(a) ==> f(x) - f(a) <= 0. $

Tekintsük az $f$ függvény $a$-hoz tartozó különbséghányados-függvényét:

$ (f(x) - f(a))/(x-a) "  " (x in cal(D)_f \\ {a}). $

Ha $a < x < a + r ==> x - a > 0$ és $f(x) - f(a) <= 0 ==>$
$
  ==> (f(x) - f(a))/(x-a) <= 0 ==> limits(lim)_(x arrow a+0)(f(x) - f(a))/(x-a) = f'_+(a) <= 0.
$

Ha $a - r < x < a ==> x - a < 0$ és $f(x) - f(a) <= 0 ==>$
$
  ==> (f(x) - f(a))/(x-a) >= 0 ==> limits(lim)_(x arrow a-0)(f(x) - f(a))/(x-a) = f'_-(a) >= 0.
$

Mivel $f in D{a}$, ezért
$
  underbrace(f'_-(a), >= 0) = underbrace(f'_+(a), <= 0) = f'(a) = 0
$
$square$

#pagebreak()
== 5. A Rolle-féle középértéktétel
=== Tétel:
Legyen $a,b in bb(R)$ és $a < b$. Ekkor
#set math.cases(reverse: true)
$
    cases(
        f in C[a,b],
        f in D(a,b),
        f(a) = f(b),
    ) ==> exists xi in (a,b), "hogy" f'(xi) = 0.
$

=== Bizonyítás:
$
  f in C[a,b] ==> "(Weierstrass-tétel)" exists alpha, beta in [a,b]:\
  f(alpha) = min_[a,b] f =: m "  és  " f(beta) = max_[a,b] f =: M.
$

- 1. eset: $m = M$.
  Ekkor $f$ állandó, így $forall xi in (a,b): f'(xi) = 0$.
- 2. eset: $m != M$.
  Mivel $f(a) = f(b)$, ezért $alpha$ és $beta$ közül legalább az egyik (pl. $alpha$) ($a,b$)-be esik.\ Ekkor $xi := alpha in "int" cal(D)_f = (a,b)$, és $f$-nek $xi$-ben lokális minimuma van.\ Mivel $f in D{xi} ==> ("az elsőrendű szükséges feltétel") f'(xi) = 0.$
$square$

#pagebreak()
== 6.
