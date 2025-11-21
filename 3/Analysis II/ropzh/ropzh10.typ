= Mi a kapcsolat a monotonitás és a Riemann-integrálhatóság között?
Ha az $f: [a, b] arrow RR$ függvény monoton az $[a, b]$ intervallumon, akkor integrálható $[a, b]$-n

= Definiálja a szakaszonként monoton függvény fogalmát!
Legyen $a, b in RR, a < b$.\
AMH az $f: [a, b] arrow RR$ függvény szakaszonként monoton, ha
$
  exists m in NN^+ " és " tau = {a = x_0 < x_1 < dots < x_m = b} in cal(F)[a, b]
$
úgy, hogy minden $i = 1, dots, m$ index esetén
- az $f_(|_((x_i-1, x_i)))$ függvény monoton
- $f$ korlátos $[a ,b]$-n.

= Definiálja az egyenletes folytonosság fogalmát!
Az $f in RR arrow RR$ függvény egyenletesen folytonos a $H subset cal(D)_f$ halmazon, ha
$
  forall epsilon > 0, exists delta > 0: forall x, y in H, abs(x - y) < delta: abs(f(x) - f(y)) < epsilon
$

= Mondja ki az egyenletes folytonosságra igazolt Heine-tételt!
Ha $-infinity < a < b < +infinity$ és $f in C[a, b]$, akkor $f$ egyenletesen folytonos $[a, b]$ intervallumon.

= Mi a kapcsolat a folytonosság és a Riemann-integrálhatóság között?
Ha az $f$ függvény folytonos az $[a, b]$ intervallumon, akkor integrálható $[a, b]$-n. $(C[a, b] subset R[a, b])$

= Definiálja a szakaszonként folytonos függvény fogalmát!
Legyen $a, b in RR, a < b$.\
AMH az $f: [a, b] arrow RR$ függvény szakaszonként folytonos, ha
$
  exists m in NN^+ " és " tau = {a = x_0 < x_1 < dots < x_m = b} in cal(F)[a, b]
$
úgy, hogy minden $i = 1, dots, m$ index esetén
- az $f_(|_((x_i-1, x_i)))$ függvény folytonos
- léteznek és végesek a $lim_(x_(i - 1), + 0) f, lim_(x_i - 0) f$ hatátértékek.

= Hogyan szól a Newton–Leibniz-tétel ?
Ha $f in R[a, b]$ és a $f$ függvénynek van primitív függvénye az [a, b] intervallumon, akkor
$
    integral_a^b f(x) dif x = F(b) - F(a) =: [F(x)]_a^b
$
ahol $F$ a $f$ függvény egy (tetszőleges) primitív függvénye

#pagebreak()
= Definiálja az integrálfüggvény fogalmát!
TFH $f in R[a, b]$ és $x_0 in [a, b]$. Ekkor a
$
  F: [a, b] in.rev x arrow.r.bar integral_(x_0)^x f(t) dif t
$
függvényt az $f$ függvény $x_0$-ban eltűnő integrálfüggvényének nevezzük.

