print("PKCS#5 és PKCS#7 padding")
def padding(block_size: int, msg: bytes) -> bytes:
    pad_length = (block_size - len(msg)) % block_size
    if pad_length == 0:
        pad_length = block_size
    return msg + bytes.fromhex(f"{pad_length:02x}") * pad_length

def check_padding(msg: bytes) -> bool:
    return all(i == msg[-1] for i in msg[-msg[-1]:])

padded1 = padding(8, b"cryptography")
padded2 = padding(12, b"cryptography")
print(padded1, check_padding(padded1))
print(padded2, check_padding(padded2))

print("-" * 30)

print("Data Encryption Standard (DES)")
from operator import xor
from permutations import *

class BadPaddingError(Exception):
    pass

def xor_blocks(a: list[int], b: list[int]) -> list[int]:
    """Elemenként XOR-ozza az `a` és `b` listákat."""
    return [xor(i, j) for i, j in zip(a, b)]

def xor_strings(a: bytes, b: bytes) -> bytes:
    """Két bytestring-et XOR-oz össze."""
    return b"".join((i ^ j).to_bytes(1) for i, j in zip(a, b))


class DES:
    def __init__(self, key: bytes, block_size: int) -> None:
        if len(key) != 8:
            raise ValueError(f'The key must be 8 bytes long')
        self.key = key
        self.block_size = block_size
        self.round_keys = self._key_schedule()

    def encrypt(self, plaintext: bytes) -> bytes:
        pass

    def decrypt(self, ciphertext: bytes) -> bytes:
        pass

    def _encryption(self, block: bytes, encrypt: bool) -> bytes:
        block = f"{int.from_bytes(block):064b}"
        block = list(map(int, [block[i] for i in IP]))
        left, right = block[:32], block[32:]
        if encrypt:
            round_keys = self.round_keys
        else:
            round_keys = self.round_keys[::-1]
        for n in range(16):
            round_key = round_keys[n]
            left, right = right, xor_blocks(left, self._cipher(right, round_key))
        block = right + left
        block = [str(block[i]) for i in IP_inv]
        block = int(''.join(block), base=2).to_bytes(8)
        return block

    def _cipher(self, r: list[int], k: list[int]) -> list[int]:
        subst = [S1, S2, S3, S4, S5, S6, S7, S8]
        r = [r[i] for i in E]
        rk = xor_blocks(r, k)
        res, j = [], 0
        for i in range(0, 48 - 6 + 1, 6):
            block = rk[i:i+6]
            row, col = int(f'0b{block[0]}{block[-1]}', base=2), int(f'0b{"".join(str(b) for b in block[1:-1])}', base=2)
            res += [int(b) for b in bin(subst[j][row][col])[2:].zfill(4)]
            j += 1
        res = [res[i] for i in P]
        return res

    def _key_schedule(self) -> list[list[int]]:
        iterations = [1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1]
        res = []
        key = f"{int.from_bytes(self.key):064b}"
        key = list(map(int, key))
        round_key = [key[i] for i in PC1]
        c, d = round_key[:28], round_key[28:]
        for n in range(16):
            left_shifts = iterations[n]
            c = c[left_shifts:] + c[:left_shifts]
            d = d[left_shifts:] + d[:left_shifts]
            round_key = c + d
            res.append([round_key[i] for i in PC2])
        return res

# Működési módok: https://csrc.nist.gov/projects/block-cipher-techniques/BCM

class DES_ECB(DES):
    def __init__(self, key: bytes, block_size: int = 8) -> None:
        super().__init__(key, block_size)

    def encrypt(self, plaintext: bytes) -> bytes:
        pass

    def decrypt(self, ciphertext: bytes) -> bytes:
        pass


class DES_CBC(DES):
    def __init__(self, key: bytes, block_size: int = 8, iv: bytes | None = None) -> None:
        super().__init__(key, block_size)

    def encrypt(self, plaintext: bytes) -> bytes:
        ...

    def decrypt(self, ciphertext: bytes) -> bytes:
        ...

print("-" * 30)
print("Padding Oracle Attack")
ct = b' n+w-\xd2v\xe9\xbf\x13\xc3\xcd\xb1\x16{\x93}\x8d\x9e\xebl\xbe\xda\n'
des = DES_CBC(b"mysecret", iv=ct[:8])
print(des.decrypt(ct))

print("Első lépés: padding hosszának megkeresése")

print("Második lépése: az üzenet utolsó bájtjának meghatározása")
