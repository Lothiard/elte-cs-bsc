/ 1): Feladat. Egy dobozban $9$ cédula van, rajtuk a $11, 12, 12, 22, 23, 23, 31, 31, 33$ számok. Találomra kihúzunk egy cédulát, $X$ jelölje az első, $Y$ pedig a második számjegyet. Mutassuk meg, hogy $X$ és $Y$ nem függetlenek, de $G_(X+Y) = G_X G_Y$ , ahol $G_Z$ a $Z$ nemnegatív egész értékű valószínűségi változó generátorfüggvényét jelöli.

*Függetlenség vizsgálata:* Az összes eset $9$. $ P(X=1) = 3/9 "  " P(Y=2) = 3/9 $ Viszont $ P(X=1, Y=2) = P("12") = 2/9 $ Mivel $ 2/9 != 1/9 $ (ami $3/9 dot 3/9$ lenne), a változók *nem függetlenek*.
*Generátorfüggvények:*
$ G_X (z) = G_Y (z) = 1/3 z + 1/3 z^2 + 1/3 z^3 $
$ G_X (z) G_Y (z) = 1/9 (z + z^2 + z^3)^2 = 1/9 (z^2 + 2z^3 + 3z^4 + 2z^5 + z^6) $
A cédulák összegeit ($X+Y$) megvizsgálva a gyakoriságok alapján: $ G_(X+Y)(z) = 1/9 z^2 + 2/9 z^3 + 3/9 z^4 + 2/9 z^5 + 1/9 z^6 $ A két kifejezés megegyezik.

/ 2): Feladat. Egy kockával addig dobunk, amíg először sikerül kétszer egymás után hatost dobni. Jelölje $X$ a szükséges dobásszámot. Szá-mítsuk ki $X$ generátorfüggvényét, és ebből $X$ várható értékét és szórását.

$ G(z) = 5/6 z G(z) + 5/36 z^2 G(z) + 1/36 z^2 $
$ G(z) = z^2 / (36 - 30z - 5z^2) $
$ E X = G'(1) = 42 $

#pagebreak()
/ 3): Feladat. Egy kockával addig dobunk, amíg először sikerül $7$ hatost dobni (nem kell közvetlenül egymás után dobni a hatosokat). Jelölje $ξ$ a szükséges dobásszámot. Számítsuk ki $ξ$ generátorfüggvényét.

Ez egy negatív binomiális folyamat. Egyetlen hatosig a várakozási idő GF-je: $ G_i (z) = (1/6 z) / (1 - 5/6 z) = z / (6 - 5z) $
Mivel $7$ független várakozási idő összege: $ G_xi (z) = (G_i (z))^7 = ( z / (6 - 5z) )^7 $

/ 4): Feladat. Kockaországban minden kisfiú naponta $0.3$-paramérű Poisson eloszlású alkalommal eszik virslit. Az egyes alkalmakkor meg-evett virslik darabszámai egymástól függetlenek és generátorfüggvényeik $ln(1-0.2z) / ln(0, 8)$. Mi egy kisfiú által egy nap alatt megevett virslik számának generátorfüggvénye?

Ez egy összetett Poisson-eloszlás. $ G_N (z) = e^(0.3(z-1)) $
Az összetett eloszlás GF-je: $ G_S (z) = G_N (G_X (z)) $
$ G_S (z) = exp(0.3 dot ( (ln(1 - 0.2z)) / (ln(0, 8)) - 1 )) $

/ 5): Feladat. Családnév fennmaradása. Csak a fiúutódokat tekintjük. $p_k$ annak a valószínűsége, hogy egy újszülött fiúnak $k$ fiúgyermeke lesz. Feltételezzük azt is, hogy különbözü fiúk gyerekszámai függetlenek. Pl. az USA múlt századi adataira jó illesztés volt $p_0 = 0,4825, p_k = (0,2126)(0,5893)^(k-1)$ Határozzuk meg annak valószí-nűségét, hogy egy családnév kihal! Mi lesz az $n$-edik generációban élő fiúutódok számának várható értéke és szórása?

*GF:* $ f(z) = 0.4825 + (0.2126 z) / (1 - 0.5893 z) $
*Kihalás ($q$):* Az $f(q) = q$ egyenlet legkisebb nemnegatív gyöke: $q approx 0.8187$\
*Várható érték:* $ m = f'(1) approx 1.2604 "   " E Z_n = m^n = 1.2604^n $

/ 6): Feladat. Az utódszám generátorfüggvénye $1-p(1-z)^α, α, p in (0, 1)$ Határozza meg az $n$-edik generáció létszámának generátorfügg-vényét és a kihalás valószínűségét!

*n. generáció:* $ f_n (z) = 1 - p^((1-alpha^n)/(1-alpha)) dot (1-z)^(alpha^n) $
*Kihalás:* A fixpontból $ q = 1 - p^(1/(1-alpha)) $
