try:
    value = int(input("Value: "))
    print(value/value)
except ValueError:
    print("Bad input...")
except ZeroDivisionError:
    print("Null-division")
except:
    print("Except!")

#Feladat:
    
# Pszeudokód
# próbáld meg két bemenetet kérni a felhasználótól
# alakítsd át a bemeneteket egész számmá
# oszd el az első számot a második számmal és írd ki az eredményt
# ha ValueError kivétel keletkezik, írd ki, hogy a bemenetnek számnak kell lennie
# ha ZeroDivisionError kivétel keletkezik, írd ki, hogy a második szám nem lehet nulla

# Python kód
try:
    num1 = int(input("Add meg az első számot: "))
    num2 = int(input("Add meg a második számot: "))
    print(num1 / num2)
except ValueError:
    print("A bemenetnek számnak kell lennie.")
except ZeroDivisionError:
    print("A második szám nem lehet nulla.")

# Feladat
# definiálj egy listát
# próbáld meg egy bemenetet kérni a felhasználótól
# alakítsd át a bemenetet egész számmá
# írd ki a listából az adott indexen lévő elemet
# ha IndexError kivétel keletkezik, írd ki, hogy az index túl nagy
# ha ValueError kivétel keletkezik, írd ki, hogy a bemenetnek számnak kell lennie

# Python kód
my_list = [1, 2, 3, 4, 5]
try:
    index = int(input("Add meg az indexet: "))
    print(my_list[index])
except IndexError:
    print("Az index túl nagy.")
except ValueError:
    print("A bemenetnek számnak kell lennie.")