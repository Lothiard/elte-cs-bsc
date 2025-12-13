== 1
=== a
$
    integral (x dot root(3, ln (x^2 + 1)))/(x^2 + 1) dif x "  " (x > 0)\
    (ln (x^2 + 1))' = (2x)/(x^2 + 1)\
    1/2 integral (2x)/(x^2 + 1) (ln (x^2 + 1))^(1/3) dif x = 1/2 integral (ln(x^2 + 1))' (ln(x^2 + 1))^(1/3) dif x = 1/2 (ln(x^2 + 1)^(4/3))/(4/3) + C = 1/2 dot 3/4 root(3, (ln(x^2 + 1))^4) + C
$

=== b
$
    integral ((3 - sin x)^2)/(1 + cos 2x) dif x "  " x in (0, pi/2)\
    integral (9 - 6 sin x + sin^2 x)/(sin^2 x + cos^2 x + cos^2 x - sin^2 x) dif x = integral (9 - 6 sin x + sin^2 x)/(2 cos^2 x) dif x = 9/2 integral 1/(cos^2 x) dif x - 3 integral (sin x)/(cos^2 x) dif x + 1/2 integral (sin^2 x)/(cos^2 x) dif x =\ = 9/2 tan x - 3/(cos x) + 1/2 integral (1 - cos^2 x)/(cos^2 x) dif x = 9/2 tan x + 3/(cos x) + 1/2 tan x - 1/2 x + C
$

=== c
$
    integral x arctan 1/x dif x "  " (x > 0)\
    integral (x^2/2)' arctan 1/x dif x = x^2/2 arctan 1/x - integral x^2/2 dot 1/(1 + (1/x)^2) dot (-1/x)^2 dif x =\ = x^2/2 arctan 1/x + 1/2 underbrace(integral x^2/(x^2 + 1) dif x, integral (x^2 - 1 + 1)/(x^2 + 1) dif x) = x^2/2 arctan 1/x + 1/2 x - 1/2 arctan x + C
$

== 2
$
    integral 1/(x - 6sqrt(x + 13)) dif x "  " x in (0, +infinity)\
    u = sqrt(x + 13), "  " x = u^2 - 13, "  " x' = 2u\
    integral 1/(u^2 - 6u + 13) dot 2u dif u = integral (2u - 6 + 6)/(u^2 - 6u + 13) dif u = integral (2u - 6)/(u^2 - 6u + 13) dif u + integral 6/(u^2 - 6u + 13) dif u =\ = ln (u^2 - 6u + 13) + 6/4 integral 1/(((u - 3)/2)^2 + 1) = ln(u^2 - 6u + 13) + 3/2 (arctan((u - 3)/2))/(1/2) + C ==>\ ==> ln (x + 13 - 6sqrt(x + 13) + 13) + 3 arctan ((sqrt(x + 13) - 3)/2) + C
$

#pagebreak()
== 3
=== a
$
    y = x^2 - 6x; "  " y = 4x - x^2\
$

=== b
$
    y = sqrt(x); "  " y = sqrt(2x - 1); "  "  y = 0\
    sqrt(x) = sqrt(2x - 1) ==> x = 2x - 1 ==> x = 1\
    integral_0^1 sqrt(x) dif x - integral_(1/2)^1 sqrt(2x - 1) dif x = [(x^3/2)/(3/2)]_0^1 - 1/2 [((2x - 1)^(3/2))/(3/2)]_(1/2)^1 = 2/3 (1^(3/2) - 0^(3/2)) - 1/2 dot 2/3 (1^(3/2) - 0^(3/2)) = 2/3 - 1/3 = 1/3\
    "vagy"\
    H = {(x, y) in RR^2 | 0 <= y <= 1 and y^2 <= x <= (y^2 + 1)/2}\
    T(H) = integral_0^1 ((y^2 + 1)/2 - y^2) dif y = 1/2 integral_0^1 (y^2 + 1 - 2y^2) dif y = 1/2 integral_0^1 (1 - y^2) dif y = 1/2 [y - y^3/3]_0^1 = 1/2 (1 - 1/3) = 1/2 dot 2/3 = 1/3
$

== 4
$
    f(y) = sqrt((4e^(2x) + 13e^x)/(e^(2x) + 3e^x - 10)) "  " x in [ln 3, ln 4]\
    0 <= f and f in C[ln 3, ln 4] and "nevezo nem" 0 ==> f in R[ln 3, ln 4] ==> exists V = pi integral_(ln 3)^(ln 4) f^2(x) dif x\
    pi integral_(ln 3)^(ln 4) (4e^(2x) + 13e^x)/(e^(2x) + 3e^x - 10) dif x\
    u = e^x, "  " x = ln u, "  " x' = 1/u\
    V/pi = integral_3^4 (4u^2 + 13u)/(u^2 + 3u - 10) 1/u dif u = integral_3^4 (4u + 13)/(u^2 + 3u - 10) dif u = integral_3^4 (4u + 13)/((u - 2)(u + 5)) dif u\
    A = 3, " " B = 1\
    integral_3^4 3/(u - 2) + 1/(u + 5) dif u = 3 [ln abs(t - 2)]_3^4 + [ln abs(t + 5)]_3^4 = 3 (ln 3 - ln 1) + (ln 9 - ln 8) = ln 8 + ln 9 - ln 8 = ln 9
$
