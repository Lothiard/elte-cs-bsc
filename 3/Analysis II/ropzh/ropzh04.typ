= Mi a konvex függvény definı́ciója?
AMH $f: I arrow RR$ konvex az $I$ intervallumon, ha
$
  forall a,b in I, a < b " esetén"\
  f(x) <= (f(b) - f(a))/(b - a)(x-a) + f(a) "  " (forall x in (a,b))
$

\
= Mi a konkáv függvény definı́ciója?
AMH $f: I arrow RR$ konkáv az $I$ intervallumon, ha
$
  forall a,b in I, a < b " esetén"\
  f(x) >= (f(b) - f(a))/(b - a)(x-a) + f(a) "  " (forall x in (a,b))
$

\
= Jellemezze egy függvény konvexitását az első deriváltfüggvény segı́tségével!
TFH $I subset RR$ nyílt intervallum és $f in D(I)$. Ekkor
$
  f " konvex " I"-n" <==> f' arrow.tr I"-n"
$

\
= Jellemezze egy függvény konkávitását az első deriváltfüggvény segı́tségével!
TFH $I subset RR$ nyílt intervallum és $f in D(I)$. Ekkor
$
  f " konkáv " I"-n" <==> f' arrow.br I"-n"
$

\
= Jellemezze egy függvény konvexitását a második deriváltfüggvény segı́tségével!
TFH $I subset RR$ nyílt intervallum és $f in D^2(I)$. Ekkor
$
  f " konvex " I"-n" <==> f'' >= 0 " " I"-n"
$

\
= Jellemezze egy függvény konkávitását a második deriváltfüggvény segı́tségével!
TFH $I subset RR$ nyílt intervallum és $f in D^2(I)$. Ekkor
$
  f " konkáv " I"-n" <==> f'' <= 0 " " I"-n"
$

\
= Mi az inflexiós pont definı́ciója?
Legyen $I$ nyílt intervallum és TFH $f in D(I)$\
AMH a $c in I$ pont az $f$ függvénynek inflexiós pontja, ha
$
  exists delta > 0: f "konvex " (c - delta, c]"-n és konkáv " [c, c + delta)"-n, vagy fordítva"
$

\
= Mondja ki a konvexitás és az érintő kapcsolatára vonatkozó tételt!
TFH $I subset RR$ nyílt intervallum és $f in D(I)$. Ekkor
$
  f "konvex " I"-n" <==> forall a in I: f(x) >= e_(f, a)(x), "  " (x in I),
$

\
= Mondja ki a konkávitás és az érintő kapcsolatára vonatkozó tételt!
TFH $I subset RR$ nyílt intervallum és $f in D(I)$. Ekkor
$
  f "konkáv " I"-n" <==> forall a in I: f(x) <= e_(f, a)(x) "  " (x in I),
$

\
= Mikor mondjuk, hogy egy függvénynek aszimptotája van a $+infinity$-ben?
Legyen $a in RR$ és $f:(a, +infinity) arrow RR$.\
AMH $f$-nek van aszimptotája $(+infinity)$-ben, ha
$
  exists l(x) = A x + B "  " (x in RR)
$
elsőfokú függvény, amelyre
$
  limits(lim)_(x arrow +infinity) (f(x) - l(x)) = 0
$
Ekkor az $l(x) " " (x in RR)$ egyenes $f$ aszimptotája $(+infinity)$-ben

\
= Hogyan szól a +∞-beli aszimptota létezésére vonatkozó feltétel?
Az $f: (a, +infinity) arrow RR$ függvénynek akkor és csak akkor van aszimptotája $(+infinity)$-ben, ha léteznek és végesek az alábbi határértékek:
$
  limits(lim)_(x arrow +infinity) (f(x))/x =: A in RR, "    " limits(lim)_(x arrow +infinity) (f(x) - A x) =: B in RR
$
Ekkor az
$
  l(x) = A x + B "  " (x in RR)
$
egyenes az $f$ függvény aszimptotája $(+infinity)$-ben

