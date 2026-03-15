#set page(paper: "a4", margin: 2.5cm)
#set par(justify: true)

== HF1.
*Feladat:* Igazoljuk, hogy ha $A$ és $B$ hasonló mátrixok, akkor $tr(A)=tr(B)$.

*Megoldás:*
Mivel $A$ és $B$ hasonló mátrixok, definíció szerint létezik egy $S$ invertálható mátrix, amelyre igaz, hogy:
$ B = S^(-1) A S $
A trace tulajdonságai alapján bármely két megfelelő méretű, összeszorozható $X$ és $Y$ mátrixra érvényes a ciklikus permutáció szabálya, azaz $tr(X Y) = tr(Y X)$. Ezt felhasználva:
$ tr(B) = tr(S^(-1) (A S)) = tr((A S) S^(-1)) = tr(A (S S^(-1))) = tr(A I) = tr(A) $

#pagebreak()
== HF2.
*Feladat:* Igazoljuk, hogy $||a dot b^T||_2 = ||a||_2 dot ||b||_2$ illetve $||a dot b^T||_F = ||a||_2 dot ||b||_2$ minden $a,b in K^n$ vektorra.

*Megoldás:*
Legyen $M = a b^T$ egy $n times n$-es diád mátrix.

*Kettes (spektrál) norma:*
$ ||M||_2 = max_(||x||_2=1) ||M x||_2 $
Helyettesítsük be az $M = a b^T$ kifejezést:
$ ||a b^T||_2 = max_(||x||_2=1) ||a (b^T x)||_2 $
Mivel $b^T x$ egy skalár (a $b$ és $x$ vektorok belső szorzata, $chevron.l b, x r chevron.r$), ezt kiemelhetjük a normából:
$ ||a (b^T x)||_2 = |b^T x| dot ||a||_2 $
A Cauchy-Schwarz-Bunyakovszkij egyenlőtlenség alapján $ |b^T x| <= ||b||_2 dot ||x||_2 $ Mivel $||x||_2 = 1$, ezért $|b^T x| <= ||b||_2$.

A maximum akkor vétetik fel, ha az $x$ vektor párhuzamos $b$-vel, azaz $x = b/(||b||_2)$. Ekkor a belső szorzat abszolút értéke pontosan $||b||_2$.
Így a maximum értéke megadja a keresett normát:
$ ||a b^T||_2 = ||a||_2 dot ||b||_2 $

\ \ \ \ \
*Frobenius norma:*
$ ||M||_F = sqrt(sum_(i=1)^n sum_(j=1)^n |m_(i j)|^2) $
Az $M = a b^T$ mátrix elemei $m_(i j) = a_i b_j$. Behelyettesítve:
$
  ||a b^T||_F^2 = sum_(i=1)^n sum_(j=1)^n |a_i b_j|^2 = sum_(i=1)^n sum_(j=1)^n (|a_i|^2 |b_j|^2) = (sum_(i=1)^n |a_i|^2) (sum_(j=1)^n |b_j|^2) = ||a||_2^2 dot ||b||_2^2
$
A négyzetgyökvonás elvégzése után megkapjuk az állítást:
$ ||a b^T||_F = ||a||_2 dot ||b||_2 $

#pagebreak()
== HF3.
*Feladat:* Az $A="tridiag"(gamma_i, alpha_i, beta_i)$ tridiagonális mátrixot diagonális hasonlósági transzformációval hozzuk $tilde(A)="tridiag"(b_i, a_i, 1)$ alakra.

*Megoldás:*
Keressünk egy $D = "diag"(d_1, d_2, ..., d_n)$ invertálható diagonális mátrixot, amellyel a transzformáció alakja: $tilde(A) = D^(-1) A D$.

Az eredeti $A$ mátrix elemei: főátlóban $a_(i,i) = alpha_i$, szubdiagonálisban (alatta) $a_(i,i-1) = gamma_i$ és szuperdiagonálisban (felette) $a_(i,i+1) = beta_i$.

A transzformált mátrix elemei az indexekre nézve: $tilde(a)_(i,j) = d_i^(-1) a_(i,j) d_j$.

Vizsgáljuk meg a három érintett átlót:
1. *Főátló:* $tilde(a)_(i,i) = d_i^(-1) alpha_i d_i = alpha_i$. Tehát a transzformált mátrix főátlója $a_i = alpha_i$.
2. *felső mellékátló:* Ezt a feladat szerint konstans 1-re akarjuk hozni.
  $ tilde(a)_(i,i+1) = d_i^(-1) beta_i d_(i+1) = 1 $
  Ebből a $D$ mátrix elemeire rekurzió adódik: $d_(i+1) = d_i / beta_i$. Választhatjuk például a $d_1 = 1$ kezdőértéket.
3. *alsó mellékátló:* Ide a $b_i$ elemek fognak kerülni.
  $ tilde(a)_(i,i-1) = d_i^(-1) gamma_i d_(i-1) = gamma_i (d_(i-1) / d_i) $
  A szuperdiagonálisnál kapott összefüggést ($d_(i-1) / d_i = beta_(i-1)$) felhasználva ezt behelyettesíthetjük:
  $b_i = gamma_i beta_(i-1)$  (ahol $i = 2, ..., n$).

Összegezve: a hasonlósági transzformáció eredményeként a kívánt $tilde(A)$ elemei: $a_i = alpha_i$ és $b_i = gamma_i beta_(i-1)$.

#pagebreak()
== HF4.
*Feladat:* Az előző feladatban kapott speciális tridiagonális alakra alkalmazzuk az LU algoritmus egy lépését! $A := "tridiag"(b_i, a_i, 1)$, $L := "tridiag"(l_i, 1, 0)$, $U := "tridiag"(0, u_i, 1)$ és $A = L dot U$. Határozzuk meg $l_i, u_i$ értékét.

*Megoldás:*
A mátrixszorzás definíciója alapján fejezzük ki az $A = L U$ szorzat nem nulla elemeit.
- Az $L$ mátrix: főátlójában 1-esek, alatta $l_i$ elemek vannak ($i=2...n$).
- Az $U$ mátrix: főátlójában $u_i$ elemek, felette 1-esek vannak ($i=1...n-1$).

Az $(L U)$ szorzás soronként és oszloponként:
1. *Főátló feletti elemek ($i, i+1$ indexeken):*
  $ (L U)_(i, i+1) = L_(i,i) U_(i, i+1) = 1 dot 1 = 1 $ (Ez megegyezik $A$ adott szuperdiagonálisával).
2. *Főátló alatti elemek ($i, i-1$ indexeken):*
  $ (L U)_(i, i-1) = L_(i, i-1) U_(i-1, i-1) = l_i dot u_(i-1) = b_i $
  Ebből közvetlenül adódik: $l_i = b_i / u_(i-1)$.
3. *Főátló elemei ($i, i$ indexeken):*
  Első sor esetén: $ (L U)_(1,1) = L_(1,1) U_(1,1) = 1 dot u_1 = a_1 $ Ebből: $ u_1 = a_1 $
  Többi sor ($i > 1$): $ (L U)_(i,i) = L_(i, i-1) U_(i-1, i) + L_(i,i) U_(i,i) = l_i dot 1 + 1 dot u_i = l_i + u_i = a_i $
  Ebből adódik: $u_i = a_i - l_i$.

A keresett elemeket a következő iterációval határozzuk meg:
- $u_1 = a_1$
- Minden $i = 2, ..., n$ esetén: $l_i = b_i / u_(i-1)$ és $u_i = a_i - l_i$.

