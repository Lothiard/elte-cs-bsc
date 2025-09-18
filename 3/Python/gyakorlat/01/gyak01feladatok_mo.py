#I./1.

x = 3.14
y = 10
name = "alma"
t = (1,"egy")
c = 1 + 5j

print(type(x))
print(type(y))
print(type(name))
print(type(t))
print(type(c))

#I./2.

num = int(input("Your number: \n"))
print(f"Doubled: {num*2}")

#I./3.

text = "even"
n = 2
b = True
print(f"{n} is {text} : {b}")

#II./1.

a = int(input("First number: "))
b = int(input("Second number: "))
print(a + b)
print(a - b)
print(a * b)
print(a / b)

#II./2.

width = float(input("Width: "))
height = float(input("Height: "))
print(f"Perimeter: {2*(width+height)}")
print(f"Area: {width*height}")

#II./3.

inp = int(input("Number: "))
if inp % 2 == 0:
    print("Even")
else:
    print("Odd")

#II./4.

cel = float(input("Temp in C°: "))
fah = cel * 9/5 + 32
print(fah)

#III./1.

lst = ["alma","korte","barack","banan"]
print(lst[0])
print(lst[-1])
lst.append("szilva")
print(lst)
lst.remove("alma")
print(lst)

#III./2.

nums = list()
x = int(input("Number: "))
y = int(input("Number: "))
z = int(input("Number: "))
v = int(input("Number: "))
w = int(input("Number: "))
nums.append(x)
nums.append(y)
nums.append(z)
nums.append(v)
nums.append(w)
print(nums)

#III./3.

dict = {"John" : 30,
        "Joe" : 25,
        "Anne" : 40,
        "James" : 20}

max_age = max(dict, key=dict.get)
print(max_age)

#III./4.

eng_to_hun = {"dog" : "kutya",
              "cat" : "macska",
              "wolf" : "farkas",
              "fish" : "hal",
              "bird" : "madar"}

print(eng_to_hun["bird"])

#III./5.

set1 = {1,2,3,4,5}
set2 = {2,4,6,8,10}

print(set.union(set1,set2))
print(set.intersection(set1,set2))
print(set.difference(set1,set2))