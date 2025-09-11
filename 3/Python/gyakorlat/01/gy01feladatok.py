# 1
x = 3.14
print(type(x))

# 2
szam = int(input("adj meg egy szamot "))
print(szam*2)

# 3
harmas = ["cica", 123, False]
for vmi in harmas:
    print(vmi, end=" ")
print()

# 4
a = int(input("a = "))
b = int(input("b = "))
print(a + b, a - b, a * b, a / b);

# 5
print("teglalap: ")
print(f"\t terulete: {a * b}")
print(f"\t kerulete: {2 * (a + b)}")

# 6
szam = int(input("Adj meg egy szamot: "));
print(not (szam % 2))

# 7
celsius = int(input("Adj meg vmi celsiust "))
print(celsius * (9 / 5) + 32)

# 8
gyumolcsok = ["alma", "korte", "banan", "nem tudok tobb gyumolcsot"]
print(gyumolcsok[0], gyumolcsok[-1])

gyumolcsok.append("paradicsom")
gyumolcsok.remove("korte")

for gyum in gyumolcsok:
    print(gyum)

# 9
lista = []
sum = 0
for _ in range(5):
    num = int(input("adj meg egy szamot ha kemeny vagy: "))
    lista.append(num)
    sum += num

print(f"Az atlag: {sum / 5}")

# 10
emberek = {
    "lajos" : 59,
    "ivan" : 13,
    "laci" : 96,
    "Zhibo a goat" : 20
}

print(max(emberek, key=emberek.get)) # type: ignore

