class Flower:
    def __init__(self, name, color, beauty):
        self.name = name
        self.color = color
        if 1 <= beauty <= 10:
            self.beauty = beauty
        else:
            raise ValueError("1 <= Beauty <= 10")

    def __eq__(self, other):
        return self.beauty == other.beauty

    def __lt__(self, other):
        return self.beauty < other.beauty


class Rose(Flower):
    def __str__(self):
        return (
            f"Rose - Name: {self.name}, Color: {self.color}, Beauty: {self.beauty * 2}"
        )


class Tulip(Flower):
    def __str__(self):
        return f"Tulip - Name: {self.name}, Color: {self.color}, Beauty: {self.beauty * 1.5}"


class Daisy(Flower):
    def __str__(self):
        return (
            f"Daisy - Name: {self.name}, Color: {self.color}, Beauty: {self.beauty * 1}"
        )


class Bouquet:
    count = 0

    def __init__(self):
        self.flowers = []
        Bouquet.count += 1

    def add_flowers(self, *new_flowers):
        for flower in new_flowers:
            self.flowers.append(flower)

    def __str__(self):
        sorted_flowers = sorted(self.flowers, key=lambda f: f.beauty)
        return "\n".join(str(flower) for flower in sorted_flowers)
