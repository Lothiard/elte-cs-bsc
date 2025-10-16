'''
Ez a kódrészlet egy Python unit teszt, amely a unittest 
modult használja a Basket osztály tesztelésére. 
A TestBasket osztály egy tesztosztály, amely a 
unittest.TestCase osztályból származik. 
A test_add_good metódus egy teszteset, amely a következőket ellenőrzi:

Létrehoz egy Basket objektumot 100 pénzzel/egységgel és 
0 elemmel (basket = Basket(100, 0)).

Létrehoz egy Good objektumot "Apple" névvel 
és 10 pénzértékkel (apple = Good("Apple", 10)).

Hozzáadja az almát a kosárhoz (basket.add_good(apple)).

Ellenőrzi, hogy a kosárban lévő pénz 90-re csökkent 
(self.assertEqual(basket.money, 90)).

Ellenőrzi, hogy a kosár tartalma 1 elemre nőtt 
(self.assertEqual(len(basket.content), 1)).

Ellenőrzi, hogy a kosár adatbázisában lévő 
elemek száma 1 (self.assertEqual(basket.db, 1)).

Ez a teszt biztosítja, hogy a Basket osztály 
add_good metódusa helyesen működik, amikor 
elegendő pénz áll rendelkezésre egy áru hozzáadásához.
'''

import unittest
from basketF import Basket, Good

class TestBasket(unittest.TestCase):
    def test_add_good(self):
        basket = Basket(100, 0)
        apple = Good("Apple", 10)
        basket.add_good(apple)
        self.assertEqual(basket.money, 90)
        self.assertEqual(len(basket.content), 1)
        self.assertEqual(basket.db, 1)
    
    def test_add_good_not_enough_money(self):
        basket = Basket(5, 0)
        apple = Good("Apple", 10)
        basket.add_good(apple)
        self.assertEqual(basket.money, 5)
        self.assertEqual(len(basket.content), 0)
        self.assertEqual(basket.db, 0)
    
    def test_show_content(self):
        basket = Basket(100, 0)
        apple = Good("Apple", 10)
        banana = Good("Banana", 20)
        basket.add_good(apple)
        basket.add_good(banana)
        basket.show_content()

if __name__ == '__main__':
    unittest.main()