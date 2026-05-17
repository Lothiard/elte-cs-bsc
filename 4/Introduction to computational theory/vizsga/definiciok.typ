#set page(numbering: "1")
#set heading(numbering: "1.1.")

= Bevezetés a számításelméletbe - Teljes vizsgaösszefoglaló

== Alapfogalmak: Szavak és Nyelvek
- *Ábécé*: Véges, nemüres halmaz ($V$), elemei a betűk.
- *Szó*: Az ábécé elemeiből képzett véges sorozat. Az üres szó jele $epsilon$, hossza $|epsilon| = 0$.
- *Konkatenáció*: Két szó, $u = s_1 dots s_n$ és $v = t_1 dots t_k$ egymás után írása ($u v$). $|u v| = |u| + |v|$. Egységeleme $epsilon$. Asszociatív, de nem kommutatív.
- *Hatványozás*: $u^0 = epsilon, u^i = u u^{i-1}$.
- *Tükörkép*: $u^R$ (vagy $u^(-1)$). Ha $u = a_1 dots a_n$, akkor $u^R = a_n dots a_1$. Tulajdonság: $(u v)^R = v^R u^R$.
- *Palindróma*: Olyan szó, amelyre $u = u^R$.
- *Részszó*: $u$ részszava $v$-nek, ha $v = x u y$. Ha $x = epsilon$, akkor *prefix*, ha $y = epsilon$, akkor *suffix*.
- *Nyelv*: Az ábécé feletti összes szó halmazának ($V^*$) tetszőleges részhalmaza ($L subset V^*$).
- *Műveletek nyelveken*: Unió ($L_1 union L_2$), metszet ($L_1 inter L_2$), különbség ($L_1 minus L_2$), konkatenáció ($L_1 L_2 = {u v | u in L_1, v in L_2}$), Kleene-lezárt ($L^* = union_(i >= 0) L^i$), pozitív lezárt ($L^+ = union_(i >= 1) L^i$).
- *Homomorfizmus*: Olyan $h: V_1^* arrow V_2^*$ leképezés, amelyre $h(u v) = h(u)h(v)$ és $h(epsilon) = epsilon$.

== Grammatikák és a Chomsky-hierarchia
A grammatika egy $G = (N, T, S, R)$ négyes, ahol $N$ a nemterminálisok, $T$ a terminálisok halmaza, $S in N$ a kezdőszimbólum, $R$ pedig a szabályok halmaza ($u arrow v$, ahol $u$ tartalmaz legalább egy nemterminálist).

- *Levezetés*: $alpha arrow_G beta$, ha $alpha = u x v$ és $beta = u y v$, ahol $x arrow y in R$. $arrow^*$ a reflexív, tranzitív lezárt.
- *Generált nyelv*: $L(G) = {w in T^* | S arrow^* w}$.
- *Osztályozás*:
  - *0-típusú (mondatszerkezetű)*: Nincs korlátozás.
  - *1-típusú (környezetfüggő)*: $u_1 A u_2 arrow u_1 v u_2$, ahol $v != epsilon$. Kivétel: $S arrow epsilon$ lehet, ha $S$ nem szerepel jobb oldalon.
  - *2-típusú (környezetfüggetlen)*: $A arrow v$, ahol $A in N$.
  - *3-típusú (reguláris)*: $A arrow u B$ vagy $A arrow u$ (jobb-lineáris).

== Véges automaták és reguláris nyelvek
- *VDA (Determinisztikus)*: $A = (Q, T, delta, q_0, F)$. $delta$ mindenütt értelmezett egyértelmű függvény. Elfogadott nyelv: $L(A) = {w in T^* | delta(q_0, w) in F}$.
- *VNDA (Nemdeterminisztikus)*: $delta: Q times T arrow P(Q)$. Több kezdőállapot és $epsilon$-átmenet is megengedett. Egy szót akkor fogad el, ha *létezik* legalább egy elfogadó számítás.
- *Determinizálás (Részhalmaz-konstrukció)*:
  *Bizonyítás vázlat:* Minden $A$ VNDA-hoz készíthető $A'$ VDA, ahol $Q' = P(Q)$, $q_0' = Q_0$, $F' = {S subset Q | S inter F != emptyset}$, és $delta'(S, a) = union_(q in S) delta(q, a)$. A két gép ugyanazt a nyelvet ismeri fel.
- *Minimalizálás*:
  1. Elérhetetlen állapotok törlése (szélességi kereséssel).
  2. Ekvivalens állapotok összevonása: $q approx p$, ha minden $w$ szóra $delta(q, w) in F arrow.l.r.double delta(p, w) in F$. Algoritmusa a partíció-finomítás ($approx_i$).
- *Myhill-Nerode tétel*: Egy $L$ nyelv pontosan akkor reguláris, ha a maradéknyelveinek ($L_u = {v | u v in L}$) száma véges.
- *Arden tétele*: A $P = R union P Q$ nyelvi egyenlet legkisebb megoldása $P = R Q^*$. Ha $epsilon in.not Q$, a megoldás egyértelmű.

