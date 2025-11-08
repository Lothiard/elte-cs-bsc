from functools import reduce


def f1():
    d = {"Adam": 11, "Jerry": 4, "Michael": 45, "Ben": 10}
    print([name for name, value in d.items() if value > 10])


def f2():
    lst = [33, 22, 33, 21, 33, 44, 33, 11, 11, 2, 1]
    s = {33, 22, 45, 47, 42, 52}

    lst_set = set(lst)

    union = lst_set | s
    intersection = lst_set & s
    difference = lst_set - s

    print("Union: ", union)
    print("Intersection: ", intersection)
    print("Difference: ", difference)


def f3(*args):
    print("Lambda nelkul: ", sum(x for x in args if x > 5))
    print("Lambaval: ", (lambda *args: sum(x for x in args if x > 5))(*args))


def f4(list):
    print((lambda list: [s for s in list if len(s) > 5])(list))


def f5(list):
    print((lambda list: reduce(lambda a, b: a if a < b else b, list))(list))


def f6(string):
    print(string[::-1])


def main():
    f1()
    f2()
    f3(33, 22, 33, 21, 33, 44, 33, 11, 11, 2, 1)
    f4(["Egy", "Ketto", "Harom", "Negyothathet"])
    f5([33, 22, 33, 21, 33, 44, 33, 11, 11, 2, 1])
    f6("Never odd or even")


if __name__ == "__main__":
    main()
