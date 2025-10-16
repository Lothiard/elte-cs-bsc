class Basket:
    def __init__(self, money, db):
        self.money = money
        self.db = db
        self.content = []
    
    def add_good(self, good):
        if (self.money - good.price) > 0:
            self.content.append(good)
            self.db += 1
            self.money -= good.price
        else:
            print("Not enough money!")
        
    def show_content(self):
        print(self.money)
        print(self.content)
        print(self.db)
        
class Good:
    def __init__(self, name, price):
        self.price = price
        self.name = name