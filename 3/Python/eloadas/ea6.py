from abc import ABC, abstractmethod


class A:
    pass

a = A()

class B(ABC):
    @abstractmethod
    def add(self):
        pass

#b = B()

'''
TypeError: Can't instantiate abstract class B without 
an implementation for abstract method 'add'
'''

class BC(B):
    pass

#bc = BC()
''' Same '''

class BB(ABC):
    @abstractmethod
    def add(self):
        pass
    
    def mul(self, a):
        a*1

bb = BB()


class F(BB):
    def add(self, x, y):
        return x + y

#vagy 

class F2(BB):
    def add(self):
        return 1 + 2

# Interface

'''
Az interfészek nem szükségesek a Pythonban. Ennek az az oka, hogy a 
Python rendelkezik megfelelő többszörös öröklődéssel, 
valamint ducktyping-el, 
ami azt jelenti, hogy ott, ahol Java-ban kell interfészeket használni, 
nem kell Pythonban.

Ennek ellenére az interfészek számos felhasználási módja létezik. 
Néhányat a Pythons Abstract Base Classes lefed, amelyet a Python 
2.6-ban vezettek be. Hasznosak, ha olyan alaposztályokat akarunk 
készíteni, amelyek nem példányosíthatók, de egy adott felületet 
vagy egy implementáció egy részét biztosítják.
'''



def acc_checker(function):
    def checked(self, *args, **kwargs):
        if self.granted:
            return function(self, *args, **kwargs)
        else:
            print(f"Access denied: {self.name}")
    return checked

class User:
    def __init__(self, name, level):
        self.name = name
        self.granted = level
        
    @acc_checker
    def userFunction1(self):
        print(f"Access granted: {self.name}")
        
user1 = User("Joe", True)
user2 = User("Tim", False)

user1.userFunction1()
user2.userFunction1()

class EUConnector:
    def csatlakoztat(self):
        return "Európai dugasz csatlakoztatva."
    
class USAConnector:
    def plug_in(self):
        return "Amerikai dugasz csatlakoztatva."

class Adapter:
    def __init__(self, amerikai_dugasz):
        self.amerikai_dugasz = amerikai_dugasz
    def csatlakoztat(self):
        return self.amerikai_dugasz.plug_in()

adapterEU = Adapter(USAConnector())
print(adapterEU.csatlakoztat()) 

class Ház:
    def __init__(self):
        self.alap = None
        self.falak = None
        self.tető = None
    def __str__(self):
        return f"Alap: {self.alap}, Falak: {self.falak}, Tető: {self.tető}"
    
class HázÉpítő:
    def __init__(self):
        self.ház = Ház()
    def alap_épít(self):
        self.ház.alap = "Betonalap"
        return self
    def falak_épít(self):
        self.ház.falak = "Tégla falak"
        return self
    def tető_épít(self):
        self.ház.tető = "Cseréptető"
        return self
    def get_ház(self):
        return self.ház
    
házépítő = HázÉpítő()
ház = házépítő.alap_épít().falak_épít().tető_épít().get_ház()
print(ház) 

# decorator functions
import time
from datetime import timedelta

def frame(f):
    def wrapper():
        print("----------")
        f()
        print("----------")
    return wrapper

@frame
def fun():
    print("Num")
    
fun()

def timing(f):
    def wrapper(*args, **kwargs):
        startTime = time.time()
        res = f(*args, **kwargs)
        totalRunTime = time.time() - startTime
        formattedTime = str(timedelta(seconds=totalRunTime))
        print(f"TotalRunTime: {formattedTime}")
        return res
    return wrapper

'''
A timedelta a totalRunTime másodpercekben mért értékét alakítja 
át egy timedelta objektummá, amelyet aztán karakterlánccá alakítanak
(str(timedelta(seconds=totalRunTime))). 

Pl.: 0:00:01.234567 (1 másodperc és 234567 mikroszekundum).

'''

@timing
def add(x, y):
    return x + y

a = add(10, 20)

class A:
    def függvény(self):
        return "A-ból"
class B(A):
    def függvény(self):
        return "B-ből"
class C(A):
    def függvény(self):
        return "C-ből"
class D(B, C):
    pass
d = D()
print(d.függvény()) 

class Kávé:
    def ár(self):
        return 500
    
class TejKávéDecorator:
    def __init__(self, kávé):
        self.kávé = kávé
    def ár(self):
        return self.kávé.ár() + 100
    
class CukorKávéDecorator:
    def __init__(self, kávé):
        self.kávé = kávé
    def ár(self):
        return self.kávé.ár() + 50
    
kávé = Kávé()
tej_kávé = TejKávéDecorator(kávé)
cukros_tej_kávé = CukorKávéDecorator(tej_kávé)
print(cukros_tej_kávé.ár()) 

class Személy:
    def __init__(self, név, kor):
        self.név = név
        self.kor = kor
    def __eq__(self, másik):
        return self.kor == másik.kor
    def __lt__(self, másik):
        return self.kor < másik.kor

személy1 = Személy("Anna", 30)
személy2 = Személy("Béla", 25)

print(személy1 == személy2)  
print(személy1 > személy2) 


class Autó:
    def vezet(self):
        return "Az autó halad."
    
class Motor:
    def vezet(self):
        return "A motor száguld."
    
class JárműFactory:
    @staticmethod
    def jármű_létrehoz(típus):
        if típus == "autó":
            return Autó()
        elif típus == "motor":
            return Motor()
        else:
            raise ValueError("Ismeretlen járműtípus")
        
