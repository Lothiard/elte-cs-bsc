from string import ascii_lowercase, ascii_uppercase
import random
import re
from math import gcd, comb
from collections import Counter

# SHIFT CIPHER (ELTOLÁSOS TITKOSÍTÁS)


def shift_cipher_gen() -> int:
    return random.randint(1, 26)


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


# VIGENERE-FÉLE TITKOSÍTÁS
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

    # key = repeat_to_length(key, len(pt))
    # ct = []
    # for p, k in zip(pt, key):
    #     offset = ord("A") if p.isupper() else ord("a")
    #     c = chr((ord(p) - offset + ord(k.lower()) - ord("a")) % 26 + offset)
    #     ct.append(c)
    # return "".join(ct)


def vigenere_dec(key: str, ct: str) -> str:
    pt = ""
    for i, c in enumerate(ct):
        pt += ascii_lowercase[
            (ascii_uppercase.find(c) - ascii_lowercase.find(key[i])) % 26
        ]
    return pt

    # key = repeat_to_length(key, len(ct))
    # pt = []
    # for c, k in zip(ct, key):
    #     offset = ord("A") if c.isupper() else ord("a")
    #     p = chr((ord(c) - offset - (ord(k.lower()) - ord("a"))) % 26 + offset)
    #     pt.append(p)
    # return "".join(pt)


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
matches = re.finditer("CHR", vigenere_ct, re.MULTILINE)
for match in matches:
    print(match.start())
    kasiski.append(match.start())
print(gcd(*kasiski))


def index_of_coincidence(s: str) -> float:
    return sum(comb(fi, 2) for fi in Counter(s).values()) / comb(len(s), 2)


print(
    index_of_coincidence(
        "thisisaverylongtextbecausehopefullyitwillshowwhatiwantittoshow"
    )
)
print(index_of_coincidence("".join(random.choices(ascii_lowercase, k=1000))))

k = 1
while True:
    c_k = [index_of_coincidence(vigenere_ct[s::k]) for s in range(k)]
    if all(0.055 <= c <= 0.075 for c in c_k):
        break
    k += 1

print("A kulcs hossza valoszinuleg", k)


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
print("Potencialis kulcs: ", key)
