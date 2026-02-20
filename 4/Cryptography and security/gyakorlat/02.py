# DEFINÍCIÓK

# KONGRUENCIA:
# Legyen m > 0. Az a és b egész számok kongruensek modulo m-re nézve,
# ha m|(a-b), azaz m osztja a és b különbségét. Jelölés: a ≡ b (mod m)
# Állítás: a kongruencia ekvivalenciareláció

# A kongruencia maradékosztályokat határoz meg, amit a reprezentánsával jelölünk és a konvenciónk
# szerint 0,...,m-1 értékekkel jelöljük szögletes zárójelben: [0], [1], ..., [m-1].
# Más források a szögletes zárójelet elhagyhatják.

# MARADÉKOSZTÁLY:
# azon egész számok halmaza, amik ugyanazt a maradékot adják modulo m-re nézve,
# például m=3 esetén a következő maradékosztályaink vannak:
# [0] = {..., -6, -3, 0, 3, 6, ...} = {3k mod 3 | k egész szám} (azaz a modulus többszörösei)
# [1] = {..., -5, -2, 1, 4, 7, ...} = {3k+1 mod 3 | k egész szám}
# [2] = {..., -4, -1, 2, 5, 8, ...} = {3k+2 mod 3 | k egész szám}

# MARADÉKRENDSZER:
# A maradékosztályok halmazát maradékrendszernek hívjuk.
# Sage-ben ezt az objektumot a Zmod(m) konstruktorral lehet létrehozni.
# Redukált maradékrendszer: azon maradékosztályok halmaza, amik reprezentánsa relatív prím a
# modulusra nézve.

# MULTIPLIKATÍV INVERZ:
# Egy a egész szám multiplikatív inverze modulo m-re nézve az az x egész szám,
# amire a következő kongruencia teljesül: ax ≡ xa ≡ 1 (mod m)
# Multiplikatív inverz akkor és csak akkor létezik, ha gcd(a,m) = 1
# Sage-ben az inverz értékét az inverse_mod függvény segítségével keressük meg: inverse_mod(a, m)
# Papíron a kiterjesztett Euklideszi algoritmussal keressük meg az inverzet.
# Példa: keressük meg 7 (multiplikatív) inverzét modulo 16-ra:
# 16 = 2*7 + 2
# 7 = 3*2 + 1
# 2 = 2*1 + 0
#
# 2 = 16 - 2*7
# 1 = 7 - 3*2 = 7 - 3*(16 - 2*7) = -3*16 + 7*7
# és az inverz mindig annak az együtthatója lesz, aminek az inverzét keressük. A fenti példában ez
# 7 lesz, és az inverse_mod(7, 16) is ezt adja vissza.

# Másik példa: keressük meg 3 (multiplikatív) inverzét modulo 13-ra:
# 13 = 4*3 + 1
# 3 = 3*1 + 0
#
# 1 = 13 - 4*3
# és az inverz mindig annak az együtthatója lesz, aminek az inverzét keressük. A fenti példában
# ez -4 lesz, de talán szebb, ha követjük a konvenciónkat és vesszük -4 mod 13 értékét, ami 9.
# A sage a 9-et fogja megadni, de -4 és 9 ugyanabban a maradékosztályban vannak modulo 13-ra nézve.

# REND: Egy a egész szám (multiplikatív) rendje modulo m-re nézve az az r nemnegatív szám,
# amire a^r (mod m) = 1 teljesül.
# Például: 7 (mod 10) rendje r = 4, mert
# 7^1 (mod 10) = 7
# 7^2 (mod 10) = 9
# 7^3 (mod 10) = 3
# 7^4 (mod 10) = 1

# DISZKRÉT LOGARITMUS:
# Legyen a modulus p prím, és a egy szám a p redukált maradékrendszeréből. Az a^k mod p értékéből k
# meghatározását diszkrét logaritmusnak hívjuk.


