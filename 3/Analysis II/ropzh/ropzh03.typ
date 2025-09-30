== 1. Mit ért azon, hogy az $f in RR arrow RR$ függvénynek valamely helyen lokális minimuma van?
Az $f$ függvénynek $a in "int" D_f$ pontban lokális minimuma van, ha
$
    exists K(a) subset D_f, "hogy" forall x in K(a) : f(x) >= f(a)
$
Az $a in "int" D_f$ pont $f$ lokális minimumhelye, $f(a)$ pedig $f$ lokális minimuma.

== 2. Mit ért azon, hogy az $f in RR arrow RR$ függvénynek valamely helyen lokális maximuma van?
Az $f$ függvénynek $a in "int" D_f$ pontban lokális maximuma van, ha
$
    exists K(a) subset D_f, "hogy" forall x in K(a) : f(x) <= f(a)
$
Az $a in "int" D_f$ pont $f$ lokális maximumhelye, $f(a)$ pedig $f$ lokális maximuma.

== 3. Hogyan szól a lokális szélsőértékre vonatkozó elsőrendű szükséges feltétel?
TFH az $f$ függvénynek az $a in "int" cal(D)_f$ pontban lokális szélsőértéke van és $f in D{a}$. Ekkor
$
    f'(a) = 0
$

== 4. Adjon példát olyan $f in RR arrow$ függvényre, amelyre valamely $a in RR$ esetén $f in D{a}, " " f'(a) = 0$ teljesül, de az $f$ függvénynek az a pontban nincs lokális szélsőértéke!
$
    f(x) = x^3
$

== 5. Milyen szükséges és elégséges feltételt ismer differenciálható függvény monoton növekedésével kapcsolatban?
Legyen $f:(a,b) arrow RR$ differenciálható függvény.
$f arrow.t$ ha
$
    f'(x) >= 0 "  " (forall x in (a,b))
$

== 6. Milyen elégséges feltételt ismer differenciálható függvény szigorú monoton növekedésével kapcsolatban?
Legyen $f:(a,b) arrow RR$ differenciálható függvény.
$f$ szigorú monoton növekvő ha
$
    f'(x) > 0 "  " (forall x in (a,b)) " es nincs olyan intervallum amin " f'(x) = 0 " mindvégig"
$


== 7. Milyen szükséges és elégséges feltételt ismer differenciálható függvény szigorú monoton növekedésével kapcsolatban?
legyen $(a, b) subset RR$ nyílt intervallum.

TFH $f in D(a,b)$

Ekkor $f arrow.t " " [arrow.b] " " (a,b)"-n" <==> f' >= 0 " " [f' <= 0] " " (a,b)"-n"$ és $(a,b)$-nek nincs olyan részintervalluma, amelyen $f' = 0$ azonosan.

== 8. Mit ért azon, hogy egy függvény valamely helyen jelet vált?
Azt mondjuk hogy a $h$ függvény a $c in "int" cal(D)_h$ negatívból pozitívba megy át (röviden $h$-nak $c$-ben előjelváltása van), ha $h(c) = 0 "és" exists delta > 0$ úgy, hogy
$
    h(x) < 0, " ha " x in (c - delta, c) "  és " h(x) > 0, " ha " x in (c, c + delta)
$

A $h$ függvény $c$-beli $(+, −)$ előjelváltását hasonlóan értelmezzük. Ekkor $h$ a $c$ pontban pozitívból negatívba megy át.

Azt mondjuk, hogy a $h$ függvény $c$-ben előjelet vált, ha $h$-nak $c$-ben $(−, +)$ vagy $(+, −)$ előjelváltása van.

== 9. Hogyan szól a lokális minimumra vonatkozó elsőrendű elégséges feltétel?
legyen $-infinity < a < b < +infinity$ és $f:(a,b) arrow RR$. TFH
- $f in D(a,b)$,
- egy $c in (a,b)$ pontban $f'(c) = 0$,
- az $f'$ deriváltfüggvény előjelet vált $c$-ben

Ekkor ha az $f'$ függvénynek $c$-ben $(−, +)$ előjelváltása van, akkor $c$ az $f$ függvénynek szigorú lokális minimumhelye;

== 10. Hogyan szól a lokális maximumra vonatkozó elsőrendű elégséges feltétel?
legyen $-infinity < a < b < +infinity$ és $f:(a,b) arrow RR$. TFH
- $f in D(a,b)$,
- egy $c in (a,b)$ pontban $f'(c) = 0$,
- az $f'$ deriváltfüggvény előjelet vált $c$-ben

Ekkor ha az $f'$ függvénynek $c$-ben $(+, -)$ előjelváltása van, akkor $c$ az $f$ függvénynek szigorú lokális maximumhelye;

== 11. Írja le a lokális minimumra vonatkozó másodrendű elégséges feltételt!
legyen $-infinity < a < b < +infinity$ és $f:(a,b) arrow RR$. TFH
- $f$ kétszer deriválható egy $c in (a,b)$ pontban, $f in D^2{c}$
- $f'(c) = 0$
- $f''(c) != 0$

Ekkor $c$ szigorú lokális szélsőértékhelye az $f$ függvénynek ha $f'' (c) > 0$, akkor $c$ az $f$ függvénynek szigorú lokális minimumhelye;

== 12. Írja le a lokális maximumra vonatkozó másodrendű elégséges feltételt!
legyen $-infinity < a < b < +infinity$ és $f:(a,b) arrow RR$. TFH
- $f$ kétszer deriválható egy $c in (a,b)$ pontban, $f in D^2{c}$
- $f'(c) = 0$
- $f''(c) != 0$

Ekkor $c$ szigorú lokális szélsőértékhelye az $f$ függvénynek ha $f'' (c) < 0$, akkor $c$ az $f$ függvénynek szigorú lokális maximumhelye;

== 13. Fogalmazza meg a Weierstrass-tételt!
Korlátos és zárt $[a,b] subset RR$ intervallumon folytonos $f$ függvénynek léteznek abszolút szélsőértékei, azaz
$
    exists alpha, beta in [a,b] "  úgy hogy  " f(beta) <= f(x) <= f(alpha) "  " (forall x in [a,b])
$
