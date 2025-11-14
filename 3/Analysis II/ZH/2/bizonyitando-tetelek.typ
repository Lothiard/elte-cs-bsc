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
  0 <= I^*(f) - I_*(f) <= S(f, tau) - s(f, tau) = Omega(f, tau) < epsilon ==>\ ==> 0 <= I^*(f) - I_*(f) < epsilon " " forall epsilon > 0 ==>\ ==> I^*(f) - I_*(f) = 0 ==>\ ==> I^*(f) = I_*(f) ==> f in R[a, b].
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
  g_i = inf_([x_(i-1), x_i]) g, "    " G_i = sup_([x_(i-1), x_i]) f,
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
  I_*(g) = I^*(g) = integral_a^b g, " ezért " I_*(f + g) = I^*(f + g), " tehát " f + g in R[a, b] " és " integral_a^b (f + g) = integral_a^b f + integral_a^b 
$

#pagebreak()
== 3. A szorzatfüggvény integrálhatóságára vonatkozó tétel.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 4. Függvények hányadosának integrálhatóságára vonatkozó tétel.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 5. A monoton függvények integrálhatóságára vonatkozó tétel.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 6. Az egyenletes folytonosságra vonatkozó Heine-tétel.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 7. A folytonos függvények integrálhatóságára vonatkozó tétel.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 8. A Newton–Leibniz-tétel.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 9. Az integrálfüggvény folytonosságára vonatkozó állı́tás.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 10. Az integrálfüggvény differenciálhatóságára vonatkozó állı́tás.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 11. A parciális integrálásra vonatkozó tétel határozott integrálra.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 12. A helyettesı́téses integrálás szabálya határozott integrálra.
=== Tétel:

=== Bizonyítás:


