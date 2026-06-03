= 1. Lineáris algebrai alapok

== a) Alapfogalmak és a sajátérték feladat alapjai

A sajátérték-probléma (SÉP) a numerikus analízis egyik legfontosabb területe. A célunk, hogy egy négyzetes mátrix hatását megértsük a tér vektoraira.

=== Definíciók

1. *Sajátérték és sajátvektor:* Legyen $A in CC^(n times n)$ egy négyzetes mátrix. A $lambda in CC$ számot az $A$ mátrix *sajátértékének*, a $v in CC^n, v != 0$ vektort pedig az $A$ mátrix $lambda$-hoz tartozó *sajátvektorának* nevezzük, ha teljesül az $A v = lambda v$ egyenlet.

2. *Karakterisztikus polinom:* Az $A$ mátrix karakterisztikus polinomja a $p(lambda) = det(A - lambda I)$ összefüggéssel definiált polinom. A sajátértékek pontosan a karakterisztikus polinom gyökei ($p(lambda) = 0$).

3. *Multiplicitások:*
  - *Algebrai multiplicitás ($m_A(lambda)$):* A $lambda$ sajátérték mint gyök hányszoros gyöke a karakterisztikus polinomnak.
  - *Geometriai multiplicitás ($m_G(lambda)$):* A $lambda$ sajátértékhez tartozó sajátaltér ($W_lambda$) dimenziója, ahol $W_lambda = (v in CC^n : A v = lambda v)$. Ez megadja a lineárisan független sajátvektorok maximális számát az adott sajátértékhez.
  - *Tétel:* Minden sajátértékre igaz, hogy $m_A(lambda) >= m_G(lambda)$.

=== Hasonlósági transzformáció

*Definíció:* Az $A, B in CC^(n times n)$ mátrixok *hasonlóak* ($A tilde B$), ha létezik olyan $T$ invertálható mátrix, melyre $B = T^(-1) A T$. A $T$ mátrixot transzformációs mátrixnak nevezzük.

*A sajátértékek kapcsolata:* Ha $A$ és $B$ hasonlóak, akkor a sajátértékeik azonosak.
*Bizonyítás:*
$ p_B (lambda) = det(B - lambda I) = det(T^(-1) A T - lambda T^(-1) T) = det(T^(-1) (A - lambda I) T) = $
$ = det(T^(-1)) det(A - lambda I) det(T) = det(A - lambda I) = p_A (lambda) $
Mivel a karakterisztikus polinomjaik megegyeznek, a gyökeik (a sajátértékek) is azonosak lesznek.

*A sajátvektorok transzformációja:* Ha $v$ az $A$ sajátvektora ($A v = lambda v$), akkor $w = T^(-1) v$ a $B$ sajátvektora.
*Bizonyítás:*
$
  B w = (T^(-1) A T) (T^(-1) v) = T^(-1) A (T T^(-1)) v = T^(-1) A v = T^(-1) (lambda v) = lambda (T^(-1) v) = lambda w
$

=== Jordan-normálforma
*Tétel:* Minden $A in CC^(n times n)$ mátrixhoz létezik egy olyan invertálható $X$ mátrix, hogy $X^(-1) A X = J$, ahol $J$ egy blokk-diagonális mátrix:
$ J = mat(J_1, 0, dots, 0; 0, J_2, dots, 0; dots, dots, dots, dots; 0, 0, dots, J_m) $
Ahol minden $J_i$ egy úgynevezett Jordan-blokk, melynek átlójában egy $lambda_i$ sajátérték áll, felette pedig 1-esek:
$ J_i = mat(lambda_i, 1, 0, dots, 0; 0, lambda_i, 1, dots, 0; dots, dots, dots, dots, 1; 0, 0, 0, dots, lambda_i) $
Ez a forma megmutatja, hogy bár nem minden mátrix diagonalizálható (csak azok, ahol minden sajátértékre $m_A = m_G$), minden mátrix "majdnem" diagonális alakra hozható.

== b) Schur-tétel és a normális mátrixok diagonalizálása

Ez a rész a tétel nehezebb, bizonyítás-orientált fele.

=== Schur-tétel
*Állítás:* Minden $A in CC^(n times n)$ mátrixhoz létezik egy $U in CC^(n times n)$ unitér mátrix ($U^* U = I$), hogy $U^* A U = R$ felsőháromszög-mátrix.

*Bizonyítás (Teljes indukcióval):*
1. *n=1:* Az állítás triviálisan igaz.
2. *Indukciós lépés:* Tegyük fel, hogy $(n-1)$-re igaz.
3. Keressük meg $A$ egy $lambda_1$ sajátértékét és a hozzá tartozó $v_1$ egységnyi sajátvektort ($||v_1||_2 = 1$).
4. Készítsünk egy $U_1$ unitér mátrixot (például Householder-transzformációval), melynek első oszlopa $v_1$. Ekkor $U_1 = [v_1, V_2]$.
5. Számítsuk ki $U_1^* A U_1$ értékét:
$ U_1^* A U_1 = mat(v_1^*; V_2^*) A mat(v_1, V_2) = mat(v_1^* A v_1, v_1^* A V_2; V_2^* A v_1, V_2^* A V_2) $
Mivel $A v_1 = lambda_1 v_1$, ezért:
- $v_1^* A v_1 = v_1^* lambda_1 v_1 = lambda_1 (v_1^* v_1) = lambda_1$.
- $V_2^* A v_1 = V_2^* lambda_1 v_1 = lambda_1 (V_2^* v_1) = 0$ (mivel $U_1$ oszlopai merőlegesek).
6. Így $U_1^* A U_1 = mat(lambda_1, *; 0, A_2)$, ahol $A_2$ egy $(n-1) times (n-1)$-es mátrix.
7. Az indukciós feltevés szerint $A_2$ unitér hasonlósággal felsőháromszög alakra hozható ($Q^* A_2 Q = R_2$).
8. A teljes $U$ mátrixot az $U_1$ és a $Q$ kombinációjából kapjuk meg, ezzel $A$-t felsőháromszög alakra hoztuk.

=== Normális mátrixok diagonalizálása
*Definíció:* Az $A$ mátrix *normális*, ha $A^* A = A A^*$. (Ilyenek például a szimmetrikus, önadjungált vagy unitér mátrixok.)

*Tétel:* $A$ normális mátrix $arrow.l.r$ létezik $U$ unitér mátrix, melyre $U^* A U = D$ diagonális.

*Bizonyítás ($arrow.r$):*
1. A Schur-tétel alapján minden $A$-hoz létezik $U$ unitér mátrix, hogy $U^* A U = R$ felsőháromszög.
2. Mivel $A$ normális, bemutatható, hogy $R$ is normális. (Ha $A^* A = A A^*$, akkor $(U R U^*)^* (U R U^*) = (U R U^*) (U R U^*)^*$, amiből $R^* R = R R^*$ következik.)
3. Nézzük meg az $R^* R = R R^*$ egyenletet az (1,1) elemre:
  - $(R^* R)_(11) = overline(r)_11 r_11 = |r_11|^2$.
  - $(R R^*)_(11) = sum_(j=1)^n r_(1j) overline(r)_(1j) = |r_11|^2 + |r_12|^2 + dots + |r_(1n)|^2$.
4. Ahhoz, hogy a két oldal egyenlő legyen, minden főátló feletti elemnek az első sorban nullának kell lennie: $r_12 = r_13 = dots = r_(1n) = 0$.
5. Ezt a gondolatmenetet folytatva a többi sorra is, azt kapjuk, hogy minden főátló feletti elem 0.
6. Mivel $R$ felsőháromszög és minden főátló feletti eleme 0, ezért $R$ szükségképpen diagonális ($R = D$).

/*
Magyarázat a tételhez

Ez a tétel a mátrixok "szétszereléséről" szól. Amikor azt mondjuk, hogy egy mátrix *diagonalizálható*, az azt jelenti, hogy van egy olyan nézőpont (bázis), amiből nézve a mátrix csak nyújtja a vektorokat a tengelyek mentén, de nem forgatja el őket.

A *Schur-tétel* azért zseniális, mert azt mondja: nem biztos, hogy minden mátrixot tudunk ilyen tökéletesen diagonalizálni, de *felsőháromszög* alakra *minden* mátrixot hozhatunk unitér transzformációval. Ez a numerikus módszerek "svájci bicskája". Az unitér transzformáció (forgatás és tükrözés) azért jó nekünk, mert nem növeli a kerekítési hibákat, stabil marad a számolás.

A *Jordan-alak* elméletileg fontos, mert megmutatja a mátrix belső struktúráját, de a gyakorlatban (Matlabban) sosem használjuk, mert a 1-esek megjelenése a főátló felett rendkívül érzékeny a kis hibákra. Ha egy sajátértéket csak egy kicsit is elrontunk, a Jordan-struktúra összeomolhat.

Végül a *normális mátrixok*. Ők a "tökéletes" mátrixok. Ha egy mátrix felcserélhető az adjungáltjával, akkor garantált, hogy van ortonormált sajátvektor-bázisa. Ezért tudjuk őket nemcsak felsőháromszög, hanem egyenesen diagonális alakra hozni.

*/

#pagebreak()

= 2. Sajátértékek becslése

Ebben a tételben azt vizsgáljuk meg, hogyan tudjuk a mátrix elemeiből közvetlenül, bonyolult számítások nélkül "bekeríteni" a sajátértékeket a komplex számsíkon.

== a) Becslés normával és a Gersgorin-tétel

=== Becslés mátrixnormával
A legegyszerűbb becslés a mátrixnormák tulajdonságaiból adódik.

*Állítás:* Az $A$ mátrix minden $lambda_i$ sajátértéke a komplex sík origó középpontú, $r = ||A||$ sugarú zárt körlemezén belül helyezkedik el, azaz $|lambda_i| <= ||A||$ minden $i=1, ..., n$ esetén.

*Magyarázat:* Ez a becslés bármely illeszkedő mátrixnormára (pl. sorösszeg- vagy oszlopösszeg-norma) igaz. Bár ez egy nagyon biztos korlát, gyakran túl tág, és nem mond semmit a sajátértékek pontosabb eloszlásáról.

=== A Gersgorin-tétel (Sorokra vonatkozó alak)
Semyon Aranovich Gersgorin 1931-es tétele ennél sokkal finomabb becslést ad, minden egyes sorhoz rendel egy kört.

*Tétel:* Az $A$ mátrix minden sajátértéke benne van a komplex sík $a_(i i)$ középpontú és
$ r_i = sum_(j=1, j != i)^n |a_(i j)| $
sugarú zárt körlemezeinek uniójában. Ezeket a köröket *Gersgorin-köröknek* nevezzük.

*Bizonyítás:*
1. Legyen $lambda$ az $A$ egy tetszőleges sajátértéke és $v != 0$ a hozzá tartozó sajátvektor ($A v = lambda v$).
2. Keressük meg a $v$ vektornak azt az $i$ indexű komponensét, amely abszolút értékben a legnagyobb: $|v_i| = ||v||_oo$. Mivel $v != 0$, ezért $|v_i| > 0$.
3. Írjuk fel az $A v = lambda v$ egyenlet $i$-edik sorát:
$ sum_(j=1)^n a_(i j) v_j = lambda v_i $
4. Emeljük ki a szummából a $j=i$ tagot és rendezzük át:
$ (a_(i i) - lambda) v_i = - sum_(j=1, j != i)^n a_(i j) v_j $
5. Vegyük mindkét oldal abszolút értékét, és használjuk a háromszög-egyenlőtlenséget:
$ |a_(i i) - lambda| |v_i| <= sum_(j=1, j != i)^n |a_(i j)| |v_j| $
6. Mivel $|v_i|$ a legnagyobb komponens, ezért $|v_j| <= |v_i|$ minden $j$-re. Így a jobb oldalt tovább becsülhetjük:
$ |a_(i i) - lambda| |v_i| <= |v_i| sum_(j=1, j != i)^n |a_(i j)| $
7. Osszunk le a nem-nulla $|v_i|$-vel:
$ |a_(i i) - lambda| <= sum_(j=1, j != i)^n |a_(i j)| = r_i $
Ez éppen azt jelenti, hogy a $lambda$ sajátérték benne van az $i$-edik Gersgorin-körben. Mivel ez minden sajátértékre igaz valamilyen $i$-re, a tétel állítása igazolt.

=== A Gersgorin-tétel javítása diagonális hasonlósági transzformációval
Gyakran előfordul, hogy a körök túl nagyok, és szeretnénk őket "összehúzni" egy-egy fontos sajátérték körül.

*Tétel:* Legyen $D = "diag"(d_1, d_2, ..., d_n)$ egy invertálható diagonális mátrix. Ekkor a $B = D^(-1) A D$ mátrix sajátértékei megegyeznek $A$ sajátértékeivel, és a Gersgorin-körök középpontjai nem változnak ($b_(i i) = a_(i i)$), de sugaraik a következőképpen alakulnak:
$ R_i = sum_(j=1, j != i)^n |a_(i j)| (|d_j|) / (|d_i|) $

*Bizonyítás:* A mátrixszorzás szabályai szerint a $B$ mátrix elemei: $b_(i j) = (1/d_i) a_(i j) d_j$. Ha $i=j$, akkor $b_(i i) = a_(i i)$, tehát a középpontok fixek. A sugarakra pedig egyszerűen alkalmazzuk a Gersgorin-tételt a $B$ mátrixra.

*Alkalmazás:* Ha egy adott $i$-edik kört akarunk kicsinyíteni, válasszunk nagy $d_i$ értéket a többi $d_j$-hez képest. Ez az $i$-edik sor sugarát csökkenti, miközben a többi sorét (ahol $d_i$ a számlálóban van) növeli.

=== A Gersgorin-tétel következményei
A tételből több rendkívül hasznos állítás is fakad:
1. *Alkalmazás oszlopokra:* Mivel $A$ és $A^T$ sajátértékei azonosak, a tétel az oszlopokra is igaz.
2. *Metszet-tulajdonság:* A sajátértékek a sorok és az oszlopok által meghatározott kör-uniók *metszetében* vannak.
3. *Invertálhatóság:* Ha a $0$ nincs benne egyetlen Gersgorin-körben sem, akkor a mátrix invertálható (mivel nem lehet 0 sajátértéke).
4. *Diagonális dominancia:* Minden szigorúan diagonálisan domináns mátrix (ahol $|a_(i i)| > r_i$ minden $i$-re) invertálható.
5. *Pozitív definitség:* Ha $A$ szimmetrikus, és minden középpontja pozitívabb, mint a sugara ($a_(i i) > r_i$), akkor minden sajátértéke pozitív, tehát a mátrix pozitív definit.

== b) Általánosított Gersgorin-tétel

A klasszikus tétel csak annyit mond, hogy a körök uniójában van *valahol* az összes sajátérték. Az általánosított változat ennél többet mond a körök csoportosításáról.

*Tétel:* Ha a Gersgorin-körök uniója felbontható több diszjunkt (egymástól elkülönülő) körcsoportra, akkor minden egyes körcsoport pontosan annyi sajátértéket tartalmaz, ahány körből az adott csoport áll.

*Bizonyítás (Homotópia módszerrel):*
1. Bontsuk fel a mátrixot $A = D + B$ alakra, ahol $D$ a diagonális rész, $B$ pedig a nullázott főátlójú rész.
2. Definiáljunk egy folytonos mátrix-sorozatot a $t in$ paraméterrel: $A(t) = D + t B$.
3. Figyeljük meg a szélsőértékeket:
  - $t=0$: $A(0) = D$. Ennek a sajátértékei pontosan a diagonális elemek ($a_(i i)$), és a Gersgorin-körök sugara 0.
  - $t=1$: $A(1) = A$. Ez az eredeti mátrixunk a tényleges sugaraival.
4. Tudjuk, hogy a sajátértékek folytonosan függenek a mátrix elemeitől (és így $t$-től is).
5. Ahogy $t$ növekszik 0-ról 1-re, a sajátértékek elindulnak a középpontokból ($a_(i i)$), és "vándorolnak" a síkon.
6. Mivel minden $t$-re érvényes a Gersgorin-tétel, a sajátértékek sosem hagyhatják el a körök pillanatnyi unióját.
7. Ha egy körcsoport diszjunkt marad a folyamat során, akkor a benne indult sajátértékek nem tudnak "átugrani" egy másik, tőlük elszigetelt körcsoportba, mert ehhez ki kellene lépniük a Gersgorin-unióból.
8. Így a csoportban maradó sajátértékek száma végig állandó marad, és megegyezik a kezdeti (t=0) állapottal, ami a csoportot alkotó körök száma.

/*

Magyarázat a tételhez (a szóbeli felkészüléshez):

Amikor erről a tételről beszélsz, képzeld el úgy, mint egy *területi alapú becslést*. A sajátértékek a karakterisztikus polinom "szellemei", amiket nehéz pontosan megfogni, de a Gersgorin-körökkel építünk köréjük egy kerítést.

A legfontosabb logikai ugrás a bizonyításban az, hogy *az eigenvector legnagyobb elemét használjuk*. Miért? Mert ha az egyenletet leosztjuk vele, a többi elem ($v_j / v_i$) biztosan nem lesz nagyobb 1-nél. Ez a trükk szorítja be a sajátértéket a sorösszegnyi távolságra a diagonális elemtől.

A *diagonális hasonlósági transzformáció ($D^(-1)AD$)* a gyakorlatban olyan, mintha "átméreteznénk" a koordináta-tengelyeket. Ez a numerikus analízis egyik legfontosabb eszköze: ha egy kör túl nagy és rálóg a nullára (ami miatt nem tudjuk bizonyítani az invertálhatóságot), akkor ezzel a trükkel "vékonyabbá" tehetjük a mátrixot abban a sorban.

Az *általánosított tétel (homotópia)* pedig a folytonosság erejét használja. Olyan, mintha egy animációt néznénk: elindulunk a pontokból ($t=0$), a körök elkezdenek nőni, de ha két "sziget" nem ér össze, akkor a lakóik (a sajátértékek) nem tudnak átköltözni egyikről a másikra.

*/

#pagebreak()

= 3. A sajátérték-probléma érzékenysége

A numerikus stabilitás szempontjából kulcskérdés, hogy a bemenő adatok (mátrixelemek) kis változása mekkora változást okoz a végeredményben (sajátértékekben).

== a) A SÉP érzékenységének fogalma és a reziduális hiba

A SÉP érzékenysége azt méri, hogy a sajátértékek mennyire stabilak a mátrix perturbációjával szemben. Két alapvető megközelítést alkalmazunk:
1. *Közelítő sajátpár jósága:* Van egy $mu$ közelítő sajátértékünk és egy $u$ közelítő sajátvektorunk. Milyen messze van $mu$ a mátrix egy valódi $lambda_i$ sajátértékétől?
2. *Mátrix perturbációja:* Ha $A$ helyett $A + Delta A$-val számolunk, mennyit mozdulnak el a sajátértékek?

=== Tétel: Becslés a reziduális hibával
Legyen $A in CC^(n times n)$ diagonalizálható mátrix, azaz $X^(-1) A X = D = "diag"(lambda_1, ..., lambda_n)$. Legyen $mu in CC$ és $u in CC^n, u != 0$ egy közelítő sajátpár, és legyen $r = A u - mu u$ a közelítés *reziduális hibája*.

Olyan mátrixnormát használva, amelyre $||"diag"(d_i)|| = max |d_i|$, érvényes a következő becslés:
$ min_(i=1, ..., n) |lambda_i - mu| <= (||r||) / (||u||) dot "cond"(X) $

*Bizonyítás:*
1. Induljunk ki a reziduum definíciójából és használjuk fel a diagonalizálhatóságot ($A = X D X^(-1)$):
$ r = A u - mu u = (X D X^(-1)) u - mu (X X^(-1)) u = X (D - mu I) X^(-1) u $
2. Ha $mu$ pontos sajátérték, az állítás $0 <= 0$ alakban teljesül. Tegyük fel, hogy $mu$ nem sajátértéke $A$-nak, ekkor $(D - mu I)$ invertálható.
3. Fejezzük ki $u$-t az egyenletből:
$ u = X (D - mu I)^(-1) X^(-1) r $
4. Vegyük mindkét oldal normáját és használjuk a szorzat-egyenlőtlenséget:
$ ||u|| <= ||X|| dot ||(D - mu I)^(-1)|| dot ||X^(-1)|| dot ||r|| $
5. Tudjuk, hogy a diagonális mátrix inverzének normája a reciprok értékek maximuma:
$ ||(D - mu I)^(-1)|| = max_i (1)/(|lambda_i - mu|) = 1 / (min_i |lambda_i - mu|) $
6. Behelyettesítve és átrendezve:
$
  ||u|| <= "cond"(X) dot (||r||) / (min_i |lambda_i - mu|) arrow.r min_i |lambda_i - mu| <= (||r||)/(||u||) dot "cond"(X)
$

=== Összehasonlítás a LER érzékenységével
- *Lineáris egyenletrendszereknél ($A x = b$):* Az érzékenységet a mátrix saját kondíciós száma, a $"cond"(A) = ||A|| dot ||A^(-1)||$ határozza meg.
- *Sajátérték-feladatnál:* Nem az $A$ mátrix "jósága" számít, hanem a *sajátvektoraiból álló bázis* ($X$) kondíciós száma.
- *Következmény:* Ha $A$ normális ($A^* A = A A^*$), akkor $X$ unitér is lehet, így $"cond"_2(X) = 1$. Ez azt jelenti, hogy a normális (pl. szimmetrikus) mátrixok sajátérték-feladata mindig jól kondicionált!

== b) Perturbációs tételek és folytonosság

=== Inverz perturbációs tétel
Ez a tétel azt mondja ki, hogy bármilyen "rossz" közelítésünk is van, az valaminek a tökéletes megoldása.
*Állítás:* Legyen $r = A u - mu u$. Ekkor létezik olyan $E$ mátrix, hogy $mu$ és $u$ az $A + E$ mátrixnak *pontos* sajátpárja, és $||E||_2 = (||r||_2) / (||u||_2)$.
*Magyarázat:* Ez segít eldönteni, érdemes-e tovább számolni. Ha $||E||$ kisebb, mint a mátrix elemeinek bizonytalansága, akkor a közelítésünk fizikailag tökéletes.

=== Bauer-Fike tétel
Ez a SÉP érzékenységének "szent grálja" a perturbált mátrixokra.
*Tétel:* Ha $A$ diagonalizálható ($X$ által) és $mu$ a perturbált $A + Delta A$ mátrix egy sajátértéke, akkor:
$ min_i |lambda_i - mu| <= "cond"(X) dot ||Delta A|| $

*Bizonyítás (vázlat):*
Hasonlóan a reziduális tételhez, az $(A + Delta A - mu I)$ szingularitását használjuk ki. Belátható, hogy létezik egy $B = (D - mu I)^(-1) X^(-1) Delta A X$ mátrix, aminek a $-1$ sajátértéke. Ebből a $1 = |-1| <= rho(B) <= ||B||$ egyenlőtlenséggel adódik a becslés.

=== A sajátértékek folytonos függése
A tételek egyik legfontosabb elméleti következménye, hogy a sajátértékek a mátrix elemeinek *folytonos függvényei*.
- Miért? Mert a karakterisztikus polinom együtthatói a mátrix elemeinek folytonos függvényei (polinomjai), és a polinomok gyökei folytonosan függenek az együtthatóktól.
- *Vigyázat:* Ez a sajátvektorokra nem feltétlenül igaz! Ha két sajátérték nagyon közel kerül egymáshoz, a hozzájuk tartozó sajátvektorok "összeomolhatnak" vagy hirtelen irányt válthatnak (lásd: instabilitás).

/*
### Magyarázat a tételhez (hogy "beszédes" legyen):

Amikor a SÉP érzékenységéről beszélsz a vizsgán, a kulcsszó a *$"cond"(X)"$*.

Magyarázd el a vizsgáztatónak, hogy miért nem $"cond"(A)"$ szerepel itt: Az $A$ mátrix lehet majdnem szinguláris (determinánsa közel 0), de attól még a sajátértékei lehetnek kőszikla-stabilak. A stabilitást az határozza meg, hogy a *sajátvektorok mennyire "feszítik ki" jól a teret*. Ha a sajátvektorok majdnem egy irányba mutatnak (az $X$ mátrix oszlopai majdnem lineárisan összefüggnek), akkor $"cond"(X)"$ óriási lesz, és a legkisebb hiba is hatalmasat lök a sajátértékeken.

A *Bauer-Fike tétel* a gyakorlatban azt jelenti: ha szimmetrikus mátrixszal dolgozol ($X$ unitér, kondíciója 1), akkor ha a mátrix elemeiben elkövetsz egy $10^(-6)$ nagyságú hibát, a sajátértékek sem fognak $10^(-6)$-nál messzebb vándorolni. Ez egy fantasztikus biztonsági garancia!

Viszont említsd meg a *Wilkinson-polinomot* vagy a tétel végén a sajátvektorok érzékenységét: a sajátértékek folytonosak, de "vadul" viselkedhetnek. Ha két sajátérték ütközik, a bázisunk (az $X$) elfajulhat, és ott minden stabilitás elveszik.

*/

#pagebreak()

= 4. A karakterisztikus polinom meghatározására alkalmas módszerek I.

Ebben a fejezetben olyan technikákat vizsgálunk, amelyek célja a mátrix sajátértékeit hordozó karakterisztikus polinom, $p(lambda) = det(A - lambda I)$, együtthatóinak vagy értékeinek kinyerése.

== a) Karakterisztikus polinom meghatározása interpolációval

A legkézenfekvőbb módszer, ha a karakterisztikus polinomot nem szimbolikusan próbáljuk kifejteni, hanem egyfajta "fekete dobozként" kezeljük, amelyet több ponton mintavételezünk.

=== Az alapötlet
Tudjuk, hogy egy $n times n$-es mátrix karakterisztikus polinomja $n$-edfokú, és a főegyütthatója $(-1)^n$ (vagy ha $det(lambda I - A)$ alakban írjuk fel, akkor 1). Egy $n$-edfokú polinomot $n+1$ adat határoz meg egyértelműen. Mivel a főegyütthatót ismerjük, valójában csak $n$ darab különböző pontban kell kiszámítanunk a polinom értékét.

=== A módszer lépései
1. Válasszunk $n$ darab különböző $x_1, x_2, ..., x_n$ valós pontot.
2. Számítsuk ki minden pontban a $p(x_i) = det(x_i I - A)$ determináns értékét. Ez numerikusan például LU-felbontással végezhető el.
3. Keressük a polinomot $p(lambda) = lambda^n + p_1 lambda^(n-1) + ... + p_(n-1) lambda + p_n$ alakban.
4. Helyettesítsük be a mért értékeket, így egy lineáris egyenletrendszert (LER) kapunk az ismeretlen $p_1, ..., p_n$ együtthatókra:
$ p_1 x_i^(n-1) + ... + p_(n-1) x_i + p_n = p(x_i) - x_i^n quad (i = 1, ..., n) $

=== Numerikai megjegyzések
- *Vandermonde-mátrix:* A fenti LER mátrixa egy Vandermonde-mátrix. Bár elméletileg kiváló, a gyakorlatban a Vandermonde-mátrixok rendkívül rosszul kondicionáltak, így a $p_k$ együtthatók meghatározása nagy kerekítési hibával járhat.
- *Jobb megoldás:* Ahelyett, hogy megoldanánk a LER-t az együtthatókra, használjunk *Newton-* vagy *Lagrange-interpolációs algoritmust* a $p(lambda)$ felírásához a $(x_i, p(x_i) - x_i^n)$ pontpárokra.

== b) Frobenius kísérő mátrix és tridiagonális rekurzió

=== A Frobenius kísérő mátrix
A Frobenius-mátrix (vagy kísérő mátrix) azt mutatja meg, hogy tetszőleges polinomhoz tudunk-e konstruálni olyan mátrixot, amelynek éppen az a karakterisztikus polinomja.

*Definíció:* Adott $p(lambda) = lambda^n + p_1 lambda^(n-1) + ... + p_n$ polinom esetén a Frobenius-mátrix ($F_n$) olyan mátrix, amelynek utolsó oszlopa (vagy sora) a negatív együtthatókat tartalmazza, az alátlóban 1-esek állnak, minden más elem pedig 0.

*Tétel:* $det(lambda I - F_n) = p(lambda)$.

*Bizonyítás (vázlat):*
A bizonyítást az első sor szerinti kifejtéssel végezzük el $n$ szerinti teljes indukcióval.
1. Kifejtve az első sor szerint, kapunk egy $lambda$ szorzót és egy $(n-1)$-edrendű Frobenius-determinánst ($det(lambda I - F_(n-1))$).
2. A kifejtés másik ága a konstans tagot ($p_n$) adja meg.
3. Az indukciós lépés végén az adódik, hogy $lambda p_(n-1)(lambda) + p_n$, ami pontosan kiadja a teljes $n$-edfokú polinomot.

=== Karakterisztikus polinom tridiagonális esetben
A tridiagonális mátrixok (ahol csak a főátlóban és a két szomszédos mellékátlóban vannak nem-nulla elemek) kiemelt szerepűek, mert minden szimmetrikus mátrix véges sok lépésben ilyen alakra hozható.

*Tétel (Rekurziós formula):* Legyen $A$ tridiagonális mátrix $alpha_i$ főátlóval, valamint $beta_i$ és $gamma_i$ mellékátlókkal. Ekkor a karakterisztikus polinom értéke a következő háromtagú rekurzióval számolható:
$ p_0(lambda) = 1 $
$ p_1(lambda) = alpha_1 - lambda $
$ p_k(lambda) = (alpha_k - lambda) p_(k-1)(lambda) - beta_(k-1) gamma_(k-1) p_(k-2)(lambda) quad (k = 2, ..., n) $

=== Alkalmazás nemlineáris egyenletek megoldásánál
Ez a rekurzió rendkívül stabil és hatékony. A sajátértékek keresésekor nem az együtthatókat számoljuk ki, hanem:
1. *Intervallumfelezés:* A rekurzióval gyorsan ellenőrizhetjük a polinom előjelét és a gyökök számát egy intervallumban (Sturm-sorozatok elve).
2. *Newton-módszer:* Ha szükségünk van a deriváltra, a rekurziót levezethetjük $lambda$ szerint is, így $p_n(lambda)$ és $p'_n(lambda)$ egyidejűleg számolható, és alkalmazható a $lambda_(j+1) = lambda_j - p_n(lambda_j)/p'_n(lambda_j)$ iteráció.

/*
### Magyarázat a tételhez (hogy "beszédes" legyen):

Amikor erről a tételről beszélsz a vizsgán, érdemes a *numerikus stabilitással* kezdeni. Mondd el, hogy bár elméletileg a karakterisztikus polinom gyökei a sajátértékek, a gyakorlatban a polinom *hatványegyütthatós alakjának* (pl. $x^2 - 7x + 10$) meghatározása és abból a gyökkeresés rendkívül veszélyes. Erre a legjobb példa a *Wilkinson-polinom*: ha egy polinom együtthatóit csak egy parányit megváltoztatjuk, a gyökök drasztikusan elvándorolhatnak.

Ezért fontos az *a) részben* az interpoláció: nem az együtthatókat akarjuk megkapni, hanem a polinom értékét több helyen, hogy "bekerítsük" a gyököket.

A *Frobenius-mátrix* jelentősége abban áll, hogy megmutatja: a sajátérték-feladat és a gyökkeresés egyenértékű. Ha van egy bonyolult polinomod, aminek a gyökeit keresed, csinálhatsz belőle egy Frobenius-mátrixot, és ráereszthetsz egy QR-algoritmust.

Végül a *tridiagonális rekurzió*. Ez a szóbeli egyik legszebb része. Magyarázd el, hogy miért nem "bontjuk ki" a zárójeleket! Azért, mert a *háromtagú rekurzió* (ami emlékeztet az ortogonális polinomok rekurziójára) lehetővé teszi, hogy tetszőleges $lambda$ helyen kiszámoljuk a polinom értékét anélkül, hogy valaha is látnánk az együtthatóit. Ez a "divide and conquer" elve: a nagy determinánst visszavezetjük kisebb főminorok sorozatára.

*/

#pagebreak()

= 5. A karakterisztikus polinom meghatározására alkalmas módszerek II.

== a) A Fagyejev-féle "trace" módszer

A Fagyejev-módszer (más néven Leverrier–Fagyejev algoritmus) egy elegáns rekurzív eljárás a karakterisztikus polinom együtthatóinak meghatározására, anélkül, hogy determinánsokat kellene kifejtenünk.

=== Az algoritmus alapja
Keressük a karakterisztikus polinomot az alábbi, 1-főegyütthatós alakban:
$ p(lambda) = det(lambda I - A) = lambda^n + p_1 lambda^(n-1) + p_2 lambda^(n-2) + dots + p_n $.

Az eljárás a mátrixhatványok nyomaira (trace) épít. Legyen $s_k = tr(A^k)$ az $A$ mátrix $k$-adik hatványának nyoma.

=== Az $s_k$ mennyiségek kapcsolata a sajátértékekkel
*Tétel:* Az $s_k = tr(A^k)$ érték megegyezik a sajátértékek $k$-adik hatványösszegével:
$ s_k = sum_(i=1)^n lambda_i^k $.

*Bizonyítás:*
1. Tudjuk, hogy minden $A$ mátrix hasonló egy $J$ Jordan-normálformához: $A = X J X^(-1)$.
2. A mátrixhatványozás tulajdonságai miatt $A^k = X J^k X^(-1)$.
3. Mivel a hasonló mátrixok nyoma megegyezik ($tr(A) = tr(B)$, ha $A tilde B$), ezért $tr(A^k) = tr(J^k)$.
4. A Jordan-alak egy felsőháromszög-mátrix, ahol a főátlóban a sajátértékek ($lambda_i$) állnak. A hatványozás során a főátlóbeli elemek egyszerűen $lambda_i^k$ alakot öltenek.
5. A nyom a főátlóbeli elemek összege, így $tr(J^k) = sum_(i=1)^n lambda_i^k$, ami igazolja az állítást.

=== A Newton-Waring (Girard) formulák és az n-edik egyenlet bizonyítása
Az együtthatókat ($p_k$) az $s_k$ értékekből az alábbi alsóháromszög-mátrixú egyenletrendszerrel kapjuk meg:
$ s_k + p_1 s_(k-1) + dots + p_(k-1) s_1 + k dot p_k = 0 quad (k = 1, ..., n) $

*Az n-edik egyenlet bizonyítása:*
1. Tudjuk, hogy minden $lambda_i$ sajátérték gyöke a karakterisztikus polinomnak:
  $ lambda_i^n + p_1 lambda_i^(n-1) + dots + p_(n-1) lambda_i + p_n = 0 $
2. Összegezzük ezt az egyenletet minden sajátértékre ($i = 1$-től $n$-ig):
  $
    sum_(i=1)^n lambda_i^n + p_1 sum_(i=1)^n lambda_i^(n-1) + dots + p_(n-1) sum_(i=1)^n lambda_i + sum_(i=1)^n p_n = 0
  $
3. Felhasználva az $s_k = sum lambda_i^k$ összefüggést és azt, hogy $sum_(i=1)^n p_n = n dot p_n$:
  $ s_n + p_1 s_(n-1) + dots + p_(n-1) s_1 + n dot p_n = 0 $
Ezzel az utolsó egyenletet bebizonyítottuk. A többi egyenlet hasonlóan, a Newton-Waring formulák általános elméletéből következik.

== b) Szimmetrikus mátrix tridiagonális alakra hozása

A gyakorlatban a sajátértékek keresése előtt célszerű a mátrixot minél egyszerűbb, de azonos sajátértékekkel rendelkező (hasonló) alakra hozni. Szimmetrikus mátrixok esetén ez a *tridiagonális alak*.

=== Tétel
Ha $A = A^T$ (valós szimmetrikus), akkor létezik olyan $Q$ ortogonális mátrix, melyre $Q^T A Q = T$ tridiagonális mátrix.

=== Bizonyítás (Konstrukció Householder-transzformációkkal)
A bizonyítás $n-2$ lépésből áll, ahol minden lépésben egy-egy oszlopot (és a szimmetria miatt egy-egy sort) nullázunk ki a tridiagonális sávon kívül.

1. *Első lépés:* Tekintsük az $A$ mátrix első oszlopát az első elem nélkül: $tilde(a)_1 = [a_(21), a_(31), ..., a_(n_1)]^T$.
2. Készítsünk egy $tilde(H)_1$ Householder-tükrözést, amely $tilde(a)_1$-et egy olyan vektorba viszi, aminek csak az első eleme nem nulla: $tilde(H)_1 tilde(a)_1 = sigma_1 e_1$.
3. Terjesszük ki ezt a transzformációt a teljes térre: $H_1 = mat(1, 0^T; 0, tilde(H)_1)$. Ez egy ortonormált mátrix.
4. Alkalmazzuk a hasonlósági transzformációt: $A_1 = H_1 A H_1$.
  - A balról szorzás kinullázza az első oszlop elemeit a 2. elem alatt.
  - A jobbról szorzás (a szimmetria miatt) kinullázza az első sor elemeit a 2. elem után.
  - Az $(1,1)$ elem és az $(1,2), (2,1)$ elemek (a tridiagonális rész) megmaradnak.
5. *Iteráció:* Ismételjük meg az eljárást a megmaradt $(n-1) times (n-1)$-es, majd $(n-2) times (n-2)$-es blokkokra.
6. $n-2$ lépés után a mátrix tridiagonális lesz. Mivel minden lépés hasonlósági transzformáció volt, a sajátértékek nem változtak.

=== Nem szimmetrikus eset: Hessenberg-alak
Ha a mátrix *nem szimmetrikus*, ugyanez az eljárás (Householder-tükrözések sorozata) nem tudja a főátló feletti részeket is kinullázni. Ebben az esetben a mátrixot *felső Hessenberg-alakra* lehet hozni (ahol a főátló alatt csak egy mellékátlóban vannak nem-nulla elemek).

/*
### Magyarázat a tételhez (hogy "beszédes" legyen):

Amikor erről a tételről beszélsz, képzeld el a *Fagyejev-módszert* úgy, mint egy "nyomkövető" algoritmust. A determináns számítása (4. tétel) lassú és instabil lehet. Fagyejev rájött, hogy a mátrix hatványainak nyomai ($s_k$) hordozzák az összes információt a polinom együtthatóiról. A *Newton-Waring formulák* valójában egy hidat képeznek a "hatványösszegek" ($s_k$) és az "elemi szimmetrikus polinomok" (azaz a $p_k$ együtthatók) között. A bizonyításnál a Jordan-alak használata azért zseniális, mert ott a nyom és a sajátértékek kapcsolata azonnal látható.

A *tridiagonális alakra hozás* a numerikus algoritmusok előszobája. Magyarázd el a vizsgáztatónak, hogy miért nem "diagonalizálunk" rögtön: azért, mert a diagonalizálás (a sajátértékek megtalálása) egy iteratív folyamat, míg a tridiagonális alak elérése *véges sok lépésben* (pontosan $n-2$) garantált.

A *Householder-transzformációk* használata azért fontos, mert ezek *unitér (ortogonális)* műveletek. Geometriailag ezek tükrözések. A numerikus analízisben azért imádjuk őket, mert nem növelik a kerekítési hibákat (a kondíciószámuk 1), így a folyamat végén kapott tridiagonális mátrix sajátértékei "ugyanazok" lesznek, mint az eredetié, minimális hiba mellett.

Végül, ha nem szimmetrikus a mátrix, a tükrözés csak az alátló alatt tud takarítani, de a főátló felett nem – így kapjuk a *Hessenberg-alakot*, ami a QR-algoritmus alapja lesz a 7. tételnél.

*/

#pagebreak()

= 6. A Rayleigh-hányados és a hatványmódszer

== a) A Rayleigh-hányados fogalma és tulajdonságai

A Rayleigh-hányados egy olyan mérőszám, amely egy mátrix és egy vektor kapcsolatát jellemzi, és alapvető szerepet játszik a sajátértékek közelítésében, különösen önadjungált mátrixok esetén.

=== Definíció
Legyen $A in CC^(n times n)$ egy négyzetes mátrix és $x in CC^n, x != 0$ egy tetszőleges vektor. Az
$ r(x) = (chevron.l A x, x chevron.r) / (chevron.l x, x chevron.r) $
hányadost *Rayleigh-hányadosnak* nevezzük

=== 1. Tétel: Szélső sajátértékek becslése
Ha $A = A^*$ (önadjungált, azaz valós esetben szimmetrikus), akkor a Rayleigh-hányados értéke a legkisebb és a legnagyobb sajátérték közé esik:
$
  max_(x != 0) (chevron.l A x, x chevron.r) / (chevron.l x, x chevron.r) = lambda_max quad "illetve" quad min_(x != 0) (chevron.l A x, x chevron.r) / (chevron.l x, x chevron.r) = lambda_min
$

*Bizonyítás:*
1. Mivel $A$ önadjungált, létezik $U$ unitér mátrix, amellyel $A = U D U^*$, ahol $D = "diag"(lambda_1, ..., lambda_n)$
2. Helyettesítsük be ezt a hányadosba: $(chevron.l U D U^* x, x chevron.r) / (chevron.l x, x chevron.r)$.
3. Vezessük be az $y = U^* x$ koordináta-transzformációt. Az unitér transzformáció megtartja a skaláris szorzatot, így $chevron.l y, y chevron.r = chevron.l x, x chevron.r$.
4. A hányados alakja: $(chevron.l D y, y chevron.r) / (chevron.l y, y chevron.r) = (sum_(i=1)^n lambda_i |y_i|^2) / (sum_(i=1)^n |y_i|^2)$
5. Mivel minden $|y_i|^2 >= 0$, a számlálóban lévő összeg egy súlyozott átlag, amely biztosan nem lehet nagyobb $lambda_max$-nál és kisebb $lambda_min$-nél.
6. Ha $x$-nek a megfelelő sajátvektort választjuk, a hányados pontosan a sajátértéket adja vissza, tehát a korlátok elérhetőek.

=== 2. Tétel: Minimális reziduális hiba
Rögzített $x != 0$ vektor esetén a $min_lambda ||A x - lambda x||_2$ feladat megoldása (azaz az a $lambda$, amely a legkisebb hibát adja) pontosan a Rayleigh-hányados: $lambda = (chevron.l A x, x chevron.r) / (chevron.l x, x chevron.r)$.

*Bizonyítás:*
Az $f(lambda) = ||A x - lambda x||_2^2$ függvényt keressük minimumra. Ez egy másodfokú polinom $lambda$-ban:
$
  f(lambda) = chevron.l A x - lambda x, A x - lambda x chevron.r = chevron.l A x, A x chevron.r - 2 lambda chevron.l A x, x chevron.r + lambda^2 chevron.l x, x chevron.r
$
A teljes négyzetté alakítás vagy deriválás ($f'(lambda) = 0$) után kapjuk, hogy a minimum helye pontosan $lambda = (chevron.l A x, x chevron.r) / (chevron.l x, x chevron.r)$.

== b) Hatványmódszer, inverz iteráció és shiftelés

A hatványmódszer (von Mises eljárás) a mátrix abszolút értékben legnagyobb sajátértékének meghatározására szolgál.

=== Hatványmódszer konvergencia tétele
Legyen $A$ normális mátrix ($A^* A = A A^*$), sajátértékei legyenek $|lambda_n| > |lambda_(n-1)| >= ... >= |lambda_1|$. Legyen $x^(0)$ egy kezdővektor, amelynek van komponense a $v_n$ domináns sajátvektor irányába ($c_n != 0$)

*A tétel állításai:*
1. Az $x^(k+1) = A x^(k)$ rekurzióval generált sorozat iránya a $v_n$ sajátvektorhoz tart.
2. A sajátérték közelítése: $lim_(k -> oo) x_i^((k+1)) / x_i^((k)) = lambda_n$.
3. Ha $A$ önadjungált, akkor a Rayleigh-hányadosok sorozata is $lambda_n$-hez tart: $lim_(k -> oo) (chevron.l x^((k+1)), x^((k)) chevron.r) / (chevron.l x^((k)), x^((k)) chevron.r) = lambda_n$.

*Bizonyítás (vázlat):*
Fejtsük ki $x^((0))$-t a sajátvektorok bázisán: $x^((0)) = sum c_j v_j$. Ekkor $x^((k)) = A^k x^((0)) = sum c_j lambda_j^k v_j$. Kiemelve a domináns tagot: $x^((k)) = lambda_n^k (c_n v_n + sum_(j=1)^(n-1) c_j (lambda_j / lambda_n)^k v_j)$. Mivel $abs(lambda_j / lambda_n) < 1$, a szumma a k növelésével nullához tart, így csak a domináns irány marad meg.

=== Konvergencia sebessége
A módszer sebessége a $abs(lambda_(n-1) / lambda_n)$ hányadostól függ. Ha a két legnagyobb sajátérték közel van egymáshoz, a konvergencia fájdalmasan lassú lehet.

=== Inverz iteráció
Az inverz iteráció nem más, mint a hatványmódszer alkalmazása az $A^(-1)$ mátrixra. Mivel $A^(-1)$ sajátértékei $1/lambda_i$, a domináns sajátérték itt az eredeti mátrix *legkisebb* abszolút értékű sajátértéke lesz.
- *Lépése:* $A x^((k+1)) = x^((k))$ lineáris egyenletrendszert oldunk meg minden lépésben (célszerű LU-felbontással).
- *Haszna:* Rendkívül gyors és stabil módszer a legkisebb sajátérték megtalálására.

=== Shiftelés (Eltolás)
A shiftelés során az $A - p I$ mátrixszal dolgozunk. Ennek sajátértékei $lambda_i - p$ lesznek, de a sajátvektorai változatlanok maradnak.

*Mire használható?*
1. *Konvergencia gyorsítása:* A $abs((lambda_(n-1)-p) / (lambda_n-p))$ hányados megfelelő $p$ választással kicsinyíthető.
2. *Közbülső sajátértékek keresése:* Ha az inverz iterációt $A - p I$-vel végezzük, akkor az $1 / (lambda_i - p)$ domináns sajátértékét keressük. Ha $p$ közel van egy $lambda_k$ sajátértékhez, akkor a módszer arra a belső sajátértékre fog konvergálni.

/*

### Magyarázat a tételhez (hogy "beszédes" legyen):

Amikor erről a tételről beszélsz a vizsgán, kezdd a *Rayleigh-hányados fizikai értelmével*. Magyarázd el, hogy ha van egy vektorunk ($x$), ami majdnem sajátvektor, akkor a Rayleigh-hányados a "legjobb válasz", amit a mátrix adhat arra, hogy mi lenne a hozzá tartozó sajátérték. Önadjungált mátrixoknál ez nem csak egy tipp, hanem egy szigorú minimum-tulajdonság (2. tétel): ez a szám minimalizálja a hibát a kettes normában.

A *hatványmódszernél* a legfontosabb kép az, hogy a mátrixszal való szorzás minden lépésben "belehúzza" a vektort a legnagyobb sajátértékhez tartozó irányba. Olyan ez, mint egy gravitációs mező: a legerősebb komponens előbb-utóbb elnyeli az összes többit.

*Miért fontos a normálás?* (Bár a tétel elméleti, említsd meg!) Mert ha $|lambda_n| > 1$, a vektor hossza a végtelenbe tartana, ha $|lambda_n| < 1$, akkor pedig kinullázódna a gépben. Ezért minden lépésben "visszahúzzuk" egységnyi hosszra.

Az *inverz iteráció* és a *shiftelés* kombinációja a tétel csúcspontja. Mondd el, hogy ez a modern numerikus algoritmusok egyik legfontosabb trükkje. Ha van egy tippünk, hogy hol van egy sajátérték (például egy Gersgorin-kör közepe), akkor oda shiftelünk ($p$), és az inverz iteráció "rá rántja" a vektort a legközelebbi sajátértékre. Ez a folyamat döbbenetesen gyors (másodrendű, vagy szimmetrikus esetben harmadrendű konvergencia).

*/

#pagebreak()

= 7. Jacobi-módszer

A Jacobi-módszer egy klasszikus, iteratív eljárás, amelyet kifejezetten valós szimmetrikus mátrixok összes sajátértékének és sajátvektorának meghatározására fejlesztettek ki. Az eljárás eleganciája abban rejlik, hogy geometriai forgatások sorozatával próbálja a mátrixot "kivasalni" diagonális alakra.

== a) A Jacobi-módszer alapötlete, változatai és a képletek levezetése

=== Az alapötlet: Geometriai megközelítés
Induljunk ki egy $A = A^T$ valós szimmetrikus mátrixból. A lineáris algebrából tudjuk, hogy minden ilyen mátrix ortogonálisan diagonalizálható, azaz létezik olyan $Q$ ortogonális mátrix ($Q^T Q = I$), amelyre $Q^T A Q = D$ diagonális. A $D$ átlójában a sajátértékek, $Q$ oszlopaiban pedig a sajátvektorok állnak.

A Jacobi-módszer célja, hogy ezt a $Q$ mátrixot ne egy lépésben (ami lehetetlen lenne), hanem *elemi forgatási mátrixok* ($Q_k$) végtelen szorzataként állítsa elő:
$ A_k = Q_k^T A_(k-1) Q_k $
Ahol minden lépésben egy olyan forgatást végzünk, amely a mátrix egy választott, főátlón kívüli elemét ($a_(i j)$) pontosan nullává teszi.

=== Az elemi forgatási mátrix ($Q_(i, j)(phi)$)
Egy elemi forgatási mátrix az $(i, j)$ síkban (ahol $i < j$) hajt végre forgatást $phi$ szöggel. Ez egy olyan egységmátrix, amelynek csak négy eleme tér el az identitástól:
- $q_(i i) = cos(phi) = c$
- $q_(j j) = cos(phi) = c$
- $q_(i j) = sin(phi) = s$
- $q_(j i) = -sin(phi) = -s$
Ez a mátrix ortogonális, és a vele való hasonlósági transzformáció csak az $i$-edik és $j$-edik sorokat, illetve oszlopokat változtatja meg.

=== A forgatási szög ($phi$) levezetése
A feladatunk meghatározni azt a $phi$ szöget, amelyre a transzformált $B = Q^T A Q$ mátrixban $b_(i j) = 0$ lesz. A mátrixszorzást elvégezve a kritikus elemre a következő adódik:
$ b_(i j) = (c^2 - s^2) a_(i j) + s c (a_(i i) - a_(j j)) $
Ahhoz, hogy ez nulla legyen, rendezzük át az egyenletet:
$ (c^2 - s^2) a_(i j) = s c (a_(j j) - a_(i i)) $
Használjuk fel a kétszeres szögekre vonatkozó azonosságokat ($cos(2phi) = c^2 - s^2$ és $sin(2phi) = 2 s c$):
$ cos(2phi) a_(i j) = 1/2 sin(2phi) (a_(j j) - a_(i i)) $
Átosztva kapjuk a szög meghatározására szolgáló fundamentális képletet:
$ cot(2phi) = (a_(j j) - a_(i i)) / (2 a_(i j)) $
A $phi$ szöget általában a $(-pi/4, pi/4)$ intervallumban keressük, ami garantálja a stabilitást és az egyértelműséget.

=== A módszer változatai
Attól függően, hogy melyik $(i, j)$ pozíciót választjuk nullázásra, három fő variánst ismerünk:
1. *Klasszikus Jacobi:* Minden lépésben megkeressük a főátlón kívüli abszolút értékben legnagyobb elemet ($|a_(i j)| = max_(p != q) |a_(p q)|$). Ez elméletileg a leggyorsabb konvergenciát adja, de a maximumkeresés nagy mátrixoknál lassú.
2. *Ciklikus Jacobi:* Sorban haladunk az összes lehetséges $(i, j)$ páron (pl. sorfolytonosan), majd ha a végére értünk, újrakezdjük a ciklust. Nem kell keresgélni, de több "felesleges" forgatást végezhetünk.
3. *Küszöb-Jacobi:* Hasonló a ciklikushoz, de csak akkor forgatunk, ha az adott elem abszolút értéke meghalad egy aktuális $epsilon$ küszöböt. Ahogy haladunk előre, a küszöböt csökkentjük.

== b) Bizonyítások: Lemmák és konvergencia

A konvergencia igazolásához bevezetjük a mátrix "nem-diagonális részének tömegét": $N(A) = sum_(i != j) a_(i j)^2$. A célunk belátni, hogy ez a mennyiség minden lépéssel csökken.

=== A 3. Lemma bizonyítása
*Állítás:* Egy $(i, j)$ pozíciójú forgatás után az átlóbeli elemekre igaz, hogy $b_(i i)^2 + b_(j j)^2 = a_(i i)^2 + a_(j j)^2 + 2 a_(i j)^2$.

*Bizonyítás:*
Az ortogonális transzformációk (mint a forgatás) egyik legfontosabb tulajdonsága, hogy megőrzik a mátrix Frobenius-normáját (az összes elem négyzetösszegét): $||B||_F^2 = ||A||_F^2$.
Mivel a forgatás csak az $i$. és $j$. sorokat és oszlopokat érinti, a többi elem négyzete változatlan marad a transzformáció során. Így a változás csak az érintett négy kereszteződési pontban ($i, i; i, j; j, i; j, j$) jelentkezhet:
$ b_(i i)^2 + b_(j j)^2 + 2 b_(i j)^2 = a_(i i)^2 + a_(j j)^2 + 2 a_(i j)^2 $
Mivel a forgatási szöget úgy választottuk meg, hogy $b_(i j) = 0$ legyen, a bal oldalon kiesik a vegyes tag, és marad:
$ b_(i i)^2 + b_(j j)^2 = a_(i i)^2 + a_(j j)^2 + 2 a_(i j)^2 $
Ez azt jelenti, hogy a főátló elemeinek "súlya" minden lépésben pontosan $2 a_(i j)^2$ értékkel növekszik.

=== A klasszikus Jacobi-módszer konvergencia tétele
*Tétel:* A klasszikus Jacobi-módszerrel generált $A_k$ sorozat diagonális mátrixhoz konvergál, amelynek átlójában a sajátértékek állnak.

*Bizonyítás:*
1. A 3. lemmából és a norma megmaradásából következik, hogy a főátlón kívüli rész csökken:
  $ N(B) = N(A) - 2 a_(i j)^2 $
2. Klasszikus esetben $|a_(i j)|$ a legnagyobb elem. Mivel összesen $M = n(n-1)$ darab főátlón kívüli elemünk van, ezért a legnagyobb elem négyzete biztosan nem kisebb az átlagnál:
  $ a_(i j)^2 >= N(A) / M $
3. Behelyettesítve a csökkenési képletbe:
  $ N(B) <= N(A) - 2 N(A) / M = N(A) (1 - 2/M) $
4. A rekurziót alkalmazva $k$ lépésre: $N(A_k) <= N(A_0) (1 - 2/M)^k$.
Mivel $(1 - 2/M) < 1$, a hiba mértéke ($N(A_k)$) mértani sorozat szerint tart a nullához, tehát a mátrix diagonálissá válik.

=== Az LU- és QR-algoritmus alapötlete
Ezek a módszerek nem csak szimmetrikus mátrixokra alkalmasak, és szintén hasonlósági transzformációkra épülnek.

1. *LU-algoritmus:* Alapja az $A = L U$ felbontás. Az ötlet az, hogy ha $A_k = L_k U_k$, akkor a következő lépés legyen a tényezők felcserélt szorzata: $A_(k+1) = U_k L_k$. Mivel $A_(k+1) = L_k^(-1) A_k L_k$, a sajátértékek megmaradnak, és a mátrix fokozatosan felsőháromszög alakra tart.
2. *QR-algoritmus:* Ez a modern numerika alapja. $A_k = Q_k R_k$ felbontást készítünk ($Q$ ortogonális, $R$ felsőháromszög), majd a sorrendet megfordítva kapjuk a következőt: $A_(k+1) = R_k Q_k$. Itt $A_(k+1) = Q_k^T A_k Q_k$ hasonlósági transzformáció történik. Ez rendkívül stabil, és (megfelelő eltolásokkal kiegészítve) nagyon gyorsan konvergál egy olyan felsőháromszög mátrixhoz, aminek az átlójában ott csücsülnek a sajátértékek.

/*

### Beszédes magyarázat a 7. tételhez (a vizsgára):

Amikor a *Jacobi-módszerről* beszélsz, próbáld érzékeltetni a folyamat fizikai valóját. Magyarázd el, hogy a mátrixszal végzett transzformáció olyan, mintha a koordináta-rendszert folyamatosan forgatnád addig, amíg a tengelyek pontosan a *sajátvektorok* irányába nem mutatnak. Ebben a kitüntetett állásban a mátrix már nem forgatja a vektorokat, csak nyújtja őket (ezért lesz diagonális).

A *3. Lemma* a tétel szíve. Úgy is fogalmazhatsz, hogy a mátrixban van egyfajta "állandó összenergia" (a Frobenius-norma). A Jacobi-módszer minden lépésben "kiszívja" a nem-kívánatos elemekből ($a_(ij)$) az energiát, és mivel az összenergia nem veszhet el, a mátrix kénytelen ezt a főátlóba ($a_(ii), a_(jj)$) "átcsatornázni". Ezért lesz a folyamat végén a főátló a domináns.

A *konvergenciánál* emeld ki, hogy a *klasszikus* módszer azért jó, mert mindig a "legfájóbb" hibát (a legnagyobb elemet) orvosoljuk, így garantált a leggyorsabb csökkenés.

Végül a *QR-algoritmusnál* érdemes megjegyezni (csak szóban), hogy miért szeretjük jobban, mint a Jacobit: a Jacobi csak szimmetrikus mátrixokra jó, és minden sajátértéket egyszerre akar megtalálni, ami sokszor felesleges. A QR viszont tetszőleges mátrixokra működik, és a tridiagonális/Hessenberg alakra hozással (5. tétel) kombinálva elképesztően hatékony.

*/

#pagebreak()

= 8. Polinom interpoláció I.

A függvények közelítésének egyik legtermészetesebb módja az interpoláció, ahol a célunk egy olyan egyszerű függvény (polinom) megtalálása, amely bizonyos kitüntetett pontokban pontosan megegyezik az eredeti függvény értékeivel.

== a) Az interpoláció alapfeladata, létezése és egyértelműsége

=== Az alapfeladat megfogalmazása
Adottak az $[a, b]$ intervallumon belüli $x_0, x_1, ..., x_n$ különböző alappontok, valamint a hozzájuk tartozó $y_0, y_1, ..., y_n$ valós értékek (melyek gyakran egy $f$ függvény értékei: $y_i = f(x_i)$).
Olyan legfeljebb $n$-edfokú $p_n$ polinomot keresünk a $P_n$ halmazból, amelyre teljesül az interpolációs feltétel:
$ p_n (x_i) = y_i quad (i = 0, 1, ..., n). $
Fontos megfigyelni, hogy $n+1$ darab adatunk van (pontpár), és ehhez keresünk egy legfeljebb $n$-edfokú polinomot.

=== Tétel: Az interpolációs polinom létezése és egyértelműsége
Minden megadott $(x_i, y_i)$ számpár-sorozathoz (ahol az $x_i$-k különbözők) pontosan egy olyan $p_n in P_n$ polinom létezik, amely eleget tesz az interpolációs feltételeknek.

=== Bizonyítás (Határozatlan együtthatók módszerével)
1. Keressük a polinomot a természetes bázisban: $p_n(x) = a_0 + a_1 x + a_2 x^2 + dots + a_n x^n$.
2. Írjuk fel az interpolációs feltételeket minden pontra. Ez egy $(n+1)$ egyenletből álló lineáris egyenletrendszert (LER) eredményez az $a_k$ együtthatókra:
$ a_0 + a_1 x_0 + a_2 x_0^2 + dots + a_n x_0^n = y_0 $
$ a_0 + a_1 x_1 + a_2 x_1^2 + dots + a_n x_1^n = y_1 $
$ dots $
$ a_0 + a_1 x_n + a_2 x_n^2 + dots + a_n x_n^n = y_n $
3. Az egyenletrendszer mátrixa az úgynevezett *Vandermonde-mátrix*:
$
  V = mat(1, x_0, x_0^2, dots, x_0^n; 1, x_1, x_1^2, dots, x_1^n; dots, dots, dots, dots, dots; 1, x_n, x_n^2, dots, x_n^n)
$
4. A lineáris algebrából tudjuk, hogy a Vandermonde-mátrix determinánsa $det(V) = product_(i > j) (x_i - x_j)$.
5. Mivel kikötöttük, hogy az alappontok különbözők, a determináns nem lehet nulla.
6. Ha a determináns nem nulla, az egyenletrendszernek bármely jobb oldal ($y_i$) esetén létezik egyetlen egyértelmű megoldása az $a_k$ együtthatókra. Ezzel a létezést és az egyértelműséget is beláttuk.

=== A Lagrange-alappolinomok
Bár a fenti bizonyítás elméletileg tökéletes, a Vandermonde-mátrix invertálása numerikusan instabil. Ezért bevezetjük a Lagrange-alappolinomokat, amelyek egy speciális bázist alkotnak.

*Definíció:* Az $x_0, ..., x_n$ alappontokhoz tartozó $k$-adik Lagrange-alappolinom:
$ l_k (x) = product_(j=0, j != k)^n (x - x_j) / (x_k - x_j) $

=== A Lagrange-alappolinomok tulajdonságai és bizonyításuk
*Tulajdonság:* $l_k (x_i) = delta_(k i)$, azaz értéke 1, ha $i=k$, és 0, ha $i != k$.
*Bizonyítás:*
- Ha $i != k$, akkor a számlálóban a szorzat egyik tényezője $(x_i - x_i) = 0$ lesz, így az egész tört nulla.
- Ha $i = k$, akkor a számláló és a nevező pontosan megegyezik: $product (x_k - x_j) / (x_k - x_j) = 1$.

=== Az interpolációs polinom Lagrange-alakja
A fenti tulajdonság lehetővé teszi, hogy a keresett polinomot azonnal felírjuk:
$ L_n (x) = sum_(k=0)^n y_k l_k (x) $
Ez a forma rendkívül elegáns, mert behelyettesítve $x_i$-t, a szummából csak az az egy tag marad meg, ahol $k=i$ (ami éppen $y_i dot 1$), az összes többi kiesik (nulla lesz).

== b) Az interpoláció hibatétele és becslése

Gyakori kérdés, hogy ha egy $f$ függvényt polinommal helyettesítünk, mekkora hibát követünk el az alappontokon kívüli helyeken.

=== Tétel: Az interpoláció hibaformulája
Legyen $f in C^(n+1) [a, b]$ (n-szer folytonosan differenciálható), és legyenek $x_0, ..., x_n$ az alappontok. Ekkor minden $x in [a, b]$ ponthoz létezik olyan $xi_x$ az alappontok és $x$ által kifeszített legkisebb intervallumban, hogy:
$ f(x) - p_n(x) = f^((n+1)) (xi_x) / ((n+1)!) omega_n (x) $
ahol $omega_n (x) = product_(j=0)^n (x - x_j)$ a hiba-függvény (vagy csomóponti polinom).

=== Bizonyítás (Rolle-tétel alkalmazásával)
1. Ha $x$ megegyezik valamelyik alapponttal, a hiba 0, és az állítás triviálisan igaz.
2. Tegyük fel, hogy $x$ rögzített és nem alappont. Definiáljuk a következő segédfüggvényt $z$-ben:
$ g(z) = f(z) - p_n (z) - K omega_n (z) $
ahol $K$ egy olyan konstans, hogy $g(x) = 0$ legyen.
3. Vegyük észre, hogy $g(z)$ függvénynek legalább $n+2$ darab gyöke van az $[a, b]$ intervallumon (az $n+1$ darab alappont és a rögzített $x$).
4. A Rolle-tétel szerint ha egy folytonos és differenciálható függvénynek van $k$ gyöke, akkor a deriváltjának legalább $k-1$ gyöke van a gyökök között.
5. Alkalmazzuk ezt sorban:
  - $g(z)$-nek $n+2$ gyöke van.
  - $g'(z)$-nek legalább $n+1$ gyöke van.
  - ...
  - $g^((n+1)) (z)$-nek legalább 1 gyöke van. Jelöljük ezt $xi_x$-szel.
6. Számítsuk ki $g(z)$ $(n+1)$-edik deriváltját:
  - $f^((n+1)) (z)$ az eredeti függvény deriváltja.
  - $p_n^((n+1)) (z) = 0$, mert $p_n$ egy $n$-edfokú polinom, és annak $(n+1)$-edik deriváltja már nulla.
  - $omega_n^((n+1)) (z) = (n+1)!$, mert $omega_n$ egy $n+1$-edfokú polinom $z^(n+1)$ főtaggal.
7. Tehát $g^((n+1)) (xi_x) = f^((n+1)) (xi_x) - K(n+1)! = 0$.
8. Ebből kifejezve $K$-t: $K = f^((n+1)) (xi_x) / ((n+1)!)$.
9. Mivel a konstrukció szerint $g(x) = f(x) - p_n (x) - K omega_n (x) = 0$, behelyettesítve $K$ értékét megkapjuk a tétel állítását.

=== Hibabecslés (Gyakorlati korlát)
Mivel $xi_x$ pontos értékét nem ismerjük, a gyakorlatban felső becslést használunk:
$ |f(x) - p_n(x)| <= M_(n+1) / ((n+1)!) |omega_n (x)| $
ahol $M_(n+1) = max_(z in [a,b]) |f^((n+1)) (z)|$.
Ez a becslés mutatja, hogy a hiba két dologtól függ: a függvény "vadulásától" (magasabb deriváltak értéke) és az alappontok elhelyezkedésétől ($omega_n$ értéke).

/*

### Beszédes kiegészítés a 8. tételhez:

Amikor ezt a tételt magyarázod, emeld ki, hogy a *polinom interpoláció nem mindenható*. Az *egyértelműség* bizonyítása során a Vandermonde-determináns azért fontos, mert garantálja, hogy ha találsz egy jó polinomot (bármilyen módszerrel), akkor az *az az egyetlen*, ami létezik.

A *Lagrange-alappolinomoknál* érdemes megjegyezni, hogy ezek olyanok, mint a "kapcsolók". Az $l_k$ polinom csak az $x_k$ pontban "kapcsol be" (veszi fel az 1-et), az összes többi pontban néma marad (nulla). Így a teljes polinom csak egy súlyozott összege lesz a bemeneti értékeknek.

A *hibaformula bizonyítása* a szóbeli egyik "kedvence". A kulcs az a gondolat, hogy ha sok pontban megegyezik két függvény, akkor a különbségük sokszor hullámzik át a nullán. Minden deriválásnál elveszítünk egy gyököt (Rolle-elv), de ha elég sokáig deriválunk, végül marad egy olyan pont ($xi$), ahol a függvény "görbülete" (a deriváltja) közvetlenül kapcsolatba hozható a hibával.

Végül a *hibabecslésnél* érdemes előrevetíteni (ami a 10. tétel lesz), hogy mivel az $M_(n+1)$ a függvény adottsága, a hibát csak az *alappontok okos megválasztásával* (pl. Csebisev-alappontok) tudjuk csökkenteni, amivel az $omega_n(x)$ kilengéseit minimalizáljuk.

*/

#pagebreak()

= 9. Polinom interpoláció II.

Az interpoláció során nemcsak az a kérdés, hogy létezik-e a keresett polinom, hanem az is, hogyan tudjuk azt hatékonyan felírni és kiszámolni. A Newton-alak és az osztott differenciák módszere a numerikus analízis egyik legpraktikusabb eszköze, mivel rugalmasságot biztosít az alappontok számának növelése esetén.

== a) Az interpoláció alapfeladata és a Newton-alak felépítése

=== Az interpoláció alapfeladata (Emlékeztető)
Adottak az $x_0, x_1, ..., x_n$ különböző alappontok és a hozzájuk tartozó $y_0, y_1, ..., y_n$ függvényértékek. Olyan legfeljebb $n$-edfokú $p_n$ polinomot keresünk, amelyre teljesül:
$ p_n(x_i) = y_i, quad i = 0, 1, ..., n. $
Tudjuk, hogy ez a polinom létezik és egyértelmű.

=== Az osztott differenciák fogalma
Az osztott differenciák a függvény megváltozását mérik az alappontok függvényében, rekurzív módon definiálva:

1. *Nulladrendű osztott differencia:* Megegyezik a függvény adott pontbeli értékével:
  $ f[x_i] = f(x_i). $
2. *Elsőrendű osztott differencia:* Két szomszédos pont közötti változást ír le:
  $ f[x_i, x_(i+1)] = (f(x_(i+1)) - f(x_i)) / (x_(i+1) - x_i). $
3. *k-adrendű osztott differencia:* Az alacsonyabb rendű differenciák különbségeként épül fel:
  $ f[x_i, x_(i+1), ..., x_(i+k)] = (f[x_(i+1), ..., x_(i+k)] - f[x_i, ..., x_(i+k-1)]) / (x_(i+k) - x_i). $

=== A Newton-féle bázis
A Newton-alak felírásához egy speciális polinom-bázist használunk, amely a következő tagokból áll:
$ 1, (x - x_0), (x - x_0)(x - x_1), ..., (x - x_0)(x - x_1)...(x - x_(n-1)). $
Általánosan jelölve: $omega_0(x) = 1$ és $omega_k(x) = product_(j=0)^(k-1) (x - x_j)$.

=== Az interpolációs polinom Newton-alakja
A fenti bázisban felírt polinom együtthatói éppen a megfelelő rendű osztott differenciák:
$ N_n(x) = f(x_0) + sum_(k=1)^n f[x_0, x_1, ..., x_k] dot omega_k(x). $

=== A rekurziós formula
A Newton-alak legfőbb előnye, hogy ha új $x_(n+1)$ alappontot veszünk fel, a korábban kiszámolt polinomot nem kell kidobni, hanem egyszerűen kiegészíthetjük:
$ N_(n+1)(x) = N_n(x) + f[x_0, x_1, ..., x_(n+1)] dot omega_(n+1)(x). $

=== A Newton-alak hibatétele és bizonyítása
*Tétel:* Legyen $x$ egy olyan pont, amely nem alappont. Ekkor a hiba felírható osztott differencia segítségével:
$ f(x) - N_n(x) = f[x, x_0, x_1, ..., x_n] dot omega_n(x). $

*Bizonyítás:*
1. Tekintsünk egy olyan $N_(n+1)(z)$ polinomot, amely az $x_0, ..., x_n$ pontok mellett a rögzített $x$ helyen is interpolál.
2. A Newton-alak rekurziója szerint:
  $ N_(n+1)(z) = N_n(z) + f[x_0, ..., x_n, x] dot omega_n(z). $
3. Mivel $N_(n+1)$ az $x$ helyen pontosan $f(x)$-et adja, helyettesítsünk be $z = x$-et:
  $ f(x) = N_n(x) + f[x_0, ..., x_n, x] dot omega_n(x). $
4. Az osztott differenciák szimmetriája miatt (lásd b rész) az indexek sorrendje felcserélhető:
  $ f[x_0, ..., x_n, x] = f[x, x_0, ..., x_n]. $
5. Átrendezve kapjuk: $f(x) - N_n(x) = f[x, x_0, ..., x_n] dot omega_n(x)$.

== b) Az osztott differenciák tulajdonságai és a levezetés

=== Az osztott differenciák tulajdonságai
1. *Szimmetria:* Az osztott differencia értéke független az alappontok sorrendjétől (permutáció-invariáns).
2. *Lineáris leképezés:* Két függvény összegének osztott differenciája megegyezik a differenciák összegével.
3. *Kapcsolat a deriválttal:* Belátható, hogy $f[x_0, ..., x_k] = (f^((k))(xi)) / (k!)$ valamilyen $xi in [a, b]$ helyen.

=== Következmény a kétféle hibaformulából
A 8. tételben a hibát deriválttal ($(f^((n+1))(xi))/(n+1)!$), itt pedig osztott differenciával fejeztük ki. A kettő összevetéséből adódik:
$ f[x, x_0, ..., x_n] = (f^((n+1))(xi)) / ((n+1)!). $
Ez rávilágít arra, hogy az osztott differenciák valójában a magasabb rendű deriváltak diszkrét közelítései.

=== Az interpolációs polinom Newton-alakjának levezetése
A levezetés alapja a Lagrange-alak teleszkopikus felbontása:
1. Legyen $l_k (x)$ a $k$ pontra illeszkedő polinom. Felírhatjuk:
  $ L_n(x) = L_0(x) + (L_1(x) - L_0(x)) + ... + (L_n(x) - L_(n-1)(x)). $
2. A $Q_k(x) = l_k (x) - L_(k-1)(x)$ különbség legfeljebb $k$-adfokú, és gyöke az összes korábbi $x_0, ..., x_(k-1)$ alappontnak (hiszen ott mindkét $L$ ugyanazt az értéket veszi fel).
3. Így $Q_k(x) = c_k dot (x - x_0)...(x - x_(k-1)) = c_k dot omega_k(x)$.
4. A $c_k$ konstans meghatározásához behelyettesítjük $x_k$-t, amiből levezethető, hogy $c_k$ pontosan a $k$-adrendű osztott differencia lesz.

/*

### Beszédes kiegészítés a 9. tételhez (a vizsgára):

Amikor ezt a tételt magyarázod, kezdd azzal, hogy miért szeretjük a *Newton-alakot* jobban, mint a Lagrange-félét. A kulcsszó a *dinamizmus*. Ha mérési adatokat gyűjtesz, és kapsz egy újabb pontot, a Lagrange-módszernél az összes alappolinom megváltozik, mindent elölről kell számolni. A Newton-alaknál viszont csak "hozzátoldunk" egy újabb tagot a már meglévő polinomhoz.

Az *osztott differenciák táblázata* (amit a gyakorlaton is csináltál) valójában egy "háromszögmátrix", ahol minden oszlop az előző oszlop értékeiből táplálkozik. Emeld ki a vizsgán, hogy a *főátlóban* lévő elemek a lényegesek – ezek lesznek a polinom együtthatói.

A *hibaformula bizonyítása* ebben a tételben azért zseniális, mert nem kell hozzá Rolle-tétel vagy bonyolult analízis. Egyszerűen azt használjuk ki, hogy ha az $x$ pontot is kikiáltjuk alappontnak, akkor ott a hiba definíció szerint nulla lesz. Ebből a "trükkből" azonnal kiesik a hiba képlete.

Végül a *deriválttal való kapcsolatnál* érdemes megemlíteni: az osztott differencia olyan, mint egy "átlagos derivált" a megadott pontok felett. Ezért tudjuk majd a 13. tételnél (Hermite-interpoláció) használni őket akkor is, ha az alappontok összeesnek: ott az osztott differenciák simán átmennek a derivált értékekbe.

*/

#pagebreak()

= 10. A Csebisev-polinom

A Csebisev-polinomok (elsőfajú) a numerikus analízis legfontosabb speciális függvénysorozatai közé tartoznak. Nevüket Pafnutyij Lvovics Csebisev orosz matematikusról kapták. Különlegességük, hogy bár trigonometrikus függvényekkel definiáljuk őket, valójában valódi polinomok, amelyek rendkívüli tulajdonságokkal rendelkeznek a függvények közelítése terén.

== a) A Csebisev-polinom fogalma és alapvető tulajdonságai

=== Definíció
Az $n$-edfokú (elsőfajú) Csebisev-polinomot a $[-1, 1]$ intervallumon a következőképpen definiáljuk:
$ T_n (x) = cos(n dot arccos(x)), quad x in [-1, 1]. $
Bár a definícióban koszinusz és arkusz koszinusz szerepel, látni fogjuk, hogy ez minden $n$-re egy $n$-edfokú polinomot eredményez.

=== A háromtagú rekurzió és bizonyítása
A Csebisev-polinomok kiszámítása nem a definícióval, hanem egy hatékony rekurziós formulával történik.
*Állítás:*
$ T_0 (x) = 1 $
$ T_1 (x) = x $
$ T_(n+1) (x) = 2x dot T_n (x) - T_(n-1) (x) quad (n = 1, 2, dots). $

*Bizonyítás:*
Vezessük be a $theta = arccos(x)$ jelölést, ekkor $x = cos(theta)$. A definíció szerint $T_n (x) = cos(n theta)$.
Használjuk fel a koszinusz összegzési képleteit:
1. $cos((n+1)theta) = cos(n theta) cos(theta) - sin(n theta) sin(theta)$
2. $cos((n-1)theta) = cos(n theta) cos(theta) + sin(n theta) sin(theta)$
Adjuk össze a két egyenletet:
$ cos((n+1)theta) + cos((n-1)theta) = 2 cos(theta) cos(n theta). $
Visszahelyettesítve $x$-et és a polinomokat:
$ T_(n+1) (x) + T_(n-1) (x) = 2x dot T_n (x), $
amiből átrendezéssel pontosan a rekurziót kapjuk.

=== Főegyüttható és paritás
A rekurzióból látható, hogy $T_2(x) = 2x^2 - 1$, $T_3(x) = 4x^3 - 3x$, és így tovább.
* Megfigyelés: Minden lépésben a legmagasabb fokú tagot megszorozzuk $2x$-szel. Ebből következik, hogy $n >= 1$ esetén a $T_n$ polinom főegyütthatója $2^(n-1)$.
* Paritás: $T_n$ paritása megegyezik $n$ paritásával. Ha $n$ páros, $T_n$ páros függvény ($T_n(-x) = T_n(x)$), ha $n$ páratlan, akkor $T_n$ páratlan.

=== A gyökök meghatározása és bizonyítása
A Csebisev-polinomoknak pontosan $n$ darab különböző valós gyöke van a $(-1, 1)$ nyílt intervallumban.
*Állítás:* A $T_n$ polinom gyökei:
$ x_k = cos((2k+1) / (2n) pi), quad k = 0, 1, dots, n-1. $

*Bizonyítás:*
A gyökökhöz meg kell oldanunk a $T_n(x) = 0$ egyenletet:
$ cos(n arccos(x)) = 0. $
Tudjuk, hogy a koszinusz akkor nulla, ha az argumentuma a $pi/2$ páratlan többszöröse:
$ n arccos(x) = pi/2 + k pi = (2k+1)/2 pi. $
Leosztva $n$-nel:
$ arccos(x) = (2k+1) / (2n) pi. $
Mindkét oldal koszinuszát véve megkapjuk a fenti $x_k$ értékeket. Mivel a koszinusz függvény a $[0, pi]$ intervallumon szigorúan monoton, az $n$ darab különböző $k$ értékhez $n$ darab különböző gyök tartozik.

=== Szélsőértékek és bizonyításuk
A Csebisev-polinomok "hullámzása" a $[-1, 1]$ intervallumon rendkívül szabályos: $-1$ és $+1$ között oszcillálnak.
*Állítás:* $T_n$-nek $n+1$ darab szélsőérték helye van a $[-1, 1]$ intervallumon, ahol felváltva veszi fel a $+1$ és $-1$ értékeket. Ezek a helyek:
$ xi_k = cos((k pi) / n), quad k = 0, 1, dots, n. $

*Bizonyítás:*
Megoldandó: $cos(n arccos(x)) = plus.minus 1$.
A koszinusz akkor $plus.minus 1$, ha az argumentuma a $pi$ egész számú többszöröse:
$ n arccos(x) = k pi arrow.r arccos(x) = (k pi) / n. $
Visszahelyettesítve: $T_n (xi_k) = cos(n dot (k pi)/n) = cos(k pi) = (-1)^k$.
Látható, hogy $k=0$-nál $xi_0 = 1$ és $T_n(1) = 1$, $k=n$-nél pedig $xi_n = -1$.

== b) A Csebisev-tétel és szerepe az interpolációban

Ez a rész megmagyarázza, miért "optimálisak" ezek a polinomok. Vezessük be az *1-főegyütthatós Csebisev-polinomot*:
$ tilde(T)_n (x) = 1 / 2^(n-1) T_n (x). $
Ennek a polinomnak a főegyütthatója 1, és a maximális értéke a $[-1, 1]$ intervallumon $1 / 2^(n-1)$.

=== Csebisev-tétel (Extremális tulajdonság)
*Tétel:* Az összes olyan $n$-edfokú polinom közül, amelynek főegyütthatója 1, a $tilde(T)_n$ Csebisev-polinom az, amelynek a maximális abszolút értéke (szub-normája) a legkisebb a $[-1, 1]$ intervallumon. Azaz:
$ min_(P in P_n^((1))) ||P||_(oo) = ||tilde(T)_n||_(oo) = 1 / 2^(n-1). $

*Bizonyítás (Indirekt):*
1. Tegyük fel, hogy létezik egy olyan $Q$ polinom, melyre $||Q||_(oo) < ||tilde(T)_n||_(oo) = 1 / 2^(n-1)$.
2. Vizsgáljuk az $R = tilde(T)_n - Q$ különbséget. Mivel mindkét polinom főegyütthatója 1, a legmagasabb fokú tagok kiesnek, így $R$ egy legfeljebb $(n-1)$-edfokú polinom.
3. Nézzük $R$ értékeit a $tilde(T)_n$ szélsőértékhelyein ($xi_k$). Tudjuk, hogy $tilde(T)_n (xi_k) = (-1)^k / 2^(n-1)$.
4. Mivel feltettük, hogy $|Q(xi_k)| < 1 / 2^(n-1)$, ezért az $R$ különbség előjele minden pontban megegyezik a $tilde(T)_n$ előjelével:
  - Ha $k$ páros, $tilde(T)_n(xi_k) > 0$, tehát $R(xi_k) > 0$.
  - Ha $k$ páratlan, $tilde(T)_n(xi_k) < 0$, tehát $R(xi_k) < 0$.
5. Ez azt jelenti, hogy az $R$ polinom $n+1$ darab pont között legalább $n$-szer vált előjelet.
6. A Bolzano-tétel szerint $R$-nek ekkor legalább $n$ darab gyöke van.
7. Egy legfeljebb $(n-1)$-edfokú polinomnak csak akkor lehet $n$ darab gyöke, ha az azonosan nulla ($R equiv 0$).
8. Ekkor viszont $tilde(T)_n = Q$, ami ellentmond annak a feltevésnek, hogy $Q$ normája kisebb. Tehát $tilde(T)_n$ valóban a minimális.

=== Szerepe az interpolációban (Hiba minimalizálása)
Emlékezzünk az interpoláció hibaformulájára:
$ f(x) - p_n(x) = (f^((n+1)) (xi)) / ((n+1)!) omega_n(x). $
A hiba két fő részből áll: a függvény deriváltjából (amit nem tudunk befolyásolni) és az $omega_n(x) = product (x - x_i)$ csomóponti polinomból.
Az interpoláció akkor lesz a legpontosabb, ha az $omega_n(x)$ kilengéseit minimalizáljuk.
Az $omega_n$ egy olyan $n+1$-edfokú polinom, amelynek főegyütthatója 1. A Csebisev-tétel szerint ez a polinom akkor lesz a "legkisebb" a $[-1, 1]$ intervallumon, ha megegyezik a $tilde(T)_(n+1)$ Csebisev-polinommal.
*Következmény:* Az interpolációs hiba akkor lesz minimális, ha alappontoknak a Csebisev-polinom gyökeit választjuk.

=== Optimális interpoláció hibabecslése
1. *$[-1, 1]$ intervallumon:* Ha az alappontok a $T_(n+1)$ gyökei, akkor $||omega_n||_(oo) = 1 / 2^n$. Ekkor:
$ ||f - L_n||_(oo) <= M_(n+1) / ((n+1)! dot 2^n) $
ahol $M_(n+1) = max |f^((n+1))|$.

2. *$[a, b]$ intervallumon:* Általános intervallum esetén a gyököket transzformálnunk kell: $x_k' = (b-a)/2 x_k + (a+b)/2$. Ekkor az $omega_n$ norma értéke $( (b-a)/2 )^(n+1) dot 1/2^n$-re módosul, a hibabecslés pedig:
$ ||f - L_n||_(oo) <= M_(n+1) / ((n+1)!) dot ( (b-a) / 2 )^(n+1) dot 1 / 2^n. $

