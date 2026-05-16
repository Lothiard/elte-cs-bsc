from random import randint, randbytes


def inv_mod(a: int, m: int) -> int | None:
    b = m
    x, y = 1, 0
    while b != 0:
        q = a // b
        x, y = y, x - q * y
        a, b = b, a % b
    if a == 1:
        return x % m
    else:
        return None


def power_mod(a: int, k: int, m: int) -> int:
    if m < 2:
        raise ValueError("m must be greater than 1")
    if a == 0:
        return 0
    if k == 0:
        return 1
    p_bits = [int(b) for b in str(bin(k)[3:])]
    r = a % m
    for p in p_bits:
        u = (r**2) % m
        v = (u * a) % m
        r = v if p else u
    return r


from hashlib import md5
from math import gcd


class ElGamalSign:
    public_key: tuple[
        int, int, int
    ]  # p prime, g mul. generator in Z_p*, g^x mod p where x is a random number between 1 and p-2
    __private_key: int  # x random number

    def __init__(self, p: int, g: int) -> None:
        self.parameters = (p, g)
        x = randint(10, p - 1)
        self.__private_key = x
        self.public_key = (p, g, power_mod(g, x, p))

    @staticmethod
    def message_hash(message: bytes, p: int) -> int:
        return int.from_bytes(md5(message).digest(), byteorder="big") % (p - 1)

    def sign(self, message: bytes) -> tuple[bytes, int, int]:
        p, g, _ = self.public_key
        x = self.__private_key
        h = self.message_hash(message, p)

        while True:
            z = randint(2, p - 2)
            if gcd(z, p - 1) == 1:
                z_inv = inv_mod(z, p - 1)
                if z_inv is not None:
                    s1 = power_mod(g, z, p)
                    s2 = ((h - x * s1) * z_inv) % (p - 1)
                    if s2 > 0:
                        break

        return (message, s1, s2)

    @staticmethod
    def verify(
        signed_message: tuple[bytes, int, int], public_key: tuple[int, int, int]
    ) -> bool:
        message, s1, s2 = signed_message
        p, g, gx = public_key

        if not (0 < s1 < p and 0 < s2 < p - 1):
            return False

        h = ElGamalSign.message_hash(message, p)

        left_side = power_mod(g, h, p)
        right_side = (power_mod(gx, s1, p) * power_mod(s1, s2, p)) % p

        return left_side == right_side


# DO NOT DELETE THIS FUNCTIONS (otherwise TMS tests will fail)
def elgamal_signature_tester(p: int, g: int) -> bool:
    # constructor tests
    S = ElGamalSign(p, g)
    assert S.public_key[0] == p
    assert S.public_key[1] == g
    assert 0 < S.public_key[2] < p

    # testing encrypt and decrypt
    msg = randbytes(randint(10, 1024))
    msg2 = randbytes(randint(10, 1024))
    while ElGamalSign.message_hash(msg, p) == ElGamalSign.message_hash(msg2, p):
        msg2 = randbytes(randint(10, 1024))
    s1 = S.sign(msg)
    s2 = S.sign(msg)
    s3 = S.sign(msg2)
    if s1 == s2:  # in the very unlikely case when the two signatures are the same
        s2 = S.sign(msg)
    assert msg == s1[0] == s2[0] and msg2 == s3[0]
    assert 0 < s1[1] < p and 0 < s2[1] < p and 0 < s3[1] < p
    assert 0 < s1[2] < p - 1 and 0 < s2[2] < p - 1 and 0 < s3[2] < p - 1

    assert s1 != s2  # two signatures of the same msg should be different
    assert ElGamalSign.verify(s1, S.public_key)
    assert ElGamalSign.verify(s2, S.public_key)
    assert ElGamalSign.verify(s3, S.public_key)
    s4 = (s3[0], s1[1], s1[2])
    assert not ElGamalSign.verify(s4, S.public_key)
    assert not ElGamalSign.verify(s4, (p, g, S.public_key[2] + 1))
    return True


if __name__ == "__main__":

    def find_generator(p: int) -> int | None:
        for e in range(1, p):
            x, k = e, 1
            while x > 1:
                x = (x * e) % p
                k += 1
            if k == p - 1:
                return e
        return None

    primes = [269, 523, 1039, 2063, 4111, 8209, 16411]
    for p in primes:
        elgamal_signature_tester(p, find_generator(p))
    print("OK: ElGamalSign")
