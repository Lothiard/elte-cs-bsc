class Book:
    def __init__(self, title, author, pages):
        if not title or not author or not pages:
            raise ValueError("Minden tulajdonság megadása kötelező!")
        self.title = title
        self.author = author
        self.pages = pages
        if not isinstance(pages, int) or pages <= 0:
            raise ValueError("Az oldalszámnak pozitív egész számnak kell lennie!")

    def __lt__(self, other):
        if not isinstance(other, Book):
            raise Exception("Összehasonlíthatatlan adatok!")
        return self.pages < other.pages

    def __eq__(self, other):
        if not isinstance(other, Book):
            raise Exception("Összehasonlíthatatlan adatok!")
        return self.pages == other.pages

    def __str__(self):
        return f"{self.title} - {self.author} ({self.pages} oldal)"
    
class Library:
    overall_books = [] #osztályváltozó!

    def __init__(self):
        self.books = []

    def add_book(self, book):
        if not isinstance(book, Book):
            raise TypeError("Csak Book típusú objektumok tárolhatóak a könyvtárban!")
        self.books.append(book)
        Library.overall_books.append(book)
    
    def __len__(self):
        return len(self.books)
    
    def __str__(self):
        sorted_books = sorted(self.books)
        return "\n".join(str(book) for book in sorted_books)

import math

class Shape:
    def __init__(self, size):
        if not isinstance(size, (int, float)):
            raise TypeError("A méret számmal legyen megadva (tört, vagy egész!)")
        if size <= 0:
            raise ValueError("A méretnek > 0-nak kell lennie!")
        self.size = float(size)

    def get_size(self):
        return self.size

    def get_volume(self):
        raise NotImplementedError

    def get_surface_area(self):
        raise NotImplementedError


class Circle(Shape):
    def __init__(self, radius):
        super().__init__(radius)

    def get_area(self): 
        #egyértelműsítés/tisztább kód miatt
        return self.get_surface_area()

    def get_volume(self):
        # nincs térfogat (2D)
        return 0

    def get_surface_area(self):
        # tulajdonképpen terület
        return math.pi * self.size ** 2

    def __str__(self):
        return f"Kör (sugár: {self.size:.2f})"


class Sphere(Shape):
    def __init__(self, radius):
        super().__init__(radius)

    def get_volume(self):
        return (4/3) * math.pi * self.size ** 3

    def get_surface_area(self):
        return 4 * math.pi * self.size ** 2

    def __str__(self):
        return f"Gömb (sugár: {self.size:.2f})"


class Cube(Shape):
    def __init__(self, side):
        super().__init__(side)

    def get_volume(self):
        return self.size ** 3

    def get_surface_area(self):
        return 6 * self.size ** 2

    def __str__(self):
        return f"Kocka (oldal: {self.size:.2f})"