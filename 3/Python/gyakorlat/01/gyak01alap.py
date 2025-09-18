'''
Python telepítés
https://www.python.org/downloads

VS Code
https://code.visualstudio.com

GitHub Copilot
https://education.github.com/discount_requests/application
https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication​

Verzió ellenőrzés
py --version
python --version
python3 --version

Csomagkezelő
pip --version

Terminál
cmd
py

VS Code
python .\minta.py
py .\minta.py
'''

#Alapok
#print()

#print("Hello world!")
#print("Hello","world",sep="-",end="\n\n")

#Input


'''name = input("Mi a neved? ")
print("Hello", name)
print("Hello {n}".format(n = name))
print(f"Hello {name}")'''


#Változók

'''
Mutable:
-List
-Dictionary
-Set
-...

Immutable:
-int
-float
-complex
-bool
-str
-tuple
-...

Elemi:
-int
-float
-complex
-bool

Összetett:
-string
-tuple
-list
-dictionary
-set
'''

#Dinamikus típuskezelés

#n = input("Give a number: ")
#n = int(input("Give a number: "))
#n = 10
'''print(n)
print(n*3)
print(type(n))
print(isinstance(n,int))
'''
#Típusátjárás

'''print(int(3.1415))
print(int(2.9999))
print(tuple("szia"))'''

#Heterogén adatszerkezetek

'''data = list([1, "2025", "hello", 3.1415, 1 + 3j, [27], {1,2,3,"text"}, (1,),13])
print(type(data[0]))
print(type(data[1]))
print(type(data[2]))
print(type(data[3]))
print(type(data[4]))
print(type(data[5]))
print(type(data[6]))
print(type(data[7]))
print(type(data[8]))'''

#Műveletek

'''
Alap aritmetika
+, -, /, %, *, //, **

Összehasonlítás
==, !=, <, >, <=, >=

Logikai
or, and, not

Műveleti sorrend!
'''

#Alap adatstruktúra műveletek

'''
Set:
-set.add()
-set.remove()
-x in set

Dictionary:
-dict["name"]
-dict.items()
-dict.keys(),dict.values()

Tuple:
-unpacking
t = (1,2,3)
a,b,c = t
print(a,b,c)

List:
-slicing
-copying
-lst.append(x)
-lst.count(x)
-lst.pop(x)
-lst.sort()
-lst.remove(x)
-lst.insert(i,x)

String:
-s.count(x)
-"".join()
-s.lower()
-s.upper()
-s.split(x)
'''

#Konvenciók
'''
Változónév nem kezdődhet számmal
Csak alfanumerikus karakterek és aláhúzás
Különbség kis és nagybetű között
Beszédes változónevek
'''

a = {1,2,3}
b = {3,4,5}

#print(set.union(a,b))

#Hasznos oldalak
#https://www.w3schools.com/python/default.asp
#https://www.geeksforgeeks.org/python/python-programming-language-tutorial