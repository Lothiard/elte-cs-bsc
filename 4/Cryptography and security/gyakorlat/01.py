from sage.all import *
from math import gcd
from collections import Counter


# --------------------------------------------------------------------------
# Count the characters of a text
def char_count(s: str) -> dict:
    return dict(Counter(s))


try:
    assert char_count("abc") == {"a": 1, "b": 1, "c": 1}
    assert char_count("aabbc") == {"a": 2, "b": 2, "c": 1}
    assert char_count("") == {}
    s = "a a!?"
    assert char_count(s) == {
        "a": 2,
        " ": 1,
        "!": 1,
        "?": 1,
    }
    assert char_count("Aa") == {"A": 1, "a": 1}
    s = "árvíztűrő"
    assert char_count(s) == {
        "á": 1,
        "r": 2,
        "v": 1,
        "í": 1,
        "z": 1,
        "t": 1,
        "ű": 1,
        "ő": 1,
    }
    s = "1122$$"
    assert char_count(s) == {
        "1": 2,
        "2": 2,
        "$": 2,
    }
    s = "hello world"
    assert char_count(s)["l"] == 3
    assert char_count(s)["o"] == 2
except NotImplementedError:
    pass


# --------------------------------------------------------------------------
# Write a program that calculates the kth power of a number
def my_pow(a: int | float, k: int) -> int | float:
    if k == 0:
        return 1
    if k < 0:
        # a**(-k) = 1 / (a**k)
        return 1 / my_pow(a, -k)

    result = 1
    base = a
    exp = k

    while exp > 0:
        if exp & 1:
            result *= base
        base *= base
        exp >>= 1
    return result


try:
    for a, k in zip(range(10), range(2, 10)):
        assert my_pow(a, k) == a**k
except NotImplementedError:
    pass


# --------------------------------------------------------------------------
# Write a program that calculates the greatest common divisor of two numbers (+ binary)
def my_gcd(a: int, b: int) -> int:
    a, b = abs(a), abs(b)
    while b != 0:
        a, b = b, a % b

    return a


try:
    for i, j in zip(range(1, 20), range(1, 20)):
        assert my_gcd(i, j) == gcd(i, j)
except NotImplementedError:
    pass


# --------------------------------------------------------------------------
# Create a generator for the Fibonacci numbers (use yield)
def fib_nums():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b


def fibonacci(n: int) -> int:
    if n < 0:
        raise ValueError
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a


try:
    F = fib_nums()
    A = [next(F) for _ in range(10)]
    assert len(A) == 10
    assert A == [fibonacci(i) for i in range(len(A))]
except NotImplementedError:
    pass


# --------------------------------------------------------------------------
# Create a class that encode and decodes a string with Huffman-coding
class Huffman:
    def __init__(self, base=2):
        self.__base = base

    def __repr__(self):
        return f"Huffman encoder (base ={self.__base})"

    def _build_tree(self, data: str) -> DiGraph:
        if not data:
            G = DiGraph()
            return G

        freq = char_count(data)

        import heapq

        heap = []
        counter = 0

        G = DiGraph()
        for ch, f in freq.items():
            node_label = ch
            G.add_vertex(node_label)
            heapq.heappush(heap, (f, counter, node_label, True))
            counter += 1

        internal_id = 0
        while len(heap) > 1:
            f1, _, left_label, _ = heapq.heappop(heap)
            f2, _, right_label, _ = heapq.heappop(heap)

            internal_label = f"*{internal_id}"
            internal_id += 1
            G.add_vertex(internal_label)

            G.add_edge(internal_label, left_label, "0")
            G.add_edge(internal_label, right_label, "1")

            heapq.heappush(heap, (f1 + f2, counter, internal_label, False))
            counter += 1

        _, _, root_label, _ = heap[0]

        if len(freq) == 1:
            real_root = "ROOT"
            G.add_vertex(real_root)
            G.add_edge(real_root, root_label, "0")
            root_label = real_root

        G.set_graph_attribute("root", root_label)
        return G

    def _build_codes_from_tree(self, tree: DiGraph) -> dict:
        if tree.num_verts() == 0:
            return {}

        root = tree.get_graph_attribute("root")
        codes = {}

        def dfs(node, prefix):
            out_edges = list(tree.outgoing_edges(node, labels=True))
            if not out_edges:
                ch = node
                codes[ch] = prefix or "0"
                return
            for _, v, bit in out_edges:
                dfs(v, prefix + bit)

        dfs(root, "")
        return codes

    def encode(self, data: str) -> tuple[str, DiGraph]:
        if data == "":
            return "", DiGraph()

        tree = self._build_tree(data)
        codes = self._build_codes_from_tree(tree)
        encoded = "".join(codes[ch] for ch in data)
        return encoded, tree

    def decode(self, data: str, tree: DiGraph) -> str:
        """
        Decode the bitstring `data` using the Huffman tree `tree` (DiGraph).
        """
        if tree.num_verts() == 0:
            return ""

        root = tree.get_graph_attribute("root")
        if data == "":
            return ""

        result_chars = []
        node = root

        for bit in data:
            moved = False
            for _, v, lbl in tree.outgoing_edges(node, labels=True):
                if lbl == bit:
                    node = v
                    moved = True
                    break
            if not moved:
                break

            if not list(tree.outgoing_edges(node, labels=True)):
                result_chars.append(node)
                node = root

        return "".join(result_chars)