#pagebreak()
== HF5.
*Feladat:* Legyen $L := "tridiag"(l_i, 1, 0)$, $U := "tridiag"(0, u_i, 1)$ és $tilde(A) := U dot L = "tridiag"(tilde(b)_i, tilde(a)_i, 1)$. Készítse el az $tilde(A) = tilde(L) dot tilde(U)$ felbontást, ahol $tilde(L) := "tridiag"(tilde(l)_i, 1, 0)$ és $tilde(U) := "tridiag"(0, tilde(u)_i, 1)$. Fejezzük ki $tilde(L)$ és $tilde(U)$ elemeit $L$ és $U$ elemeivel.

*Megoldás:*
Először is írjuk fel az $tilde(A) = U L$ (az LR algoritmus szerinti felcserélt) szorzat elemeit a meglévő $L$ és $U$ elemeiből.
- *Főátló ($tilde(a)_i$):*
  $
    tilde(A)_(i,i) = U_(i,i) L_(i,i) + U_(i, i+1) L_(i+1, i) = u_i dot 1 + 1 dot l_(i+1) = u_i + l_(i+1) " " ("ha" i < n)
  $

  A legutolsó elem esetén nincs szuperdiagonális, így: $ tilde(A)_(n,n) = U_(n,n) L_(n,n) = u_n dot 1 = u_n $
  Tehát: $ tilde(a)_i = u_i + l_(i+1) " és " tilde(a)_n = u_n $
- *Szubdiagonális ($tilde(b)_i$):*

  $ tilde(A)_(i, i-1) = U_(i,i) L_(i, i-1) = u_i dot l_i $ Tehát: $ tilde(b)_i = u_i l_i $
- *Szuperdiagonális:* A szorzat eredménye itt továbbra is 1 lesz.

Második lépésként ezt az újonnan kapott $tilde(A)$ mátrixot újra $tilde(L) tilde(U)$ alakra bontjuk. Ehhez felhasználjuk a HF4-ben levezetett, már bizonyított rekurziós képleteket az új hullámos ($~$) elemekre felírva:
- $tilde(u)_1 = tilde(a)_1 = u_1 + l_2$
- Minden $i=2...n$ esetén a szubdiagonális rész: $tilde(l)_i = tilde(b)_i / tilde(u)_(i-1) = (u_i l_i) / tilde(u)_(i-1)$
- Minden $i=2...n-1$ esetén a főátló: $tilde(u)_i = tilde(a)_i - tilde(l)_i = u_i + l_(i+1) - tilde(l)_i$
- A legutolsó sor esetén: $tilde(u)_n = tilde(a)_n - tilde(l)_n = u_n - tilde(l)_n$

Ezzel sikerült $tilde(L)$ és $tilde(U)$ összes elemét zárt formában $L$ és $U$ elemeivel kifejezni.

#pagebreak()
== HF6.
*Feladat:* Nézzen utána a "trace-módszer"-ben használt Newton-Waring (Girard) formuláknak és írja le a bizonyítását!

*Megoldás:*
A Newton-Girard (vagy Newton-Waring) formulák összefüggést adnak meg egy egyenlet gyökeinek elemi szimmetrikus polinomjai és a gyökök adott kitevőjű hatványösszegei között. Numerikus lineáris algebrában ezt gyakran a karakterisztikus polinom együtthatóinak keresésére használjuk. Jelöljük a gyökök (sajátértékek) $k$-adik hatványösszegét így: $p_k = sum_(j=1)^n lambda_j^k = tr(A^k)$.
Legyen a karakterisztikus polinom: $P(lambda) = lambda^n - e_1 lambda^(n-1) + e_2 lambda^(n-2) - ... + (-1)^n e_n$. Itt $e_k$ a $k$-adik elemi szimmetrikus polinom.

*A formulák:*
$ k e_k = sum_(j=1)^k (-1)^(j-1) e_(k-j) p_j $
(ahol definiáljuk, hogy $e_0 = 1$).