/*

### Beszédes kiegészítés a 10. tételhez (szóbeli tippek):

Amikor a *Csebisev-polinomokról* beszélsz, emeld ki, hogy miért hívják őket "egyenletesen hullámzó" polinomoknak. A legtöbb polinom a szélek felé "elszáll" (gondolj a Runge-jelenségre, ahol az egyenletes pontoknál a hiba az intervallum szélein óriási lesz). A Csebisev-polinomok titka, hogy *be sűrűsödnek az intervallum szélei felé*.

Magyarázd el a vizsgáztatónak, hogy ha megnézzük a gyökök képletét ($x_k = cos(dots)$), látható, hogy a széleken (ahol a koszinusz deriváltja kicsi) a pontok közelebb vannak egymáshoz. Ez a sűrűsödés ellensúlyozza a polinomok természetes hajlamát a széleken való kilengésre.

A *Csebisev-tétel bizonyítása* a "váltakozó előjelű" trükkel az analízis egyik legszebb gondolata. Lényegében azt mondjuk el, hogy ha lenne "jobb" (kisebb) polinomunk, akkor az annyiszor kellene, hogy keresztezze a Csebisev-polinomot, ahány gyöke egyáltalán nem is lehetne.

Végül hangsúlyozd: a Csebisev-alappontok használata *nem csak egy elméleti érdekesség*, hanem a gyakorlati numerikus számítások (pl. Matlab `chebfun` csomagja) alapköve. Ez az egyetlen módja annak, hogy magas fokszámú interpolációnál elkerüljük a numerikus katasztrófát.

*/

#pagebreak()

= 11. Polinom interpoláció III.

A korábbi tételekben láttuk, hogy az interpolációs polinom létezik, egyértelmű, és elméletileg remekül közelít. Azonban a gyakorlati alkalmazás során két komoly akadályba ütközünk: egyrészt a bemenő adatok (függvényértékek) pontatlansága "elszállhat" a számítás során, másrészt nem minden függvény esetén igaz, hogy több pont több pontosságot jelent. Ez a tétel ezen stabilitási és konvergencia-kérdések matematikai hátterét tárja fel.

== a) Lebesgue-függvény, Lebesgue-állandó és az öröklött hiba

Amikor egy számítógépes modellben dolgozunk, a függvényértékeket ($y_i$) sosem pontosan ismerjük (mérési hiba vagy kerekítés miatt). Kérdés: ha az $y_i$ értékeket egy kicsit megváltoztatjuk, mennyire változik meg maga az interpolációs polinom?

=== A Lebesgue-függvény és Lebesgue-állandó fogalma
Legyenek $x_0, x_1, ..., x_n$ adott alappontok az $[a, b]$ intervallumon, és jelölje $l_k (x)$ a hozzájuk tartozó Lagrange-alappolinomokat.

1. *Lebesgue-függvény:* Azt a függvényt, amely az alappolinomok abszolút értékeinek összegét adja meg minden pontban, Lebesgue-függvénynek nevezzük:
$ cal(L)_n (x) = sum_(k=0)^n |l_k (x)|, quad x in [a, b]. $

2. *Lebesgue-állandó:* A Lebesgue-függvény maximumát az intervallumon Lebesgue-állandónak nevezzük:
$ Lambda_n = norm(cal(L)_n)_(oo) = max_(x in [a, b]) sum_(k=0)^n |l_k (x)|. $

=== A Lebesgue-állandó jelentősége
A $Lambda_n$ egyfajta "hibaerősítési tényező". Megmutatja, hogy az alappontokban elkövetett hiba hányszorosára duzzadhat fel az interpoláció során az alappontok közötti részeken.
- *Egyenletes pontoknál:* $Lambda_n$ exponenciálisan növekszik $n$ függvényében ($Lambda_n approx 2^n / (e n log n)$), ami katasztrofális instabilitáshoz vezet.
- *Csebisev-pontoknál:* A növekedés csak logaritmikus ($Lambda_n approx 2/pi log(n) + c$), ami a lehető leglassabb növekedés, tehát ez a legstabilabb pontrendszer.

=== Tétel: A Lagrange-interpoláció öröklött hibája
Legyen $L_n(x)$ a pontos $f(x_i)$ értékekre, és $tilde(L)_n(x)$ a hibás $tilde(f)(x_i)$ értékekre felírt interpolációs polinom. Tegyük fel, hogy a bemenő adatok hibája korlátos: $|f(x_i) - tilde(f)(x_i)| <= epsilon$ minden $i$-re. Ekkor a két polinom eltérése:
$ |L_n(x) - tilde(L)_n(x)| <= epsilon dot Lambda_n, quad x in [a, b]. $

=== Bizonyítás
1. Írjuk fel mindkét polinomot Lagrange-alakban:
$ L_n(x) = sum_(i=0)^n f(x_i) l_i(x) quad "és" quad tilde(L)_n(x) = sum_(i=0)^n tilde(f)(x_i) l_i(x). $
2. Vegyük a két polinom különbségét és használjuk a szumma linearitását:
$ |L_n(x) - tilde(L)_n(x)| = abs(sum_(i=0)^n (f(x_i) - tilde(f)(x_i)) l_i(x)). $
3. Alkalmazzuk a háromszög-egyenlőtlenséget (a szumma abszolút értéke kisebb-egyenlő, mint az abszolút értékek szummája):
$ |L_n(x) - tilde(L)_n(x)| <= sum_(i=0)^n abs(f(x_i) - tilde(f)(x_i)) dot abs(l_i(x)). $
4. Használjuk fel a feltételt, hogy minden alappontban a hiba legfeljebb $epsilon$:
$ |L_n(x) - tilde(L)_n(x)| <= epsilon sum_(i=0)^n |l_i(x)|. $
5. Vegyük észre, hogy a jobb oldali szumma pontosan a $cal(L)_n(x)$ Lebesgue-függvény:
$ |L_n(x) - tilde(L)_n(x)| <= epsilon dot cal(L)_n(x). $
6. Mivel $cal(L)_n(x) <= Lambda_n$ minden $x$-re, megkaptuk a tétel állítását:
$ |L_n(x) - tilde(L)_n(x)| <= epsilon dot Lambda_n. $

== b) Az interpoláció konvergencia-kérdései és tételei

Azt gondolnánk, hogy ha egy folytonos függvényt egyre több pontban interpolálunk ($n -> oo$), akkor a polinom sorozat egyenletesen tart majd a függvényhez. Sajnos ez nem igaz.

=== Problémafelvetés és divergencia példák
Vannak olyan "rosszul viselkedő" függvények és alappontrendszerek, ahol a fokszám növelése nem csökkenti, hanem drasztikusan növeli a hibát.
1. *Folytonos, de nem sima függvények:* $f(x) = |x|$ esetén egyenletes alappontokon az interpoláció nem konvergál mindenhol.
2. *Runge-jelenség:* Carl Runge 1901-ben mutatta meg, hogy az $f(x) = 1 / (1 + 25x^2)$ sima függvény esetén egyenletes alappontokon az interpolációs polinomok az intervallum szélei felé vadul oszcillálni kezdenek, és a hiba a végtelenbe tart, ha $n -> oo$.

=== Három fundamentális tétel a konvergenciáról

1. *Konvergencia-tétel (elegendő feltétel):* Ha $f in C^oo [a, b]$ és létezik olyan $M$, hogy minden $n$-re $norm(f^((n)))_(oo) <= M^n$, akkor tetszőleges alappontrendszer esetén az interpoláció egyenletesen konvergál ($L_n -> f$).
  - *Magyarázat:* Ez csak a "szuper-sima" függvényekre (pl. $e^x$, $sin x$) igaz.

2. *Faber-tétel (A negatív eredmény):* Bármilyen alappontrendszer-sorozatot is választunk (akár a Csebisev-pontokat is), mindig létezik olyan $f$ folytonos függvény, amelyre az interpolációs polinomok sorozata nem konvergál egyenletesen.
  - *Tanulság:* Nincs olyan pontrendszer, ami mindenre jó.

3. *Marcinkiewicz-tétel (A pozitív eredmény):* Bármilyen $f$ folytonos függvényhez létezik olyan alappontrendszer-sorozat, amelyre az interpolációs polinomok egyenletesen konvergálnak $f$-hez.
  - *Tanulság:* Minden függvényhez van egy jó pontrendszer, csak meg kell találni.

=== A konvergencia-tétel bizonyítása (Szuper-sima függvényekre)
*Állítás:* Ha minden derivált korlátos ($norm(f^((n)))_(oo) <= M^n$), akkor $norm(f - L_n)_(oo) -> 0$.

*Bizonyítás:*
1. Induljunk ki az interpoláció hibaformulájából:
$ |f(x) - L_n(x)| = abs((f^((n+1)) (xi)) / ((n+1)!) omega_n(x)). $
2. Becsüljük meg a tagokat:
  - A deriváltat a feltétel szerint: $|f^((n+1)) (xi)| <= M^(n+1)$.
  - A csomóponti polinomot a legdurvább becsléssel: $|omega_n(x)| = abs(product_(i=0)^n (x - x_i)) <= (b - a)^(n+1)$.
3. Helyettesítsük be ezeket:
$ |f(x) - L_n(x)| <= (M dot (b-a))^(n+1) / ((n+1)!). $
4. Vizsgáljuk a határátmenetet $n -> oo$ esetén. A kifejezés számlálójában egy konstans hatványa áll, a nevezőben pedig a faktoriális.
5. Tudjuk az analízisből, hogy bármely $C$ konstansra $lim_(n -> oo) C^n / (n!) = 0$.
6. Esetünkben $C = M(b-a)$, tehát a hiba nullához tart.

/*

### Beszédes magyarázat a 11. tételhez (szóbeli vizsgára):

Amikor erről a tételről beszélsz, próbáld érzékeltetni a numerikus analízis drámáját. Az *a) részben* a lényeg az, hogy a matematika "ideális világában" ($L_n$) és a gép "zajos világában" ($tilde(L)_n$) nem ugyanazt a polinomot kapjuk. A *Lebesgue-állandó* ($Lambda_n$) a híd a kettő között. Mondd el a vizsgáztatónak: ha $Lambda_n = 100$, az azt jelenti, hogy ha a mérési adatodban van egy $0.01$ hiba, az az interpolált görbében már $1.0$ egységnyi ugrást is okozhat! Ezért "gyűlöljük" az egyenletes pontokat magas fokszám mellett: ott a $Lambda_n$ olyan gyorsan nő, hogy a legkisebb kerekítési hiba is felismerhetetlenné teszi a függvényt.

A *b) résznél* a *Runge-jelenségre* kell kihegyezni a mondandót. Magyarázd el, hogy mi történik geometriailag: az egyenletes alappontoknál a széleken túl nagyok a rések, és a polinom (ami "vissza akar kanyarodni" a következő ponthoz) kénytelen hatalmasat lendülni. Ez okozza a vad oszcillációt.

A három tétel (*Konvergencia-tétel, Faber, Marcinkiewicz*) egyfajta matematikai "háromszöget" alkot. A konvergencia-tétel azt mondja: "Ha a függvényed nagyon rendes, nem lesz baj." Faber azt mondja: "Nincs tökéletes pontrendszer." Marcinkiewicz pedig azt: "Minden függvényhez van egy ideális partner (pontrendszer)."

Végül a *faktoriális vs. hatvány* érvelés a bizonyítás végén nagyon fontos: a faktoriális ($n!$) mindig "legyőzi" a hatványt ($C^n$), ez a matematikai garancia arra, hogy a hiba végül elenyészik a szuper-sima függvényeknél.

*/

#pagebreak()

= 12. Hermite-féle interpoláció I.

A gyakorlati feladatok során gyakran nemcsak a függvény értékeit ismerjük bizonyos pontokban, hanem a változásának sebességét (deriváltját) is. A Hermite-interpoláció célja, hogy olyan polinomot illesszünk, amely az alappontokban nemcsak a függvényértéket, hanem a megadott rendű deriváltakat is pontosan felveszi.

== a) Az Hermite-féle interpoláció fogalma, speciális esetei, létezése és egyértelműsége

=== A Hermite-interpoláció alapfeladata
Adottak az $[a, b]$ intervallumon belüli $x_0, x_1, ..., x_k$ különböző alappontok. Minden alapponthoz rendelünk egy $m_i$ pozitív egész számot, amelyet az alappont *multiplicitásának* nevezünk. Ez a szám határozza meg, hogy az adott pontban hány feltételt kell kielégítenie a polinomnak.
Összesen $M = sum_(i=0)^k m_i$ darab feltételünk van. Ehhez egy olyan, legfeljebb $m = M - 1$ fokszámú $H_m$ polinomot keresünk, amelyre teljesül:
$ H_m^((j))(x_i) = y_i^((j)) quad (i = 0, 1, ..., k; j = 0, 1, ..., m_i - 1). $
Itt $H_m^((j))$ a polinom $j$-edik deriváltját jelöli (a $j=0$ eset a függvényértéket jelenti).

=== Speciális esetek
A Hermite-interpoláció egy rendkívül általános keretrendszer, amely magában foglalja a korábban tanult közelítéseket is:
1. *Lagrange-interpoláció:* Ha minden pont multiplicitása 1 ($m_i = 1$), akkor csak függvényértékeket írunk elő. Ekkor $M = k+1$, és visszakapjuk a klasszikus interpolációt.
2. *Taylor-polinom:* Ha csak egyetlen alappontunk van ($k = 0$) és annak multiplicitása $m_0 = m+1$, akkor a polinom az adott pontbeli függvényértéket és az első $m$ darab deriváltat veszi fel. Ez pontosan az $m$-edfokú Taylor-polinom.
3. *Fejér–Hermite-interpoláció:* Speciális eset, amikor minden alappont multiplicitása pontosan 2 ($m_i = 2$). Ilyenkor minden pontban ismerjük a függvényértéket és az első deriváltat is. A polinom fokszáma ekkor $2k+1$.
4. *Fejér-féle lépcsőparabola:* A Fejér–Hermite egy olyan változata, ahol a deriváltakra tett feltételek mind nullák ($y_i^((1)) = 0$). Ez rendkívül stabil közelítést ad, különösen Csebisev-alappontokon.

=== Tétel: A Hermite-interpolációs polinom létezése és egyértelműsége
Minden Hermite-féle interpolációs feladatnak pontosan egy megoldása van a legfeljebb $m$-edfokú polinomok halmazában.

=== Bizonyítás (Az egyértelműségre alapozva)
A feladat felírható egy $M times M$ méretű lineáris egyenletrendszerként, ahol az ismeretlenek a polinom $a_j$ együtthatói. A lineáris algebrából tudjuk, hogy egy ilyen rendszernek akkor és csak akkor van egyértelmű megoldása minden jobb oldalra, ha a hozzá tartozó homogén feladatnak csak a triviális (nulla) megoldása létezik.
1. Tekintsük a homogén feladatot: keressünk olyan $Q$ polinomot, amelynek minden előírt értéke és deriváltja nulla ($y_i^((j)) = 0$).
2. Ha $Q^((j))(x_i) = 0$ teljesül $j = 0, dots, m_i - 1$ esetén, az azt jelenti, hogy az $x_i$ pont a $Q$ polinomnak legalább $m_i$-szeres gyöke.
3. A gyökök száma multiplicitással számolva: $sum_(i=0)^k m_i = M$.
4. Tudjuk, hogy $Q$ egy legfeljebb $m = M-1$ fokszámú polinom.
5. Az algebra alaptétele szerint egy $m$-edfokú polinomnak legfeljebb $m$ darab gyöke lehet, kivéve, ha a polinom az azonosan nulla függvény.
6. Mivel $Q$-nak $M$ darab gyöke van és $M > m$, ezért $Q equiv 0$.
7. Ezzel beláttuk az egyértelműséget, amiből következik a megoldás létezése is tetszőleges adatokra.

== b) Az Hermite-féle interpoláció hibatétele és az inverz interpoláció

=== Tétel: Hermite-interpoláció hibaformulája
Legyen $f in C^(m+1)[a, b]$, és legyen $H_m$ az $x_i$ pontokon $m_i$ multiplicitással illeszkedő Hermite-polinom. Ekkor minden $x in [a, b]$ ponthoz létezik olyan $xi_x$ az intervallumban, hogy:
$ f(x) - H_m(x) = (f^((m+1))(xi_x))/((m+1)!) Omega_m(x) $
ahol $Omega_m(x) = product_(i=0)^k (x - x_i)^(m_i)$ a Hermite-féle csomóponti polinom.

=== Bizonyítás (Rolle-tétel általánosításával)
1. Rögzítsünk egy $x$ pontot, ami nem alappont. Definiáljuk a segédfüggvényt:
$ G(z) = f(z) - H_m(z) - K Omega_m(z), $
ahol $K$-t úgy választjuk, hogy $G(x) = 0$ legyen.
2. Vizsgáljuk $G(z)$ gyökeit:
  - Van $k+1$ darab alappontunk, ahol $G$ a deriváltjaival együtt nulla (összesen $M$ feltétel).
  - Plusz van a rögzített $x$ pontunk, ahol $G(x)=0$.
  - Ez összesen $M+1 = m+2$ darab gyök (multiplicitással számolva).
3. Alkalmazzuk a Rolle-tételt: ha egy függvénynek van két gyöke, a deriváltjának van legalább egy gyöke közöttük. Ha egy pont $m_i$-szeres gyök, akkor a deriváltjának ott $(m_i-1)$-szeres gyöke lesz.
4. Minden deriválásnál eggyel csökken a gyökök száma, de a különböző gyökök között mindig születik egy új "Rolle-gyök".
5. Az $m+1$-edik deriváltnál, $G^((m+1))(z)$-nél, legalább 1 gyök marad az intervallumban. Jelöljük ezt $xi_x$-szel.
6. $0 = G^((m+1))(xi_x) = f^((m+1))(xi_x) - 0 - K dot (m+1)!$
  - A $H_m^((m+1)) = 0$, mert $m$-edfokú.
  - Az $Omega_m$ egy $m+1$ fokszámú polinom $z^(m+1)$ főtaggal, így $(m+1)$-edik deriváltja $(m+1)!$.
7. Kifejezve $K$-t és visszahelyettesítve $G(x)=0$-ba, megkapjuk az állítást.

=== Az inverz interpoláció elve és alkalmazása
Az inverz interpoláció egy elmés trükk nemlineáris egyenletek ($f(x) = 0$) megoldására, ahol az interpolációt "visszafelé" használjuk.

*Az alapötlet:* Tegyük fel, hogy az $f$ függvény szigorúan monoton (és így invertálható) az $[a, b]$ intervallumon. Ahelyett, hogy az $f(x)$ függvényt közelítenénk, az $f^(-1)$ inverz függvényt közelítjük egy polinommal.
1. Ismerjük az $(x_i, y_i)$ pontokat, ahol $y_i = f(x_i)$.
2. Tekintsük az $y$ értékeket "alappontoknak" és az $x$ értékeket a hozzájuk tartozó "függvényértékeknek".
3. Készítsünk egy $Q_n(y)$ interpolációs polinomot, amelyre $Q_n(y_i) = x_i$.
4. Ekkor $Q_n(y) approx f^(-1)(y)$.
5. Mivel az eredeti egyenletünk $f(x) = 0$, a keresett gyök $x^* = f^(-1)(0)$.
6. A gyök közelítése tehát egyszerűen a polinom értéke a nullában: $x^* approx Q_n(0)$.

*Alkalmazás:* Ez a módszer rendkívül hasznos, mert elkerüli a $p_n(x) = 0$ magas fokszámú egyenlet megoldásának nehézségeit. Ha a deriváltakat is ismerjük, Hermite-típusú inverz interpolációt is végezhetünk, ami még gyorsabb konvergenciát eredményez (pl. a Newton-módszer egy speciális esete ennek).

/*

### Beszédes kiegészítés a 12. tételhez (szóbeli tippek):

Amikor erről a tételről beszélsz, hangsúlyozd a *"multiplicitás"* jelentőségét. Magyarázd el a vizsgáztatónak, hogy a Hermite-interpoláció tulajdonképpen pontok *"összecsúsztatása"*. Ha két alappont ($x_0$ és $x_1$) végtelenül közel kerül egymáshoz, akkor a közöttük felírt osztott differencia ($ frac(f(x_1)-f(x_0))(x_1-x_0) $) a deriváltba megy át. Ezért kell a multiplicitás: az $m_i=2$ azt jelenti, hogy ott két pont "olvadt össze", ezért kell ott a függvényérték mellé a derivált is.

A *létezés és egyértelműség* bizonyításánál a legfontosabb láncszem a homogén feladat. Említsd meg: ha egy polinomnak és az első deriváltjának is nulla az értéke egy pontban, akkor az a pont egy "érintő gyök", tehát legalább kétszeres. Ebből jön ki, hogy több gyöke lenne, mint a fokszáma, ami lehetetlen.

A *hibaformulánál* mutass rá a hasonlóságra a Lagrange-esettel. A különbség csak az $Omega_m(x)$-ben van: itt az alappontok a multiplicitásuknak megfelelő hatványon szerepelnek. Ez geometriailag azt jelenti, hogy a hiba az alappontok közelében sokkal "laposabban" (gyorsabban) simul nullához, mint a sima interpolációnál.

Végül az *inverz interpolációnál* emeld ki a zsenialitását: nem egyenletet oldunk meg (ami nehéz), hanem csak kiértékelünk egy polinomot a nullában (ami könnyű). Ez a numerikus analízis egyik legpraktikusabb "menekülőútja", amikor egy gyököt kell gyorsan becsülni.

*/

#pagebreak()

= 13. Hermite-féle interpoláció II.

A Hermite-interpoláció elméleti alapozása után (12. tétel) most azt vizsgáljuk meg, hogyan tudjuk ezt a speciális polinomot a gyakorlatban, algoritmusok számára is emészthető módon felépíteni. Két fő utat járunk be: a rugalmas Newton-alakot és a szerkezetileg elegáns Lagrange-típusú előállítást.

== a) Az Hermite-interpoláció alapjai és a Newton-alak kiterjesztése

=== Alapfeladat, létezés és egyértelműség (Emlékeztető)
Adottak az $x_0, x_1, ..., x_k$ különböző alappontok, a hozzájuk tartozó $m_i$ multiplicitások (hogy hány feltételt írunk elő az adott pontban), valamint a $y_i^((j))$ függvény- és deriváltértékek.
A feladat egy olyan legfeljebb $m = (sum m_i) - 1$ fokszámú $H_m$ polinom meghatározása, amelyre:
$ H_m^((j))(x_i) = y_i^((j)) quad (i=0, ..., k; j=0, ..., m_i - 1). $
Tudjuk, hogy ez a feladat mindig egyértelműen megoldható, mivel a hozzá tartozó homogén egyenletrendszernek (ahol minden előírt érték nulla) csak a triviális nulla-polinom a megoldása (hiszen több gyöke lenne, mint a fokszáma).

=== Az osztott differencia fogalmának kiterjesztése
A Newton-alak felírásához szükségünk van az osztott differenciákra. De mi történik, ha az alappontok "összecsúsznak"? A klasszikus képletben; $ (f(x_1)-f(x_0))/(x_1-x_0) $ a nevező nullává válna.
A megoldást a hibaformulák összevetése és a határérték-számítás adja:
1. *Elsőrendű eset:* Ha $x_1 -> x_0$, akkor az $f[x_0, x_1]$ osztott differencia tart a függvény $x_0$ pontbeli deriváltjához. Ezért definiáljuk így:
  $ f[x_i, x_i] := f'(x_i). $
2. *Általános $j$-edrendű eset:* Ha $j+1$ darab alappont esik egybe, a $j$-edrendű osztott differencia a $j$-edik deriválttal hozható összefüggésbe:
  $ f[x_i, x_i, ..., x_i] := (f^((j))(x_i)) / (j!). $
Ez a definíció lehetővé teszi, hogy a Newton-féle osztott differencia táblázatot akkor is kitölthessük, ha nincsenek különböző pontjaink, csak egy pontunk és annak magasabb rendű deriváltjai.

=== A Newton-alak felírása Hermite-esetben
A gyakorlati kiszámítás menete a következő:
1. Készítünk egy osztott differencia táblázatot, ahol minden $x_i$ alappontot pontosan $m_i$-szer sorolunk fel egymás után.
2. A táblázat első oszlopaiba beírjuk az ismert függvényértékeket.
3. Azokban a sorokban, ahol az alappontok megegyeznek, a "hiányzó" osztott differenciák helyére behelyettesítjük a fenti deriváltas definíciókat ($f^((j))/j!$).
4. A táblázat többi részét (ahol különböző pontok találkoznak) a megszokott rekurzióval töltjük ki.
5. A polinom Newton-alakját a táblázat főátlójában (a legfelső értékek) szereplő $c_k$ együtthatókkal írjuk fel:
  $ H_m(x) = c_0 + c_1(x-z_0) + c_2(x-z_0)(x-z_1) + ... + c_m(x-z_0)...(x-z_(m-1)), $
  ahol $z_i$ az "expanded" alappont-sorozat (a multiplicitásokkal felsorolt pontok).

== b) Fejér–Hermite alappolinomok és a Lagrange-alak

Amikor minden alappontban pontosan a függvényértéket és az első deriváltat ismerjük ($m_i = 2$ minden $i$-re), Fejér–Hermite interpolációról beszélünk. Ilyenkor a polinom fokszáma $2k+1$. Ezt a polinomot felírhatjuk Lagrange-szerű bázisban is.

=== A Fejér–Hermite alappolinomok definíciója
Olyan alappolinomokat keresünk, amelyek "szétválasztják" a függvényértékek és a deriváltak hatását.
1. *Elsőfajú alappolinomok ($A_i$):* Ezeknél $A_i(x_j) = delta_(i j)$ és $A_i'(x_j) = 0$. (Csak az egyik pontban vesz fel 1-et, és sehol sincs meredeksége.)
2. *Másodfajú alappolinomok ($B_i$):* Ezeknél $B_i(x_j) = 0$ és $B_i'(x_j) = delta_(i j)$. (Mindenhol nulla az értéke, de az egyik pontban 1 a meredeksége.)

=== Az alappolinomok képleteinek levezetése és bizonyítása
Keressük az alappolinomokat $P_(2k+1)$ fokszámban. Tudjuk, hogy mindkét típusnak minden $j != i$ esetén kétszeres gyöke van az $x_j$ pontokban. Ezért mindegyik tartalmazni fogja az $l_i^2(x)$ tényezőt, ahol $l_i$ a klasszikus Lagrange-alappolinom.

*A másodfajú ($B_i$) bizonyítása:*
Tegyük fel, hogy $B_i(x) = (a x + b) l_i^2(x)$.
Mivel $B_i(x_i) = 0$, ezért $a x_i + b = 0$, tehát a lineáris tag $(x - x_i)$ alakú.
Legyen $B_i(x) = c (x - x_i) l_i^2(x)$.
Nézzük a deriváltat $x_i$-ben: $B_i'(x_i) = c dot 1 dot l_i^2(x_i) + c(x_i - x_i) dot [l_i^2(x_i)]' = c dot 1 dot 1^2 + 0 = c$.
Mivel azt akarjuk, hogy $B_i'(x_i) = 1$, ezért $c=1$.
*Eredmény:* $B_i(x) = (x - x_i) l_i^2(x)$.