# CSOPORT
# Egy (G, °) rendezett párt, ahol G egy halmaz és ˚ egy binér művelet, csoportnak nevezzük, ha
# teljesül a következő három tulajdonság:
# 1. Minden elemre G-ben, a˚(b˚c) = (a˚b)˚c, azaz a művelet asszociatív
# 2. Létezik egységelem G-ben, amit e-vel jelölünk, és a°e = e°a = a (és ez egyértelmű)
# 3. Minden elemnek G-ben létezik inverze: a°a^-1 = a^-1 ° a = e
# Ha a binér művelet kommutatív, akkor a (G, °) csoportot Abel csoportnak nevezzük. A kommutativitás
# nem feltétele a csoportnak.

# Példák: az egész számok, komplex számok, racionális számok mind csoportot alkotnak a rajtuk megszokott
# műveletekre nézve.
# Nem lesz csoport a következő: legyen G = {0, 1} és definiáljuk a szorzást a következőképp:
# 0*0 = 0
# 0*1 = 0
# 1*0 = 0
# 1*1 = 1
# Ez nem lesz csoport, mert nem egyértelmű, melyik az egységelem.


# írjunk egy oszt(a,m) függvényt, ami megadja,
# hogy a paraméterül kapott a egész szám melyik
# maradékosztályba tartozik modulo m-re nézve.
def oszt(a: int, m: int) -> int:
    # sage-ben: mod(a, m)
    return a % m

print(oszt(13, 10))
print(oszt(-9, 10))
assert oszt(1,5) == 1
assert oszt(14,5) == 4
assert oszt(-1,5) == 4
assert oszt(-6,5) == 4
assert oszt(-10,5) == 0


# írjunk egy függvényt, amely egy egész számokat tartalmazó
# l lista elemeit osztáyozza modulo m-re nézve. A függvény egy
# dictionary-t ad vissza, ahol a kulcsot a maradékosztályok
# reprezentánsai [0..m-1], az értékek a bele tartozó elemek
# listája a bemeneti l listából
def oszt_dict(l: list[int], m: int) -> dict[int, list[int]]:
    return {i: [item for item in l if oszt(item, m) == i] for i in range(m)}


print(oszt_dict([1, 6, 8, 15], 5))
assert oszt_dict([0, 1, 2, 3, 4, 5, 6, 7, 8], 2) == {0: [0, 2, 4, 6, 8], 1: [1, 3, 5, 7]}
assert oszt_dict([0, 1, 2, 3, 4, 5, 6, 7, 8], 3) == {0: [0, 3, 6], 1: [1, 4, 7], 2: [2, 5, 8]}
assert oszt_dict([0, 1, 2, 3, 4, 5, 6, 7, 8], 4) == {0: [0, 4, 8], 1: [1, 5], 2: [2, 6], 3: [3, 7]}
assert oszt_dict([0, 1, 2, 3, 4, 5, 6, 7, 8], 5) == {0: [0, 5], 1: [1, 6], 2: [2, 7], 3: [3, 8], 4: [4]}
assert oszt_dict([1, 7, 9, 10], 2) == {1: [1, 7, 9], 0: [10]}
assert oszt_dict([1, 7, 9, 10], 3) == {1: [1, 7, 10], 0: [9], 2: []}
assert oszt_dict([1, 7, 9, 10], 4) == {1: [1, 9], 3: [7], 2: [10], 0: []}
assert oszt_dict([1, 7, 9, 10], 5) == {1: [1], 2: [7], 4: [9], 0: [10], 3: []}
assert oszt_dict([-4, 6, -10, 12, -123], 2) == {0: [-4, 6, -10, 12], 1: [-123]}
assert oszt_dict([-4, 6, -10, 12, -123], 3) == {2: [-4, -10], 0: [6, 12, -123], 1: []}
assert oszt_dict([-4, 6, -10, 12, -123], 4) == {0: [-4, 12], 2: [6, -10], 1: [-123], 3: []}
assert oszt_dict([-4, 6, -10, 12, -123], 5) == {1: [-4, 6], 0: [-10], 2: [12, -123], 3: [], 4: []}
