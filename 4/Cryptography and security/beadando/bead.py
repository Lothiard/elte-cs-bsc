import string
from math import gcd


def mod_inverse(a, m):
    def extended_gcd(a, b):
        if a == 0:
            return b, 0, 1
        gcd_val, x1, y1 = extended_gcd(b % a, a)
        x = y1 - (b // a) * x1
        y = x1
        return gcd_val, x, y

    gcd_val, x, _ = extended_gcd(a % m, m)
    if gcd_val != 1:
        raise ValueError(f"Modular inverse does not exist for a={a} mod m={m}")
    return x % m


def encrypt(plaintext):
    if not plaintext.isalpha():
        raise ValueError("plaintext must contain only alphabetic characters!")

    alphabet = string.ascii_lowercase
    n = len(plaintext)

    a_values = [alphabet.index(char) + 1 for char in plaintext.lower()]

    a_values = [(x + n) % 26 for x in a_values]
    a_values = [x if x != 0 else 26 for x in a_values]

    b_values = []
    for a in a_values:
        b = 27
        while gcd(b, a) != 1:
            b += 1
        b_values.append(b)

    c_values = [mod_inverse(a, b) for a, b in zip(a_values, b_values)]

    edge_list = []
    for i in range(n):
        edge_list.append((i, n + i, b_values[i], c_values[i], i))

    return edge_list


def decrypt(edge_list, n):
    alphabet = string.ascii_lowercase

    edges_sorted = sorted(edge_list, key=lambda x: x[2])

    a_values_sorted = []
    original_indices = []
    for _, _, b, c, orig_idx in edges_sorted:
        a = mod_inverse(c, b)
        a_values_sorted.append(a)
        original_indices.append(orig_idx)

    w_values_sorted = [(a - n) % 26 for a in a_values_sorted]
    w_values_sorted = [w if w != 0 else 26 for w in w_values_sorted]

    result = [""] * n
    for i, orig_idx in enumerate(original_indices):
        result[orig_idx] = alphabet[w_values_sorted[i] - 1]

    return "".join(result)


def run_tests():
    print("\n[TEST 1] Egykarakteres szöveg")
    plaintext1 = "a"
    encrypted1 = encrypt(plaintext1)
    decrypted1 = decrypt(encrypted1, len(plaintext1))
    print(f"  Eredeti:    '{plaintext1}'")
    print(f"  Dekódolt:   '{decrypted1}'")
    print(f"  Test: {'PASSED' if plaintext1 == decrypted1 else 'FAILED'}")

    print("\n[TEST 2] Négykarakteres szöveg ('edge' - cikk példa)")
    plaintext2 = "edge"
    encrypted2 = encrypt(plaintext2)
    decrypted2 = decrypt(encrypted2, len(plaintext2))
    print(f"  Eredeti:    '{plaintext2}'")
    print("  Titkosított éllistája:")
    for i, (main, pend, b, c, orig_idx) in enumerate(encrypted2):
        print(
            f"    Edge {i}: main_v={main}(w={b}) -- pend_v={pend}(w={c}) [orig_idx={orig_idx}]"
        )
    print(f"  Dekódolt:   '{decrypted2}'")
    print(f"  Test: {'PASSED' if plaintext2 == decrypted2 else 'FAILED'}")

    print("\n[TEST 3] Hétkarakteres szöveg ('cryptog')")
    plaintext3 = "cryptog"
    encrypted3 = encrypt(plaintext3)
    decrypted3 = decrypt(encrypted3, len(plaintext3))
    print(f"  Eredeti:    '{plaintext3}'")
    print(f"  Dekódolt:   '{decrypted3}'")
    print(f"  Test: {'PASSED' if plaintext3 == decrypted3 else 'FAILED'}")

    print("\n[TEST 4] Nagy betűs szöveg konverzió ('HELLO')")
    plaintext4 = "hello"
    encrypted4 = encrypt("HELLO")
    decrypted4 = decrypt(encrypted4, len(plaintext4))
    print(f"  Eredeti:    '{plaintext4}'")
    print(f"  Dekódolt:   '{decrypted4}'")
    print(f"  Test: {'PASSED' if plaintext4 == decrypted4 else 'FAILED'}")

    print("\n[TEST 5] Ismétlődő karakterek ('aaaa')")
    plaintext5 = "aaaa"
    encrypted5 = encrypt(plaintext5)
    decrypted5 = decrypt(encrypted5, len(plaintext5))
    print(f"  Eredeti:    '{plaintext5}'")
    print(f"  Dekódolt:   '{decrypted5}'")
    print(f"  Test: {'PASSED' if plaintext5 == decrypted5 else 'FAILED'}")

    print("\n[TEST 6] Ábécé összes karaktere")
    plaintext6 = string.ascii_lowercase
    encrypted6 = encrypt(plaintext6)
    decrypted6 = decrypt(encrypted6, len(plaintext6))
    print(f"  Eredeti:    '{plaintext6}'")
    print(f"  Dekódolt:   '{decrypted6}'")
    print(f"  Test: {'PASSED' if plaintext6 == decrypted6 else 'FAILED'}")

    print("\n[TEST 7] 50 karakteres szöveg (maximum hossz)")
    plaintext7 = "a" * 25 + "z" * 25
    encrypted7 = encrypt(plaintext7)
    decrypted7 = decrypt(encrypted7, len(plaintext7))
    print(f"  Hossz:      {len(plaintext7)}")
    print(f"  Dekódolt hossz: {len(decrypted7)}")
    print(f"  Test: {'PASSED' if plaintext7 == decrypted7 else 'FAILED'}")

    print("\n[TEST 8] Vegyes szöveg ('thequickbrownfox')")
    plaintext8 = "thequickbrownfox"
    encrypted8 = encrypt(plaintext8)
    decrypted8 = decrypt(encrypted8, len(plaintext8))
    print(f"  Eredeti:    '{plaintext8}'")
    print(f"  Dekódolt:   '{decrypted8}'")
    print(f"  Test: {'PASSED' if plaintext8 == decrypted8 else 'FAILED'}")

    print("\n[TEST 9] Gráf szerkezetének ellenőrzése (4 csúcs)")
    plaintext9 = "test"
    encrypted9 = encrypt(plaintext9)
    print(f"  Szöveg hossza: {len(plaintext9)}")
    print(f"  Gráf csúcsainak száma: {len(encrypted9) * 2}")
    print(f"  Élek száma: {len(encrypted9)}")
    print(f"  Test: {'PASSED' if len(encrypted9) == 4 else 'FAILED'}")

    print("\n[TEST 10] Modulo inverz verifikáció")
    plaintext10 = "crypto"
    encrypted10 = encrypt(plaintext10)
    all_valid = True
    for main, pend, b, c, orig_idx in encrypted10:
        a = mod_inverse(c, b)
        if (c * a) % b != 1:
            all_valid = False
    decrypted10 = decrypt(encrypted10, len(plaintext10))
    print(f"  Inverz ellenőrzés: {'PASSED' if all_valid else 'FAILED'}")
    print(f"  Dekódolás: {'PASSED' if plaintext10 == decrypted10 else 'FAILED'}")
    print(
        f"  Test: {'PASSED' if all_valid and plaintext10 == decrypted10 else 'FAILED'}"
    )


if __name__ == "__main__":
    run_tests()