*Az elsőfajú ($A_i$) bizonyítása:*
Legyen $A_i(x) = (a x + b) l_i^2(x)$.
1. Feltétel ($A_i(x_i)=1$): $a x_i + b = 1$.
2. Feltétel ($A_i'(x_i)=0$): Deriváljuk szorzatként: $A_i'(x) = a dot l_i^2(x) + (a x + b) dot 2 l_i(x) l_i'(x)$.
Behelyettesítve $x_i$-t: $A_i'(x_i) = a dot 1^2 + (1) dot 2 dot 1 dot l_i'(x_i) = a + 2 l_i'(x_i) = 0$.
Ebből $a = -2 l_i'(x_i)$.
Visszahelyettesítve a 1. feltételbe: $b = 1 - a x_i = 1 + 2 l_i'(x_i) x_i$.
A lineáris tag: $a x + b = -2 l_i'(x_i) x + 1 + 2 l_i'(x_i) x_i = 1 - 2(x - x_i) l_i'(x_i)$.
*Eredmény:* $A_i(x) = [1 - 2(x - x_i) l_i'(x_i)] l_i^2(x)$.

=== Az interpolációs polinom Lagrange-alakjának bizonyítása
*Tétel:* A Fejér–Hermite interpolációs polinom előállítható a következő alakban:
$ H_(2k+1)(x) = sum_(i=0)^k f(x_i) A_i(x) + sum_(i=0)^k f'(x_i) B_i(x). $

*Bizonyítás:*
Ellenőriznünk kell, hogy ez a lineáris kombináció teljesíti-e az interpolációs feltételeket tetszőleges $x_j$ pontban.
1. *Függvényérték:* $H_(2k+1)(x_j) = sum f(x_i) A_i (x_j) + sum f'(x_i) B_i (x_j)$.
  Az alappolinomok tulajdonságai miatt $A_i(x_j)$ csak akkor nem nulla, ha $i=j$ (ekkor 1), és $B_i(x_j)$ mindenhol nulla.
  Így $H_(2k+1) (x_j) = f(x_j) dot 1 + 0 = f(x_j)$. Megfelel.
2. *Derivált:* $H'_(2k+1) (x_j) = sum f(x_i) A'_i (x_j) + sum f'(x_i) B'_i (x_j)$.
  Mivel $A'_i (x_j)$ mindenhol nulla, és $B'_i (x_j)$ csak akkor 1, ha $i=j$, különben nulla.
  Így $H'_(2k+1) (x_j) = 0 + f'(x_j) dot 1 = f'(x_j)$. Megfelel.
Mivel a feltételeket teljesíti és a fokszáma rendben van, az egyértelműség miatt ez a keresett polinom.

/*

### Beszédes magyarázat a 13. tételhez (a sikeres felelethez):

Amikor erről a tételről beszélsz, próbáld megvilágítani a *kétféle szemléletmódot*.

A *Newton-alaknál* a lényeg a *határátmenet*. Magyarázd el a vizsgáztatónak, hogy miért írjuk fel az alappontokat többször a táblázatban. Képzeld el, hogy van két pontod, $x_0$ és $x_1$, amik elkezdenek egymáshoz közeledni. A köztük lévő szelő meredeksége ($f[x_0, x_1]$) egyre jobban hasonlít az érintő meredekségére ($f'(x_0)$). Amikor a két pont teljesen egybeesik, a táblázatban a "0/0" helyett egyszerűen beírjuk a deriváltat. Ez egy rendkívül stabil és elegáns módja annak, hogy a klasszikus algoritmust "felokosítsuk" a deriváltak fogadására.

A *Lagrange-alaknál* (a tétel b része) a geometria a kulcs. Itt nem egyben építjük a polinomot, hanem "alkatrészekből" rakjuk össze. Az $A_i(x)$ és $B_i(x)$ alappolinomok olyanok, mint a precíziós szerszámok:
- Az *$A_i$* alappolinom gondoskodik arról, hogy a függvényérték jó legyen, de közben vigyáz, hogy ne rontsa el a meredekséget (mert a deriváltja nulla az alappontokban).
- A *$B_i$* pedig fordítva: ő csak a meredekséget állítja be, de közben nem mozdítja el a függvényértéket (mert az értéke nulla az alappontokban).

A *bizonyításoknál* hangsúlyozd az *$l_i^2(x)$* szerepét. Miért kell a négyzet? Azért, mert ha egy polinomnak egy pontban az értéke ÉS a deriváltja is nulla, akkor ott legalább kétszeres gyöke kell legyen. A Lagrange-alappolinom négyzete pontosan ezt biztosítja: egy olyan "érintő gyököt", ami nem engedi, hogy az alappolinom "belezavarjon" a többi pont értékeibe.

Végül említsd meg a *Fejér-féle lépcsőparabolát* (csak egy mondatban): ez a Fejér–Hermite egy speciális esete, ahol minden előírt derivált nulla. Ez azért zseniális, mert Csebisev-alappontokon használva ez a polinomsorozat *minden* folytonos függvényhez egyenletesen konvergál, elkerülve a Runge-jelenséget!

*/

#pagebreak()

= 14. Spline-ok I.

A globális polinom interpoláció (8-11. tétel) nagy hátránya, hogy magas fokszám esetén a közelítés instabillá válhat (Runge-jelenség). A spline-ok alapötlete az, hogy az intervallumot részekre bontjuk, és minden kis részintervallumon alacsony fokszámú polinomokat használunk, amiket "szépen" (folytonosan és simán) összeillesztünk.

== a) Az interpolációs spline és az elsőfokú spline

=== Az interpolációs spline definíciója
Tekintsük az $[a, b]$ intervallum egy felosztását: $a = x_0 < x_1 < ... < x_n = b$. Jelölje $I_k = [x_(k-1), x_k]$ a $k$-adik részintervallumot.
Az $S_l$ függvényt $l$-edfokú spline-nak nevezzük, ha teljesíti a következő feltételeket:
1. *Szakaszonkénti polinom:* Minden $I_k$ intervallumon egy legfeljebb $l$-edfokú polinom: $S_(l|I_k) in P_l$.
2. *Sima illeszkedés:* A függvény az egész $[a, b]$ intervallumon $(l-1)$-szer folytonosan differenciálható: $S_l in C^(l-1)[a, b]$.
3. *Interpoláció:* A spline az alappontokban felveszi az előírt értékeket: $S_l (x_i) = y_i$ minden $i = 0, ..., n$ esetén.

=== Az elsőfokú spline (Szakaszonkénti lineáris interpoláció)
Az $l=1$ esetben a spline szakaszonként elsőfokú polinomokból (egyenesekből) áll. A simasági feltétel ($l-1 = 0$) csak a folytonosságot követeli meg.

*Konstrukció lokális bázisban:*
Minden $I_k = [x_(k-1), x_k]$ intervallumon a spline alakja:
$ p_k(x) = a_0^((k)) + a_1^((k))(x - x_(k-1)) $
Az interpolációs feltételek a szakasz két végpontjára:
- $p_k(x_(k-1)) = a_0^((k)) = y_(k-1)$
- $p_k(x_k) = a_0^((k)) + a_1^((k))(x_k - x_(k-1)) = y_k$
Ebből az együtthatók közvetlenül adódnak: $a_0^((k)) = y_(k-1)$ és $a_1^((k)) = (y_k - y_(k-1)) / (x_k - x_(k-1)) = f[x_(k-1), x_k]$.
Látható, hogy az elsőfokú spline-t az adatok egyértelműen meghatározzák, nincs szükség plusz peremfeltételekre.

=== Az elsőfokú spline hibabecslése és bizonyítása
*Tétel:* Legyen $f in C^2[a, b]$ és $S_1$ a hozzá tartozó elsőfokú interpolációs spline. Ekkor:
$ norm(f - S_1)_(oo) <= 1/8 h^2 norm(f'')_(oo) $
ahol $h = max_k (x_k - x_(k-1))$ a legnagyobb lépésköz.

*Bizonyítás:*
1. Vizsgáljuk a hibát egy tetszőleges $I_k = [x_(k-1), x_k]$ intervallumon. Ekkor $S_1$ ezen a szakaszon nem más, mint az $f$ függvény $x_(k-1)$ és $x_k$ pontokra támaszkodó lineáris interpolációs polinomja.
2. A 8. tételben tanult hibaformula alapján $x in I_k$ esetén:
  $ f(x) - S_1(x) = (f''(xi_k)) / 2! (x - x_(k-1))(x - x_k). $
3. Vegyük a kifejezés abszolút értékét: $|f(x) - S_1(x)| = (|f''(xi_k)|) / (2 |(x - x_(k-1))(x - x_k)|)$
4. Becsüljük meg a tagokat:
  - $|f''(xi_k)| <= norm(f'')_(oo)$ az egész intervallumon.
  - A $w(x) = (x - x_(k-1))(x - x_k)$ egy lefelé nyíló parabola, melynek maximuma a két pont között félúton van. Legyen $h_k = x_k - x_(k-1)$. A csúcspontban a helyettesítési érték: $|(h_k/2) dot (-h_k/2)| = h_k^2 / 4$.
5. Behelyettesítve: $|f(x) - S_1(x)| <= norm(f'')_(oo) / 2 dot h_k^2 / 4 = 1/8 h_k^2 norm(f'')_(oo)$.
6. Mivel ez minden szakaszra igaz, a globális hiba a legnagyobb szakaszhoz tartozó $h$ értékkel becsülhető.

== b) A másodfokú spline és konstrukciója

A másodfokú spline ($l=2$) szakaszonként parabolákból áll, és folytonosan differenciálhatónak kell lennie ($S_2 in C^1$).

=== Szabadságfokok és peremfeltételek
Vizsgáljuk meg az ismeretlenek és a feltételek számát $n$ darab részintervallum esetén:
- *Ismeretlenek:* Minden szakaszhoz 3 együttható tartozik ($a, b, c$), összesen $3n$.
- *Interpolációs feltételek:* Minden szakasz két végén egy-egy érték, összesen $2n$.
- *Simasági feltételek:* Minden belső pontban ($n-1$ darab) az első deriváltnak meg kell egyeznie a bal és jobb oldali polinomra, összesen $n-1$.
*Összesen:* $2n + (n-1) = 3n - 1$ feltételünk van $3n$ ismeretlenre.
Látjuk, hogy 1 szabad paraméter marad, ezért az egyértelműséghez szükség van *egy peremfeltételre*, ami általában az egyik végpontbeli derivált: $S_2'(a) = f'(a)$ vagy $S_2'(b) = f'(b)$.

=== Levezetés lokális bázisban (baloldali peremfeltétel esetén)
Keressük a spline-t az $I_k$ szakaszon a következő alakban:
$ p_k(x) = a_0^((k)) + a_1^((k))(x - x_(k-1)) + a_2^((k))(x - x_(k-1))^2 $
Legyen adott az $m_1 = f'(x_0)$ kezdő meredekség. A célunk a spline-t szakaszról szakaszra, rekurzívan felépíteni.

*1. szakasz ($I_1$):*
- $p_1(x_0) = a_0^((1)) = y_0$.
- $p_1'(x_0) = a_1^((1)) = m_1$.
- $p_1(x_1) = y_0 + m_1(x_1 - x_0) + a_2^((1))(x_1 - x_0)^2 = y_1$.
Ebből kifejezhető $a_2^((1)) = (y_1 - y_0 - m_1(x_1 - x_0)) / (x_1 - x_0)^2$, ami nem más, mint a másodrendű osztott differencia: $f[x_0, x_0, x_1]$.

*Rekurzió a $k$-adik szakaszra:*
Tegyük fel, hogy az előző szakasz végén megkaptuk az $m_k = p_(k-1)'(x_(k-1))$ meredekséget.
- $a_0^((k)) = y_(k-1)$
- $a_1^((k)) = m_k$
- $a_2^((k)) = (f[x_(k-1), x_k] - m_k) / (x_k - x_(k-1))$
A következő szakaszhoz szükséges meredekség az aktuális parabola deriváltja a szakasz végén:
$ m_(k+1) = p_k'(x_k) = a_1^((k)) + 2 a_2^((k))(x_k - x_(k-1)) $
Behelyettesítve $a_2^((k))$ értékét:
$ m_(k+1) = m_k + 2 (f[x_(k-1), x_k] - m_k) = 2 f[x_(k-1), x_k] - m_k $
Ez a rendkívül egyszerű rekurziós képlet lehetővé teszi, hogy a kezdő $m_1$ ismeretében az összes többi szakasz paramétereit gyorsan kiszámoljuk.

/*

### Beszédes kiegészítés a 14. tételhez (szóbeli tippek):

Amikor erről a tételről beszélsz, a legfontosabb üzeneted az legyen: *a spline-ok a stabilitást hozzák el a numerikába*. Magyarázd el, hogy miért nem "elszállósak" (mint a Runge-példa): azért, mert helyileg alacsony fokszámúak (1, 2 vagy 3), így nem tudnak hatalmas kilengéseket produkálni két pont között.

Az *a) részben* a hibaformula bizonyításánál emeld ki a *1/8-os szorzót*. Mondd el, hogy ez feleakkora hiba, mint amit egyetlen Lagrange-polinom adna az egész intervallumon, és ahogy finomítjuk a felosztást ($h -> 0$), a hiba négyzetes sebességgel ($h^2$) zuhan a nullához.

A *b) résznél* a vizsgáztatót le fogod nyűgözni, ha megmutatod a *szabadságfok-számolást*. Ez rávilágít arra, hogy a matematika miért "kényszerít" minket peremfeltételek megadására. A másodfokú spline konstrukciójánál hangsúlyozd a *rekurzív jelleget*: olyan ez, mint egy stafétafutás, ahol az előző parabola átadja a botot (a meredekséget) a következőnek.

Végül egy fontos megfigyelés: a másodfokú spline rekurziója ($m_(k+1) = 2f[...] - m_k$) kicsit instabil lehet, ha túl sok szakaszunk van, mert a kezdőhiba $m_1$-ben váltakozó előjellel öröklődik tovább. Ezért a gyakorlatban inkább a 15. tételnél tárgyalt köbös spline-okat preferáljuk.

*/

#pagebreak()

= 15. Spline-ok II.

A köbös spline ($l=3$) a gyakorlatban leggyakrabban alkalmazott szakaszonkénti polinom-közelítés. Ennek oka, hogy a harmadfokú görbék már elég "rugalmasak" ahhoz, hogy kétszer folytonosan differenciálható ($C^2$) illesztést tegyenek lehetővé, ami a szemnek is sima görbületet ad, ugyanakkor elkerülik a magas fokszámú globális polinomok vad oszcillációit.

== a) Az interpolációs köbös spline és a szabadságfokok rejtélye

=== Az interpolációs spline definíciója
Adott az $[a, b]$ intervallum egy felosztása: $a = x_0 < x_1 < ... < x_n = b$. Azt az $S_3$ függvényt nevezzük köbös interpolációs spline-nak, amely:
1. *Szakaszonként harmadfokú:* Minden $I_k = [x_(k-1), x_k]$ intervallumon egy legfeljebb harmadfokú polinom: $p_k (x) in P_3$.
2. *Kétszer folytonosan differenciálható:* A görbe nemcsak folytonos, de a meredeksége (első derivált) és a görbülete (második derivált) is törésmentesen simul a belső pontokban: $S_3 in C^2[a, b]$.
3. *Interpolál:* Minden alappontban pontosan felveszi az előírt értéket: $S_3(x_i) = y_i$ ($i = 0, dots, n$).

