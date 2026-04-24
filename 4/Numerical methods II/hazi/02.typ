/ 1. feladat:
Mivel $Q$ és $P$ értéke az $x_i in {-2, -1, 0, 1, 2}$ helyeken megegyezik, a különbségüknek ($Q-P$) ezen öt pont a gyöke. Ez felírható a csomóponti polinom segítségével:
$ Q(x) - P(x) = c dot (x+2)(x+1)x(x-1)(x-2) $
A $c$ állandót az $x=3$ pontbeli eltérés határozza meg:
$ Q(3) - P(3) = 30 - 61 = -31 $
$ c dot (3+2)(3+1)3(3-1)(3-2) = c dot (5 dot 4 dot 3 dot 2 dot 1) = 120c $
$ 120c = -31 arrow.double c = -31 / 120 $
A keresett polinom:
$ Q(x) = x^4 - x^3 + x^2 - x + 1 - 31 / 120 (x+2)(x+1)x(x-1)(x-2) $

/ 2. feladat:
Az alappontok egy egyenesre esnek ($y = 0.5x + 0.5$). A LER mátrixa szinguláris:
$ mat(1, 1, 1; 3, 2, 1; 5, 3, 1) vec(a, b, c) = vec(3, 2, 6) $
Mivel $R_1 + R_3 = (6, 4, 2) = 2 dot R_2$, a sorok lineárisan összefüggnek. Megoldás csak akkor lenne, ha a függvényértékekre is fennállna: $3 + 6 = 2 dot 2$. Mivel $9 != 4$, az egyenletrendszer ellentmondásos, a polinom nem létezik.

/ 3. feladat:
Az osztott differencia explicit alakja alapján:
$ f[x_0, ..., x_n] = sum_(k=0)^n f(x_k) / omega'_n(x_k) $
Legyen $h(x) = a f(x) + b g(x)$. Ekkor:
$
  h[x_0, ..., x_n] = sum_(k=0)^n (a f(x_k) + b g(x_k)) / omega'_n(x_k) = a sum_(k=0)^n f(x_k) / omega'_n(x_k) + b sum_(k=0)^n g(x_k) / omega'_n(x_k) = a f[x_0, ..., x_n] + b g[x_0, ..., x_n]
$
A linearitást igazoltuk.

/ 4. feladat:
A Newton-alak alapján:
$ P_2(x) = f[x_0] + f[x_0, x_1](x-x_0) + f[x_0, x_1, x_2](x-x_0)(x-x_1) $
Kétszeresen deriválva $x$ szerint:
$ P_2 '(x) = f[x_0, x_1] + f[x_0, x_1, x_2] dot [(x-x_1) + (x-x_0)] $
$ P_2 ''(x) = f[x_0, x_1, x_2] dot (1 + 1) = 2 f[x_0, x_1, x_2] $
Mivel a másodrendű osztott differencia konstans, az állítás igaz.

#pagebreak()
/ 5. feladat:
1. *Táblázat:* Egy elemhez 2 kivonás és 1 osztás kell (3 művelet). Összesen $n(n+1)/2$ elem van. Műveletigény: $approx 1.5 n^2$.
2. *Newton-Horner kiértékelés:*
$ P_n(x) = c_0 + (x-x_0)(c_1 + (x-x_1)(... + (x-x_(n-1))c_n ...)) $
Minden tagnál ($n$ darab) 1 kivonás, 1 szorzás, 1 összeadás történik. Műveletigény: $3n$.

/ 6. feladat:
A spline $C^2$ folytonos. Ha a széleken lineáris, akkor ott $S''(x) = 0$. A folytonosság miatt $S''(x_1) = 0$ és $S''(x_2) = 0$. A középső $[x_1, x_2]$ szakaszon $S$ harmadfokú, így $S''$ legfeljebb elsőfokú. Mivel egy egyenes két pontban nulla, a teljes szakaszon nulla. Tehát $S$ a középső szakaszon is lineáris.
*Paraméteres alak:* $S(x) = f(x_i) + f[x_i, x_(i+1)](x-x_i)$.

/ 7. feladat:
A Fejér-Hermite alak: $ H_3(x) = f(-1)A_0(x) + f(1)A_1(x) + f'(-1)B_0(x) + f'(1)B_1(x) $
Az alappolinomok integráljai $integral_0^1$ felett:
$
  integral_0^1 A_0(x) dif x = 3/16, "   " integral_0^1 A_1(x) dif x = 13/16, "   " integral_0^1 B_0(x) dif x = 5/48, "   " integral_0^1 B_1(x) dif x = -11/48
$
*Kvadratúra formula:*
$ integral_0^1 f(x) dif x approx 3/16 f(-1) + 13/16 f(1) + 5/48 f'(-1) - 11/48 f'(1) $

/ 8. feladat:
A Hermite-hibaformula alapján:
$ E(f) = integral_0^1 (f^((4))(xi_x)) / 4! (x+1)^2(x-1)^2 dif x $
Az integrálszámítás középértéktétele alapján, mivel a súlyfüggvény nem vált előjelet:
$ E(f) = (f^((4))(eta)) / 24 integral_0^1 (x^2-1)^2 dif x = (f^((4))(eta)) / 24 dot 8/15 = (f^((4))(eta)) / 45 $
$ |E(f)| <= M_4 / 45, " ahol " M_4 = norm(f^((4)))_oo $

#pagebreak()
/ 9. feladat:
A trapézszabály hibája $O(h^2)$. Legyen $I$ a pontos érték:
$ I - T_n = c h^2 + ... $
$ I - T_(2n) = c (h/2)^2 + ... = (c h^2) / 4 $
A második 4-szereséből vonjuk ki az elsőt:
$ 3I - (4T_(2n) - T_n) approx 0 $
$ I approx (4T_(2n) - T_n) / 3 $ Ez a kombináció pontosan a Simpson-szabályt adja.

/ 10. feladat:
Elemi intervallumon ($h = b-a$):
$ m_E = h dot f(a + h/2) $
$ m_T = h/2 (f(a) + f(b)) $
$ m_S = h/6 (f(a) + 4f(a + h/2) + f(b)) $
Behelyettesítve:
$ (2h f(a + h/2) + h/2 (f(a) + f(b))) / 3 = (4h f(a + h/2) + h f(a) + h f(b)) / 6 = m_S $
