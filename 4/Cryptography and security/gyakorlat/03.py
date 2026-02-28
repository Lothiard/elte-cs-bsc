from string import ascii_lowercase, ascii_uppercase
import random


# ELTOLÁSOS TITKOSÍTÁS
def shift_cipher_gen() -> int:
    return random.randint(0, 25)


def shift_cipher_enc(key: int, pt: str) -> str:
    ct = ""
    for c in pt:
        ct += ascii_uppercase[(ascii_lowercase.find(c) + key) % 26]
    return ct


def shift_cipher_dec(key: int, ct: str) -> str:
    pt = ""
    for c in ct:
        pt += ascii_lowercase[(ascii_uppercase.find(c) - key) % 26]
    return pt


k = shift_cipher_gen()
print(shift_cipher_dec(k, shift_cipher_enc(k, "teszt")) == "teszt")
print(shift_cipher_enc(13, shift_cipher_enc(13, "teszt").lower()).lower() == "teszt")


# HELYETTESÍTÉSES TITKOSÍTÁS
def subst_gen() -> dict[str, str]:
    perm = random.sample(ascii_lowercase, k=26)
    return {k: v for k, v in zip(ascii_lowercase, perm)}


print(subst_gen())


def subst_enc(key: dict[str, str], pt: str) -> str:
    return "".join(key[c] for c in pt)


def subst_dec(key: dict[str, str], ct: str) -> str:
    key = {v: k for k, v in key.items()}
    return subst_enc(key, ct)


k = subst_gen()
print(subst_dec(k, subst_enc(k, "teszt")) == "teszt")

# forrás: http://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html
freq = {
    "a": 0.0812,
    "b": 0.0149,
    "c": 0.0271,
    "d": 0.0432,
    "e": 0.1202,
    "f": 0.0230,
    "g": 0.0203,
    "h": 0.0592,
    "i": 0.0731,
    "j": 0.0010,
    "k": 0.0069,
    "l": 0.0398,
    "m": 0.0261,
    "n": 0.0695,
    "o": 0.0768,
    "p": 0.0182,
    "q": 0.0011,
    "r": 0.0602,
    "s": 0.0628,
    "t": 0.0910,
    "u": 0.0288,
    "v": 0.0111,
    "w": 0.0209,
    "x": 0.0017,
    "y": 0.0211,
    "z": 0.0007,
}

subst_ct = (
    "LOJUMGEPJSESNEPCEPYQLJQLOYBJQDYLJMEMDIPD"
    "CGYSNGSGLDDLCNLLLOJVPDYVJNEJSKGUJMJMLPYN"
    "YPLOJLOJTVQXTDVDNJTJDGYNKIUSCPTPJDMYIOLU"
    "SVJNLLSKDLDPPYXQOYGMNJQLOJPPESDMTJZOSVDV"
    "PJDGGJGCPLJWMSENGYQJWMJGGDNGYNSVDNTGDWWJ"
    "JGGJGMOYVDYSNDLVSGLLWMSWSDMLSLXTUOYGDNJE"
    "UYLEOOSCIOGYLYSOJCNYEOOJOMSVDNSKDVCLGOYG"
    "NGSKJNYLYDDQDMMEJM"
)


# VIGENERE-FÉLE TCHRITKOSÍTÁS
def repeat_to_length(s: str, length: int) -> str:
    return (s * length)[:length]


print(repeat_to_length("kripto", 8))


def vigenere_gen(n: int) -> str:
    return "".join(random.choices(ascii_lowercase, k=n))


def vigenere_enc(key: str, pt: str) -> str:
    ct = ""
    for i, c in enumerate(pt):
        ct += ascii_uppercase[
            (ascii_lowercase.find(c) + ascii_lowercase.find(key[i])) % 26
        ]
    return ct


def vigenere_dec(key: str, ct: str) -> str:
    pt = ""
    for i, c in enumerate(ct):
        pt += ascii_lowercase[
            (ascii_uppercase.find(c) - ascii_lowercase.find(key[i])) % 26
        ]
    return pt


pt = "hellotesztszoveghello"
k = repeat_to_length("kripto", len(pt))
print(vigenere_dec(k, vigenere_enc(k, pt)) == pt)

# VIGENERE FELTÖRÉSE KASISKI MÓDSZERÉVEL
vigenere_ct = (
    "CHREEVOAHMAERATBIAXXWTNXBEEOPHBSBQMQEQERBW"
    "RVXUOAKXAOSXXWEAHBWGJMMQMNKGRFVGXWTRZXWIAK"
    "LXFPSKAUTEMNDCMGTSXMXBTUIADNGMGPSRELXNJELX"
    "VRVPRTULHDNQWTWDTYGBPHXTFALJHASVBFXNGLLCHR"
    "ZBWELEKMSJIKNBHWRJGNMGJSGLXFEYPHAGNRBIEQJT"
    "AMRVLCRREMNDGLXRRIMGNSNRWCHRQHAEYEVTAQEBBI"
    "PEEWEVKAKOEWADREMXMTBHHCHRTKDNVRZCHRCLQOHP"
    "WQAIIWXNRMGWOIIFKEE"
)