jármű1 = JárműFactory.jármű_létrehoz("autó")
jármű2 = JárműFactory.jármű_létrehoz("motor")
print(jármű1.vezet())  
print(jármű2.vezet()) 

class Elemek:
    def __init__(self, elemek):
        self.elemek = elemek

    def __getitem__(self, index):
        return self.elemek[index]

    def __setitem__(self, index, érték):
        self.elemek[index] = érték

LT = Elemek([10, 20, 30])
print(LT[1]) 
LT[1] = 40
print(LT[1]) 

from interface import implements, Interface

# Interface package
# Python 2.7 és a Python 3.4+ verziókban
# from interface import implements, interface

class MyInterface(Interface):

    def method1(self, x):
        pass

class MyClass(implements(MyInterface)):

    def method1(self, x):
        return x * 2



class BookStore:
    __db = 0
    def __init__(self):
        BookStore.__db +=1
        self.books = []
        print(f"Létrejött a(z) {self.__len__()}. BookStore.")

    def hozzáad_könyv(self, könyv):
        self.books.append(könyv)

    def __len__(self):
        return BookStore.__db
        #return len(self.könyvek)

# Példa a Könyvtár osztály használatára
b1 = BookStore()
b2 = BookStore()
b3 = BookStore()

b1.hozzáad_könyv("Python programozás")
b2.hozzáad_könyv("Adatbázis-kezelés")
b1.hozzáad_könyv("Algoritmusok és adatszerkezetek")

print(f"Összesen {len(b1)} db BookStore jött létre eddig.")  # Kimenet: 3
# print(BookStore.len()) nem használható!

# MRO

class A:
    def method(self):
        print("A")
        
class B(A):
    def method(self):
        print("B")
        
class C(A):
    def method(self):
        print("C")
        
class D(B, C):
    pass

d = D()
d.method()

print(D.__mro__)


class Alany:
    def __init__(self):
        self.lista = []
        self.megfigyelők = []
        
    def add(self, elem):
        self.lista.append(elem)
        self.értesítés()
        
    def feliratkozás(self, megfigyelő):
        self.megfigyelők.append(megfigyelő)
        
    def értesítés(self):
        for megfigyelő in self.megfigyelők:
            megfigyelő.update()
            
class Megfigyelő:
    def __init__(self, name):
        self.name = name
    
    def update(self):
        print(f"{self.name} updatelve. Az alany állapota megváltozott.")

alany = Alany()
megfigyelő1 = Megfigyelő('M1')
megfigyelő2 = Megfigyelő('M2')
alany.feliratkozás(megfigyelő1)
alany.feliratkozás(megfigyelő2)

alany.add(10)
alany.add(20)

import time
import random

#Abstract classes

class Observable:
    def __init__(self):
        self.observers = []

    def attach(self, *args):
        for observer in args:
            if observer not in self.observers:
                self.observers.append(observer)

    def detach(self, observer):
        if observer in self.observers:
            self.observers.remove(observer)

    def notify(self, *args, **kwargs):
        for observer in self.observers:
            observer.update(self, *args, **kwargs)

class Observer:
    def update(self, observable):
        pass

class Sensor:
    def settepr(self, observable):
        pass

# Konkrét osztályok a funkciókkal

class Thermometer(Sensor):
    def __init__(self, l, h, observable):
        self.intervall = (l, h)
        self.observable = observable

    def settepr(self):
        while True:
            tempr = random.uniform(*self.intervall)
            self.observable.settempr(tempr)
            time.sleep(random.randint(1, 6))

class Station(Observable):
    def settempr(self, tempr):
        self.tempr = tempr
        self.notify(self)
       
class Monitor(Observer):
    def __init__(self, name):
        self.name = name
    
    def update(self, observable, *args, **kwargs):
        temp = observable.tempr
        print(f'{self.name} -> Temperature updated: {temp:.2f} c')

S1 = Station()
m1 = Monitor('M1')
m2 = Monitor('M2')
m3 = Monitor('Test')

S1.attach(m1, m2, m3)
T = Thermometer(10, 30, S1)
T.settepr()

        
    class Example:
    def __init__(self, value1):
        self.__value1 = value1  # rejtett mező

    @property
    def value1(self):
        return self.__value1

    @value1.setter
    def value1(self, value):
        if value >= 0:
            self.__value1 = value
        else:
            raise ValueError("Az érték nem lehet negatív")
        
    def __private_method(self):
        print("Private metódus.")
        
    def useprivate(self):
        self.__private_method()

# Példa használata
example = Example(10)
print(example.value1)  # 10
example.useprivate()

#example.__private_method()

# example.value1 = -10
# Hibát dob, mert az érték negatív


class Személy:
    def __init__(self, név, kor):
        self.név = név
        self.kor = kor

    def __str__(self):
        return f"Személy neve: {self.név}, kor: {self.kor}"

    def __repr__(self):
        return f"Személy(név='{self.név}', kor={self.kor})"

személy1 = Személy("Anna", 30)

print(személy1)  
print(repr(személy1)) 


class Singleton:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(Singleton, cls).__new__(cls)
        return cls._instance
    
    
# Példányosítás és használat
singleton1 = Singleton()
singleton2 = Singleton()

print(singleton1 is singleton2)  
# Ez True-t fog kiírni, mert mindkét 
# változó ugyanarra a példányra mutat.

