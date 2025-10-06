class Animal:
    def __init__(self, name, age):
        self.name = name
        self.set_age(age)
    def set_age(self, age):
        if age < 0 or age > 120:
            raise BaseException()
        self.age = age
    def __str__(self):
        return f"Állat: {self.name}, Kor: {self.age}"
    
dog = Animal("Buddy", 14)
cat = Animal("Kitty", 12)
cat.set_age(10)

print(dog)
print(cat)