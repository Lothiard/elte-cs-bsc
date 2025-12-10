= Analízis II., ZH II. bizonyítandó tételek

== 1. Oszcillációs összegek. Az integrálhatóság jellemzése az oszcillációs összegekkel.
=== Tétel:
$
  f in R[a, b] <==> forall epsilon > 0, " " exists tau in cal(F)[a, b]: Omega(f, tau) < epsilon.
$

=== Bizonyítás:
/ $==>$:
TFH $f in R[a, b]: I_*(f) = I^*(f) =: I(f)$.
$
  sup {s(f, tau) | tau in cal(F)[a, b]} = I_*(f) = I(f) ==> "(a sup def.)" ==> forall epsilon > 0, " " exists tau_1 in cal(F)[a, b]: I(f) - epsilon/2 < s(f, tau_1) <= I(f);\

  inf {S(f, tau) | tau in cal(F)[a, b]} = I^*(f) = I(f) ==> "(az inf def.)" ==> forall epsilon > 0, " " exists tau_2 in cal(F)[a, b]: I(f) <= S(f, tau_2) < I(f) + epsilon/2;
$
Legyen $tau := tau_1 union tau_2 in cal(F)[a, b]$. Ekkor $tau$ finomítása $tau_1, tau_2$-nek, ezért
$
  I(f) - epsilon/2 < s(f, tau_1) <= s(f, tau) <= I_*(f) <= I^*(f) <= S(f, tau) <= S(f, tau_2) <= I(f) + epsilon/2 ==> Omega(f, tau) = S(f, tau) - s(f, tau) < epsilon.
$

/ $<==$:
Legyen $epsilon > 0$ tetszőleges és $tau in cal(F)[a, b]: Omega(f, tau) < epsilon.$\
Mivel $s(f, tau) <= I_*(f) <= I^*(f) <= S(f, tau),$ ezért
$
  0 <= I^*(f) - I_*(f) <= S(f, tau) - s(f, tau) = Omega(f, tau) < epsilon ==>\ ==> 0 <= I^*(f) - I_*(f) < epsilon " " (forall epsilon) > 0 ==>\ ==> I^*(f) - I_*(f) = 0 ==>\ ==> I^*(f) = I_*(f) ==> f in R[a, b].
$
$square$

#pagebreak()
== 2. Az összegfüggvény integrálhatóságára vonatkozó tétel.
=== Tétel:
TFH $f,g in R[a,b]$. Ekkor
$
  f + g in R[a, b] "  és  " integral_a^b (f + g) = integral_a^b f + integral_a^b g
$

=== Bizonyítás:
Legyen $tau = {x_0 = a < x_1 < dots < x_n = b} in cal(F)[a, b]$ és
$
  f_i = inf_([x_(i-1), x_i]) f, "    " F_i = sup_([x_(i-1), x_i]) f,\
  g_i = inf_([x_(i-1), x_i]) g, "    " G_i = sup_([x_(i-1), x_i]) g,
$
Mivel
$
  f_i + g_i <= f(x) + g(x) <= F_i + G_i, " " forall x in [x_(i - 1), x_i],
$
ezért
$
  f_i + g_i <= inf_([x_(i-1), x_i]) (f + g) <= sup_([x_(i-1), x_i]) (f + g) <= F_i + G_i.
$
Ebből $(x_i − x_(i−1))$-gyel való szorzás és összegzés után az adódik, hogy
$
  s(f, tau) + s(g, tau) <= s(f + g, tau) <= S(f + g, tau) <= S(f, tau) + S(g, tau)
$

TFH $tau_1, tau_2 in cal(F)[a,b]$, és legyen $tau = tau_1 union tau_2 in cal(F)[a, b]$. Ekkor
$
  s(f, tau_1) + s(g, tau_2) <= s(f, tau) + s(g, tau) <= s(f + g, tau) <= I_*(f + g)
$
Innen először a $tau_1 in cal(F)[a, b]$, majd a $tau_2 in cal(F)[a, b]$ felosztásokra a bal oldal felső határát véve következik hogy
$
  I_*(f) + I_*(g) <= I_*(f + g).
$
Hasonlóan igazolható, hogy
$
  I^*(f + g) <= I^*(f) + I^*(g).
$
Így
$
  I_*(f) + I_*(g) <= I_*(f + g) <= I^*(f + g) <= I^*(f) + I^*(g)
$
Mivel
$
  f, g in R[a, b], " ezért " I_*(f) = I^*(f) = integral_a^b f