*Bizonyítás:*
Induljunk ki a sajátértékek generátorfüggvényéből (amely kis $t$-kre konvergens):
$ E(t) = product_(i=1)^n (1 - lambda_i t) = sum_(k=0)^n (-1)^k e_k t^k $
Vegyük mindkét oldal logaritmikus deriváltját (deriváljuk a függvényt és osszuk el saját magával):
$
  (E'(t))/(E(t)) = d/(d t) ln(E(t)) = d/(d t) sum_(i=1)^n ln(1 - lambda_i t) = sum_(i=1)^n (-lambda_i) / (1 - lambda_i t)
$
A felírt tört kifejezést mértani sorként sorba tudjuk fejteni:
$
  -sum_(i=1)^n sum_(j=0)^oo lambda_i (lambda_i t)^j = -sum_(j=0)^oo (sum_(i=1)^n lambda_i^(j+1)) t^j = -sum_(j=0)^oo p_(j+1) t^j
$
Ezután szorozzuk át a differenciálegyenlet mindkét oldalát $-t E(t)$-vel a törtek eltüntetéséhez:
$ -t E'(t) = E(t) sum_(j=1)^oo p_j t^j $
Ide helyettesítsük vissza a legelső $E(t)$ polinom formát:
Bal oldal: $ -t d/(d t) sum_(k=0)^n (-1)^k e_k t^k = -t sum_(k=1)^n (-1)^k k e_k t^(k-1) = sum_(k=1)^n (-1)^(k-1) k e_k t^k $
Jobb oldal: $ (sum_(m=0)^n (-1)^m e_m t^m) (sum_(j=1)^oo p_j t^j) $
Keressük meg a jobb oldali szorzatban a $t^k$ változóhoz tartozó együtthatót. A polinom-szorzás (konvolúció) szabályai alapján ez a szumma: $sum_(j=1)^k (-1)^(k-j) e_(k-j) p_j$.
A két oldalnak azonosan egyenlőnek kell lennie, tehát a $t^k$ együtthatói is megegyeznek:
$ (-1)^(k-1) k e_k = sum_(j=1)^k (-1)^(k-j) e_(k-j) p_j $
Végül, ha az egyenlet mindkét oldalát beszorozzuk $(-1)^(k-1)$-nel, és észrevesszük, hogy $(-1)^(2k-j-1) = (-1)^(j-1)$, megkapjuk az igazolandó tételt:
$ k e_k = sum_(j=1)^k (-1)^(j-1) e_(k-j) p_j $

#pagebreak()
== HF7.
*Feladat:* Bizonyítsuk, hogy szimmetrikus és tridiagonális mátrixok esetén a QR-algoritmus megtartja a mátrix szimmetriáját és tridiagonális alakját.

*Megoldás:*
A QR algoritmus egy lépésének formája: az $A$ mátrixot felbontjuk $A = Q R$ alakra, majd összeszorozzuk őket fordított sorrendben az iteráció következő eleméhez: $A_1 = R Q$.
Tudjuk, hogy $Q$ ortogonális ($Q^T = Q^(-1)$) és $R$ felső háromszögmátrix. Feltételezzük, hogy az $A$ szimmetrikus ($A = A^T$) és tridiagonális.

*1. Szimmetria megtartásának igazolása:*
Az első egyenletet szorozzuk be balról $Q^(-1)$-nel: $R = Q^(-1) A$. Mivel $Q$ ortogonális, ez megegyezik a $R = Q^T A$ kifejezéssel.
Ezt behelyettesítve a második egyenletbe kapjuk $A_1$ értékét:
$ A_1 = R Q = (Q^T A) Q = Q^T A Q $
Nézzük meg $A_1$ transzponáltját:
$ A_1^T = (Q^T A Q)^T = Q^T A^T (Q^T)^T = Q^T A Q $
Mivel $A$ eleve szimmetrikus volt ($A = A^T$), észrevehetjük, hogy $A_1^T = A_1$, tehát az új mátrix is megőrizte a szimmetriáját.

\ \ \ \ \
*2. Tridiagonális alak megtartásának igazolása:*
Minden tridiagonális mátrix definíció szerint felső Hessenberg-mátrix is egyben (hiszen a főátló alatti második, és minden további alsó elem nulla).
A QR-felbontásnál a HF8-ban részletesen bebizonyítjuk, hogy egy felső Hessenberg-mátrixból kiindulva a következő iteráció eredménye ($A_1$) szintén egy felső Hessenberg-mátrix lesz.
Az első lépésben igazoltuk, hogy az $A_1$ mátrix szimmetrikus, a HF8 alapján pedig felső Hessenberg-mátrix is. Ha egy szimmetrikus mátrix esetében a főátló alatti második és az alatti elemek mind nullák, akkor a szimmetria miatt a főátló feletti második és az afölötti elemeknek is feltétlenül nulláknak kell lenniük.
A szimmetrikus felső Hessenberg-mátrix tehát csak és kizárólag tridiagonális mátrix lehet. Az állítást ezzel igazoltuk.

#pagebreak()
== HF8.
*Feladat:* Bizonyítsuk, hogy a QR-algoritmus a mátrix felső Hessenberg tulajdonságát megtartja.

*Megoldás:*
Legyen $A$ egy felső Hessenberg-mátrix, aminek definíciója: $a_(i,j) = 0$, ha $i > j+1$.
Készítsük el a QR felbontását: $A = Q R$. Feltételezhetjük a levezetéshez, hogy az $A$ mátrix invertálható (szinguláris esetben határértékkel vagy Givens-forgatások konstrukciójával belátható), így $R$ reguláris felső háromszögmátrix, amelynek inverze ($R^(-1)$) is garantáltan felső háromszögmátrix.
Ebből $Q$ kifejezhető mint: $Q = A R^(-1)$.

Vizsgáljuk meg a $Q$ mátrix elemeit a szorzás szabályai alapján:
$ q_(i,j) = (A R^(-1))_(i,j) = sum_(k=1)^n a_(i,k) (R^(-1))_(k,j) $
Mivel $R^(-1)$ felső háromszögmátrix, $(R^(-1))_(k,j) = 0$, ha $k > j$. Tehát a szummát bőven elég $j$-ig vennünk:
$ q_(i,j) = sum_(k=1)^j a_(i,k) (R^(-1))_(k,j) $
A kiindulási $A$ felső Hessenberg tulajdonsága miatt tudjuk, hogy $a_(i,k) = 0$, ha $i > k+1$. Mivel $k$ maximum értéke a vizsgált szummában $j$, ezért az $a_(i,k)$ minden létező tagban nulla lesz abban az esetben, ha $i > j+1$. Emiatt természetesen $q_(i,j) = 0$, ha $i > j+1$.
Tehát beláttuk, hogy maga a $Q$ ortogonális mátrix is felső Hessenberg-mátrix formájú.

Most vizsgáljuk az algoritmus következő iterációját, az $A_1 = R Q$ szorzatot:
$ (A_1)_(i,j) = sum_(k=1)^n r_(i,k) q_(k,j) $
A vizsgált mátrixok korlátjai a következők:
- $r_(i,k) = 0$, ha $i > k$ (mivel $R$ szigorúan felső háromszög).
- $q_(k,j) = 0$, ha $k > j+1$ (ahogy fent beláttuk, $Q$ felső Hessenberg).

Ahhoz, hogy az összegzett szorzat egy tagja egyáltalán lehessen nem nulla, egyszerre kell teljesülnie az $i <= k$ és a $k <= j+1$ feltételeknek. Ezt a kettőt összevonva egyértelmű, hogy a nem nulla tagok felbukkanásához legalább az $i <= j+1$ indexfeltételnek fenn kell állnia.
Amennyiben $i > j+1$, ott biztosan nem fog létezni egyetlen olyan $k$ index sem, amelyre a szorzat mindkét tényezője nem nulla lehetne egyidőben, így a szumma minden eleme nulla, vagyis $(A_1)_(i,j) = 0$.
Ezzel maradéktalanul igazoltuk, hogy a QR lépés után keletkező $A_1$ mátrix is megtartotta a felső Hessenberg tulajdonságát.