=== Szabadságfokok számolása (Miért kell a peremfeltétel?)
Vizsgáljuk meg a matematikai kényszereket $n$ darab részintervallum esetén:
- *Ismeretlenek száma:* Minden szakaszon egy harmadfokú polinomunk van ($a x^3 + b x^2 + c x + d$), ez szakaszonként 4 együttható, összesen $4n$ ismeretlen.
- *Feltételek száma:*
  - *Interpoláció:* Minden szakasz két végpontjában adott az érték ($2$ feltétel szakaszonként), ez $2n$ feltétel.
  - *Első derivált folytonossága ($S' in C$):* Minden belső pontban ($n-1$ darab) a bal és jobb oldali meredekségnek egyeznie kell, ez $n-1$ feltétel.
  - *Második derivált folytonossága ($S'' in C$):* Minden belső pontban a görbületnek is egyeznie kell, ez újabb $n-1$ feltétel.
*Összesen:* $2n + (n-1) + (n-1) = 4n - 2$ feltétel.

Látjuk a drámát: $4n$ ismeretlenünk van, de csak $4n-2$ egyenletünk. Hiányzik *pontosan 2 feltétel* ahhoz, hogy a spline egyértelmű legyen. Ezt a két hiányzó információt nevezzük peremfeltételeknek, amelyeket az intervallum két szélén, $a$-ban és $b$-ben írunk elő.

=== A négy klasszikus peremfeltétel
1. *Hermite-féle peremfeltétel:* Előírjuk a görbe meredekségét a két végponton: $S'_3(a) = f'(a)$ és $S'_3(b) = f'(b)$. Fizikailag ez egy olyan rugalmas sínt jelent, aminek a végeit rögzített szögben befogtuk.
2. *Természetes peremfeltétel:* A második deriváltakat nullának választjuk a széleken: $S''_3(a) = 0$ és $S''_3(b) = 0$. Fizikailag ez a legtermészetesebb állapot: a rugalmas szál végei szabadon állnak be, nincs rajtuk feszítő nyomaték (egyenesbe simulnak a végeken).
3. *Periodikus peremfeltétel:* Csak ha $y_0 = y_n$. Ekkor megköveteljük, hogy a görbe "körbeérjen": $S_3'(a) = S_3'(b)$ és $S_3''(a) = S_3''(b)$.
4. *"Not-a-knot" (Nem-csomópont) feltétel:* Azt kérjük, hogy az $S'''_3$ (harmadik derivált) is legyen folytonos az $x_1$ és $x_(n-1)$ pontokban. Ez azt jelenti, hogy az első két szakasz, illetve az utolsó két szakasz valójában ugyanaz a köbös polinom (nincs valódi váltás a csomópontban).

== b) A redukált LER levezetése természetes peremfeltétel esetén

A célunk, hogy a $4n$ ismeretlenes óriási egyenletrendszert "legyaluljuk" egyetlen típusú ismeretlenre: a szakaszok második deriváltjaira ($a_2^((k))$ együtthatókra). Legyen $h_k = x_k - x_(k-1)$ a szakasz hossza.

=== A polinom alakja és az együtthatók kimentése
A $k$-adik szakaszon a polinomunk:
$ p_k(x) = a_3^((k))(x - x_(k-1))^3 + a_2^((k))(x - x_(k-1))^2 + a_1^((k))(x - x_(k-1)) + a_0^((k)) $
- Az interpolációból azonnal tudjuk: $a_0^((k)) = y_(k-1)$.
- Vezessük be a jelölést: $M_k = p''_k(x_(k-1)) = 2 a_2^((k))$. Tehát $a_2^((k)) = M_k / 2$.
- Az $S'' in C$ feltétel miatt a $k$. szakasz végén a második derivált megegyezik a $(k+1)$. szakasz elejével: $6 a_3^((k)) h_k + 2 a_2^((k)) = 2 a_2^((k+1))$.
- Ebből kifejezhető $a_3^((k)) = (a_2^((k+1)) - a_2^((k))) / (3 h_k)$.

Látható, hogy már csak az $a_1^((k))$ (lineáris tag) és maguk az $a_2^((k))$ értékek az ismeretlenek. Az interpolációt a szakasz végére is felírva ($p_k(x_k) = y_k$), kimenthetjük $a_1^((k))$-t is az $a_2$ értékek segítségével.

=== A központi egyenlet felállítása
A végső simasági feltétel az első deriváltak folytonossága: $p'_k (x_k) = p'_(k+1) (x_(k+1))$. Ha behelyettesítjük az összes korábban kifejezett együtthatót, egy gyönyörű, tridiagonális egyenletrendszert kapunk az $a_2^((k))$ értékekre:
$ h_k a_2^((k)) + 2(h_k + h_(k+1)) a_2^((k+1)) + h_(k+1) a_2^((k+2)) = 3(f[x_k, x_(k+1)] - f[x_(k-1), x_k]) $

=== Speciális eset: Természetes peremfeltétel
A természetes peremfeltétel szerint $S''(a) = 0$ és $S''(b) = 0$.
- Ez azt jelenti, hogy a legelső ismeretlenünk: $a_2^((1)) = 0$.
- És a legutolsó (segéd)ismeretlenünk: $a_2^((n+1)) = 0$.
Mivel a két szélső érték kiesett (nulla lett), az $(n+1) times (n+1)$-es rendszerünk leredukálódik egy *$(n-1) times (n-1)$* méretű rendszerre a belső $a_2^((2)), dots, a_2^((n))$ ismeretlenekre.

*A redukált LER mátrixos alakja (egyenletes $h$ felosztás esetén):*
$
  mat(4, 1, 0, dots; 1, 4, 1, dots; 0, 1, 4, dots; dots, dots, dots, 4) dot mat(a_2^((2)); a_2^((3)); dots; a_2^((n))) = 6/h mat(f[x_1, x_2] - f[x_0, x_1]; dots; f[x_(n-1), x_n] - f[x_(n-2), x_(n-1)])
$

A mátrix szigorúan diagonálisan domináns (a 4-esek az átlóban jóval nagyobbak a mellékátlóbeli 1-eseknél), ezért a rendszer mindig stabilan és egyértelműen megoldható.

/*

### Beszédes magyarázat a 15. tételhez (felkészüléshez):

Amikor erről a tételről beszélsz, próbáld érzékeltetni a *szabadságfokok drámáját*. Magyarázd el: a természet nem adja ingyen a simaságot. Ha azt akarjuk, hogy a görbe kétszeresen differenciálható legyen, elhasználjuk szinte az összes szabad paraméterünket ($4n-2$), és pont a két vége marad "lógva". Ezért *kell* a vizsgáztató fejében is elhelyezni azt a két extra szöget vagy csuklót (peremfeltételt).

A *négy peremfeltétel* közül a *természetes* a legfontosabb elméletileg, mert ez minimalizálja a görbe "összenergiáját" (erről szól a 17. tétel vége: $ "int" S''^2 $ minimális). A *"not-a-knot"*-ról pedig említsd meg: ez a lusták kedvence (és a Matlab alapértelmezettje), mert itt nem kell a felhasználónak plusz adatokat (pl. deriváltakat) ismernie, a spline magát zárja be.

A *levezetésnél* ne vessz el a részszámításokban! A lényeg a logikai ív:
1. Felírjuk a szakasz-polinomot.
2. Kimutatjuk, hogy minden együttható ($a_0, a_1, a_3$) kifejezhető a "második deriváltas" $a_2$ értékekkel.
3. Az első deriváltak belső találkozásánál ($S' in C$) megszületik a *tridiagonális rendszer*.
4. A természetes peremfeltétel pedig egyszerűen "lecsippenti" a rendszer elejét és végét, mert ott az értékek nullák.

Hangsúlyozd a *tridiagonális mátrix* előnyeit: rendkívül gyorsan (Thomas-algoritmus, $O(n)$ idő alatt) megoldható, szemben a klasszikus interpoláció $O(n^3)$-as igényével. Ez teszi a spline-okat a modern mérnöki tervezés (CAD, grafika) királyaivá.

*/

#pagebreak()

= 16. Spline-ok III.

Eddig a spline-okat szakaszokonként definiált polinomokként kezeltük, amelyeket illesztési feltételekkel (folytonosság, simaság) "ragasztottunk" össze. Ebben a tételben megmutatjuk, hogy az adott felosztáshoz tartozó összes spline egy lineáris teret alkot, és megkeressük ennek a térnek a legpraktikusabb bázisait.

== a) Globális bázis és a B-spline-ok alapjai

Tekintsük az $[a, b]$ intervallum $Omega_n = (x_0, x_1, dots, x_n)$ felosztását. Jelölje $S_l (Omega_n)$ az ezen a felosztáson értelmezett $l$-edfokú spline-ok halmazát.

=== Az egyoldali hatványfüggvény (Truncated Power Function)
A spline-ok globális leírásához szükségünk van egy olyan függvényre, amely "kikapcsolható".
*Definíció:* A jobb oldali (vagy egyoldali) $l$-edfokú hatványfüggvényt a következőképpen definiáljuk:
$
  (x - x_k)_+^l = cases(
    (x - x_k)^l & "ha " x >= x_k,
    0 & "ha " x < x_k.
  )
$
Ez a függvény a csomópont előtt nulla, utána pedig egy polinom. Fontos tulajdonsága, hogy az $x_k$ pontban pontosan $(l-1)$-szer folytonosan differenciálható, ami éppen megfelel a spline-ok simasági követelményének.

=== A globális spline-bázis megadása
Tetszőleges $S in S_l (Omega_n)$ spline felírható a következő $n+l$ elemű függvényrendszer lineáris kombinációjaként:
$ (1, x, x^2, dots, x^l, (x - x_1)_+^l, (x - x_2)_+^l, dots, (x - x_(n-1))_+^l) $
Ebben a bázisban az első $l+1$ tag az egész intervallumon értelmezett "hagyományos" polinomokat reprezentálja, míg az egyoldali hatványfüggvények az egyes belső csomópontokban bekövetkező "töréseket" (a legmagasabb fokú együttható változását) kezelik.

=== A B-spline-ok fogalma
Bár a fenti bázis elméletileg kiváló, numerikusan instabil lehet (hasonlóan a Vandermonde-mátrixhoz). Ezért vezetjük be a B-spline-okat (Basis Splines), amelyek "lokális" bázist alkotnak.

*Definíció:* A $B_(l, k)$ függvényeket B-spline-oknak nevezzük, ha:
1. *Nemnegatívak:* $B_(l, k)(x) >= 0$ minden $x$-re.
2. *Minimális tartójúak:* Csak korlátos számú részintervallumon nem nullák (lokális hatás).
3. *Egységfelbontást alkotnak:* $sum_k B_(l, k)(x) equiv 1$ minden $x$-re (stabil súlyozás).

=== Lineáris spline előállítása B-spline-okkal
Vizsgáljuk meg az $l=1$ esetet (elsőfokú spline). Az elsőfokú B-spline-ok az úgynevezett "kalapfüggvények".
*A bázisfüggvény alakja ($B_(1, k)$):*
- Az $x_k$ és $x_(k+1)$ között 0-ról 1-re nő lineárisan.
- Az $x_(k+1)$ és $x_(k+2)$ között 1-ről 0-ra csökken lineárisan.
- Mindenhol máshol nulla.

*Levezetés:*
Tudjuk, hogy egy elsőfokú interpolációs spline-t az alappontbeli értékei ($f(x_i)$) egyértelműen meghatároznak. Mivel a kalapfüggvényekre igaz, hogy $B_(1, k-1)(x_k) = 1$ és minden más bázisfüggvény értéke ott 0, ezért az interpolációs spline egyszerűen felírható:
$ S_1(x) = sum_(k=-1)^(n-1) f(x_(k+1)) dot B_(1, k)(x). $
Itt a $c_k = f(x_(k+1))$ együtthatók közvetlenül a megadott függvényértékek lesznek. Ez a levezetés megmutatja a B-spline-ok erejét: az együtthatók meghatározásához nem kell egyenletrendszert megoldani, azok "leolvashatók" az adatokból.

== b) Tétel a spline-bázisról és az egyértelműség bizonyítása

=== Tétel: A globális bázis tulajdonságai
Az $[a, b]$ intervallum $Omega_n$ felosztása feletti $S_l (Omega_n)$ spline-térben a
$ cal(B) = (1, x, dots, x^l, (x - x_1)_+^l, dots, (x - x_(n-1))_+^l) $
függvényrendszer bázist alkot. Ez két dolgot jelent:
1. A rendszer lineárisan független.
2. Minden spline egyértelműen előállítható ezek lineáris kombinációjaként.
Ennek következményeként a spline-tér dimenziója: $dim S_l (Omega_n) = n + l$.

=== Az egyértelmű előállíthatóság bizonyítása
A bizonyítást konstruktív módon, intervallumról intervallumra haladva végezzük el.

1. *Első szakasz ($I_1 = [x_0, x_1]$):*
  Ezen a szakaszon minden egyoldali hatványfüggvény $(x - x_i)_+^l$ értéke 0, hiszen $x < x_i$ minden $i >= 1$-re.
  Így a spline ezen a részen egyszerűen egy $l$-edfokú polinom: $S|_(I_1) = p_1(x)$.
  A polinomok elméletéből tudjuk, hogy $p_1(x)$ egyértelműen felírható az $(1, x, dots, x^l)$ bázisban:
  $ p_1(x) = sum_(j=0)^l alpha_j x^j. $

2. *Második szakasz ($I_2 = [x_1, x_2]$):*
  Itt már "bekapcsol" az első egyoldali függvény: $(x - x_1)_+^l$. A többi még nulla.
  Tekintsük az $R_2(x) = S(x) - p_1(x)$ különbséget az $I_2$ szakaszon.
  Mivel $S in C^(l-1)$, ezért az $x_1$ csomópontban a spline és a $p_1$ polinom értéke és első $l-1$ deriváltja megegyezik.
  Ezért $R_2(x)$ és deriváltjai nullák az $x_1$ pontban: $R_2^((j))(x_1) = 0$ minden $j = 0, dots, l-1$ esetén.
  Egy olyan polinom, amelynek egy pontban $l$-szeres gyöke van, szükségképpen $R_2(x) = beta_1 (x - x_1)^l$ alakú.
  Mivel ez csak az $x >= x_1$ tartományon érvényes, globálisan ez pontosan a $beta_1 (x - x_1)_+^l$ tagot jelenti.

3. *Indukciós lépés:*
  Tegyük fel, hogy az első $k-1$ csomópontig már egyértelműen meghatároztuk az együtthatókat. A $k$-adik csomópontnál ($x_k$) fellépő változást az $S(x) - tilde(S)_(k-1)(x)$ különbség vizsgálatával kapjuk meg, ahol $tilde(S)_(k-1)$ a már felépített spline. A simasági kényszerek miatt ez a különbség csak $beta_k (x - x_k)_+^l$ alakú lehet.

4. *Összegzés:*
  Véges sok lépésben ($n-1$ belső ponton áthaladva) megkapjuk a teljes előállítást. Mivel minden lépésben a $beta_k$ együttható egyértelműen adódott a simasági feltételekből, a teljes spline egyértelműen reprezentálható a bázisban.

/*

### Beszédes kiegészítés a 16. tételhez (felkészüléshez):

Amikor erről a tételről beszélsz, a kulcsszó a *"folytonos simítás"*. Magyarázd el a vizsgáztatónak, hogy miért hívják ezeket "egyoldali" függvényeknek. Ezek olyanok, mint a *kapcsolók*: amíg nem érünk el egy bizonyos $x_k$ pontot, addig nem csinálnak semmit (nullák). Amint átlépjük a pontot, "bekapcsolnak" és egy polinommal módosítják a görbe futását.

A *b) rész bizonyításánál* a legfontosabb logikai lépés az, hogy miért lesz a különbség pontosan a hatványfüggvény konstansszorosa. Mondd el: "Mivel a spline $C^(l-1)$ simaságú, a két szomszédos szakasz polinomja között csak az $l$-edik deriváltban lehet ugrás. Ez az ugrás pedig matematikailag pontosan egy $l$-edfokú, az adott pontban $l$-szeres gyökkel rendelkező tagot jelent."

A *dimenzió számolása ($n+l$)* is fontos:
- Vegyél egy példát: $n=2$ szakasz, $l=3$ (köbös).
- Dimenzió: $2+3 = 5$.
- Miért? Mert van 4 együtthatónk a polinomhoz ($a, b, c, d$), és van 1 belső csomópontunk, ahol egy extra szabadságfokot ($ beta_1 $) kapunk. Ez összesen 5. Ez konzisztens a 15. tétellel, ahol 2 peremfeltétel kellett a 4 feltétel mellé (itt is látszik, hogy az adatok száma és a dimenzió hogyan függ össze).

Végül a *B-spline-oknál* emeld ki: ezek a "mérnöki spline-ok". Azért szeretjük őket, mert ha megmozdítasz egy adatpontot, az nem rángatja meg a görbét a világ végén (mint az interpoláció), hanem csak a közvetlen közelében változtatja meg (lokális tartó).

*/

#pagebreak()

= 17. Spline-ok IV.

A B-spline-ok olyan speciális spline-függvények, amelyek lokális tartóval rendelkeznek, és bázist alkotnak a spline-ok terében. Nevük a "Basis Spline" kifejezésből ered. Használatukkal az interpoláció numerikusan rendkívül stabillá válik.

== a) A B-spline-ok fogalma, rekurziója és a másodfokú spline

=== Definíció és alapvető tulajdonságok
Tekintsük az $[a, b]$ intervallum egy kiterjesztett $Ω_∞ = (x_k)_(k in bb(Z))$ felosztását. A $B_(l, k)$ függvényeket $l$-edfokú B-spline-oknak nevezzük, ha teljesítik a következőket:
1. *Nemnegativitás:* $B_(l, k)(x) >= 0$ minden $x$-re.
2. *Minimális tartó:* A függvény csak az $[x_k, x_(k+l+1)]$ intervallumon nem nulla. Ez azt jelenti, hogy egy $l$-edfokú B-spline pontosan $l+1$ darab részintervallumot "fed le".
3. *Egységfelbontás:* Minden $x$ pontban a bázisfüggvények összege pontosan 1: $sum_k B_(l, k)(x) equiv 1$.

=== Alacsony fokszámú B-spline-ok megadása
- *Nulladfokú B-spline ($l=0$):* Lépcsős függvény, amely az $[x_k, x_(k+1))$ félig nyílt intervallumon 1, különben 0.
- *Elsőfokú B-spline ($l=1$):* Az úgynevezett "kalapfüggvény". Az $[x_k, x_(k+1)]$ szakaszon lineárisan nő 0-ról 1-re, az $[x_(k+1), x_(k+2)]$ szakaszon pedig lineárisan csökken 1-ről 0-ra.

=== A B-spline rekurzió (Cox-de Boor formula)
Magasabb fokszámú B-spline-okat az alacsonyabb fokszámúakból állíthatunk elő rekurzívan:
$
  B_(l, k)(x) = (x - x_k)/(x_(k+l) - x_k) B_(l-1, k)(x) + (x_(k+l+1) - x)/(x_(k+l+1) - x_(k+1)) B_(l-1, k+1)(x)
$
Ez a formula mutatja meg, hogy egy $l$-edfokú B-spline két $(l-1)$-edfokú B-spline súlyozott összege.

=== Tétel a spline előállításáról
Minden $l$-edfokú spline egyértelműen előállítható a B-spline-ok lineáris kombinációjaként:
$ S(x) = sum_(k) c_k B_(l, k)(x) $
A feladatunk az interpoláció során a $c_k$ együtthatók meghatározása.

=== Másodfokú B-spline ($l=2$) egyenletes felosztáson
Tegyük fel, hogy a felosztás egyenletes ($x_(k+1) - x_k = h$). A rekurzió alkalmazásával a másodfokú B-spline három szakaszból áll:
$
  B_(2, k)(x) = (1)/(2h^2) cases(
    (x - x_k)^2 & "ha " x in [x_k, x_(k+1)],
    h^2 + 2h(x - x_(k+1)) - 2(x - x_(k+1))^2 & "ha " x in [x_(k+1), x_(k+2)],
    (x_(k+3) - x)^2 & "ha " x in [x_(k+2), x_(k+3)],
    0 & "különben."
  )
$
Az interpolációhoz ($S_2(x_i) = f(x_i)$) fel kell írnunk a spline értékeit az alappontokban. Belátható, hogy $B_(2, k)(x_(k+1)) = 1/2$ és $B_(2, k)(x_(k+2)) = 1/2$, minden más alappontban 0. Így az interpolációs feltétel:
$ f(x_i) = (c_(i-2) + c_(i-1))/(2) $
Ez egy kétátlós egyenletrendszert ad, amely egy peremfeltétellel (pl. $f'(a)$) kiegészítve egyértelműen megoldható.

== b) Köbös spline és hibabecslések

=== Köbös B-spline ($l=3$) egyenletes felosztáson
A harmadfokú B-spline ($B_(3, k)$) négy részintervallumon ($[x_k, x_(k+4)]$) értelmezett. Az alappontokban felvett értékei kulcsfontosságúak:
- $B_(3, k)(x_(k+1)) = 1/6$
- $B_(3, k)(x_(k+2)) = 4/6$
- $B_(3, k)(x_(k+3)) = 1/6$

Az interpolációs feltétel ($S_3(x_i) = sum c_k B_(3, k)(x_i) = f(x_i)$) a következő tridiagonális egyenletrendszerhez vezet:
$ c_(i-3) + 4c_(i-2) + c_(i-1) = 6 f(x_i), "  " i = 0, dots, n. $
Ez a rendszer $n+1$ egyenletet jelent az $n+3$ darab $c_k$ ismeretlenre ($c_(-3), dots, c_(n-1)$). A hiányzó két egyenletet a peremfeltételekből (Hermite, természetes vagy periodikus) kapjuk meg.

=== Hibabecslések harmadfokú spline-okra
Legyen $f in C^4[a, b]$ és $S_3$ a hozzá tartozó Hermite-peremfeltételű köbös spline. Ekkor a legnagyobb lépésközre ($h$) vonatkozóan a következő becslések érvényesek:
1. *Függvényérték hibája:* $|f - S_3|_(oo) <= (5)/(384) h^4 |f^((4))|_(oo)$
2. *Első derivált hibája:* $|f' - S_3'|_(oo) <= (1)/(24) h^3 |f^((4))|_(oo)$
3. *Második derivált hibája:* $|f'' - S_3''|_(oo) <= (3)/(8) h^2 |f^((4))|_(oo)$

Ezek a becslések mutatják, hogy a köbös spline rendkívül pontos: a hiba a lépésköz negyedik hatványával csökken ($O(h^4)$).

=== Minimum-tulajdonság (Energia-minimalizálás)
*Tétel:* A klasszikus peremfeltételű (Hermite, természetes, periodikus) köbös spline minimalizálja az alábbi integrált:
$ integral_a^b (S''_3(x))^2 dif x <= integral_a^b (f''(x))^2 dif x. $
Ez azt jelenti, hogy a köbös spline a "legsimább" interpoláló függvény: fizikailag ez a görbe rendelkezik a legkisebb feszítési energiával.

/*

### Beszédes kiegészítés a 17. tételhez (hogy biztos legyen az ötös):

Amikor erről a tételről beszélsz, a kulcsszó a *lokalitás*. Magyarázd el a vizsgáztatónak a B-spline-ok lényegét: ha van egy óriási adatsorod (pl. ezer mérési pont), és az egyik pontot megváltoztatod, a Lagrange-interpolációnál az egész görbe "beremeg" a világ végén is. A B-spline-nál viszont a hiba vagy változás *csak a szomszédos 2-3 szakaszra korlátozódik*. Ez a tulajdonság teszi őket nélkülözhetetlenné a számítógépes grafikában.

A *rekurzió (Cox-de Boor)* kapcsán érdemes megjegyezni, hogy bár a képlet bonyolultnak tűnik, a jelentése egyszerű: egy magasabb fokszámú görbét két alacsonyabb fokszámú görbe "összeúsztatásával" kapunk meg. Olyan ez, mint egy csúszó átlagolás.

A *másodfokú spline levezetésénél* hangsúlyozd, hogy miért $c_(i-1) + c_(i-2)$ szerepel az egyenletben. Magyarázd el, hogy az alappontban két B-spline találkozik, és mindkettő pontosan félmagasságban ($1/2$) van ott. Ezért az interpolációhoz csak össze kell adni a két szomszédos együttható felét.

A *köbös spline-nál* a $1, 4, 1$ együtthatósorozat ($1/6, 4/6, 1/6$) a "bűvös szám". Említsd meg, hogy a mátrixunk így *szigorúan diagonálisan domináns* lesz (a 4-es nagyobb, mint az 1+1), ami garantálja a numerikus stabilitást. Nem fognak "elszállni" az együtthatók.

Végül a *minimum-tulajdonság*. Ez a tétel legszebb elméleti része. Mondd el, hogy a köbös spline olyan, mint egy vékony, rugalmas acélszál (innen a neve: *spline* = rajzolósín), amit pontokhoz rögzítünk. A természetben az acélszál úgy áll be, hogy a benne lévő feszültség (ami a második derivált négyzetével arányos) a legkisebb legyen. Ezért szeretjük a köbös spline-t: nemcsak pontos, hanem a szemnek is ez tűnik a "legtermészetesebb" görbének.

*/

#pagebreak()

= 18. Mátrix szinguláris felbontása I.

A szinguláris felbontás (Singular Value Decomposition – SVD) a sajátérték-felbontás általánosítása tetszőleges, akár nem négyzetes mátrixokra is. Míg a diagonalizálás azt mutatja meg, hogyan nyújtja meg a mátrix a sajátvektorait, az SVD azt tárja fel, hogyan képez le a mátrix egy ortonormált bázist egy másik ortonormált bázisba.

== a) A szinguláris értékek fogalma és a felbontás tétele

=== Szinguláris értékek definíciója
Legyen $A in CC^(m times n)$ egy tetszőleges mátrix. Az $A$ mátrix *szinguláris értékeinek* nevezzük az $A^* A$ (önadjungált és pozitív szemidefinit) mátrix pozitív sajátértékeinek négyzetgyökeit:
$ sigma_i = sqrt(lambda_i (A^* A)) > 0, quad (i = 1, ..., r) $
ahol $r = "rang"(A)$. A szokásos rendezés szerint $sigma_1 >= sigma_2 >= ... >= sigma_r > 0$. Ha a mátrix nem teljes rangú, a többi szinguláris értéket ($i > r$) nullának tekintjük.

=== Tétel: Szinguláris felbontás (SVD)
Tetszőleges $A in CC^(m times n)$ mátrix esetén léteznek olyan $U in CC^(m times m)$ és $V in CC^(n times n)$ unitér mátrixok, valamint egy $D in CC^(m times n)$ diagonális jellegű mátrix, hogy:
$ A = U D V^* $
ahol $D$ particionált alakja $D = mat(Sigma, 0; 0, 0)$, és $Sigma = "diag"(sigma_1, ..., sigma_r)$.

*Geometriai jelentés:* A felbontás azt mondja, hogy minden lineáris leképezés felbontható három egyszerű lépésre: egy forgatásra/tükrözésre a kiindulási térben ($V^*$), egy tengelyirányú nyújtásra ($D$), és egy végfázisú forgatásra/tükrözésre a célirányú térben ($U$).

== b) Általánosított inverz és általánosított megoldás

=== Moore-Penrose-féle általánosított inverz
Egy tetszőleges $A in CC^(m times n)$ mátrixnak nem feltétlenül létezik inverze a klasszikus értelemben. Azonban létezik egy egyértelmű $A^+ in CC^(n times m)$ mátrix, amelyet *Moore-Penrose-féle általánosított (pszeudo) inverznek* nevezünk, ha teljesíti az alábbi négy axiómát:
1. $A A^+$ önadjungált: $(A A^+)^* = A A^+$
2. $A^+ A$ önadjungált: $(A^+ A)^* = A^+ A$
3. $A A^+ A = A$ (az $A$ "majdnem" identitásként hat rajta)
4. $A^+ A A^+ = A^+$ (az $A^+$ "majdnem" identitásként hat rajta)

=== Diagonális mátrix általánosított inverze
Legyen $D in CC^(m times n)$ egy diagonális jellegű mátrix (mint az SVD-ben). Ennek általánosított inverze a $D^+ in CC^(n times m)$ mátrix, amely szintén diagonális jellegű, és elemei:
$ d_(i i)^+ = cases(1/d_(i i) &"ha " d_(i i) != 0, 0 &"ha " d_(i i) = 0.) $

*Bizonyítás:* Be kell látni a 4 axiómát. Mivel $D$ és $D^+$ diagonálisak, a szorzataik ($D D^+$ és $D^+ D$) is diagonálisak, aminek a főátlójában 1-esek (ahol $d_(i i) != 0$) és 0-k állnak. A diagonális mátrixok mindig önadjungáltak (valós esetben), így az 1. és 2. feltétel teljesül. A 3. és 4. feltétel pedig elemenként ellenőrizhető: $d_(i i) (1/d_(i i)) d_(i i) = d_(i i)$ és $(1/d_(i i)) d_(i i) (1/d_(i i)) = 1/d_(i i)$ minden nem-nulla elemre.

=== Általánosított inverz előállítása SVD-ből
*Tétel:* Ha $A = U D V^*$ a szinguláris felbontás, akkor az általánosított inverz:
$ A^+ = V D^+ U^* $

*Bizonyítás:* Ellenőrizzük a 3. axiómát ($A A^+ A = A$):
$ (U D V^*) (V D^+ U^*) (U D V^*) = U D (V^* V) D^+ (U^* U) D V^* = U D I D^+ I D V^* = U (D D^+ D) V^* $
Mivel a diagonális esetre már tudjuk, hogy $D D^+ D = D$, így kapjuk:
$ U D V^* = A $
A többi három axióma hasonlóan, az $U$ és $V$ unitér tulajdonságát ($U^* U = I$, $V^* V = I$) kihasználva bizonyítható.

=== Általánosított megoldás
Legyen $A x = b$ egy tetszőleges lineáris egyenletrendszer. Az $x^+ = A^+ b$ vektort a rendszer *általánosított megoldásának* nevezzük.
- Ha a rendszernek nincs megoldása (túlhatározott), akkor $x^+$ a legkisebb négyzetes hibájú közelítés.
- Ha végtelen sok megoldása van (alulhatározott), akkor $x^+$ a legkisebb euklideszi normájú megoldás.

/*

### Beszédes kiegészítés a 18. tételhez (szóbeli vizsgára):

Amikor erről a tételről beszélsz, próbáld megvilágítani, hogy miért ez a numerikus analízis "Svájci bicskája".

A *szinguláris értékek* ($sigma_i$) kapcsán hangsúlyozd: ezek a számok mondják meg, hogy a mátrix mennyire "lapítja le" a teret bizonyos irányokban. Ha egy szinguláris érték nagyon kicsi, az azt jelenti, hogy a mátrix abban az irányban majdnem mindent a nullába visz (instabilitás).

A *Moore-Penrose axiómák* lényege az, hogy egy olyan inverzet kapjunk, ami a lehető legjobban utánozza a valódi inverz tulajdonságait. A 3. és 4. axióma ($AA^+A=A$) gyakorlatilag azt mondja, hogy ha az $A$ képhalmazában vagyunk, akkor az $A^+$ visszavisz minket az értelmezési tartományba úgy, hogy az $A$ újra alkalmazva ugyanoda vigyen.

A *diagonális mátrix pszeudo-inverze* a bizonyítás legegyszerűbb, de legfontosabb része. Mondd el: "Egyszerűen ott, ahol nem nulla az elem, vesszük a reciprokát, ahol pedig nulla, ott hagyjuk nullának." Ez a művelet rendkívül stabil.

Végül az *SVD-ből való előállításnál* emeld ki a sorrendet! $A = UDV^* => A^+ = VD^+U^*$. Miért fordul meg az $U$ és $V$? Mert az inverz képzésekor a szorzat tényezőinek sorrendje megfordul, és az unitér mátrixok inverze az adjungáltjuk ($U^(-1) = U^*$, így $(U^* )^(-1) = U$).

*/

#pagebreak()

= 19. Mátrix szinguláris felbontása II.

A szinguláris felbontás és a Moore-Penrose-féle általánosított inverz elmélete nemcsak elméleti szépség, hanem a túlhatározott és alulhatározott egyenletrendszerek megoldásának alapköve.

== a) Általánosított inverz teljes rangú esetekben

Emlékeztetőül: Az $A$ mátrix Moore-Penrose-féle általánosított inverze ($A^+$) az a mátrix, amely teljesíti a négy alapaxiómát: $A A^+$ és $A^+ A$ önadjungáltak, valamint $A A^+ A = A$ és $A^+ A A^+ = A^+$.

Bár az általánosított inverz tetszőleges mátrixra előállítható az SVD-ből ($A^+ = V D^+ U^*$), ha a mátrix teljes rangú, sokkal egyszerűbb, közvetlen képleteket is használhatunk.

=== 1. Túlhatározott, teljes oszloprangú eset
Legyen $A in CC^(m times n)$ olyan mátrix, ahol több az egyenlet, mint az ismeretlen ($m > n$), és a mátrix rangja maximális ($r = n$). Ez azt jelenti, hogy az $A$ oszlopai lineárisan függetlenek.

*Tétel:* Ebben az esetben az általánosított inverz:
$ A^+ = (A^* A)^(-1) A^* $

*Bizonyítás:* Ellenőrizzük a Moore-Penrose axiómákat!
1. $A^+ A = (A^* A)^(-1) A^* A = (A^* A)^(-1) (A^* A) = I_n$. Az egységmátrix önadjungált.
2. $A A^+ = A (A^* A)^(-1) A^*$. Vegyük az adjungáltját: $(A (A^* A)^(-1) A^*)^* = (A^*)^* ((A^* A)^(-1))^* A^* = A (A^* A)^(-1) A^*$. Tehát önadjungált.
3. $A A^+ A = A (A^+ A) = A I = A$.
4. $A^+ A A^+ = (A^+ A) A^+ = I A^+ = A^+$.
Mivel mind a négy feltétel teljesül, a képlet valóban az általánosított inverzet adja.

=== 2. Alulhatározott, teljes sorrangú eset
Legyen $A in CC^(m times n)$ olyan mátrix, ahol kevesebb az egyenlet, mint az ismeretlen ($m < n$), és a mátrix rangja maximális ($r = m$). Ez azt jelenti, hogy az $A$ sorai lineárisan függetlenek.

*Tétel:* Ebben az esetben az általánosított inverz:
$ A^+ = A^* (A A^*)^(-1) $

*Bizonyítás:* Az előző esethez hasonlóan az axiómák behelyettesítésével igazolható. Itt az $A A^+ = I_m$ fog teljesülni, ami az axiómák azonnali teljesülését vonja maga után.

== b) Az általánosított inverz approximációs tulajdonsága

Ez a fejezet választ ad arra, hogy miért az $x^+ = A^+ b$ vektort tekintjük a rendszer "legjobb" megoldásának.

=== Fundamentális lemmák
A bizonyításhoz szükségünk van két technikai segédtételre, amelyek az általánosított inverz axiómáiból következnek.

*2. Lemma:* $A^* (A A^+ - I) = 0$
*Bizonyítás:* Vegyük a kifejezés adjungáltját: $(A^* (A A^+ - I))^* = (A A^+ - I)^* A = ( (A A^+)^* - I ) A$. Az 1. axióma miatt ez $(A A^+ - I) A = A A^+ A - A$. A 3. axióma szerint $A A^+ A = A$, így az eredmény $A - A = 0$.

*3. Lemma:* $(A^+)^* (I - A^+ A) = 0$
*Bizonyítás:* Hasonlóan az adjungált képzésével: $(I - A^+ A)^* A^+ = (I - (A^+ A)^*) A^+ = (I - A^+ A) A^+ = A^+ - A^+ A A^+ = 0$ (a 2. és 4. axióma alapján).

=== Az approximációs tétel
*Tétel:* Legyen $A x = b$ egy tetszőleges lineáris egyenletrendszer és $x^+ = A^+ b$.
1. *Legkisebb hiba:* Bármely $x in CC^n$ esetén $|A x - b|_2 >= |A x^+ - b|_2$.
2. *Minimális norma:* Ha létezik több olyan $x$ is, amely minimalizálja a hibát, akkor azok közül az $x^+$ vektor normája a legkisebb: $|x|_2 > |x^+|_2$ minden $x != x^+$ esetén.

=== A tétel bizonyítása (1. rész)
Bontsuk fel az $A x - b$ vektort két részre:
$ A x - b = (A x - A x^+) + (A x^+ - b) = A(x - x^+) + (A x^+ - b) $
A 2. Lemma segítségével belátható, hogy ez a két vektor merőleges egymásra:
$
  chevron.l A(x - x^+), A x^+ - b chevron.r = chevron.l x - x^+, A^* (A A^+ b - b) chevron.r = chevron.l x - x^+, A^* (A A^+ - I) b chevron.r = 0
$
Mivel merőlegesek, alkalmazható Pitagorasz tétele:
$ |A x - b|_2^2 = |A(x - x^+)|_2^2 + |A x^+ - b|_2^2 $
Mivel a bal oldali tag $(|A(x - x^+)|_2^2)$ nemnegatív, ezért $|A x - b|_2^2 >= |A x^+ - b|_2^2$, ami igazolja, hogy $x^+$ a legjobb közelítést adja.

/*

### Beszédes magyarázat a 19. tételhez (a vizsgára):

Amikor erről a tételről beszélsz, próbáld megértetni a vizsgáztatóval a *"miértet"*.

*Miért fontos a teljes rangú eset?*
Mondd el, hogy a mérnöki gyakorlatban leggyakrabban a túlhatározott rendszerekkel találkozunk (például 100 mérési pontunk van 2 ismeretlen paraméterre). Ilyenkor az $A^*A$ mátrix invertálható, és az általánosított inverz képlete ($A^+ = (A^*A)^(-1)A^*$) megegyezik azzal, amit a *legkisebb négyzetek módszerénél* (20. tétel) használnak. Ez a tétel tehát a híd az absztrakt SVD és a gyakorlati regressziószámítás között.

*Az approximációs tulajdonság jelentősége:*
Ez a tétel a Moore-Penrose inverz "szentírása". Magyarázd el: ha egy egyenletrendszernek *nincs megoldása* (mert a pontok nem esnek egy egyenesre), akkor az $x^+$ azt a pontot adja meg, ahol a hiba a lehető legkisebb. Ha viszont *végtelen sok megoldás* van (alulhatározott rendszer), akkor az $x^+$ kiválasztja azt az egyet, amelyik a legközelebb van az origóhoz (legkisebb energia).

*A lemmák és Pitagorasz:*
A bizonyítás során emeld ki, hogy a trükk a merőlegességben van. Az általánosított inverz úgy "szeleteli fel" a teret, hogy az $x^+$ által okozott hiba merőleges legyen az $A$ mátrix képterére. Geometriailag ez egy *merőleges vetítés*. Amikor Pitagorasz tételét használod, valójában azt mutatod meg, hogy bármilyen más $x$ választása csak egy extra hiba-komponenst ad hozzá a már meglévő minimális távolsághoz.

*/

#pagebreak()


= 20. Legkisebb négyzetek módszere

A gyakorlatban gyakran előfordul, hogy egy kísérlet során sok mérési pontot kapunk, amelyekre nem tudunk (vagy a mérési zaj miatt nem is akarunk) pontosan illeszkedő interpolációs polinomot fektetni. Ilyenkor olyan alacsony fokszámú görbét keresünk, amely a lehető legközelebb halad el a pontok mellett.

== a) A feladat megfogalmazása és megoldása általánosított inverzzel

=== A feladat megfogalmazása
Adottak az $x_1, x_2, dots, x_N$ különböző alappontok és a hozzájuk tartozó $y_1, y_2, dots, y_N$ függvényértékek (mérési eredmények). Olyan $p_n$ legfeljebb $n$-edfokú polinomot keresünk ($n+1 <= N$, de általában $N gt.double n$), amelyre a hibák négyzetösszege minimális:
$ sum_(i=1)^N (y_i - p_n (x_i))^2 arrow min $
Ezt a $p_n$ polinomot négyzetesen legjobban közelítő polinomnak nevezzük.

=== Átfogalmazás lineáris egyenletrendszerré
Írjuk fel az illeszkedési feltételeket minden pontra: $p_n (x_i) = y_i$. Mivel $p_n (x) = a_n x^n + dots + a_1 x + a_0$, ez egy túlhatározott lineáris egyenletrendszert ad az $a$ együtthatóvektorra:
$ A a = y $
Ahol $A$ egy $N times (n+1)$ méretű Vandermonde-típusú mátrix (melynek oszlopaiban az alappontok hatványai állnak), $a$ az ismeretlen együtthatók vektora, $y$ pedig a mért értékek vektora.

=== Megoldás az általánosított inverzzel
Mivel $N > n+1$, a rendszernek általában nincs pontos megoldása. Az előző tételből (19. tétel) tudjuk, hogy az ilyen rendszerek "legjobb" közelítő megoldását az általánosított inverz adja:
$ a^+ = A^+ y $
Ahol $A^+$ a Moore-Penrose-féle pszeudo-inverz.

=== Igazolás az approximációs tulajdonsággal
Be kell látnunk, hogy ez az $a^+$ valóban megoldja a kitűzött feladatot.
1. A feladatunk a $sum (y_i - p_n (x_i))^2$ kifejezés minimalizálása.
2. Vegyük észre, hogy ez pontosan megegyezik az $|A a - y|_2^2$ euklideszi norma négyzetével.
3. Az általánosított inverz approximációs tétele (19. tétel) kimondja, hogy bármely $a$ vektor esetén $|A a^+ - y|_2 <= |A a - y|_2$.
4. Mivel a norma minimalizálása egyenértékű a négyzetének minimalizálásával, így az $a^+$ vektor együtthatóival felírt polinom valóban a keresett négyzetesen legjobban közelítő polinom.

== b) A polinom előállítása szélsőérték-feladatként

A gyakorlatban a pszeudo-inverz helyett gyakran közvetlen deriválással vezetjük le a megoldást, ami a Gauss-féle normálegyenletekhez vezet.

=== Levezetés szélsőérték-feladatként
Definiáljuk a minimalizálandó $F$ többváltozós függvényt az $a_0, a_1, dots, a_n$ együtthatók függvényében:
$ F(a_0, a_1, dots, a_n) = sum_(i=1)^N (y_i - sum_(j=0)^n a_j x_i^j)^2 $
A szélsőérték létezésének szükséges feltétele, hogy a parciális deriváltak minden ismeretlen szerint nullák legyenek:
$ (partial F)/(partial a_k) = 0 "  " (k = 0, dots, n) $

=== A deriválás lépései
Végezzük el a deriválást a láncszabály segítségével:
$ sum_(i=1)^N 2(y_i - p_n (x_i)) dot (- (partial p_n)/(partial a_k)(x_i)) = 0 $
Mivel $(partial p_n)/(partial a_k)(x_i) = x_i^k$, kapjuk:
$ sum_(i=1)^N (y_i - p_n (x_i)) dot x_i^k = 0 => sum_(i=1)^N p_n (x_i) x_i^k = sum_(i=1)^N y_i x_i^k $

=== A Gauss-féle normálegyenletek
Helyettesítsük vissza a polinom alakját ($p_n(x_i) = sum a_j x_i^j$):
$ sum_(j=0)^n a_j (sum_(i=1)^N x_i^(j+k)) = sum_(i=1)^N y_i x_i^k "  " (k = 0, dots, n) $
Ez egy $(n+1) times (n+1)$ méretű lineáris egyenletrendszer. Mátrixos alakban ez pontosan a következő:
$ A^T A a = A^T y $
Mivel az alappontok különbözők, az $A$ mátrix teljes oszloprangú, így az $A^T A$ mátrix szimmetrikus, pozitív definit és invertálható. A rendszer megoldása:
$ a = (A^T A)^(-1) A^T y $
Ez pontosan megegyezik a teljes rangú esetre vonatkozó általánosított inverz képletével.

/*

### Beszédes magyarázat a 20. tételhez (felkészüléshez):

Amikor erről a tételről beszélsz a vizsgán, próbáld megvilágítani a *különbséget az interpoláció és ezen módszer között*. Mondd el: "Míg az interpolációnál minden pontot szentírásnak veszünk és átmegyünk rajtuk, addig itt megengedjük a hibát, mert tudjuk, hogy a méréseink pontatlanok lehetnek."

Az *a) részben* az a zseniális, hogy nem kell újra feltalálni a spanyolviaszt. Ha már tudod a 19. tételt (az SVD-t és a pszeudo-inverzet), akkor a legkisebb négyzetek feladata csak egy egyszerű alkalmazás. A pszeudo-inverz "természeténél fogva" a legkisebb hibát keresi meg.

A *b) részben* a *szélsőérték-keresés* a lényeg. Képzeld el az $F$ függvényt, mint egy tál alakú felületet a többdimenziós térben. Mi a legalacsonyabb pontját (minimumát) keressük. A parciális deriváltak nullává tétele olyan, mintha minden irányban megkeresnénk azt a pontot, ahol a felület "vízszintes".

A *Gauss-féle normálegyenletek* kapcsán emeld ki: ez a módszer azért népszerű, mert egy hatalmas, túlhatározott problémát (sok ezer mérési pont) redukál egy egészen kicsi, jól kezelhető méretű ($n+1$ ismeretlenes) rendszerre.

*Egy fontos megjegyzés a végére:* Bár az $A^T A a = A^T y$ elméletileg gyönyörű, numerikusan az $A^T A$ mátrix kondíciós száma sokkal rosszabb lehet, mint az eredeti $A$ mátrixé. Ezért a professzionális szoftverek (mint a Matlab `\` operátora) gyakran inkább *QR-felbontást* használnak a megoldáshoz, mert az stabilabb.

*/

#pagebreak()

= 21. Hilbert-térbeli approximáció

A Hilbert-terek elmélete a numerikus analízis egyik legmélyebb alapköve. Lehetővé teszi, hogy a hagyományos geometriai fogalmainkat (mint a merőlegesség, a vetítés és a távolság) kiterjesszük végtelen dimenziós függvényterekre is. Ez az elmélet ad választ arra, hogyan találhatjuk meg egy bonyolult függvényhez a "legközelebbi" egyszerűbb függvényt egy adott szempont szerint.

== a) Hilbert-tér fogalma és az approximációs feladat megoldása

=== A Hilbert-tér definíciója
A $(H, chevron.l dot, dot chevron.r)$ párost Hilbert-térnek nevezzük, ha teljesülnek az alábbiak:
1. *Lineáris tér:* $H$ egy vektortér a valós számtest felett.
2. *Skaláris szorzat:* Értelmezve van egy $chevron.l f, g chevron.r$ művelet, amely szimmetrikus, additív és pozitív definit.
3. *Norma:* A skaláris szorzat természetes módon indukál egy normát: $norm(f) = sqrt(chevron.l f\, f chevron.r)$.
4. *Teljesség:* A tér minden Cauchy-sorozata konvergens, és a határértéke is a térben van. Ez biztosítja, hogy ha egy közelítő sorozattal haladunk valahová, a célállomásunk nem esik ki a térből.

=== Az approximációs feladat megfogalmazása
Legyen $H$ egy Hilbert-tér, $f in H$ egy tetszőleges elem, és $H' subset H$ egy zárt altér. Olyan $f' in H'$ elemet keresünk, amelyre az $f$ és az altér távolsága minimális:
$ norm(f - f') = inf_(h' in H') norm(f - h') $

=== A Hilbert-térbeli approximáció tétele
*Állítás:* Létezik pontosan egy ilyen $f'$ elem, és ez az elem jellemezhető azzal a tulajdonsággal, hogy a hiba ($f - f'$) merőleges az altér minden elemére:
$ f - f' perp H' quad arrow.l.r quad chevron.l f - f', h' chevron.r = 0 quad forall h' in H' $

*Geometriai jelentés:* Minden $f$ elem egyértelműen felbontható egy $H'$-beli és egy arra merőleges elemi összegre: $f = f' + f''$, ahol $f' in H'$ és $f'' in (H')^perp$. Geometriailag $f'$ nem más, mint az $f$ elem *merőleges vetülete* az $H'$ altérre.

=== Megoldás véges dimenziós altér esetén
Tegyük fel, hogy az altér generátorrendszere $H' = "span"(g_1, ..., g_n)$, ahol a $g_i$ bázisvektorok lineárisan függetlenek. Keressük a legjobb közelítést $f' = sum_(i=1)^n c_i g_i$ alakban.
A merőlegességi feltétel miatt minden $j = 1, ..., n$ indexre:
$
  chevron.l f - sum_(i=1)^n c_i g_i, g_j chevron.r = 0 arrow.r sum_(i=1)^n c_i chevron.l g_i, g_j chevron.r = chevron.l f, g_j chevron.r
$
Ez egy $n times n$-es lineáris egyenletrendszert ad, amit *Gram-rendszernek* nevezünk:
$ G c = b $
Ahol $G_(j, i) = chevron.l g_i, g_j chevron.r$ a *Gram-mátrix*, $b_j = chevron.l f, g_j chevron.r$ pedig a jobb oldali vektor. Mivel a bázisvektorok függetlenek, a Gram-mátrix szimmetrikus, pozitív definit és invertálható.

=== A távolság kiszámítása
A minimális távolság négyzete ($d^2$) a vetítési tulajdonságból vezethető le:
$ d^2 = norm(f - f')^2 = chevron.l f, f - f' chevron.r - chevron.l f', f - f' chevron.r $
Mivel a második tag a merőlegesség miatt nulla, kapjuk a távolságképletet:
$ d^2 = norm(f)^2 - chevron.l f, sum c_i g_i chevron.r = norm(f)^2 - b^T c $

=== Speciális esetek: OGR és ONR
1. *Ortogonális rendszer (OGR):* Ha a bázis elemei merőlegesek ($chevron.l g_i, g_j chevron.r = 0$, ha $i != j$), akkor a Gram-mátrix diagonális. Az együtthatók: $c_i = (chevron.l f, g_i chevron.r) / norm(g_i)^2$.
2. *Ortonormált rendszer (ONR):* Ha a bázis elemei egységnyi hosszúak is ($norm(g_i) = 1$), akkor $G$ az egységmátrix, és az együtthatók egyszerűen a Fourier-együtthatók: $c_i = chevron.l f, g_i chevron.r$.

== b) A négyzetesen legjobban közelítő polinom előállítása

Alkalmazzuk a fenti elméletet az $f$ függvény polinomokkal történő közelítésére.

=== A tér és a skaláris szorzat megválasztása
Legyen $H = L_(2,w)[a, b]$ a négyzetesen integrálható függvények tere a $w(x) >= 0$ súlyfüggvénnyel. Itt a skaláris szorzat:
$ chevron.l f, g chevron.r_w = integral_a^b f(x) g(x) w(x) dif x $
A közelítő altér legyen $H' = P_n$, a legfeljebb $n$-edfokú polinomok tere.

=== Levezetés hatványbázisban
Válasszuk bázisnak a természetes hatványokat: $g_j(x) = x^j$ ($j = 0, ..., n$).
A Gram-mátrix elemei ekkor a függvényrendszer *momentumai* lesznek:
$ G_(i, j) = chevron.l x^i, x^j chevron.r_w = integral_a^b x^(i+j) w(x) dif x $
A jobb oldali vektor elemei: $b_j = chevron.l f, x^j chevron.r_w = integral_a^b f(x) x^j w(x) dif x$.
A megoldandó $G c = b$ rendszer ekkor pontosan a *Gauss-féle normálegyenleteket* adja vissza. A kapott $c_j$ értékekkel a négyzetesen legjobban közelítő polinom:
$ p_n(x) = sum_(j=0)^n c_j x^j $

Megjegyzés: Ha a hatványbázis helyett *ortogonális polinomokat* választunk bázisnak (mint a 22. tételben), a Gram-mátrix diagonális lesz, így az együtthatók meghatározása stabilabbá és gyorsabbá válik.

/*

### Beszédes magyarázat a 21. tételhez (hogy ne csak a kód legyen):

Amikor erről a tételről beszélsz a vizsgán, a legfontosabb, hogy értesd: ez a tétel a *geometria és az analízis találkozása*.

1. *A merőlegesség ereje:* Emeld ki, hogy az approximációban a "legjobb" mindig a "merőleges vetületet" jelenti. Olyan ez, mint amikor a szobában a padlón keresed a lámpa ($f$) alatti legközelebbi pontot ($f'$). A hiba ($f-f'$) mindig függőleges, azaz merőleges a padlóra ($H'$). Ezt hívják *ortogonális projekciónak*.

2. *Gram-mátrix és momentumok:* Amikor a b) részhez érsz, mutass rá, hogy a skaláris szorzat itt egy integrál. A hatványbázisban a mátrix elemei ($x^i \cdot x^j$ integrálja) valójában a terület súlyozott átlagai. Mondd el, hogy bár ez elméletileg tökéletes, a hatványbázis Gram-mátrixa (pl. a Hilbert-mátrix) numerikusan "nagyon gonosz" (rosszul kondicionált), ezért a gyakorlatban inkább a 22. tételbeli ortogonális polinomokat használjuk.

3. *Energia-minimalizálás:* A távolságképlet ($d^2 = norm(f)^2 - b^T c$) azt mutatja meg, hogy mennyi "energia" (hiba) marad meg a függvényben, miután levontuk belőle azt a részt, amit a polinomokkal már le tudtunk írni.

*/

#pagebreak()

= 22. Ortogonális polinomok

Az ortogonális polinomok olyan függvénysorozatok, amelyek egy adott súlyfüggvényre nézve merőlegesek egymásra. Ez a tulajdonság alapvető a függvények legjobb közelítésénél, mivel lehetővé teszi, hogy bonyolult egyenletrendszerek megoldása helyett közvetlen számításokkal kapjuk meg a közelítő polinom együtthatóit.

== a) Az ortogonális polinomrendszer fogalma és rekurziója

=== Definíció
Tekintsük az $(L_(2,w)[a, b], chevron.l dot, dot chevron.r_w)$ Hilbert-teret, ahol $w(x) >= 0$ egy súlyfüggvény. A $(p_0, p_1, ..., p_n)$ polinomrendszert *ortogonális rendszernek* nevezzük, ha bármely két különböző fokszámú tagjának skaláris szorzata nulla:
$ chevron.l p_i, p_j chevron.r_w = integral_a^b p_i (x) p_j (x) w(x) dif x = 0, quad "ha " i != j. $
Ha a polinomok főegyütthatója 1, akkor *1-főegyütthatós (monic)* ortogonális polinomokról beszélünk, jelölésük: $tilde(p)_n$.

=== Az 1-főegyütthatós ortogonális polinomok rekurziója
Minden ortogonális polinomrendszerre felírható egy háromtagú rekurziós összefüggés.

*Tétel:* Legyen $(tilde(p)_n)_(n=0)^oo$ egy 1-főegyütthatós ortogonális polinomrendszer. Ekkor:
$ tilde(p)_(-1) (x) equiv 0 $
$ tilde(p)_0 (x) equiv 1 $
$ tilde(p)_(n+1) (x) = (x - alpha_(n+1)) tilde(p)_n (x) - beta_n tilde(p)_(n-1) (x) quad (n = 0, 1, dots) $
ahol az együtthatók:
$
  alpha_(n+1) = (chevron.l id dot tilde(p)_n, tilde(p)_n chevron.r_w) / norm(tilde(p)_n)_w^2 quad "és" quad beta_n = norm(tilde(p)_n)_w^2 / norm(tilde(p)_(n-1))_w^2 > 0.
$

*Bizonyítás:*
1. Mivel $tilde(p)_(n+1) (x) - x tilde(p)_n (x)$ egy legfeljebb $n$-edfokú polinom, felírható az eddigi ortogonális polinomok lineáris kombinációjaként:
$ tilde(p)_(n+1) (x) = x tilde(p)_n (x) - sum_(k=0)^n c_k tilde(p)_k (x) $
2. Szorozzuk meg az egyenletet skalárisan $tilde(p)_j$-vel ($j <= n$). Az ortogonalitás miatt a bal oldalon 0-t kapunk, a szummából pedig csak a $j=k$ tag marad meg:
$
  0 = chevron.l x tilde(p)_n, tilde(p)_j chevron.r_w - c_j norm(tilde(p)_j)_w^2 arrow.r c_j = (chevron.l x tilde(p)_n, tilde(p)_j chevron.r_w) / norm(tilde(p)_j)_w^2
$
3. Vegyük észre, hogy $chevron.l x tilde(p)_n, tilde(p)_j chevron.r_w = chevron.l tilde(p)_n, x tilde(p)_j chevron.r_w$. Ha $j < n-1$, akkor $x tilde(p)_j$ egy legfeljebb $n-1$ fokszámú polinom. Mivel $tilde(p)_n$ merőleges minden nála kisebb fokszámú polinomra, ezért $c_j = 0$, ha $j < n-1$.
4. Így csak két együttható maradhat: $c_n = alpha_(n+1)$ és $c_(n-1) = beta_n$, ami pontosan a tételben szereplő rekurziót adja.

=== Tételek az ortogonális polinomok gyökeiről

*1. Tétel:* Minden $n >= 1$ esetén a $tilde(p)_n$ ortogonális polinomnak pontosan $n$ darab különböző valós gyöke van az $(a, b)$ nyílt intervallumban.

*Bizonyítás (Indirekt):*
1. Tegyük fel, hogy $tilde(p)_n$-nek csak $k < n$ darab olyan gyöke van az intervallumban, ahol előjelet vált ($x_1, ..., x_k$).
2. Konstruáljunk egy segédpolinomot: $q(x) = (x - x_1)(x - x_2) dots (x - x_k)$.
3. Vizsgáljuk a $tilde(p)_n (x) q(x)$ szorzatot. Ez a függvény az összes előjelváltó helyen egyszerre vált előjelet $tilde(p)_n$-nel, így a szorzat előjele állandó lesz (pl. végig nemnegatív).
4. Ekkor az integráljuk nem lehet nulla: $integral_a^b tilde(p)_n (x) q(x) w(x) dif x > 0$.
5. Viszont $q(x)$ fokszáma $k < n$, tehát az ortogonalitás miatt $tilde(p)_n$ merőleges rá, azaz a skaláris szorzatuknak (az integrálnak) 0-nak kellene lennie. Ez ellentmondás, tehát $k$ nem lehet kisebb, mint $n$.

*2. Tétel (Gyökök váltakozása):* A $tilde(p)_n$ és $tilde(p)_(n-1)$ polinomok gyökei váltakozva (egymásba skatulyázva) helyezkednek el: minden két szomszédos $tilde(p)_n$ gyök között van pontosan egy $tilde(p)_(n-1)$ gyök.

== b) Minimalizálási tulajdonság és klasszikus rendszerek

=== Az ortogonális polinomok minimalizálási tulajdonsága
Ez a tétel rávilágít arra, miért "legjobbak" ezek a polinomok az approximációban.

*Tétel:* Az összes olyan $n$-edfokú polinom közül, amelynek főegyütthatója 1, a $tilde(p)_n$ ortogonális polinom az, amelynek a súlyozott négyzetes normája a legkisebb. Azaz:
$ min_(Q in P_n^((1))) norm(Q)_w = norm(tilde(p)_n)_w $

*Bizonyítás:*
1. Bármely $Q in P_n^((1))$ felírható $Q = tilde(p)_n + r_(n-1)$ alakban, ahol $r_(n-1)$ egy legfeljebb $n-1$ fokszámú polinom.
2. Számoljuk ki a norma négyzetét:
$
  norm(Q)_w^2 = chevron.l tilde(p)_n + r_(n-1), tilde(p)_n + r_(n-1) chevron.r_w = norm(tilde(p)_n)_w^2 + norm(r_(n-1))_w^2 + 2 chevron.l tilde(p)_n, r_(n-1) chevron.r_w
$
3. Az ortogonalitás miatt $chevron.l tilde(p)_n, r_(n-1) chevron.r_w = 0$.
4. Marad: $norm(Q)_w^2 = norm(tilde(p)_n)_w^2 + norm(r_(n-1))_w^2$.
5. Ez az összeg akkor a legkisebb, ha a nemnegatív $norm(r_(n-1))_w^2$ tag nulla, azaz $r_(n-1) equiv 0$, tehát $Q = tilde(p)_n$.

=== Klasszikus ortogonális polinomrendszerek

A gyakorlatban leggyakrabban használt rendszerek:

1. *Legendre-polinomok ($P_n$):*
  - Intervallum: $[-1, 1]$
  - Súlyfüggvény: $w(x) = 1$
  - Alkalmazás: Általános célú közelítés és integrálás.

2. *Csebisev-polinomok (I. fajú, $T_n$):*
  - Intervallum: $[-1, 1]$
  - Súlyfüggvény: $w(x) = 1 / sqrt(1 - x^2)$
  - Alkalmazás: Interpolációs alappontok optimalizálása.

3. *Csebisev-polinomok (II. fajú, $U_n$):*
  - Intervallum: $[-1, 1]$
  - Súlyfüggvény: $w(x) = sqrt(1 - x^2)$

4. *Hermite-polinomok ($H_n$):*
  - Intervallum: $(-oo, oo)$
  - Súlyfüggvény: $w(x) = e^(-x^2)$
  - Alkalmazás: Valószínűségszámítás és kvantummechanika.

5. *Laguerre-polinomok ($L_n$):*
  - Intervallum: $[0, oo)$
  - Súlyfüggvény: $w(x) = e^(-x)$
  - Alkalmazás: Félig végtelen tartományú fizikai feladatok.

/*

### Beszédes magyarázat a 22. tételhez (vizsga-felkészüléshez):

Amikor erről a tételről beszélsz, próbáld megvilágítani a dolog "mögöttes logikáját".

A *háromtagú rekurzió* a numerikus analízis egyik legfontosabb spórolási trükkje. Mondd el a vizsgáztatónak: "Bár elméletileg minden egyes új polinomot le tudnánk gyártani Gram-Schmidt-ortogonalizációval az összes előzőre merőlegesítve, a matematika csodája az, hogy elég csak az utolsó kettőt ismernünk." Ez teszi lehetővé, hogy a számítógép akár 1000-edfokú polinomokkal is villámgyorsan dolgozzon.

A *gyökök létezésének bizonyítása* egy igazi klasszikus. A kulcsmozzanat a $q(x)$ segédpolinom. Ez a polinom "elkapja" $tilde(p)_n$ összes irányváltását, és mivel együtt váltanak előjelet, a szorzatuk "kilapul" a tengely felett. Mivel az integrál (a terület) így már nem lehet nulla, de az ortogonalitás szerint annak kellene lennie, a logikai csapda bezárul: muszáj, hogy $n$ darab gyök legyen.

A *minimalizálási tulajdonság* (b rész) azért lényeges, mert ez mondja ki: ha a "teljes energiát" (azaz az $L_2$ normát) akarjuk minimalizálni a közelítésnél, akkor nincs jobb választás az ortogonális polinomoknál. Ez a tétel a közvetlen kapcsolata ennek a fejezetnek a legkisebb négyzetek módszeréhez.

Végül a *klasszikus polinomoknál* elég, ha tudod, melyik "hol lakik" (intervallum) és mi a "kedvenc helye" (súlyfüggvény). A Csebisev például azért fontos, mert a széleken sűríti be a pontokat, míg a Legendre egyenletesen figyel az egész intervallumra.

*/

#pagebreak()

= 23. Numerikus integrálás I.

A numerikus integrálás (kvadratúra) célja az $I(f) = integral_a^b f(x) w(x) dif x$ integrál közelítő kiszámítása, ahol $w(x) >= 0$ egy súlyfüggvény. Ez különösen fontos, ha a függvény csak pontokban adott, vagy nincs zárt alakú primitív függvénye.

== a) Az interpolációs kvadratúra formulák és az érintő-formula

=== Az interpolációs kvadratúra formula alapötlete
Vegyünk egy $a <= x_0 < x_1 < dots < x_n <= b$ felosztást. Közelítsük az $f$ függvényt az ezen pontokra illeszkedő $L_n$ Lagrange-interpolációs polinommal:
$
  integral_a^b f(x) w(x) dif x approx integral_a^b L_n(x) w(x) dif x = integral_a^b sum_(k=0)^n f(x_k) l_k (x) w(x) dif x
$
A szummát kiemelve kapjuk a kvadratúra formula általános alakját:
$ sum_(k=0)^n A_k f(x_k), quad "ahol" quad A_k = integral_a^b l_k (x) w(x) dif x. $

=== Tétel a pontosságról
*Állítás:* Egy kvadratúra formula akkor és csak akkor pontos minden legfeljebb $n$-edfokú polinomra ($f in P_n$), ha interpolációs típusú, azaz az együtthatói $A_k = integral_a^b l_k (x) w(x) dif x$ alakúak.

*Bizonyítás:*
- ($arrow.l$): Ha a formula interpolációs típusú, akkor minden $f in P_n$ esetén $f equiv L_n$, így az integrálközelítés pontos értéket ad.
- ($arrow.r$): Ha a formula pontos minden $P_n$-beli polinomra, akkor pontos a Lagrange-alappolinomokra is ($l_k in P_n$). Behelyettesítve $l_k$-t a formulába: $integral_a^b l_k (x) w(x) dif x = sum_(j=0)^n A_j l_k (x_j)$. Mivel $l_k (x_j) = delta_(k j)$, a jobb oldalon csak $A_k$ marad.

=== Newton-Cotes (N-C) formulák jellemzése
A Newton-Cotes formulák olyan interpolációs kvadratúrák, ahol $w(x) equiv 1$ és az alappontok egyenletes felosztásúak.
- *Zárt formulák:* Az intervallum végpontjai is alappontok ($x_0 = a, x_n = b$). A lépésköz $h = (b-a)/n$.
- *Nyílt formulák:* A végpontok nem alappontok. A lépésköz $h = (b-a)/(n+2)$, és $x_k = a + (k+1)h$.

=== Az érintő-formula (Ny(0)) levezetése
Ez a legegyszerűbb nyílt formula, ahol $n=0$ (egyetlen alappont).
1. Alappont: Az intervallum közepe, $x_0 = (a+b)/2$.
2. Lépésköz: $h = (b-a)/2$.
3. Az együttható: $A_0 = integral_a^b 1 dif x = b-a$.
*A formula:* $integral_a^b f(x) dif x approx (b-a) f((a+b)/2)$.

== b) N-C tulajdonságok és az érintő-formula hibája

=== A Newton-Cotes együtthatók tulajdonságai
Vezessük be a $B_k = A_k / (b-a)$ relatív együtthatókat. Ezekre igaz:
1. *Összegük egységnyi:* $sum_(k=0)^n B_k = 1$. (Ez abból adódik, hogy $f equiv 1$ esetén a formula pontos.)
2. *Szimmetria:* $B_k = B_(n-k)$. (Az alappontok szimmetrikus elhelyezkedése miatt.)

=== Az érintő-formula hibája és bizonyítása
*Tétel:* Ha $f in C^2[a, b]$, akkor létezik olyan $eta in [a, b]$, hogy:
$ integral_a^b f(x) dif x - E(f) = ((b-a)^3)/(24) f''(eta) $

*Bizonyítás:*
1. Írjuk fel $f(x)$ másodrendű Taylor-formuláját az $x_0 = (a+b)/2$ középpont körül:
$ f(x) = f(x_0) + f'(x_0)(x - x_0) + (f''(xi_x))/(2)(x - x_0)^2 $
2. Integráljuk mindkét oldalt $[a, b]$ felett:
$
  integral_a^b f(x) dif x = integral_a^b f(x_0) dif x + integral_a^b f'(x_0)(x - x_0) dif x + integral_a^b (f''(xi_x))/(2)(x - x_0)^2 dif x
$
3. Számítsuk ki a tagokat:
  - $integral_a^b f(x_0) dif x = (b-a) f(x_0)$, ami pontosan az érintő-formula $E(f)$.
  - $integral_a^b f'(x_0)(x - x_0) dif x = 0$, mert a lineáris tag integrálja a középpontra szimmetrikus intervallumon nulla.
  - A maradéktag integráljára alkalmazzuk az integrálszámítás középértéktételét ($f''$ folytonos, $(x-x_0)^2 >= 0$):
$
  (f''(eta))/(2) integral_a^b (x - x_0)^2 dif x = (f''(eta))/(2) [((x - x_0)^3)/(3)]_a^b = (f''(eta))/(2) dot (2 dot ((b-a)/2)^3)/(3) = ((b-a)^3)/(24) f''(eta).
$

/*

### Beszédes kiegészítés a 23. tételhez (vizsga-felkészüléshez):

Amikor erről a tételről beszélsz, hangsúlyozd, hogy a *Newton-Cotes formulák* a "demokrácia" elvét követik: minden pont között ugyanakkora a távolság. Ez elméletileg egyszerű, de ahogy a 11. tételnél láttuk a Runge-jelenségnél, a túl sok egyenletes pont veszélyes lehet. Ezért a gyakorlatban inkább az alacsony fokszámú formulákat (mint az érintő, trapéz, Simpson) használjuk *összetett módon* (ezt a 25. tétel fejti ki bővebben).

A *pontossági tétel* bizonyítása kulcsfontosságú: a $delta_(kj)$ trükk (a Lagrange-alappolinomok tulajdonsága) az, ami miatt az együtthatókat integrálással kapjuk meg.

Az *érintő-formula* (vagy téglalap-szabály) kapcsán érdemes megjegyezni egy érdekességet: bár csak egyetlen pontot használ, mégis pontos minden *elsőfokú* polinomra (egyenesekre). Ez a szimmetriának köszönhető: a középpont körüli hibák kiejtik egymást. Ezért szerepel a hibaformulában a második derivált ($f''$), és nem csak az első.

A *hibaformula levezetésénél* a Taylor-soros megközelítés a legbiztosabb út. Mondd el a vizsgáztatónak, hogy a lineáris tag azért tűnik el, mert a középpont feletti és alatti területek "antiszimmetrikusak" és kioltják egymást.

*/

#pagebreak()

= 24. Numerikus integrálás II.

A numerikus integrálás során a célunk az $I(f) = integral_a^b f(x) dif x$ integrál közelítése olyan formulákkal, amelyek véges számú függvényérték súlyozott összegeként állnak elő.

== a) Interpolációs kvadratúra formulák és Newton-Cotes típusok

=== Interpolációs kvadratúra formula fogalma
Legyen adott egy $a <= x_0 < x_1 < dots < x_n <= b$ felosztás. A kvadratúra formula általános alakja:
$ sum_(k=0)^n A_k f(x_k) $
A formula akkor *interpolációs típusú*, ha az $A_k$ együtthatókat a Lagrange-alappolinomok integráljaiként kapjuk: $A_k = integral_a^b l_k (x) dif x$. Ez azt jelenti, hogy a függvényt a rajta áthaladó interpolációs polinommal helyettesítjük, és annak integrálját vesszük.

=== Pontossági tétel
Egy kvadratúra formula akkor és csak akkor pontos minden legfeljebb $n$-edfokú polinomra ($f in P_n$), ha interpolációs típusú.

=== Newton-Cotes (N-C) formulák jellemzése
A Newton-Cotes formulák olyan interpolációs kvadratúrák, ahol a súlyfüggvény $w(x) equiv 1$ és az alappontok egyenletes felosztásúak ($x_k = x_0 + k h$):
- *Zárt formulák ($Z(n)$):* Az intervallum végpontjai is alappontok ($x_0 = a, x_n = b$). A lépésköz $h = (b-a)/n$.
- *Nyílt formulák ($"Ny"(n)$):* A végpontok nem alappontok. A lépésköz $h = (b-a)/(n+2)$.

=== A trapéz formula ($Z(1)$) levezetése
Ez a zárt, kétpontos formula ($n=1$), ahol az alappontok a végpontok: $x_0 = a, x_1 = b$.
1. Az együtthatók összege: $A_0 + A_1 = b-a$.
2. Az alappontok szimmetriája miatt $A_0 = A_1$.
3. Ebből következik: $A_0 = A_1 = (b-a)/2$.
*A formula:* $T(f) = frac(b-a, 2) (f(a) + f(b))$.

=== A Simpson formula ($Z(2)$) levezetése
Ez a zárt, hárompontos formula ($n=2$). Alappontok: $x_0 = a, x_1 = (a+b)/2, x_2 = b$.
1. Az együtthatókat az $A_k = integral_a^b l_k (x) dif x$ képletből számoljuk.
2. A középső súly kiszámítása: $A_1 = integral_a^b frac((x-a)(x-b), ((a+b)/2-a)((a+b)/2-b)) dif x = dots = frac(4, 6) (b-a)$.
3. A szimmetria ($A_0 = A_2$) és az $sum A_k = b-a$ feltétel miatt $A_0 = A_2 = frac(1, 6) (b-a)$.
*A formula:* $S(f) = frac(b-a, 6) [f(a) + 4f(frac(a+b, 2)) + f(b)]$.

== b) Hibaformulák és bizonyításuk

=== A trapéz formula hibája
*Tétel:* Ha $f in C^2[a, b]$, akkor létezik olyan $eta in [a, b]$, hogy:
$ integral_a^b f(x) dif x - T(f) = - frac((b-a)^3, 12) f''(eta) $

*Bizonyítás:*
1. Induljunk ki a Lagrange-interpoláció hibaformulájából $n=1$ esetén: $f(x) - L_1(x) = frac(f''(xi_x), 2) (x-a)(x-b)$.
2. Integráljuk mindkét oldalt $[a, b]$ felett. A bal oldal éppen a hiba ($I(f) - T(f)$).
3. Mivel $(x-a)(x-b) <= 0$ végig az intervallumon, alkalmazható az integrálszámítás középértéktétele:
$integral_a^b frac(f''(xi_x), 2) (x-a)(x-b) dif x = frac(f''(eta), 2) integral_a^b (x-a)(x-b) dif x$.
4. Az integrált kiszámolva: $integral_a^b (x-a)(x-b) dif x = - frac(1, 6) (b-a)^3$.
5. Behelyettesítve megkapjuk a tétel állítását.

=== A Simpson formula hibája
*Tétel:* Ha $f in C^4[a, b]$, akkor létezik olyan $eta in [a, b]$, hogy:
$ integral_a^b f(x) dif x - S(f) = - frac((b-a)^5, 2880) f^((4))(eta) $

*Bizonyítás:*
1. Észrevehető, hogy páros $n$ esetén a Newton-Cotes formulák eggyel magasabb fokszámú polinomokra is pontosak ($n=2$-nél $P_3$-ra is).
2. Vegyünk egy olyan $H_3$ Hermite-interpolációs polinomot, amely illeszkedik $a$-ban, $b$-ben, és a felezőpontban 2-es multiplicitással (függvényérték és derivált).
3. Belátható, hogy $integral_a^b H_3(x) dif x = S(f)$.
4. Az Hermite-hibaformula ($m=3$) szerint: $f(x) - H_3(x) = frac(f^((4))(xi_x), 4!) (x-a)(x-b)(x - frac(a+b, 2))^2$.
5. A szorzat utolsó tényezője négyzetes, így a teljes kifejezés nem vált előjelet az $[a, b]$ intervallumon, tehát újra alkalmazható a középértéktétel:
$frac(f^((4))(eta), 24) integral_a^b (x-a)(x-b)(x - frac(a+b, 2))^2 dif x$.
6. Az integrál értéke $- frac(1, 120) (b-a)^5$, amivel adódik a tétel.

/*

### Beszédes kiegészítés a 24. tételhez (vizsga-felkészüléshez):

Amikor erről a tételről beszélsz, hangsúlyozd a *"szimmetria ajándékát"*.

A *trapéz-formulánál* emeld ki, hogy geometriailag a függvény görbéje alatti területet egy húrtrapéz területével közelítjük. Ez egyenesekre ($P_1$) pontos, de a hiba a második deriválttól függ.

A *Simpson-formulánál* a vizsgáztató kedvenc kérdése: *"Miért pontos ez a formula a harmadfokú polinomokra is, ha csak három pontot használ?"* A válasz a szimmetriában rejlik: a harmadfokú tag hibája a középpontra nézve páratlan függvény, így az integrálása során a két oldal kioltja egymást. Emiatt a hiba nem a harmadik, hanem csak a *negyedik deriválttal* arányos, ami hatalmas ugrást jelent a pontosságban.

A *bizonyításoknál* a kulcs az *integrálszámítás középértéktétele*. Mondd el: "Azért tudjuk a deriváltat kihozni az integrál elé, mert a hibaformula maradék része (a csomóponti polinom) nem vált előjelet az intervallumon". A Simpson-esetnél ez trükkös, mert a sima $\omega_2$ váltana előjelet, ezért kell a bizonyításhoz a *Hermite-interpolációt* segítségül hívni, ahol a középpontnál négyzetes tag szerepel, ami garantálja az állandó előjelet.

*/

#pagebreak()

= 25. Numerikus integrálás III.

Az interpolációs kvadratúra formulák (8-24. tétel) pontossága a hibaformulák alapján az intervallum hosszának magasabb hatványaival arányos. Nagy intervallumok esetén azonban a hiba elszállhat, ezért az $[a, b]$ tartományt $m$ egyenlő részre osztjuk, és minden részintervallumon külön-külön alkalmazzuk az alapszabályokat.

== a) Az interpolációs kvadratúra formulák és az összetett szabályok levezetése

=== Az összetett trapéz formula (Trapéz-szabály) levezetése
Osszuk fel az $[a, b]$ intervallumot $m$ darab egyenlő, $h = (b-a)/m$ hosszúságú részintervallumra az $x_k = a + k h$ ($k=0, dots, m$) osztópontokkal.
1. Minden $[x_(k-1), x_k]$ szakaszon alkalmazzuk a trapéz-formulát:
  $ integral_(x_(k-1))^(x_k) f(x) dif x approx frac(h, 2) (f(x_(k-1)) + f(x_k)). $
2. Az elemi integrálok összegzésével megkapjuk a teljes közelítést:
  $ T_m(f) = sum_(k=1)^m frac(h, 2) (f(x_(k-1)) + f(x_k)). $
3. A belső pontok kétszer szerepelnek a szummában, így a végleges alak:
  $ T_m(f) = frac(b - a, 2m) (f(a) + 2 sum_(k=1)^(m-1) f(x_k) + f(b)). $
A súlyok sorozata esztétikusan: $1, 2, 2, dots, 2, 1$.

=== Az összetett Simpson formula (Simpson-szabály) levezetése
A Simpson-szabályhoz páros számú ($m$) részintervallumra van szükség, mivel minden elemi lépés két szakaszt ($[x_(2k-2), x_(2k)]$) fog át, ahol a felezőpont az $x_(2k-1)$.
1. Alkalmazzuk a Simpson-formulát az $[x_(2k-2), x_(2k)]$ szakaszokon (melyek hossza $2h$):
  $ integral_(x_(2k-2))^(x_(2k)) f(x) dif x approx frac(2h, 6) (f(x_(2k-2)) + 4 f(x_(2k-1)) + f(x_(2k))). $
2. Összegezve a $k=1, dots, m/2$ szakaszokra:
  $ S_m(f) = frac(b - a, 3m) [f(a) + 4 sum_(k=1)^(m/2) f(x_(2k-1)) + 2 sum_(k=1)^(m/2-1) f(x_(2k)) + f(b)]. $
A súlyok sorozata itt: $1, 4, 2, 4, 2, dots, 4, 1$.

== b) Az összetett formulák hibabecslése és levezetése

=== A trapéz összetett formula hibája
*Tétel:* Ha $f in C^2[a, b]$, akkor létezik olyan $eta in [a, b]$, hogy:
$ integral_a^b f(x) dif x - T_m(f) = - frac((b-a)^3, 12m^2) f''(eta). $

*Bizonyítás:*
1. Írjuk fel a hibát a részintervallumok hibáinak összegeként:
  $ I(f) - T_m(f) = sum_(k=1)^m (- frac(h^3, 12) f''(eta_k)). $
2. Emeljünk ki konstansokat: $-(h^3/12) sum f''(eta_k) = -(b-a)^3/(12m^3) sum f''(eta_k)$.
3. Vigyünk be egy $1/m$ szorzót: $- frac((b-a)^3, 12m^2) [frac(1, m) sum_(k=1)^m f''(eta_k)]$.
4. Mivel $f''$ folytonos, a szögletes zárójelben lévő számtani középértéket a függvény felveszi egy $eta$ pontban (Darboux-tétel), így megkapjuk az állítást.

=== A Simpson összetett formula hibája
*Tétel:* Ha $f in C^4[a, b]$, akkor létezik olyan $eta in [a, b]$, hogy:
$ integral_a^b f(x) dif x - S_m(f) = - frac((b-a)^5, 180m^4) f^((4))(eta). $

*Bizonyítás:*
A levezetés analóg a trapéz esettel, de itt az elemi szakasz hossza $2h = 2(b-a)/m$.
1. Az elemi hiba: $-(2h)^5/2880 f^((4))(eta_k) = -32 h^5/2880 f^((4))(eta_k) = - h^5/90 f^((4))(eta_k)$.
2. Összegezve $m/2$ darab ilyen szakaszra: $-(m/2) frac(h^5, 90) f^((4))(eta) = - frac(m, 180) frac((b-a)^5, m^5) f^((4))(eta) = - frac((b-a)^5, 180m^4) f^((4))(eta)$.

=== Richardson-féle extrapoláció
Ez egy technika a pontosság növelésére két különböző felosztás ($m$ és $2m$) felhasználásával. A trapéz szabály esetén belátható, hogy:
$ S_m(f) = frac(1, 3) (4 T_(2m)(f) - T_m(f)). $

/*

### Beszédes kiegészítés a 25. tételhez (szóbeli tippek):

Amikor erről a tételről beszélsz, hangsúlyozz két dolgot: a *konvergenciát* és a *hatékonyságot*.

1.  *Konvergencia:* Mondd el, hogy míg a magas fokszámú egyenletes interpoláció (Runge-jelenség) veszélyes, az összetett formuláknál az $m arrow oo$ határátmenet garantáltan a pontos integrálhoz vezet, ha a függvény elég sima ($C^2$ vagy $C^4$). A hiba a trapéznál $1/m^2$, a Simpsonnál pedig $1/m^4$ sebességgel tart a nullához.
2.  *Súlyok ritmusa:* A vizsgáztatók szeretik hallani a súlyok sorozatát. A trapéznál a belső pontok "2-es súlyt" kapnak, mert minden intervallum végpontjaként és a következő kezdőpontjaként is beszámítjuk őket. A Simpsonnál a $4, 2, 4, 2 dots$ váltakozás oka, hogy a "4-esek" a részintervallumok közepén lévő pontok, a "2-esek" pedig az összeillesztési pontok.
3.  *Richardson-trükk:* Emeld ki, hogy a Richardson-extrapoláció valójában a *Romberg-integrálás* alapja. Ez egy rendkívül elegáns módja annak, hogy két "gyengébb" eredményből (két trapéz-szabályból) egy nagyságrendekkel jobb közelítést (egy Simpson-szabályt) gyártsunk anélkül, hogy bonyolultabb integrálási képleteket kellene programoznunk.

*/

#pagebreak()

= 26. Numerikus integrálás IV.

Ebben a fejezetben olyan kvadratúra-formulákat vizsgálunk, amelyek nem egyenletes felosztást használnak, hanem az alappontok optimális megválasztásával növelik a pontosságot.

== a) Csebisev-típusú kvadratúra-formulák

A Csebisev-típusú formulák különlegessége, hogy minden alapponthoz tartozó súly azonos. Ez numerikusan nagyon stabil, mivel elkerüli a nagy és váltakozó előjelű súlyok okozta kerekítési hibákat.

=== Jellemzés és alapfeladat
A formula alakja:
$ integral_a^b f(x) w(x) dif x approx A sum_(k=0)^n f(x_k). $
Itt $n+2$ darab ismeretlenünk van: az $A$ közös súly és az $x_0, x_1, dots, x_n$ alappontok. A cél az, hogy a formula pontos legyen minden $f in P_(n+1)$ polinomra.

=== Előállítás a momentumok segítségével
Mivel az alappontokat nem ismerjük előre, az együtthatókat a momentumok ($mu_j = integral_a^b x^j w(x) dif x$) segítségével határozzuk meg:
1. *Függvényérték konstansra ($f equiv 1$):* $mu_0 = A dot (n+1) => A = mu_0 / (n+1)$.
2. *Hatványfüggvényekre ($f(x) = x^j, j=1 dots n+1$):* A pontossági feltétel szerint:
  $ mu_j = A sum_(k=0)^n (x_k)^j => S_j := sum_(k=0)^n (x_k)^j = mu_j / A = (n+1) frac(mu_j, mu_0). $

=== Kapcsolat a Newton-Waring formulákkal
A megkapott $S_j$ hatványösszegek ismeretében a Newton-Waring (Girard) formulák segítségével felírható az a $P(x) = product (x - x_k)$ polinom, amelynek gyökei éppen a keresett alappontok lesznek.
*Speciális eset:* A $[-1, 1]$ intervallumon a $w(x) = 1/sqrt(1-x^2)$ súlyfüggvény esetén a Csebisev-típusú formula alappontjai éppen a $T_(n+1)$ Csebisev-polinom gyökei, a súly pedig $A = pi/(n+1)$.

== b) Gauss-típusú kvadratúra-formulák

A Gauss-típusú kvadratúrák a numerikus integrálás "királyai": $n+1$ pont felhasználásával elérik a maximális, $2n+1$ fokszámú pontosságot.

=== A Gauss-formulák jellemzése
A formula általános alakú ($sum A_k f(x_k)$), de az alappontokat úgy választjuk meg, hogy azok egybeesnek az adott intervallumhoz és súlyfüggvényhez tartozó $n+1$-edfokú ortogonális polinom gyökeivel.
*Tulajdonság:* Belátható, hogy Gauss-formulák esetén minden súly pozitív ($A_k > 0$), ami garantálja a konvergenciát és a stabilitást.

=== Tétel a pontosságról és bizonyítása
*Tétel:* A kvadratúra-formula pontos minden $f in P_(2n+1)$ polinomra akkor és csak akkor, ha az alappontok az $n+1$-edfokú ortogonális polinom gyökei.

*Bizonyítás ($arrow.l$ irány):*
1. Legyen $f in P_(2n+1)$ tetszőleges polinom. Osszuk el $f$-et maradékosan az $omega_n(x) = product (x - x_k)$ csomóponti polinommal:
  $ f(x) = omega_n(x) q(x) + r(x), "  ahol " q, r in P_n. $
2. Integráljuk mindkét oldalt a súlyfüggvénnyel:
  $ integral_a^b f w = integral_a^b omega_n q w + integral_a^b r w. $
3. Mivel $omega_n$ az $n+1$-edfokú ortogonális polinom, merőleges minden nála kisebb fokszámú polinomra, így $integral omega_n q w = 0$.
4. Az $r in P_n$ maradékra a formula interpolációs volta miatt pontos: $integral r w = sum A_k r(x_k)$.
5. Mivel $f(x_k) = omega_n(x_k) q(x_k) + r(x_k) = 0 dot q(x_k) + r(x_k) = r(x_k)$, a közelítés pontos.

=== Hibaformula és bizonyítása
*Tétel:* Ha $f in C^(2n+2)[a, b]$, akkor létezik olyan $eta in [a, b]$, hogy a hiba:
$ integral_a^b f w - sum_(k=0)^n A_k f(x_k) = frac(f^((2n+2))(eta), (2n+2)!) |omega_n|_(w, 2)^2. $

*Bizonyítás:*
1. Közelítsük $f$-et az $x_0, dots, x_n$ pontokra támaszkodó, mindenhol 2-es multiplicitású $H_(2n+1)$ Fejér-Hermite interpolációs polinommal.
2. A hibaformula szerint: $f(x) - H_(2n+1)(x) = frac(f^((2n+2))(xi_x), (2n+2)!) omega_n^2(x)$.
3. Integrálva a súlyfüggvénnyel, és kihasználva, hogy $omega_n^2(x) w(x) >= 0$, az integrálszámítás középértéktétele alapján a derivált kihozható az integrál elé.
4. Mivel a Gauss-kvadratúra pontos $P_(2n+1)$-re, a $H_(2n+1)$ polinom integrálja pontosan megegyezik a formula értékével, így megkapjuk az állítást.

/*

### Beszédes magyarázat a 26. tételhez (vizsga-tippek):

Amikor erről a tételről beszélsz, a kulcsszó a *"szabadságfokok kihasználása"*. Magyarázd el a vizsgáztatónak a különbséget: a Newton-Cotes esetében (pl. Simpson) csak az együtthatókat ($A_k$) keresgéltük, mert a pontok ($x_k$) fixen egyenlő távolságra voltak. A Gauss-módszernél viszont a pontokat is "mozgathatjuk", így kétszer annyi ismeretlenünk van, és logikus, hogy kétszer akkora fokszámig leszünk pontosak ($2n+1$).

A *Csebisev-formulánál* hangsúlyozd, hogy miért jó az egyenlő súly ($A$): ha minden súly azonos, akkor egyetlen méréshiba sem fog dominálni a végeredményben. Az alappontok meghatározása itt egy igazi algebrai csemege, hiszen a *hatványösszegektől* jutunk el a gyökökig.

A *Gauss-kvadratúra bizonyításánál* a "maradékos osztás" a bűvésztrükk. Mondd el: "Bármilyen magas fokszámú polinomot le tudunk bontani egy ortogonális részre (ami az integrálásnál kiesik) és egy alacsony fokszámú maradékra (amire meg pontos a formulánk)." Ezért nem kell a $2n+1$-edfokú polinommal birkóznunk.

Végül a *hibaformulánál* emeld ki, hogy miért a *Fejér-Hermite interpolációt* használjuk a bizonyításhoz. A sima Lagrange-interpolációnál a csomóponti polinom ($omega_n$) előjelet váltana, ami elrontaná a középértéktételt. De a Fejér-Hermite-nél minden pont kétszeres, így a hibaformulában $omega_n^2$ szerepel, ami mindig pozitív – ez a matematikai garancia arra, hogy a deriváltat ki tudjuk emelni az integráljel alól.

*/

#pagebreak()

= Numerikus integrálás V.

A Gauss-típusú kvadratúra formulák a numerikus integrálás leghatékonyabb eszközei, mivel $n+1$ alappont felhasználásával képesek minden legfeljebb $2n+1$-edfokú polinomot pontosan integrálni.

== a) A Gauss-típusú kvadratúra formulák jellemzése és az együtthatók pozitivitása

=== Jellemzés és az előállítás nehézségei
A kvadratúra formula általános alakja:
$ integral_a^b f(x) w(x) dif x approx sum_(k=0)^n A_k f(x_k). $
Az elvárt pontosság $2n+1$, ami azt jelenti, hogy a formula $2n+2$ darab feltételt kellene, hogy kielégítsen (a $1, x, dots, x^(2n+1)$ hatványfüggvényekre). Az ismeretlenek száma szintén $2n+2$: az $A_0, dots, A_n$ súlyok és az $x_0, dots, x_n$ alappontok.

*Miért nem lehet a formulákat közvetlenül az elvárt pontosság alapján (hatványfüggvényekkel) előállítani?*
Ha felírjuk a pontossági egyenleteket a hatványokra, egy *nemlineáris egyenletrendszert* kapunk az alappontokra és a súlyokra nézve. Például már $n=1$ esetén is (kétpontos formula) a következő rendszert kellene megoldanunk:
$ A_0 + A_1 = mu_0 $
$ A_0 x_0 + A_1 x_1 = mu_1 $
$ A_0 x_0^2 + A_1 x_1^2 = mu_2 $
$ A_0 x_0^3 + A_1 x_1^3 = mu_3 $
Egy ilyen rendszer megoldása nagyobb $n$ esetén rendkívül bonyolult és numerikusan instabil. Ezért van szükség az ortogonális polinomok elméletére, amely "linearizálja" a feladatot azáltal, hogy az alappontokat az ortogonális polinomok gyökeiként rögzíti.

=== Tétel: Az együtthatók pozitivitása
Gauss-típusú kvadratúra formulák esetén minden súly szigorúan pozitív: $A_k > 0$ minden $k = 0, dots, n$ esetén.

*Bizonyítás:*
1. Tekintsük az $x_0, dots, x_n$ alappontokhoz tartozó $l_k (x)$ Lagrange-alappolinomokat.
2. Legyen a vizsgált függvény $f(x) = l_k^2(x)$.
3. Mivel $l_k$ egy $n$-edfokú polinom, a négyzete $l_k^2$ egy $2n$-edfokú polinom.
4. A Gauss-kvadratúra pontos minden $P_(2n+1)$-beli polinomra, így az $l_k^2 in P_(2n)$ függvényre is pontos értéket ad.
5. Írjuk fel a kvadratúrát:
$ 0 < integral_a^b l_k^2(x) w(x) dif x = sum_(j=0)^n A_j l_k^2(x_j). $
6. Használjuk ki a Lagrange-alappolinomok tulajdonságát ($l_k (x_j) = delta_(k j)$): a szummában minden tag nulla lesz, kivéve ahol $j=k$.
7. Így az egyenlőség: $integral_a^b l_k^2 w = A_k dot 1^2 = A_k$.
8. Mivel a súlyfüggvény $w(x) >= 0$ és $l_k^2(x) > 0$ (majdnem mindenhol), az integrál értéke pozitív, tehát $A_k > 0$.

== b) Tétel a pontosságról (előállításról) és bizonyítása

*Tétel:* A $sum_(k=0)^n A_k f(x_k)$ kvadratúra formula akkor és csak akkor pontos minden $f in P_(2n+1)$ polinomra, ha interpolációs típusú és az $x_0, dots, x_n$ alappontok az $n+1$-edfokú súlyozott ortogonális polinom gyökei.

*Bizonyítás ($arrow.l$ irány):*
1. Legyen $f in P_(2n+1)$ egy tetszőleges polinom. Osszuk el $f$-et maradékosan az $omega_n(x) = product_(k=0)^n (x - x_k)$ csomóponti polinommal:
$ f(x) = omega_n(x) q(x) + r(x), "  ahol " q, r in P_n. $
2. Integráljuk mindkét oldalt a súlyfüggvénnyel:
$ integral_a^b f w = integral_a^b omega_n q w + integral_a^b r w. $
3. Mivel $omega_n$ az $n+1$-edfokú ortogonális polinom, definíció szerint merőleges minden nála kisebb fokszámú polinomra, így a $q in P_n$ polinomra is. Tehát $integral_a^b omega_n q w = chevron.l omega_n, q chevron.r_w = 0$.
4. Az $r in P_n$ maradékpolinomra a formula az interpolációs volta miatt pontos: $integral_a^b r w = sum_(k=0)^n A_k r(x_k)$.
5. Vizsgáljuk meg a függvényértékeket az alappontokban: $f(x_k) = omega_n(x_k) q(x_k) + r(x_k)$. Mivel $x_k$ az $omega_n$ gyökei, $omega_n(x_k) = 0$, így $f(x_k) = r(x_k)$.
6. Összegezve: $integral_a^b f w = 0 + integral_a^b r w = sum A_k r(x_k) = sum A_k f(x_k)$.
7. Tehát a formula valóban pontos minden $2n+1$-edfokú polinomra.

/*

### Beszédes magyarázat a 27. tételhez (vizsga-segédlet):

Amikor erről a tételről beszélsz, a vizsgáztató a *"Gauss-módszer zsenialitására"* kíváncsi.

*Az a) résznél* hangsúlyozd a kontrasztot: a Newton-Cotes formuláknál (mint a trapézszabály) az alappontok "be vannak betonozva" (egyenletesek), így csak a súlyokat ($A_k$) tudjuk állítgatni. A Gauss-módszernél viszont az alappontokat is szabadon választhatjuk meg, így kétszer annyi szabadságfokunk van. Mondd el: "Ezért tudunk $n+1$ ponttal nem csak $n$, hanem $2n+1$ fokszámig pontosak lenni". A *pozitivitás bizonyítása* pedig azért fontos, mert ez garantálja, hogy a kerekítési hibák nem fognak katasztrofálisan felerősödni (szemben a magas fokszámú Newton-Cotes formulákkal, ahol negatív súlyok is megjelenhetnek).

*A b) rész bizonyításánál* a kulcsszó a *"maradékos osztás"*. Magyarázd el a logikát: bármilyen bonyolult, magas fokszámú ($2n+1$) polinomot fel tudunk bontani egy "láthatatlan" részre ($omega_n q$), ami az ortogonalitás miatt egyszerűen *eltűnik* az integrálás során, és egy "egyszerű" maradékra ($r$), amire viszont az interpolációs alapfeltételek miatt a formulánk eleve pontos. Ez a matematikai "tisztítótűz" az, ami lehetővé teszi a rendkívüli pontosságot.

Zárásként említsd meg, hogy a gyakorlatban f közelítésére valójában a *Fejér–Hermite interpolációt* használjuk látens módon, és ez az oka annak, hogy a hibaformulában a $(2n+2)$-edik derivált szerepel.

*/
