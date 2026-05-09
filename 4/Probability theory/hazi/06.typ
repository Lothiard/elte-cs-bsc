/ 6): Egy életbiztosító társaságnak $10000$ biztosítottja van, tegyük fel, hogy ők egyforma korúak és egészségűek. $1%$ annak a valószínűsége, hogy egy ilyen személy az év folyamán meghal. Minden biztosított az év elején $11$ ezer Ft-ot fizet be, halála esetén pedig hozzátartozói $1$ millió Ft-ot kapnak a biztosítótól. Mi a valószínűsége, hogy a biztosító egy évben ezen biztosításra vonatkozóan nem lesz veszteséges?

Legyen $X$ a halálozások száma, $X tilde B(10000, 0.01)$.\
Bevétel: $10000 dot 11000 = 110$ millió Ft.\
Kifizetés: $X dot 1$ millió Ft.\
Nem veszteséges, ha $110 >= X$.\
=== Közelítés:
$E X = 10000 dot 0.01 = 100$, $D^2 X = 10000 dot 0.01 dot 0.99 = 99$.
$ P(X <= 110) = P((X - 100) / sqrt(99) <= (110 - 100) / sqrt(99)) approx Phi(10 / 9.95) approx Phi(1.005) $
A táblázatból *$Phi(1.00) approx 0.8413$*, tehát a valószínűség kb. *84%*.
