def mul_ord_classification(p: int) -> dict[int, set[int]]:
    def order(a, p):
        for k in range(1, p):
            if pow(a, k, p) == 1:
                return k
        return None

    result = dict()
    for a in range(1, p):
        k = order(a, p)
        if k not in result:
            result[k] = set()
        result[k].add(a)
    return result


if __name__ == "__main__":
    assert mul_ord_classification(7) == {1: {1}, 2: {6}, 3: {2, 4}, 6: {3, 5}}
    assert mul_ord_classification(2) == {1: {1}}
    for order in mul_ord_classification(11).keys():
        assert 10 % order == 0
    elements = set()
    for s in mul_ord_classification(13).values():
        elements |= s
    assert elements == set(range(1, 13))
    classes = mul_ord_classification(11)
    assert 10 in classes
    assert len(classes[10]) == 4  # φ(10) = 4
    print("OK!")

