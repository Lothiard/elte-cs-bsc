1. Irja fel az $exp,ln,sin,cos,tg,a^x " " (a > 0, x in bb(R))$ fuggvenyek derivaltfuggvenyet.

$ exp' = exp $
$ ln' = 1/x $
$ sin' = cos $
$ cos' = -sin $
$ tg' = 1/cos^2 $
$ a^x = a^x ln a $

\
2. Milyen ekvivalens atfogalmazast ismer a pontbeli derivalhatosagra lineris kozelitessel?

legyen $f in bb(R) arrow bb(R), a in "int"D_f.$ Ekkor:
$ f in D{a} <==> exists A in bb(R) " es " exists epsilon in D_f arrow bb(R), limits(lim)_a epsilon = 0: f(x) - f(a) = A(x - a) + epsilon(x)(x - a) " " (x in D_f), " es " A = f'(a) $

\
3. Mi az erinto definicioja?
Az $f in bb(R) arrow bb(R)$ fuggveny grafikonjanak az $(a, f(a))$ pontban van erintoje, ha $f in D{a}$.

Az f grafikonjanak $(a, f(a))$ pontbeli erintojen az
$ y = f'(a) dot (x - a) + f(a) $
egyenletu egyenest ertjuk.

\
4. Irja le az inverz fuggveny differencialhatosagarol szolo tetelt!

Legyen $I subset bb(R)$ nyilt intervalllum, es $f: I arrow bb(R)$

TFH
- (a) $f$ szigoruan monoton es folytonos $I$-n
- (b) egy $a in I$ pontban $f in D{a}$ es $f'(a) != 0$

Ekkor az $f^(-1)$ inverz fuggveny derivalhato a $b := f(a)$ pontban, es
$ (f^(-1))'(b) = 1/(f'(a)) = 1/(f'(f^(-1)(b))) $

\
5. Defininalja a jobb oldali derivalt fogalmat!
Legyen $f in bb(R) arrow bb(R), a in D_f$

TFH $exists delta > 0: [a, a + delta) subset D_f$

AMH $f$ az $a$ pontban jobbrol derivalhato, ha

$ exists " es veges a " limits(lim)_(x arrow a+0)(f(x) - f(a))/(x - a) "hatarertek" $

Ezt az $f$ fuggveny $a$ pontbeli jobb oldali derivaltjanak nevezzuk, es $f'_+(a)$-val jeloljuk.

\
6. Defininalja a bal oldali derivalt fogalmat!
Legyen $f in bb(R) arrow bb(R), a in D_f$

TFH $exists delta > 0: (a - delta, a] subset D_f$

AMH $f$ az $a$ pontban balrol derivalhato, ha

$ exists " es veges a " limits(lim)_(x arrow a-0)(f(x) - f(a))/(x - a) "hatarertek" $

Ezt az $f$ fuggveny $a$ pontbeli bal oldali derivaltjanak nevezzuk, es $f'_-(a)$-val jeloljuk.

\
7. Mikor mondjuk azt hogy egy fuggveny ketszer derivalhato egy pontban?
Legyen $f in bb(R) arrow bb(R), a in "int"D_f$

AKM $f$ ketszer derivalhato az $a in "int"D_f$ pontban (jelolese: $f in D^2{a}$), ha
- a fuggveny derivalhato az $a in "int"D_f$ pont egy kornyezeteben, azaz $exists r > 0: f in D(K_r(a))$ es
- az $f'$ derivaltfuggveny derivalhato $a$-ban, azaz $f'(a) in D{a}$.

Legyen ekkor
$ f''(a) := (f')'(a) $
az $f$ masodik $a$ pontbeli masodik derivaltja

\
8. Mondja ki a Rolle-tetelt!
Legyen $a,b in bb(R) "es" a < b$. Ekkor
#set math.cases(reverse: true)
$
    cases(
        f in C[a,b],
        f in D(a,b),
        f(a) = f(b),
    ) ==> exists xi in (a,b), "hogy" f'(xi) = 0.
$

\
9. Mondja ki a Lagrange-fele kozepertektetelt!
Legyen $a,b in bb(R) "es" a < b$. Ekkor
$
    cases(
        f in C[a,b],
        f in D(a,b),
    ) ==> exists xi in (a,b), "hogy" f'(xi) = (f(b) - f(a))/(b-a)
$

\
10. Mondja ki a Cauchy-fele kozepertektetelt!
Legyen $a,b in bb(R) "es" a < b$. Ekkor
$
    cases(
        f\, g in C[a,b],
        f\, g in D(a,b),
        forall x in (a,b): g'(x) != 0

    ) ==> exists xi in (a,b), "hogy" (f'(xi))/(g'(xi)) = (f(b) - f(a))/(g(b) - g(a))
$
