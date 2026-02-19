// #set math.cases(reverse: true)

= improprius integralok
/ def: Legyen $[a, b) subset RR$ intervallum es TFH $f: [a,b) arrow RR$ fuggvenyre $f in R[a, c] "  " (forall a <= c < b)$
Ekkor $f$ impropriusan integralhato $[a, b)$ ha $exists$ es veges $lim_(t arrow b - 0)integral_a^t f(x) dif x$

/ jeloles: $ integral_a^b f(x) dif x := lim_(t arrow b - 0) integral_a^t f(x) dif x $

/ megjegyzes: - ugyanigy: $(a, b]$-n
$
    integral_a^b f(x) dif x = lim_(t arrow a + 0) integral_t^b f(x) dif x 
$

/ : - sot: $(a, b)$-re tetszoleges $c in (a, b)$-vel:
$
    integral_a^b f(x) dif x = underbrace(integral_a^c f(x) dif x, (a, c]) + underbrace(integral_c^b f(x) dif x, [c, b))
$

/ : - $(-infinity, b], [a, +infinity), (-infinity, +infinity)$-re mind mukodik ez

/ : - nem korlatos fuggveny eseten bizonyos fokig tudjuk csak kezelni, pl: $1/x$
$
    integral_0^1 1/x dif x " mukodik, mert minden " [t, 1] "-on korlatos"
$
szamoljuk ki
$
    integral_0^1 1/x dif x = lim_(t arrow 0 + 0) integral_t^1 1/x dif x = lim_(t arrow 0 + 0) [ln(x)]_(x = t)^1 = lim_(t arrow 0 + 0) (ln(1) - ln(t)) = 0 - (-infinity) = underline(underline(+infinity))
$

#pagebreak()
= feladatok
== 1
$
    integral_1^0 1/(x^alpha) dif x, "  " alpha in RR
$

/ megjegyes: Ha $f in R[a, b]$ akkor impropriusan is integralhato az $(a, b)$-n es az improprius integrallal azonos (ez abbol kovetkezik hogy az integralfuggveny folytonos)

nezzuk $(0, 1]$-en impropriusan (bizonyos $alpha$-ra $in R[0, 1]$, de nem erdekel)
$
    lim_(t arrow 0 + 0) integral_t^1 underbrace(1/x^alpha, x^(-alpha)) dif x =_(alpha != 1) lim_(t arrow 0 + 0) [(x^(-alpha + 1))/(-alpha + 1)]_(x = t)^1 = lim_(t arrow 0 + 0) (1/(1 - alpha) - (t^(1 - alpha))/(1 - alpha)) = 1/(1 - alpha) - 1/(1 - alpha) dot  lim_(t arrow 0 + 0) (t^(1 - alpha)) =\ =_(alpha != 1 ==> beta != 0) cases(1/(1 - alpha)\, " ha" alpha < 1, +infinity\, " ha" alpha > 1 " vagy " alpha = 1)
$

$
    1 - alpha = beta < 0 <==> 1 < alpha ==> +infinity\
    1 - alpha = beta > 0 <==> 1 > alpha ==> 0
$

= hazi
$
    integral_1^(+infinity) 1/x^alpha dif x = cases(1/(alpha - 1)\, " ha" alpha > 1, +infinity\, " ha" alpha <= 1)
$

/ Megjegyzes: 
emlekezzunk:
/ : -
$
    1 + 1/2 + 1/3 + dots = sum_(n = 1)^(+infinity) = +infinity
$
/ : -
$
    1 + 1/2^2 + 1/3^2 + dots = sum_(n = 1)^(+infinity) 1/n^2 < +infinity " konvergens csak nem tudjuk mennyi az osszege"
$

altalanosan:
/ : -
$
    sum_(n = 1) 1/n^alpha = cases("divergens" <==> alpha <= 1, "konvergens" <==> alpha > 1)
$

#pagebreak()
$
    integral_1^(+infinity) f(x) dif x " vagy " sum_(n = 1)^(+infinity) f(n)
$

$
    integral_1^(+infinity) f(x) dif x < sum_(n = 1)^(+infinity) f(n) < f(1) + integral_1^(+infinity) f(x) dif x\
    "integral konvergens" ==> "osszeg konvergens"
$

