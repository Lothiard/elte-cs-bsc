###############################
###   1. Feladat (8 pont)   ###
###############################

from collections import Counter
from math import gcd
from string import ascii_uppercase

AFFINE_CT = (
    "GAFDSGXMRSPEGXTSDEAPYDGFZKDRVGAXNZDQYZXMPFDSZANJDQZADUFDCB"
    "DPZBDQGFYGXZFQYJFZZDTFZGADGRDQQXGKFSFDYKPDQPKXYPFIRFEGGAFH"
    "QGFQYFYSFRHEHFQGJXYFSQRSPEGXTSDEAPRXJKHQFZRXJENGFSZRHFQRFJ"
    "DGAFJDGHRZDQYHQMXSJDGHXQZFRNSHGPGXYFUFCXESXKNZGZPZGFJZGADG"
    "ESXGFRGESHUDGFRXJJNQHRDGHXQZDQYFQZNSFGAFZFRNSHGPDQYHQGFTSH"
    "GPXMYDGDHQAHTACPZFQZHGHUFDEECHRDGHXQZZNRADZXQCHQFKDQVHQT"
)


def modinv(a, m) -> int:
    result = 0
    for x in range(1, m):
        if (a * x) % m == 1:
            result = x
    return result


def break_affine_cipher(ct: str) -> tuple[int, int]:
    """Meghatározza az affin titkosító (a, b) kulcsát frekvenciaanalízissel."""
    ct = ct.upper()
    freq = Counter([c for c in ct if c.isalpha()])
    most_common = [item[0] for item in freq.most_common(2)]
    poss_p = [4, 19]  # e, t
    c_ind = [ord(c) - ord("A") for c in most_common]

    result = (0, 0)
    for i in range(2):
        for j in range(2):
            if i == j:
                continue

            diff_p = (poss_p[i] - poss_p[j]) % 26
            diff_c = (c_ind[i] - c_ind[j]) % 26
            inv = modinv(diff_p, 26)
            if inv is None:
                continue

            a = (diff_c * inv) % 26
            if gcd(a, 26) != 1:
                continue

            b = (c_ind[j] - a * poss_p[j]) % 26
            result = (a, b)
    return result


def decrypt_affine(ct: str, a: int, b: int) -> str:
    """
    Visszafejti az affin titkosított szöveget:
    D(c) = a^{-1} * (c - b) mod 26
    """

    a_inv = modinv(a, 26)
    pt = []
    for ch in ct:
        if ch.isalpha():
            c = ord(ch.upper()) - ord("A")
            p = (a_inv * (c - b)) % 26
            pt.append(chr(p + ord("A")))
        else:
            pt.append(ch)
    return "".join(pt)


assert break_affine_cipher(AFFINE_CT) == (7, 3)
assert decrypt_affine(AFFINE_CT, 7, 3).startswith("THE")
print(f"1. feladat: OK")


################################
###   2. feladat (15 pont)   ###
################################
class Feistel:
    BLOCK_SIZE = 8

    def __init__(self, key: bytes, iv: bytes) -> None:
        self.key = key
        self.iv = iv

    def _round_fn(self, half: bytes, subkey: int) -> bytes:
        """A `half` minden bájtjához hozzáadja a `subkey` értékét (mod 256)."""
        return bytes((b + subkey) % 256 for b in half)

    def encrypt(self, block: bytes) -> bytes:
        """Titkosítja a `block`-ot négy iteráció alatt."""
        L = block[:4]
        R = block[4:]
        for i in range(4):
            new_L = R
            new_R = bytes(l ^ f for l, f in zip(L, self._round_fn(R, self.key[i])))
            L, R = new_L, new_R
        return L + R

    def decrypt(self, block: bytes) -> bytes:
        """Visszafejti a `block`-ot."""
        L = block[:4]
        R = block[4:]
        for i in reversed(range(4)):
            new_R = L
            new_L = bytes(r ^ f for r, f in zip(R, self._round_fn(L, self.key[i])))
            L, R = new_L, new_R
        return L + R

    def ofb(self, data: bytes) -> bytes:
        """Output Feedback módban alkalmazza az `encrypt(block)` metódust."""
        result = bytearray()
        feedback = self.iv
        for i in range(0, len(data), self.BLOCK_SIZE):
            keystream = self.encrypt(feedback)
            block = data[i : i + self.BLOCK_SIZE]
            out = bytes(b ^ k for b, k in zip(block, keystream[: len(block)]))
            result.extend(out)
            feedback = keystream
        return bytes(result)


secret_key = b"\x05\x11\x2a\x7f"
public_iv = b"\x00" * Feistel.BLOCK_SIZE
feistel = Feistel(secret_key, public_iv)
assert feistel.decrypt(feistel.encrypt(b"ABCDEFGH")) == b"ABCDEFGH"
pt = b"Titkos uzenet OFB modban!"
assert feistel.ofb(pt) != pt
assert feistel.ofb(feistel.ofb(pt)) == pt
print(f"2. feladat: OK")

################################
###   3. feladat (7 pont)    ###
################################
import math


def baby_step_giant_step(g: int, h: int, p: int) -> int:
    """Megkeresi x-et, amelyre g^x ≡ h (mod p) (p prím)."""
    # 1
    m = math.ceil(p**0.5)

    # 2
    baby_steps = {}
    val = 1
    for j in range(m):
        baby_steps[val] = j
        val = (val * g) % p

    # 3
    g_inv_m = pow(pow(g, -1, p), m, p)

    # 4
    result = 0
    for i in range(m):
        if h in baby_steps:
            result = i * m + baby_steps[h]
            break
        h = (h * g_inv_m) % p
    return result


assert baby_step_giant_step(2, pow(2, 17, 29), 29) == 17
assert baby_step_giant_step(5, pow(5, 11, 23), 23) == 11
print(f"3. feladat: OK")

###############################
###   4. feladat (10 pont)  ###
###############################

import hashlib
import os


def hashcash(challenge: bytes, difficulty: int) -> bytes:
    while True:
        # 1
        nonce = os.urandom(8)

        # 2
        h = hashlib.sha256(challenge + nonce).digest()

        # 3
        bits = int.from_bytes(h, "big")
        if bits >> (256 - difficulty) == 0:
            return nonce


challenge = b"kriptografia-zh-2026"
nonce = hashcash(challenge, 16)
h = hashlib.sha256(challenge + nonce).digest()
assert h[0] == 0 and h[1] == 0
print(f"4. feladat: OK")
