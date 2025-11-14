= Felosztássorozatok segı́tségével adja meg a Riemann-integrálhatóság egy ekvivalens átfogalmazását!
Az $f in R[a, b]$ és $integral_a^b  f = I <==> exists (tau_n)$ felosztássorozat: $lim_(n arrow +infinity) s(f, tau_n) = lim_(n arrow +infinity) S(f, tau_n) = I$

= Hogyan szól a Riemann-integrálható függvények összegével kapcsolatban tanult tétel?
TFH $f,g in R[a,b]$. Ekkor
$
  f + g in R[a, b] "  és  " integral_a^b (f + g) = integral_a^b f + integral_a^b g
$

= Hogyan szól a Riemann-integrálható függvények szorzatával kapcsolatban tanult tétel?
TFH $f,g in R[a,b]$. Ekkor
$
  f dot g in R[a ,b]
$

= Hogyan szól a Riemann-integrálható függvények hányadosával kapcsolatban tanult tétel?
Ha $abs(g(x)) >= m > 0 " " (forall x in [a, b])$, akkor
$
  f/g in R[a ,b]
$

= Milyen tételt tanult Riemann-integrálható függvény értékeinek megváltoztatását illetően?
TFH $f,g in K[a, b]$. Ha $f in R[a ,b]$ és az
$
  A := {x in [a, b] | f(x) != g(x)} " halmaz véges, akkor " g in R[a, b] " és " integral_a^b g = integral_a^b f
$

= Mit ért a Riemann-integrál intervallum szerinti additivitásán?
TFH $f: [a, b] arrow RR$ korlátos, és legyen $c in (a, b)$. Ekkor
/ 1: $f in R[a, b] <==> f in R[a, c]$ és $f in R[c, b]$
/ 2: ha $f in R[a, c]$ és $f in R[c, b]$ (vagy $f in R[a, b]$), akkor
$
  integral_a^b f = integral_a^c f + integral_c^b f
$

#pagebreak()
= Hogyan szól az integrálszámı́tás első középértéktétele?
TFH $f, g in R[a, b]$ és $g >= 0$. Ekkor
/ 1: az $m := inf_([a, b]) f, M := sup_([a, b]) f$ jelölésekkel
$
  m dot integral_a^b g <= integral_a^b f dot g <= M dot integral_a^b g
$
/ 2: ha még $f in C[a, b]$ is teljesül, akkor $exists xi in [a, b]:$
$
  integral_a^b f dot g = f(xi) dot integral_a^b g
$

= Fogalmazza meg a Cauchy–Bunyakovszkij–Schwarz-féle egyenlőtlenséget!
Tetszőleges $f, g in R[a, b]$ függvények esetén
$
  abs(integral_a^b f(x) dot g(x) dif x) <= sqrt(integral_a^b f^2(x) dif x) dot sqrt(integral_a^b g^2(x) dif x)
$

