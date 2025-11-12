= 1
$
    integral sin^3 x dif x = integral sin x dot sin^2 x dif x = integral sin x dot (1 - cos^2 x) dif x = integral sin x - sin x cos^2 x dif x = integral sin x dif x - integral sin x cos^2 x dif x =\ = -cos x + C + integral (cos x)' cos^2 x dif x = -cos x + (cos^3 x)/3 + C
$

= 2
$
    integral cos^4 x dif x = integral (cos^2 x)^2 dif x = integral ((1 - cos(2x))/2)^2 dif x = 1/4 integral (1 - 2cos(2x) + cos^2(2x)) dif x =\ = 1/4[integral 1 dif x - integral 2cos(2x) dif x + integral (1 - cos(4x))/2 dif x] =\ = 1/4 x + C + 1/4 [ 2 dot (sin (2x))/2 + C + 1/2 integral 1 dif x - 1/2 integral cos(4x) dif x] =\ = x/4 + sin(2x)/4 + x/8 + 1/4(sin(4x))/8 + C =  3/8 x + (sin(2x))/4 + (sin(4x))/32 + C
$

= 3
$
    integral (cos^3 x)/(sqrt(sin^5 x)) dif x = integral cos^3 x dot (sin^5 x)^(-1/2) dif x = integral cos^3 x dot sin^(-5/2) x dif x = integral cos^2 x dot sin^(-5/2) x dot cos x dif x =\ = integral (1 - sin^2 x) dot sin^(-5/2) x dot cos x dif x = integral (sin^(-5/2) x - sin^(-1/2) x) cos x dif x = integral sin^(-5/2) x cos x dif x - integral sin^(-1/2) x cos x dif x =\ = integral sin^(-5/2) x (sin x)' dif x - integral sin^(-1/2) x (sin x)' dif x = (sin^(-3/2) x)/(-3/2) - (sin^(1/2) x)/(1/2) + C = -(2)/(3 sqrt(sin^3 x)) - 2 sqrt(sin x) + C
$

= 4
$
    integral 1/((x^2 + 1) arctan^2 x) dif x = integral (arctan x)' dot arctan^(-2) x dif x = (arctan^(-1))/(-1) + C = -1/(arctan x) + C
$

= 5
$
    integral (x^2 - 3x)e^(3x) dif x = integral (x^2 - 3x) dot ((e^(3x))/3)' dif x = (x^2 - 3x) dot (e^(3x))/3 - integral (x^2 - 3x) dot (e^(3x))/3 dif x =\ = 1/3 (x^2 - 3x)e^(3x) - integral (2x - 3) dot (e^(3x))/3 dif x,\ \

    integral (2x - 3) dot (e^(3x))/3 dif x = integral (2x - 3) dot ((e^(3x))/(9))' dif x =\ = (2x - 3) dot (e^(3x))/9 - integral (2e^(3x))/9 dif x = (2x - 3) dot (e^(3x))/9 - 2/9 dot (e^(3x))/3 = ((6x - 11) e^(3x))/9 + C,\ \

    1/3 (x^2 - 3x)e^(3x) - ((6x - 11) e^(3x))/9 + C = (3(x^2 - 3x) e^(3x))/9 - ((6x - 11) e^(3x))/9 + C = "inkabb nem"
$

= 6
$
    integral (x^2 + 1) dot cos (2x) dif x = integral (x^2 + 1) dot ((sin(2x))/2)' dif x = (x^2 + 1) dot cos (2x) - integral (2x sin (2x))/2 dif x =\ = (x^2 + 1) dot cos(2x) - [(x cos (2x))/2 - integral - (cos (2x))/2 dif x] =\ =
    (x^2 + 1) dot cos(2x) - (x cos (2x))/2 + 1/2
$

= 7
$
    integral arcsin (2x) dif x
$

= 8
$
    integral (arcsin x)^2 dif x =_(u = arcsin(x))
$

= 9
$
    integral e^(-x) dot cos 5x dif x = integral (-e^(-x))' dot cos 5x dif x =\ = -e^(-x) dot cos 5x - integral e^(-x) dot 5 sin(5x) dif x =\ = -e^(-x) dot cos 5x - (-e^(-x) dot 5 sin 5x - integral - e^(-x) dot 25 cos 5x dif x) =\ = -e^(-x) dot cos 5x - (-e^(-x) dot 5 sin 5x + 25 integral e^(-x) cos 5x dif x) ==>\ ==> (5e^(-x) sin(5x) - e^(-x) dot cos(5x))/26 + C = (e^(-x)(5 sin(5x) - cos(5x)))/26 + C
$
