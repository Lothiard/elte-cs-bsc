# Írjuk meg a Vigenére rejtjelezés módosított változatát a következők szerint:
#    1. Bontsuk a titkosítandó szöveget a kulcsnak megfelelő hosszúságú szakaszokra.
#    2. Egészítsük ki az utolsó szakaszt 'padding' karakterekkel úgy, hogy annak hossza megegyezik a kulcs hosszával.
#    3. Minden szakaszt titkosítsunk a Vigenére rejtjelezésnek megfelelően, de a kulcs
#        a. az első szakasz esetén az adott kulcs ('key').
#        b. a második szakasztól kezdve pedig az előző titkosított szakasz újra az eredeti kulccsal titkosítva.
#
#    Pl abc=['a','b','c', 'd', 'e'], padding='a', plaintext='edcba', key='a' esetén a titkosított szöveg: 'eceaa'
#                   a a a a
#                   + + + +
#                 a e c e a
#                 + + + + +
#                 e d c b a
#                 - - - - -
#                 e c e a a


class VigenereChain:
    def __init__(self, abc: list[str], padding: str = "a"):
        self._abc = abc
        self._padding = padding

    def encrypt(self, key, plaintext) -> str:
        if not plaintext:
            return ""
        n = len(self._abc)
        klen = len(key)
        blocks = [plaintext[i : i + klen] for i in range(0, len(plaintext), klen)]
        if len(blocks[-1]) < klen:
            blocks[-1] = blocks[-1].ljust(klen, self._padding)
        result = []
        prev = ""
        for i, block in enumerate(blocks):
            if i == 0:
                curr_key = key
            else:
                prev_key = ""
                for j in range(klen):
                    pi = self._abc.index(prev[j])
                    ki = self._abc.index(key[j % klen])
                    prev_key += self._abc[(pi + ki) % n]
                curr_key = prev_key
            enc = ""
            for j in range(klen):
                pi = self._abc.index(block[j])
                ki = self._abc.index(curr_key[j % klen])
                enc += self._abc[(pi + ki) % n]
            result.append(enc)
            prev = enc
        return "".join(result)

    def decrypt(self, key, ciphertext) -> str:
        if not ciphertext:
            return ""
        n = len(self._abc)
        klen = len(key)
        blocks = [ciphertext[i : i + klen] for i in range(0, len(ciphertext), klen)]
        result = []
        prev = ""
        for i, block in enumerate(blocks):
            if i == 0:
                curr_key = key
            else:
                prev_key = ""
                for j in range(klen):
                    pi = self._abc.index(prev[j])
                    ki = self._abc.index(key[j % klen])
                    prev_key += self._abc[(pi + ki) % n]
                curr_key = prev_key
            dec = ""
            for j in range(klen):
                ci = self._abc.index(block[j])
                ki = self._abc.index(curr_key[j % klen])
                dec += self._abc[(ci - ki) % n]
            result.append(dec)
            prev = block
        return "".join(result)


if __name__ == "__main__":
    vc = VigenereChain(["a", "b", "c", "d", "e"])
    assert vc.encrypt("a", "edcba") == "eceaa"
    assert vc.decrypt("a", "eceaa") == "edcba"
    assert vc.encrypt("ece", "abcd") == "edbbaa"
    assert vc.decrypt("ece", "edbbaa") == "abcdaa"

    cipher = VigenereChain(list("abcdefghijklmnopqrstuvwxyz"))
    key = "key"
    plaintext = "attackatdawn"
    ciphertext = cipher.encrypt(key, plaintext)
    decrypted = cipher.decrypt(key, ciphertext)
    assert decrypted == plaintext

    key = "key"
    plaintext = "hello"  # not a multiple of key length (3)
    ciphertext = cipher.encrypt(key, plaintext)
    decrypted = cipher.decrypt(key, ciphertext)
    # padded with 'a' by default
    expected = plaintext.ljust(len(ciphertext), "a")
    assert decrypted == expected

    key = "ab"
    plaintext = "ab"
    ciphertext = cipher.encrypt(key, plaintext)
    decrypted = cipher.decrypt(key, ciphertext)
    assert decrypted == plaintext

    key = "abc"
    plaintext = "aaaaaaaaa"
    ciphertext = cipher.encrypt(key, plaintext)
    # chaining means repeated blocks should differ
    blocks = [ciphertext[i : i + 3] for i in range(0, len(ciphertext), 3)]
    assert len(set(blocks)) > 1

    key = "d"
    plaintext = "helloworld"
    ciphertext = cipher.encrypt(key, plaintext)
    decrypted = cipher.decrypt(key, ciphertext)
    assert decrypted == plaintext

    key = "key"
    plaintext = ""
    ciphertext = cipher.encrypt(key, plaintext)
    decrypted = cipher.decrypt(key, ciphertext)
    assert ciphertext == ""
    assert decrypted == ""

    abc = list("0123456789")
    cipher = VigenereChain(abc, padding="0")
    key = "12"
    plaintext = "98765"
    ciphertext = cipher.encrypt(key, plaintext)
    decrypted = cipher.decrypt(key, ciphertext)
    expected = plaintext.ljust(len(ciphertext), "0")
    assert decrypted == expected

    print("OK!")


# DO NOT DELETE
# these function helping the automatic testing on TMS (without them the tms automatic tests will fail)
def vigenere_chain_encrypt(abc, padding, key, plaintext):
    c = VigenereChain(abc, padding)
    return c.encrypt(key, plaintext)


def vigenere_chain_decrypt(abc, padding, key, ciphertext):
    c = VigenereChain(abc, padding)
    return c.decrypt(key, ciphertext)