kasiski = []
import re
from math import gcd

matches = re.finditer("CHR", vigenere_ct, re.MULTILINE)
for match in matches:
    print(match.start())
    kasiski.append(match.start())
print(gcd(*kasiski))


from math import comb
from collections import Counter


# Index of coincidence: megadja annak a valószínűségét, hogy az `s` sztring-ben két
# véletlenszerűen választott karakter megegyezik.
# Minden i = 0,1,...,25-re legyen `fi` az ábécé i-edik karakterének előfordulása az `s` sztringben
# Minden i = 0,1,...,25-re pontosan comb(fi, 2)=fi*(fi-1)/2 féleképpen tudjuk kiválasztani az i-edik
# karaktert az ábécéből az `s` sztringben.
# És pontosan comb(n, 2)=n*(n-1)/2 féleképpen tudunk két tetszőleges karaktert kiválasztani az `s` sztringben
# Annak a valószínűsége, hogy két megegyező karaktert választunk `s`-ben, az egyes karakterek kiválasztási
# valószínűségének összege, osztva az összes lehetséges esettel:
def index_of_coincidence(s: str) -> float:
    return sum(comb(fi, 2) for fi in Counter(s).values()) / comb(len(s), 2)


print(
    index_of_coincidence(
        "thisisaverylongtextbecausehopefullyitwillshowwhatiwantoshowandstatisticsisfunbycryptographyismorefun"
    )
)
print(index_of_coincidence("".join(random.choices(ascii_lowercase, k=1000))))
# Értelmes angol szövegnek az index_of_coincidence értéke 0.068 körül van
# Véletlen angol karaktersorozatnak az index_of_coincidence értéke 0.038 körül van

k = 5
c_k = [vigenere_ct[s::k] for s in range(k)]
print(c_k)

# Legyen k=1. Keressük meg a kulcs hosszát:
# - a titkos szöveget felosztjuk k részre, minden rész minden k-adik karaktert tartalmaz:
#   c_1 = c_1 c_{1+k} c_{1+2k} ...
#   c_2 = c_2 c_{2+k} c_{2+2k} ...
#   ...
#   c_k = c_k c_{2k} c_{3k} ...
# - minden résznek kiszámoljuk az index_of_coincidence értékét
# - ha minden rész index_of_coincidence értéke ~0.068, akkor k megadja a kulcs hosszát
# - ha nem minden rész index_of_coincidence értéke ~0.068, akkor köveljük k értékét egyel és kezdjük elölről
k = 1
while True:
    c_k = [index_of_coincidence(vigenere_ct[s::k]) for s in range(k)]
    if all(0.055 <= c <= 0.075 for c in c_k):
        break
    k += 1

print("A kulcs hossza valószínűleg", k)

# Ha tudjuk a kulcs hosszát (k), akkor minden m karakterre a kulcsban végezzük el a következőt:
# - osszuk fel a ciphertext-et: c_m c_{m+k} c_{m+2k}... karaktereket tartalmazza
# - toljunk el a részsztringet 0 <= g <= 25-tel, és definiáljuk M_g = sum_{i=0}^{25} p_i f_{i+g} / n értéket,
#   ahol p_i az ábécé i-edik karakterének előfordulásának valószínűsége, n a részsztring hossza
#   és f_{i+g} az ábécé i-edik karakterének g-vel eltolt előfodulása a részsztringben
#   (pl: i = 1 és g = 2: f_1 = B és f_{1+2} = f_3 = D előfordulását nézzük a részsztring-ben B helyett)
# - állítás: ha M_g ~ 0.068, akkor az ábécé g-edik karaktere lesz a helyes karakter ebben az iterációban
key = ""
for m in range(k):
    c_m = vigenere_ct[m::k]
    max_idc = ("", 0)
    obs = Counter(c_m)
    for g in range(26):
        idc = 0
        for i in range(26):
            t = obs.get(ascii_uppercase[(i + g) % 26], 0.0) / len(c_m)
            idc += freq[ascii_lowercase[i]] * t
        if 0.055 <= idc <= 0.075 and max_idc[1] <= idc:
            max_idc = (ascii_lowercase[g], idc)
    key += max_idc[0]
print("Potenciális kulcs: ", key)
print(vigenere_dec(repeat_to_length(key, len(vigenere_ct)), vigenere_ct))