$ és
$
  I_*(g) = I^*(g) = integral_a^b g, " ezért " I_*(f + g) = I^*(f + g), " tehát " f + g in R[a, b] " és " integral_a^b (f + g) = integral_a^b f + integral_a^b g
$

#pagebreak()
== 3. A szorzatfüggvény integrálhatóságára vonatkozó tétel.
=== Tétel:
TFH $f,g in R[a,b]$. Ekkor
$
  f dot g in R[a, b]
$

=== Bizonyítás:
/ 1: TFH $f, g >= 0, tau = {a = x_0 < x_1 < dots < x_n} in cal(F)[a, b]$
$
  f_i = inf_([x_(i-1), x_i]) f, "    " F_i = sup_([x_(i-1), x_i]) f,\
  g_i = inf_([x_(i-1), x_i]) g, "    " G_i = sup_([x_(i-1), x_i]) f,
$
$
    f_i dot g_i <= f(x) dot g(x) <= F_i dot G_i, "  " forall x in [x_(i - 1), x_i] ==>\ ==> f_i dot g_i <= inf_([x_(i-1), x_i]) f dot g <= sup_([x_(i-1), x_i]) f dot g <= F_i dot G_i, "  " forall x in [x_(i - 1), x_i] ==>\ ==>
    Omega(f dot g, tau) = S(f dot g, tau) - s(f dot g, tau) =\ = sum_(i = 1)^n (sup_([x_(i-1), x_i]) f dot g - inf_([x_(i-1), x_i]) f dot g) dot (x_i - x_(i - 1)) <= sum_(i = 1)^n (F_i dot G_i - f_i dot g_i) dot (x_i - x_(i - 1))
$
Mivel $f$ és $g$ korlátos, ezért $exists M: abs(f), abs(g) <= M$ $[a, b]$-n. Így
$
    Omega(f dot g, tau) <= sum_(i = 1)^n [F_i dot (G_i - g_i) + (F_i - f_i) dot g_i] dot (x_i - x_(i - 1)) <= M dot sum_(i = 1)^n (G_i - g_i) dot (x_i - x_(i - 1)) + M dot sum_(i = 1)^n (F_i - f_i) dot (x_i - x_(i - 1)) =\ =M dot (Omega(g, tau) + Omega(f, tau)).
$
Mivel $f, g in R[a, b]$, ezért $forall epsilon > 0$-hoz $exists tau : Omega(f, tau), Omega(g, tau) < epsilon$.\
Tehát $forall epsilon > 0"-hoz" exists tau in cal(F)[a, b]$ felosztás:
$
    Omega(f dot g, tau) <= 2 dot M dot epsilon ==> f dot g in R[a, b]
$

/ 2: TFH $f, g$ tetszőleges, és legyen
$
    m_f := inf_[a, b] f, "  " m_g := inf_[a, b] g.
$
Ekkor $f - m_f >= 0$ és $g - m_g >= 0$ $[a, b]$-n integrálható függvények.\
Tehát (1.) szerint
$
    (f - m_f) dot (g - m_g) = f dot g underbrace(- m_f dot g - f dot m_g + m_f dot m_g, in R[a, b]) in R[a, b],
$
Valóban $f dot g in R[a, b]$.
$square$

#pagebreak()
== 4. Függvények hányadosának integrálhatóságára vonatkozó tétel.
=== Tétel:
TFH $f,g in R[a,b]$. Ha $abs(g(x)) >= m > 0 " " (forall x in [a, b])$, akkor
$
    f/g in R[a, b]
$

=== Bizonyítás:
Elég igazolni hogy $1/g in R[a, b]$

Legyen
$
    g_i = inf_([x_(i-1), x_i]) g, "    " G_i = sup_([x_(i-1), x_i]) g,
$
és $tau = {a = x_0 < x_1 < dots < x_n = b} in cal(F)[a, b]$ tetszőleges.\
Ekkor $forall x, y in [x_(i - 1), x_i]$ pontban
$
    1/(g(x)) - 1/(g(y)) = (g(y) - g(x))/(g(x) dot g(y)) <= (abs(g(y) - g(x)))/(abs(g(x) dot g(y))) <= (G_i - g_i)/(m^2)
$
Ebből következik, hogy
$
    sup_([x_(i - 1), x_i]) 1/g - inf_([x_(i - 1), x_i]) 1/g <= (G_i - g_i)/(m^2)
