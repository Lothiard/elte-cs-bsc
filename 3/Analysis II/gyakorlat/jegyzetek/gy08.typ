$
    integral f'(x) f^alpha (x) dif x " tipus mar meg van beszelve"
$

== a
$
    integral x/(sqrt(x^2 - 1)) dif x = integral x (x^2 - 1)^(-1/2) dif x = 1/2 integral 2x dot (x^2 - 1)^(-1/2) dif x =\ = 1/2 integral (x^2 - 1)' (x^2 - 1)^(-1/2) dif x = 1/2 ((x^2 - 1)^(1/2))/(1/2) + C = sqrt(x^2 - 1) + C
$

== f
$
    integral 1/(cos^2 x sqrt(tan^3 x)) dif x = integral (tan x)' (tan x)^(-3/2) dif x = ((tan x)^(-1/2))/(-1/2) + C
$

masik tipus
$
    integral sin^n x dot cos^m x dif x "  " (n,m in NN; ZZ; QQ)
$

== pl
a paratlan kitevobol kell levalasztani egy tagot
$
    integral sin^3 x dot cos^4 x dif x = integral underbrace(sin^2 x, 1 - cos^2 x) dot cos^4 x dot underbrace(sin x, -(cos x)') dif x = - integral cos^4 dot (cos x)' dif x + integral cos^6 dot (cos x)' dif x = -(cos^5 x)/(5) + (cos^7 x)/(7) + C
$

ha mind a ketto paratlan, a kisebbol kell levalasztani
$
    integral sin^6 dot cos^3 x dif x = integral sin^6 x dot cos^2 x dot cos x dif x = integral sin^6 x (1 - sin^2 x)(sin x)' dif x =\ = integral sin^6 x (sin x)' dif x - integral sin^8 x (sin x)' dif x = (sin^7 x)/7 - (sin^9 x)/9 + C
$

ha mindegyik paros az egesz kuka\
a fo ilyenkor otlet a linearizalas
$
    integral sin^2 x dot cos^4 x dif x = integral sin^2 x cos^2 x cos^2 x dif x = integral ((sin 2x)/(2))^2 dot (1 + cos 2x)/(2) dif x = 1/8 integral sin^2 x dif x + 1/8 integral sin^2 (2x) cos 2x dif x =\ = 1/8 integral (1 - cos (4x))/(2) dif x + 1/2 1/8 integral sin^3 (2x) dot (sin (2x))' dif x = 1/16 x - 1/16 dot (sin 4x)/(4) dot 1/48 (sin^3 2x) + c
$

hazi
$
    integral sin^3 x dif x
$
$
    integral cos^4 x dif x
$
$
    integral (cos^3 x)/(sqrt(sin^5 x)) dif x
$

== megegy ilyen tipusu pelda
$
    integral sqrt((arcsin x)/(1 - x^2)) dif x = integral underbrace(1/(sqrt(1 - x^2)), (arcsin x)') dot (arcsin x)^(1/2) dif x = 2/3 dot sqrt(arcsin^3 x) + C
$

hazi
$
    integral 1/((x^2 + 1) arctan^2 x) dif x
$

== II. parcialis integralas
$
    (f dot g)' = f' dot g + f dot g' ==> integral (f dot g)' = integral f' dot g + integral f dot g' ==> f dot g = integral f' dot g + integral f dot g' ==>\ ==> integral f' dot g = f dot g - integral f dot g' " vagy " integral f'(x) dot (x) dif x = f(x) dot g(x) - integral f(x) dot g'(x) dif x
$

= 1. tipus
== a
a $"polinom" dot exp $ tipusnal mindig az $exp$ legyen a derivalt
$
    integral (x^2 + 2x - 1) e^(-2x) dif x = integral (x^2 + 2x - 1) dot (e^(-2x)/(-2))' dif x = (x^2 + 2x - 1) dot (e^(-2))/(-2) - integral (x^2 + 2x - 1)' dot (e^(-2))/(-2) dif x =\ = -1/2 (x^2 + 2x - 1) e^(-2x) + integral (x + 1)e^(-2x) dif x = -1/2 (x^2 + 2x - 1) e^(-2x) + (x + 1) dot e^(-2x)/2 - integral (x + 1)' dot (e^(-2x))/(-2) dif x =\ = dots = -1/4 (2x^2 + 6x + 1) dot e^(-2x) + C
$

== hazi
$
    integral (x^2 - 3x)e^(3x) dif x
$

== b
$
    integral x^2 dot sin (2x) dif x = integral x^2 (-(cos 2x)/(2))' dif x = -1/2 integral x^2 (cos 2x)' dif x = -1/2 dot (x^2 cos 2x - integral 2x dot cos 2x) dif x =\ = integral x dot cos 2x dif x - 1/2 x^2 cos 2x = x dot (sin 2x)/(2) - integral 1 (sin 2x)/2 dif x - 1/2 x^2 cos 2x = 1/2 x dot sin 2x + 1/2 (cos 2x)/2 - 1/2 x^2 cos 2x + C
$

hazi
$
    integral (x^2 + 1) dot cos 2x dif x
$

#pagebreak()
= 2. tipus
inverzfuggvenyeket tartalmazo integralok
== a
$
    integral ln x dif x = integral 1 dot ln x dif x = integral (x)' ln x dif x = x dot ln x - integral x dot 1/x dif x = x ln x - integral 1 dif x = x ln x - x + C
$

== b
$
    integral (x^2 - 3x + 1) dot ln x dif x = integral ((x^3)/(3) - 3 (x^2)/(2) + x)' dot ln x dif x = dots = ((x^3)/3 - 3/2 x^2 + x) dot ln x - 1/9 x^3 + 3/4 x^2 - x + C
$

== c
$
    integral arctan (3x) dif x = integral 1 dot arctan (3x) dif x = integral x' dot arctan 3x dif x =\ = x dot arctan (3x) - integral x dot (arctan (3x))' dif x = x arctan 3x - 1/6 ln (9x^2 + 1) + C
$

hazi
$
    integral arcsin (2x) dif x
$
$
    integral (arcsin x)^2 dif x
$

= 3. tipus
egyenlettel megoldhato esetek
== 3/b
$
    integral e^(2x) dot sin x dif x = integral e^(2x) dot (-cos x)' dif x = - integral e^(2x) (cos x)' dif x = - (e^(2x) cos x - 2 integral e^(2x) cos x dif x) =\ = -e^(2x) cos x + 2 integral e^(2x) cos x dif x = -e^(2x) cos x + 2 (e^(2x) dot sin x - integral 2e^(2x) sin x dif x) = 2e^(2x) sin x - e^(2x) cos x - 4 integral e^(2x) sin x dif x
$

tehat
$
    I(x) = e^(2x) dot (2 sin x - cos x) - 4 I(x) ==> I(x) = 1/5 e^(2x) (sin x - cos x) + C
$

hazi ("jo kis zh jelolt")
$
    integral e^(-x) dot cos 5x dif x
$

== b
$
    integral sqrt(1 - x^2) dif x = integral (x)' dot (1 - x^2) dif x = x dot sqrt(1 - x^2) - integral x dot (-2x)/(2 sqrt(1 - x^2)) dif x =\ = x sqrt(1 - x^2) - integral (-x^2)/(sqrt(1 - x^2)) dif x = x sqrt(1 - x^2) - integral (1 - x^2 - 1)/(sqrt(1 - x^2)) dif x = x sqrt(1 - x^2) - integral sqrt(1 - x^2) dif x + integral 1/(sqrt(1 - x^2)) dif x ==>\ ==> 2 dot integral sqrt(1 - x^2) dif x = x sqrt(1 - x^2) + arcsin x ==> integral sqrt(1 - x^2) dif x = 1/2 dot x dot sqrt(1 - x^2) + 1/2 arcsin x + C
$

