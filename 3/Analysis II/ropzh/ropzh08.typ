= Milyen viszony van az alsó és a felső közelı́tő összegek között?
egy felosztás finomításakor az alsó közelítő összeg nem csökkenhet, a felső közelítő összeg pedig nem nőhet.

= Mi a Darboux-féle alsó integrál definı́ciója?
Legyen $f in K[a, b]$.

Az ${s(f, tau) | tau in cal(F)[a, b]} = nothing$ halmaz felülről korlátos, ezért\ $ exists sup{s(f, tau) | tau in cal(F)[a,b]} =: I_*(f) in RR $

= Mi a Darboux-féle felső integrál definı́ciója?
Legyen $f in K[a, b]$.

Az ${S(f, tau) | tau in cal(F)[a, b]} = nothing$ halmaz alulról korlátos, ezért\ $ exists inf{S(f, tau) | tau in cal(F)[a,b]} =: I^*(f) in RR $

= Mikor nevez egy függvényt (Riemann)-integrálhatónak?
AMH az $f in K[a, b]$ függvény Riemann-integrálható az $[a, b]$ intervallumon (röviden integrálható $[a, b]$-n), ha $I_∗(f) = I^∗(f).$

= Hogyan értelmezi egy függvény határozott (vagy Riemann-) integrálját?
Ha $I_∗(f) = I^∗(f)$ akkor ezt a számot az $f$ függvény $[a, b]$ intervallumon vett Riemann-integráljának (vagy más szóval határozott integráljának) nevezzük, és így jelöljük:
$
  integral_a^b f " vagy " integral_a^b f(x) dif x
$

= Adjon meg egy példát nem integrálható függvényre!
$
  f(x) := cases(
    0\, & "ha x in [0, 1]" inter QQ,
    1\, & "ha x in [0, 1]" inter (RR without QQ),
  )
$

= Mi az oszcillációs összeg definı́ciója?
Ha $f in K[a, b]$ és $tau in cal(F)[a, b]$, akkor
$
  Omega(f, tau) := S(f, tau) - s(f, tau)
$

= Hogyan szól a Riemann-integrálhatósággal kapcsolatban tanult kritérium az oszcillációs összegekkel megfogalmazva?
$
  f in R[a, b] <==> forall epsilon > 0, " " exists tau in cal(F)[a, b]: Omega(f, tau) < epsilon.
$

