# Írj programot, amely eldönti egy hamazról, hogy az ideál-e a Z_m gyűrűben!


def is_mod_ideal(m: int, I: set[int]) -> bool:
    if 0 not in I:
        return False

    for a in I:
        for b in I:
            if (a + b) % m not in I:
                return False

    for a in I:
        for r in range(m):
            if (a * r) % m not in I:
                return False
    return True


if __name__ == "__main__":
    result = is_mod_ideal(3, {0})
    assert result == True, f"got {result}"
    result = is_mod_ideal(10, {0})
    assert result == True, f"got {result}"
    result = is_mod_ideal(6, {0})
    assert result == True, f"got {result}"
    result = is_mod_ideal(6, {0, 2, 4})
    assert result == True, f"got {result}"
    result = is_mod_ideal(8, {0, 1, 2, 3, 4, 5, 6, 7})
    assert result == True, f"got {result}"
    result = is_mod_ideal(30, {14, 15, 28, 29})
    assert result == False, f"got {result}"
    result = is_mod_ideal(30, {0, 6, 11, 18, 22, 23, 27})
    assert result == False, f"got {result}"
    result = is_mod_ideal(32, {0, 1, 10, 13, 15, 16, 21, 23, 24})
    assert result == False, f"got {result}"
    result = is_mod_ideal(28, {3, 7, 8, 9, 13, 16, 18, 21, 23, 26})
    assert result == False, f"got {result}"
    result = is_mod_ideal(41, {0, 3, 4, 11, 16, 22, 23, 27, 28, 39})
    assert result == False, f"got {result}"
    print("OK")
