import os
import random


class LFSR:
    """
    Egy linear-feedback shift register (LFSR) GF(2) felett.
    Az XOR függvényt használja a következő állapot kiszámolására.
    """

    def __init__(self, seed: list[int], coeffs: list[int]) -> None:
        self.seed = seed[:]
        self.coeffs = coeffs[:]
        self.state = seed[:]

    def reset(self) -> None:
        """Visszaállítja az LFSR állapotát a kezddőállapotra."""
        self.state = self.seed[:]

    def clock(self) -> int:
        """Egy lépést végez, és visszaadja a kimeneti bit-et."""
        out = self.state[-1]
        feedback = 0
        for s, c in zip(self.state, self.coeffs):
            if c:
                feedback ^= s
        self.state = [feedback] + self.state[:-1]
        return out


class BethPiperGenerator:
    """
    A Beth-Piper stop-and-go generátor kimenete egy bit, amit a kövekezőképp állít elő
    három belső LFSR alapján:
    - Az LFSR1 és LFSR3 minden iterációban generál egy új bitet
    - Az LFSR2 csak akkor generál egy új bitet, ha az LFSR1 által generált bit az _előző_
      lépésben 1 volt. Ha nem, akkor az LFSR2 a legutoljára generált bitet adja vissza.
      Az LFSR2 legelső kimenete a kezdeti állapotának (a seed2-nek) a jobb szélső bitje.
    - A Beth-Piper stop-and-go generátor kimenete minden lépésben az LFSR2 és LFSR3
      generátorok által visszadott bitek XOR-ozva.

    A következő `coeff` listákat használjuk az egyes LFSR-ekhez:
    - LFSR1: [0, 0, 1, 0, 1]
    - LFSR2: [0, 0, 0, 0, 0, 1, 1]
    - LFSR3: [0, 0, 0, 0, 1, 0, 0, 0, 1]
    """

    LFSR1_COEFFS = [0, 0, 1, 0, 1]
    LFSR2_COEFFS = [0, 0, 0, 0, 0, 1, 1]
    LFSR3_COEFFS = [0, 0, 0, 0, 1, 0, 0, 0, 1]

    def __init__(self, seed1: list[int], seed2: list[int], seed3: list[int]):
        self.lfsr1 = LFSR(seed1, self.LFSR1_COEFFS)
        self.lfsr2 = LFSR(seed2, self.LFSR2_COEFFS)
        self.lfsr3 = LFSR(seed3, self.LFSR3_COEFFS)
        self._lfsr1_prev = self.lfsr1.state[-1]
        self._lfsr2_last = self.lfsr2.state[-1]
        self._first = True

    def clock(self) -> int:
        b1 = self.lfsr1.clock()
        b3 = self.lfsr3.clock()
        if self._first:
            b2 = self.lfsr2.state[-1]
            self._first = False
            self._lfsr2_last = self.lfsr2.clock()
        else:
            if self._lfsr1_prev == 1:
                b2 = self.lfsr2.clock()
            else:
                b2 = self._lfsr2_last
            self._lfsr2_last = b2
        self._lfsr1_prev = b1
        return b2 ^ b3

    def reset(self) -> None:
        self.lfsr1.reset()
        self.lfsr2.reset()
        self.lfsr3.reset()
        self._lfsr1_prev = self.lfsr1.state[-1]
        self._lfsr2_last = self.lfsr2.state[-1]
        self._first = True


def xor_strings(a: bytes, b: bytes) -> bytes:
    """Két bytestring-et XOR-oz össze."""
    return b"".join((i ^ j).to_bytes(1) for i, j in zip(a, b))


def bits_to_bytes(gen: "BethPiperGenerator", n: int) -> bytes:
    """A BethPiperGenerator alapján generál egy `n` hosszú bytestring-et."""
    bits = []
    for _ in range(n * 8):
        bits.append(gen.clock())
    out = bytearray()
    for i in range(n):
        byte = 0
        for j in range(8):
            byte |= bits[i * 8 + j] << (7 - j)
        out.append(byte)
    return bytes(out)


def generate_seed(k: int) -> list[int]:
    """Egy `k` hosszú random seed-et generál az LFSR-nek, aminek legalább egy bitje nem nulla."""
    while True:
        seed = random.choices([0, 1], k=k)
        if any(seed):
            return seed


def BP_encrypt(plaintext: bytes, gen: "BethPiperGenerator") -> bytes:
    """Titkosítja a `plaintext`-et a `gen` által generált kulcs alapján."""
    key = bits_to_bytes(gen, len(plaintext))
    return xor_strings(plaintext, key)


def BP_decrypt(ciphertext: bytes, gen: "BethPiperGenerator") -> bytes:
    """Visszafejti a `ciphertext`-et a `gen` által generált kulcs alapján."""
    key = bits_to_bytes(gen, len(ciphertext))
    return xor_strings(ciphertext, key)


if __name__ == "__main__":
    # Ismert kimenet tesztelése
    gen = LFSR([0, 0, 1, 1], [0, 1, 0, 1])
    assert [gen.clock() for _ in range(20)] == [
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
    ]

    # LFSR reset() függvénye visszaállítja a kezdeti állapotot
    seed = [1, 0, 1, 0, 1]
    gen = LFSR(seed, [0, 0, 1, 0, 1])
    initial = gen.state[:]
    for _ in range(20):
        gen.clock()
    assert gen.state != initial
    gen.reset()
    assert gen.state == initial

    # A kezdeti állapot visszaállítása után ugyanazt a bitsorozatot kapjuk
    gen = LFSR([1, 0, 1, 0, 1], [0, 0, 1, 0, 1])
    seq1 = [gen.clock() for _ in range(20)]
    gen.reset()
    seq2 = [gen.clock() for _ in range(20)]
    assert seq1 == seq2

    # A kezdeti állapot visszaállítása után ugyanazt a bitsorozatot kapjuk
    SEED1 = [1, 1, 0, 0, 1]
    SEED2 = [0, 1, 1, 1, 0, 1, 0]
    SEED3 = [0, 1, 1, 0, 1, 1, 1, 0, 1]
    gen = BethPiperGenerator(SEED1, SEED2, SEED3)
    seq1 = [gen.clock() for _ in range(50)]
    gen.reset()
    seq2 = [gen.clock() for _ in range(50)]
    assert seq1 == seq2

    # A reset-elt generátor ugyanazt kell adja, mint egy frissen készült generátor
    gen1 = BethPiperGenerator(SEED1, SEED2, SEED3)
    for _ in range(100):
        gen1.clock()
    gen1.reset()
    gen2 = BethPiperGenerator(SEED1, SEED2, SEED3)
    seq1 = [gen1.clock() for _ in range(50)]
    seq2 = [gen2.clock() for _ in range(50)]
    assert seq1 == seq2

    # Különböző hosszú üzenetekre és random seed-re a helyesség
    for _ in range(15):
        gen = BethPiperGenerator(
            seed1=random.choices([0, 1], k=5),
            seed2=random.choices([0, 1], k=7),
            seed3=random.choices([0, 1], k=9),
        )
        pt = os.urandom(random.randint(40, 150))
        ct = BP_encrypt(pt, gen)
        gen.reset()
        assert BP_decrypt(ct, gen) == pt, f"{_ = }"
    print("OK!")
