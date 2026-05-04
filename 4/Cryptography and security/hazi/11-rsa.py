# Write a program that validates the parameters (by correctness and not security) of RSA encryption.
def _gcd(a, b):
    while b:
        a, b = b, a % b
    return a


def _is_prime(n: int) -> bool:
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0:
        return False
    i = 3
    while i * i <= n:
        if n % i == 0:
            return False
        i += 2
    return True


def are_valid_rsa_parameters(p, q, d, e):
    if p <= 1 or q <= 1 or d <= 1 or e <= 1:
        return False

    if p == q:
        return False
    if not _is_prime(p) or not _is_prime(q):
        return False

    phi = (p - 1) * (q - 1)

    if not (1 < e < phi):
        return False
    if not (1 < d < phi):
        return False

    if _gcd(e, phi) != 1:
        return False

    return (d * e) % phi == 1


if __name__ == "__main__":
    assert are_valid_rsa_parameters(854383, 911683, 559913054987, 519917050283)
    assert not are_valid_rsa_parameters(853342, 11981, 3558587207, 3377232503)
    assert not are_valid_rsa_parameters(291491, 717009, 16867459923, 11513965147)
    assert not are_valid_rsa_parameters(955793, 955793, 727168494075, 193855182131)
    assert not are_valid_rsa_parameters(898133, 222043, 1, 16153265069065)
    assert not are_valid_rsa_parameters(758491, 882913, 553159763449, 130177488607)
    print("OK!")