$
$(x_i - x_(i - 1))$-gyel való szorzás és összegzés után azt kapjuk, hogy
$
    Omega(1/g, tau) <= 1/m^2 dot Omega(g, tau)
$
Mivel $g in R[a, b]$, ezért $forall epsilon > 0$-hoz $exists tau: Omega(g, tau) < epsilon$. Így
$
    Omega(1/g, tau) < epsilon/m^2 ==> 1/g in R[a, b]
$
$square$

#pagebreak()
== 5. A monoton függvények integrálhatóságára vonatkozó tétel.
=== Tétel:
Ha az $f: [a, b] arrow RR$ függvény monoton az $[a, b]$ intervallumon, akkor integrálható $[a, b]$-n

=== Bizonyítás:
Igazoljuk hogy
$
    forall epsilon > 0 " " exists tau in cal(F)[a, b]: Omega(f, tau) < epsilon
$
Legyen pl. $f arrow.tr$. Ha $f(a) = f(b)$, akkor $f$ állandó, ezért ebben az esetben az állítás igaz.

Ha $f(a) < f(b)$, akkor $forall tau = {a = x_0 < dots < x_n = b} in cal(F)[a, b]$ felosztásra 
$
    m_i = inf_([x_(i - 1), x_i]) f = f(x_(i - 1)) " és " M_i = sup_([x_(i - 1), x_i]) f = f(x_i)
$
ezért
$
    Omega(f, tau) = S(f, tau) - s(f, tau) = sum_(i = 1)^n (f(x_i) - f(x_(i - 1))) dot (x_i - x_(i - 1))
$
Legyen $epsilon > 0$ adott és $n in NN^+: (b - a)/n < epsilon/(f(b) - f(a))$, valamint $tau$ az $[a, b]$ egyenletes felosztása. Ekkor $x_i - x_(i - 1) < epsilon/(f(b) - f(a))$ minden $i = 1, dots, n$ indexre, és
$
    Omega(f, tau) < sum_(i = 1)^n (f(x_i) - f(x_(i - 1))) dot epsilon/(f(b) - f(a)) =\ = epsilon/(f(b) - f(a)) dot ((cancel(f(x_1)) - underbrace(f(x_0), f(a))) + (cancel(f(x_2)) - cancel(f(x_1))) + dots + (underbrace(f(x_n), f(b)) - cancel(f(x_(n - 1))))) = epsilon ==> f in R[a, b]
$
$square$

#pagebreak()
== 6. Az egyenletes folytonosságra vonatkozó Heine-tétel.
=== Tétel:
Ha $-infinity < a < b < +infinity$ és $f in C[a, b]$, akkor $f$ egyenletesen folytonos $[a, b]$ intervallumon.

=== Bizonyítás:
TFH $f$ nem egyenletesen folytonos $[a, b]$-n
$
    exists epsilon > 0, " " forall delta > 0, " " exists x, y in [a, b], abs(x - y) < delta: abs(f(x) - f(y)) >= epsilon
$
$delta := 1/n " " (n in NN^+)$ választással
$
    forall n in NN^+, " " exists x_n, y_n in [a, b]: abs(x_n - y_n) < 1/n " és " underbrace(abs(f(x_n) - f(y_n)) >= epsilon, (*))
$
Az $(x_n)$ sorozat korlátos, ezért van egy $(x_n_k)$ konvergens részsorozata, amelynek az $alpha$ határértéke ugyancsak $[a, b]$-ben van. Így
$
    y_n_k = (y_n_k - x_n_k) + x_n_k arrow 0 + alpha = alpha, " ha " n_k arrow +infinity
$
Mivel $f in C[a, b]$, ezért $f in C{alpha}$ is teljesül. Az átviteli elv szerint tehát $f(x_n_k) arrow f(alpha)$ és $f(y_n_k) arrow f(alpha)$, ezért
$
    lim_(n_k arrow +infinity) (f(x_n_k) - f(y_n_k)) = 0
$
Ez azonban ellentmond $(*)$-nak.\
$square$

#pagebreak()
== 7. A folytonos függvények integrálhatóságára vonatkozó tétel.
=== Tétel:
Ha az $f$ függvény folytonos az $[a, b]$ intervallumon, akkor integrálható $[a, b]$-n. $(C[a, b] subset R[a, b])$

=== Bizonyítás:
Elég:
$
    forall f in C[a, b]: forall epsilon > 0, exists tau in cal(F)[a, b]: Omega(f, tau) < epsilon.
