from random import randint


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


class ElGamal:
    public_key: tuple[
        int, int, int
    ]  # (p, g, g^x), where p is a given a prime (at construction time) g is a multiplicative generator mod p
    private_key: int  # x - a random number

    def __init__(self, p: int) -> None:
        self.p = p

        # p-1 prímtényezőinek meghatározása a generátor teszteléséhez
        def get_prime_factors(n):
            factors = set()
            d = 2
            while d * d <= n:
                while (n % d) == 0:
                    factors.add(d)
                    n //= d
                d += 1
            if n > 1:
                factors.add(n)
            return factors

        factors = get_prime_factors(p - 1)

        # Generátor (g) keresése
        g = 2
        while True:
            is_generator = True
            for q in factors:
                if power_mod(g, (p - 1) // q, p) == 1:
                    is_generator = False
                    break
            if is_generator:
                break
            g += 1

        # Titkos kulcs x választása [1, p-2] intervallumból
        x = randint(1, p - 2)

        self.public_key = (p, g, power_mod(g, x, p))
        self.private_key = x

    @staticmethod
    def encrypt(message: int, public_key: tuple[int, int, int]) -> tuple[int, int]:
        p, g, h = public_key
        # y véletlen érték választása (efemer kulcs)
        y = randint(1, p - 2)

        c1 = power_mod(g, y, p)
        s = power_mod(h, y, p)
        c2 = (message * s) % p

        return (c1, c2)

    def decrypt(self, encrypted_message: tuple[int, int]) -> int:
        c1, c2 = encrypted_message

        # s = c1^x mod p kiszámítása
        s = power_mod(c1, self.private_key, self.p)

        # s inverzének meghatározása mod p
        s_inv = inv_mod(s, self.p)

        # Üzenet visszafejtése
        message = (c2 * s_inv) % self.p
        return message


# DO NOT DELETE THIS FUNCTIONS (otherwise TMS tests will fail)
def elgamal_tester(p: int):
    def mul_order(a, m):
        x, o = a, 1
        while x != 1 and o < m:
            x = (x * a) % m
            o += 1
        if o == m:
            return None
        return o

    # constructor tests
    C = ElGamal(p)
    assert C.public_key[0] == p
    assert mul_order(C.public_key[1], p) == p - 1
    assert power_mod(C.public_key[1], C.private_key, p) == C.public_key[2]

    # testing encrypt and decrypt
    msg = randint(2, p - 1)
    ct1 = ElGamal.encrypt(msg, C.public_key)
    ct2 = ElGamal.encrypt(msg, C.public_key)
    if (
        ct1 == ct2
    ):  # by random the y can be the same but there is next to no chance to happen consequently
        ct2 = ElGamal.encrypt(msg, C.public_key)
    assert ct1 != ct2, f"Two encrypted messages should be different"
    assert msg == C.decrypt(ct1)
    assert msg == C.decrypt(ct2)
    return True


if __name__ == "__main__":
    primes = [29, 43, 79, 139, 269, 523, 1039, 2063, 4111, 8209, 16411]
    for p in primes:
        elgamal_tester(p)
    print("OK: ElGamal")