== Környezetfüggetlen nyelvek (L2)
- *Redukált grammatika*: Nincsenek benne felesleges (nem aktív vagy nem elérhető) nemterminálisok.
- *Chomsky-normálforma (CNF)*: $A arrow B C$ vagy $A arrow a$ alakú szabályok.
  *Átalakítás lépései:* 1. Álterminálisok, 2. Hosszredukció, 3. $epsilon$-mentesítés, 4. Láncmentesítés.
- *CYK-algoritmus*: Polinomiális ($O(n^3)$) algoritmus annak eldöntésére, hogy $w in L(G)$ teljesül-e (dinamikus programozás táblázattal).
- *Bar-Hillel (Pumpáló) lemma*: Ha $L$ környezetfüggetlen, létezik $p$ küszöbszám, hogy minden $|w| > p$ szó felbontható $w = u x v y z$ alakra, ahol $|x v y| <= p$, $|x y| >= 1$ és minden $i >= 0$ esetén $u x^i v y^i z in L$.
- *Veremautomata (PDA)*: $A = (Z, Q, T, delta, z_0, q_0, F)$. Működése az aktuális állapottól, az input betűtől és a *verem tetejétől* függ. A nemdeterminisztikus PDA pontosan a 2-es típusú nyelveket ismeri fel.

== Kiszámíthatóságelmélet
- *Turing-gép (TG)*: $M = (Q, Sigma, Gamma, delta, q_0, q_i, q_n)$. A gép írható-olvasható végtelen szalaggal és kétirányba mozgó fejjel rendelkezik.
- *Eldönthetőség (R)*: $L$ eldönthető, ha létezik TG, ami minden bemeneten megáll, és pontosan $L$ szavait fogadja el.
- *Rekurzív felsorolhatóság (RE)*: $L$ felismerhető, ha létezik TG, ami $w in L$ esetén elfogadó állapotban megáll, de $w in.not L$ esetén vagy elutasít, vagy végtelen ciklusba kerül.
- *Megállási probléma ($L_h$)*: Eldönthetetlen, de felismerhető.
  *Bizonyítás (Cantor-átlós módszer):* Indirekt tegyük fel, hogy $M_h$ eldönti $L_h$-t. Konstruáljunk egy $D$ gépet, ami $w$-re futtatja $M_h$-t $(x w, w)$-n. Ha elfogadná, fusson végtelen ciklusba, ha elutasítaná, álljon meg. $D(x D)$ ellentmondást ad.
- *Rice-tétel*: A rekurzíve felsorolható nyelvek bármely nem-triviális tulajdonsága eldönthetetlen (pl. üresség, végesség, környezetfüggetlenség).
- *Post Megfeleltetési Probléma (PMP)*: Adott dominókészlet $(u_i, v_i)$. Van-e olyan sorozat, ahol a felső és alsó szavak megegyeznek? A PMP eldönthetetlen.

== Logika
- *Ítéletkalkulus*: Logikai változók és műveletek (negáció, konjunkció, diszjunkció, implikáció).
  - *Kielégíthetőség*: Van olyan interpretáció, ahol a formula igaz.
  - *Tautológia*: Minden interpretációban igaz.
- *Elsőrendű logika*: Tartalmaz konstansokat, függvényeket, predikátumokat és kvantorokat ($forall, exists$). A logikai érvényesség (tautológia) felismerhető (RE), de nem eldönthető (Rice/TG visszavezetéssel bizonyítható).

#pagebreak()
== Bonyolultságelmélet
- *P*: Determinisztikus TG-pel polinom időben eldönthető nyelvek.
- *NP*: Nemdeterminisztikus TG-pel polinom időben eldönthető nyelvek (vagy: polinom méretű tanúval polinom időben ellenőrizhető).
- *Visszavezetés ($L_1 <=_p L_2$)*: Létezik polinom időben kiszámítható $f$, hogy $w in L_1 arrow.l.r.double f(w) in L_2$.
- *NP-teljesség*: $L$ NP-teljes, ha $L in N P$ és minden $L' in N P$ esetén $L' <=_p L$.
- *Cook-Levin tétel*: A SAT (KNF formulák kielégíthetősége) NP-teljes.
- *Nevezetes NP-teljes problémák*: 3SAT, 3-Színezés, Klikk, Hamilton-út/kör, Utazóügynök (TSP), Lefogó ponthalmaz.
- *Tárbonyolultság*:
  - *L*: Logaritmikus tár ($O(log n)$).
  - *NL*: Nemdeterminisztikus logaritmikus tár. Az Elérhetőség (s-t út) NL-teljes.
  - *Savitch-tétel*: Ha $f(n) >= log n$, akkor $N S P A C E(f(n)) subset S P A C E(f^2(n))$. Következmény: $P S P A C E = N P S P A C E$.
- *Hierarchia*: $L subset N L = c o N L subset P subset N P subset P S P A C E subset E X P T I M E$.
