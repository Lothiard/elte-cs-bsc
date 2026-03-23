import random
import secrets


def xor_strings(a: bytes, b: bytes) -> bytes:
    """Két bytestring-et XOR-oz össze."""
    return b"".join((i ^ j).to_bytes(1) for i, j in zip(a, b))


class BlockCipher:
    """
    Egy blokktitkosító Cipher Feedback (CFB) módban.

    A blokkok, a kulcs és az inicializációs vektor (iv) mérete 8 bájt hosszú.

    Az inicializációs vektor (iv) opcionális: ha nem adjuk meg (None), akkor az osztály
    generáljon egy 8 bájt hosszú véletlen bytestring-et.
    """

    BLOCK_SIZE: int = 8

    def __init__(self, key: bytes, iv: bytes | None = None) -> None:
        self.key = key
        self.iv = iv if iv is not None else secrets.token_bytes(self.BLOCK_SIZE)

    def block_cipher(self, v: bytes) -> bytes:
        """
        A paraméterül kapott `v`, blokkméret hosszú bytestring-et
        bitenként megfordítja, majd hozzáadja a kulcsot modulo 2.
        Tehát az eredményt úgy kapjuk, hogy a megfordított `v` bytestring
        és kulcs között XOR műveletet végzünk.
        """
        bitstring = "".join(f"{byte:08b}" for byte in v)
        reversed_bitstring = bitstring[::-1]
        reversed_bits = bytes(
            int(reversed_bitstring[i : i + 8], 2)
            for i in range(0, self.BLOCK_SIZE * 8, 8)
        )
        return xor_strings(reversed_bits, self.key)

    def encrypt(self, plaintext: bytes) -> bytes:
        """
        CFB módban titkosító algoritmus.
        Az inicializációs vektor **nem** része a ciphertext-nek.
        """
        ciphertext = b""
        prev = self.iv
        for i in range(0, len(plaintext), self.BLOCK_SIZE):
            block = plaintext[i : i + self.BLOCK_SIZE]
            key_stream = self.block_cipher(prev)
            c_block = xor_strings(block, key_stream)
            ciphertext += c_block
            prev = c_block
        return ciphertext

    def decrypt(self, ciphertext: bytes) -> bytes:
        """
        CFB módban visszafejtő algoritmus.
        Az inicializációs vektor **nem** része a ciphertext-nek.
        """
        plaintext = b""
        prev = self.iv
        for i in range(0, len(ciphertext), self.BLOCK_SIZE):
            c_block = ciphertext[i : i + self.BLOCK_SIZE]
            key_stream = self.block_cipher(prev)
            p_block = xor_strings(c_block, key_stream)
            plaintext += p_block
            prev = c_block
        return plaintext

    def __repr__(self) -> str:
        return f"BlockCipher(key={self.key}, iv={self.iv})"


if __name__ == "__main__":
    cipher = BlockCipher(bytes.fromhex("0123456789abcdef"))
    pt = b""
    assert cipher.encrypt(pt) == b""

    cipher = BlockCipher(
        bytes.fromhex("0123456789abcdef"), bytes.fromhex("abcdef0123456789")
    )
    pt = b""
    assert cipher.encrypt(pt) == b""

    pt = bytes.fromhex("0123456789abcdef" * 2)
    assert len(cipher.encrypt(pt)) == 16

    pt = b"\x00\x00\x00\x00\x00\x00\x00\x00"
    assert cipher.encrypt(pt) == b"\x90\xc5\xe7\xa3\t\\~:"

    pt = b"kutyahaz"
    assert cipher.encrypt(pt) == b"\xfb\xb0\x93\xdah4\x1f@"

    for _ in range(50):
        cipher = BlockCipher(secrets.token_bytes(8))
        pt = secrets.token_bytes(cipher.BLOCK_SIZE * random.randint(0, 10))
        ct = cipher.encrypt(pt)
        assert cipher.decrypt(ct) == pt
    for _ in range(50):
        cipher = BlockCipher(secrets.token_bytes(8), secrets.token_bytes(8))
        pt = secrets.token_bytes(cipher.BLOCK_SIZE * random.randint(0, 10))
        ct = cipher.encrypt(pt)
        assert cipher.decrypt(ct) == pt
    print("OK")


# DO NOT DELETE
# these function helping the automatic testing on TMS (without them the tms automatic tests will fail)
def block_encrypt(plaintext: bytes, key: bytes, iv: bytes | None = None) -> bytes:
    c = BlockCipher(key, iv)
    return c.encrypt(plaintext)


def block_decrypt(ciphertext: bytes, key: bytes, iv: bytes | None = None) -> bytes:
    c = BlockCipher(key, iv)
    return c.decrypt(ciphertext)