$
Mivel $f in C[a, b] ==>$ (l. Heine-tételét) $f$ egyenletesen folytonos az $[a, b]$ intervallumon,\ ezért $forall epsilon > 0, exists delta > 0$, hogy
$
    forall x, y in [a, b], abs(x - y) < delta: abs(f(x) - f(y)) < epsilon/(b - a)
$
Legyen
$
    epsilon > 0 " és " tau = {x_0 = a < x_1 < dots < x_n = b} in cal(F)[a, b]: norm(tau) = max{x_i - x_(i - 1) | i = 1, dots, n} < delta
$
Ekkor $Omega(f, tau)$-ban $i = 1, dots, n$ esetén legyen
$
    m_i := min_([x_(i - 1), x_i]) f = f(u_i), "  " M_i := max_([x_(i - 1), x_i]) f = f(v_i)
$
Ekkor
$
    Omega(f, tau) = sum_(i = 1)^n (M_i - m_i) dot (x_i - x_(i - 1)) <= epsilon/(b - a) dot sum_(i = 1)^n (x_i - x_(i - 1)) = epsilon ==> f in R[a, b]
$
$square$

#pagebreak()
== 8. A Newton–Leibniz-tétel.
=== Tétel:
Ha $f in R[a, b]$ és a $f$ függvénynek van primitív függvénye az [a, b] intervallumon, akkor
$
    integral_a^b f(x) dif x = F(b) - F(a) =: [F(x)]_a^b
$
ahol $F$ a $f$ függvény egy (tetszőleges) primitív függvénye

=== Bizonyítás:
Legyen $tau = {a = x_0 < x_1 < dots < x_n = b} in cal(F)[a, b]$ tetszőleges. A Lagrange-középértéktétel szerint $forall i = 1, dots, n$ indexre $exists xi in (x_(i-1), x_i):$
$
    F(x_i) - F(x_(i - 1)) = F'(xi_i) dot (x_i - x_(i - 1)) = f(xi_i) dot (x_i - x_(i - 1))
$
Összeadva $forall i = 1, dots, n$ indexre:
$
    F(b) - F(a) = sum_(i = 1)^n f(xi_i) dot (x_i - x_(i - 1)) = sigma(f, tau, xi),
$
ahol $xi := (xi_1, dots, xi_n)$. Mivel $inf_([x_(i - 1), x_i]) f <= f(xi_i) <= sup_([x_(i - 1), x_i]) f$, ezért
$
    s(f, tau) <= sigma(f, tau, xi) = F(b) - F(a) <= S(f, tau, xi)
$
Következésképpen
$
    I_*(f) = sup_(tau in cal(F)[a, b]) s(f, tau) <= F(b) - F(a) <= inf_(tau in cal(F)[a, b]) S(f, tau, xi) = I^*(f)
$
Mivel $f in R[a, b]$, ezért $I_*(f) = I^*(f) = integral_a^b f$. Így
$
    F(b) - F(a) = integral_a^b f(x) dif x.
$
$square$

#pagebreak()
== 9. Az integrálfüggvény folytonosságára vonatkozó állı́tás.
=== Tétel:
TFH $f in R[a, b]$ és $x_0 in [a, b]$. Ekkor a
$
    F(x) = integral^x_x_0 f(t) dif t "  " (x in [a, b])
$
Ekkor az $F$ függvény folytonos az $[a, b]$ intervallumon.

=== Bizonyítás:
Tetszőleges $x, y in [a, b], x < y$ esetén
$
    abs(F(y) - F(x)) = abs(integral^y_x_0 f - integral^x_x_0 f) = abs(integral^y_x_0 f - integral^(x_0)_x f) = abs(integral_x^y f) <= integral_x^y abs(f) <= M dot integral_x^y 1 = M dot (y - x),
$
ahol $M$ az $f$ függvény egy korlátja: $abs(f(x)) <= M$ $(x in [a, b])$\
Ha tehát $epsilon > 0, delta > 0: M delta < epsilon$, akkor $forall x, y in [a, b], abs(x - y) < delta$ esetén
$
    abs(F(y) - F(x)) < M dot epsilon/M = epsilon
$
$square$

#pagebreak()
== 10. Az integrálfüggvény differenciálhatóságára vonatkozó állı́tás.
=== Tétel:
TFH $f in R[a, b]$ és $x_0 in [a, b]$. Ekkor a
$
    F(x) = integral^x_x_0 f(t) dif t "  " (x in [a, b])