/ altalanosan:
$
    f:(1, +infinity) arrow RR " fv monoton csokkeno es" f >= 0
$
Ekkor
$
    integral_1^(+infinity) f(x) dif x "konvergens" <==> sum_(n = 1)^(+infinity) f(n) "konvergens"
$

== 2
$
    integral_0^pi 1/(alpha + cos(x)) dif x, " ahol " a > 1 " valos parameter"
$
$a > 1$ miatt $a + underbrace(cos(x) > 0, in [-1, 1]) ==> 1/(a + cos(x)) in C[0, pi] ==> in R[0, pi]$

emlekezzunk:
/ : -
$
    integral R(sin x, cos x), R "racionalis tort tuggveny tipusu"\
    cos(x) = (cos^2(x / 2) - sin^2(x / 2))/(cos^2(x / 2) + sin^2(x / 2)) = (1 - tan^2(x / 2))/(1 + tan^2(x / 2))
$

/ : -
$
    sin(x) = (2 sin(x/2) cos(x/2))/(sin^2(x/2) + cos^2(x/2)) = (2 tan(x/2))/(1 + tan^2(x/2))
$

$t = tg(x/2)$ helyettesitessel

$
    integral R(sin x, cos x) dif x = integral R((2t)/(1 + t^2), (1 - t^2)/(1 + t^2)) dot 2/(1 + t^2) dif t\
$

mert
$
    t = tan(x/2) <==> x = g(t) = 2 arctan(t) ==> g'(t) = 2/(1 + t^2)
$

ha
$
    x = 2 arctan(t) in [0, pi]\
    arctan(t) in [0, pi/2]\
    t in [0, +infinity)
$

igy a feladatnal
$
    integral_0^pi 1/(a + cos(x)) dif x != integral_0^(+infinity) 1/(a + (1 - t^2)/(1 + t^2)) dot 2/(1 + t^2) dif t
$
nincs ilyen szabaly

helyette hasznalhatnank improrpius integralt es akkor sem mukodne, szoval vesszuk Reimann integralkent es vesszuk es akkor mar mukodni fog a helyettesitesi szabaly
$
    integral_0^pi 1/(a + cos(x)) dif x = lim_(u arrow pi - 0) integral_0^u 1/(a + cos(x)) dif x = integral_0^u 1/(a + cos(x)) dif x = integral_0^(tan(u/2)) 1/(a + (1 - t^2)/(1 + t^2)) dot 2/(1 + t^2) dif t\
$
mert
$
    x = 2 arctan(t) in [0, u],\
    arctan(t) in [0, u/2],\
    t in [tan(0), underline(underline(tan(u/2)))]
$

$
    = integral_0^(tan(u/2)) underbrace(2/(a(1 + t^2) + (1 - t^2)), 2/((a + 1) + (a - 1)t^2)) dif t = 2/(a + 1) integral_0^(tan(u/2)) 1/(1 + (sqrt((a - 1)/(a + 1)) dot t)^2) dif t = 2/(a + 1) dot [(arctan(sqrt((a - 1)/(a + 1)) dot t))/(sqrt((a - 1)/(a + 1)))]_(t = 0)^(tan(u/2)) =\ = 2/(sqrt(a^2 - 1)) dot arctan(sqrt((a - 1)/(a + 1)) dot tan(u/2))
$

tehat
$
    integral_0^pi 1/(a + cos(x)) dif x = lim_(u arrow pi - 0) (2/(sqrt(a^2 - 1)) dot arctan(sqrt((a - 1)/(a + 1)) dot tan(u/2)))
$

$
    lim_(u arrow pi - 0) (2/(sqrt(a^2 - 1)) dot underbrace(arctan(sqrt((a - 1)/(a + 1)) dot underbrace(tan(u/2), +infinity)), pi/2)) = pi/(sqrt(a^2 - 1))
$

masik megoldas: (Newton-Leibniz tetel improprius integralokra tetel)

TFH $a, b in overline(RR), a < b$ es\
- $f in R[u, v]$ minden $a < u < v < b$\
- $f"-nek" exists F "primitiv fuggvenye" (a, b)"-n"$ 
Ekkor
$
    integral_a^b f(x) dif x " improprius integral konvergens " <==> exists F(a) := lim_(infinity + 0) F and exists F(b) := lim_(b - 0) F
$

