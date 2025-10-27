== Fogalmazza meg a primitív függvényekkel kapcsolatos második helyettesı́tési szabályt!
TFH $I, J subset RR$ nyílt intervallumok,\ $f: I arrow RR, g: J arrow I$ bijekció,\ $g in D(J),\ g'(x) != 0 " " (forall x in J)$\ és az $f circle.small g dot g': J arrow RR$ függvényeknek van primitív függvénye.\ Ekkor az $f$ függvénynek is van primitív függvénye és
$
  integral f(x) dif x =_(x = g(t)) integral f(g(t)) dot g'(t) dif t_(| t = g^(-1)(x)) "  " (x in I)
$

== Fogalmazza meg a primitív függvény létezésére vonatkozó szükséges feltételt!
Ha $I subset RR$ nyílt intervallum és a $f: I arrow RR$ függvényeknek van primitív függvénye, akkor $f$ Darboux-tulajdonságú az $I$ intervallumon.

== Fogalmazza meg a primitív függvény létezésére vonatkozó elégséges feltételt!
Ha $I subset RR$ nyílt intervallum és a $f: I arrow RR$ folytonos függvény, akkor $f$-nek van primitív függvénye.

== Definiálja intervallum egy felosztását!
Az $[a ,b]$ intervallum egy felosztásán a
$
  tau := {a = x_0 < x_1 < x_2 < dots < x_n = b}
$
halmazt értjük, ahol $n in NN^+$.

== Mit jelent egy felosztás finomítása?
Ha $tau_1, tau_2 in cal(F)[a, b]$ és $tau_1 subset tau_2$, akkor AMH $tau_2$ egy finomítása $tau_1$-nek.

== Mi az alsó közelítő összeg definı́ciója?
Legyen $f in K[a, b], tau in cal(F)[a, b]$, továbbá
$
  m_i := inf{f(x) | x_(i - 1) <= x <= x_i} = inf_([x_(i - 1), x_i]) f,\
$
minden $i = 1,2,dots,n$ indexre. A
$
  s(f, tau) := sum_(i = 1)^n m_i (x_i - x_(i - 1)),\
$
számot az $f$ függvény $tau$ felosztásához tartozó alsó közelítő összegének nevezzük.

#pagebreak()
== Mi a felső közelítő összeg definı́ciója?
Legyen $f in K[a, b], tau in cal(F)[a, b]$, továbbá
$
  M_i := sup{f(x) | x_(i - 1) <= x <= x_i} = sup_([x_(i - 1), x_i]) f,\
$
minden $i = 1,2,dots,n$ indexre. A
$
  S(f, tau) := sum_(i = 1)^n M_i (x_i - x_(i - 1)),\
$
számot az $f$ függvény $tau$ felosztásához tartozó felső közelítő összegének nevezzük.

== Mi történik egy alsó közelítő összeggel, ha a neki megfelelő felosztást finomítjuk ?
Legyen $f in K[a, b]$, és TFH $tau_1, tau_2 in cal(f)[a,b]$. Ekkor ha $tau_2$ finomabb $tau_1$-nél (azaz $tau_1 subset tau_2$), akkor
$
  s(f, tau_1) <= s(f, tau_2) "  és  " S(f, tau_1) >= S(f, tau_2)
$
azaz egy felosztás finomításakor az alsó közelítő összeg nem csökkenhet.

== Mi történik egy felső közelítő összeggel, ha a neki megfelelő felosztást finomítjuk ?
Legyen $f in K[a, b]$, és TFH $tau_1, tau_2 in cal(f)[a,b]$. Ekkor ha $tau_2$ finomabb $tau_1$-nél (azaz $tau_1 subset tau_2$), akkor
$
  s(f, tau_1) <= s(f, tau_2) "  és  " S(f, tau_1) >= S(f, tau_2)
$
azaz egy felosztás finomításakor a felső közelítő összeg nem nőhet.