$
Ha egy $d in [a, b]$ pontban $f$ folytonos, akkor ott a $F$ integrálfüggvény deriválható, és $F'(d) = f(d)$

=== Bizonyítás:
Legyen $d in (a, b)$, és TFH $f in C{d}$. Ez azt jeleni, hogy $forall epsilon > 0, exists delta > 0:$
$
    forall t in [a, b], abs(t - d) < delta: abs(f(t) - f(d)) < epsilon
$
TFH $h$-ra $d + h in (a, b)$ teljesül. Ekkor
$
    F(d + h) - F(d) = integral_(x_0)^(d + h) f - integral_(x_0)^d f = integral_d^(d + h) f
$
Mivel $f(d) = 1/h dot integral_d^(d + h) f(d) dif t$, ezért
$
    (F(d + h) - F(d))/h - f(d) = 1/h integral_d^(d + h) (f(t) - f(d)) dif t
$
Ha $0 < h < delta$, akkor
$
    abs((F(d + h) - F(d))/h - f(d)) < 1/h dot integral_d^(d + h) abs(f(t) - f(d)) dif t < 1/h dot integral_d^(d + h) epsilon dif t = 1/h dot epsilon dot h
$
Ha $-delta < h < 0$, akkor
$
    abs((F(d + h) - F(d))/h - f(d)) <= 1/abs(h) dot integral_(d + h)^d abs(f(t) - f(d)) dif t < epsilon
$
Ezek alapján $forall epsilon > 0, exists delta > 0: forall abs(h) < delta$-ra
$
    abs((F(d + h) - F(d))/h - f(d)) < epsilon
$
Ez azt jelenti, hogy
$
    lim_(h arrow 0) ((F(d + h) - F(d))/h - f(d)) = 0 ==> lim_(h arrow 0) ((F(d + h) - F(d))/h) = f(d)
$
vagyis $F in D{d}$ és $F'(d) = f(d)$\
$square$

#pagebreak()
== 11. A parciális integrálásra vonatkozó tétel határozott integrálra.
=== Tétel:
TFH $f, g: [a, b] arrow RR, "  " f,g in D[a, b], "  " f', g' in R[a, b]$
Ekkor
$
    integral_a^b f g' = f(b)g(b) - f(a)g(a) - integral_a^b f'g
$

=== Bizonyítás:
Egyrészt
$
    f in D[a, b] ==> f in C[a, b] ==> f in R[a, b]
$
Mivel $g' in R[a, b]$, ezért $f g' in R[a, b] " és " f'g in R[a, b]$. Így $f'g + f g' in R[a, b]$\
Másrészt $f g$ primitív függvénye az $f'g + f g'$ függvénynek\
A Newton-Leibniz-tétel szerint tehát
$
    integral_a^b (f g' + f' g) = [f g]_a^b = f(b)g(b) - f(a)g(a)
$
A határozott integrál additivitását felhasználva rendezés után azt kapjuk, hogy
$
    integral_a^b f g' = [f g]_a^b - integral_a^b f'g
$
$square$

#pagebreak()
== 12. A helyettesı́téses integrálás szabálya határozott integrálra.
=== Tétel:
TFH $f in C[a, b] " és " g:[alpha, beta] arrow [a, b]$ függvény folytonosan deriválható. Ekkor
$
    integral_(g(alpha))^(g(beta)) f = integral_alpha^beta f circle.small g dot g' .
$

=== Bizonyítás:
Tekintsük:
$
    F(x) := integral_(g(alpha))^x f "  " (x in [a, b]), "    " G(u) := integral_alpha^u f circle.small g dot g' "  " (x in [alpha, beta])
$
integrálfüggvényeket. Megmutatjuk, hogy
$
    (*) "    " integral_(g(alpha))^(g(beta)) f = F(g(beta)) = G(beta) = integral_alpha^beta f circle.small g dot g'
$
Egyrészt $f in C[a, b] ==> F' = f$, másrészt $f circle.small g dot g' in C[alpha, beta] ==> G' = f circle.small g dot g'$

Mivel $(F circle.small g)' = F' circle.small g dot g' = f circle.small g dot g'$, ezért $(F circle.small g - G)' = 0 ==> exists c in RR: F circle.small g - G = c$. Ugyanakkor $F(g(alpha)) = 0 = G(alpha) ==> c = 0$, következésképpen $F circle.small g = G ==> F(g(beta)) = G(beta)$\
$(*)$ valóban teljesül.\
$square$

