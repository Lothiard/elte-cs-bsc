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
== 2.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 3.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 4.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 5.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 6.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 7.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 8.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 9.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 10.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 11.
=== Tétel:

=== Bizonyítás:

#pagebreak()
== 12.
=== Tétel:

=== Bizonyítás:

