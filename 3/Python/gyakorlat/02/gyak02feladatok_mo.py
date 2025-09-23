# 1
def is_leap_year_helper(year):
    if year < 1582:
        return None
    if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
        return True
    return False

def is_leap_year():
    try:
        year = int(input("Please enter a year: "))
        result = is_leap_year_helper(year)
        if result is None:
            print("The specified year is not within the Gregorian calendar period!")
        elif result:
            print("Leap year")
        else:
            print("Not a leap year")
    except ValueError:
        print("Invalid input. Please enter a valid integer year.")

# 2
import random

def guess_the_number():
    number_to_guess = random.randint(1, 100)
    print("I'm thinking of a number between 1 and 100.")

    while True:
        try:
            guess = int(input("Please enter your guess: "))
        except ValueError:
            print("Invalid input. Please enter an integer.")
            continue

        if guess > number_to_guess:
            print("Lower")
        elif guess < number_to_guess:
            print("Higher")
        else:
            print("Congratulations! You guessed the correct number.")
            break

# 3
def duplicates():
    lst = [1, 2, 1, 2, 3, 3, 2, 1, 2, 4, 5, 13, 5, 6]
    print(list(dict.fromkeys(lst)))

# 4
def caesar():
    original = str(input("Enter a string: "))
    encoded = ""
    for letter in original:
        encoded += (chr(ord(letter) + 1))

    print(encoded)

# 5
from collections import Counter

def get_extensions():
    files = ["py.py", "py.py.txt", "hello.docx", "music.json", "names.txt", "doctor_x.xlsx", "voorhees.json"]
    extensions = []

    for file in files:
        start = file.rfind('.')
        extensions.append(file[start:])

    counts = Counter(extensions)
    print(counts)

    # culture shock as a cpp dev:
    # to throw out duplicates you just convert to a set, like wtf
    #   print(set(extensions))

# 6
import math

def degree_to_radian():
    degree = float(input("Enter degree: "))
    print(math.radians(degree))

# 7
def degree_adder():
    total_degrees = 0
    def add_and_print(degrees):
        nonlocal total_degrees
        total_degrees += degrees
        radians = math.radians(total_degrees) % (2 * math.pi)
        print(radians)
    return add_and_print

# 8
def jaccard(A, B):
    intersection = len(A & B)
    union = len(A | B)
    if union == 0:
        return 1.0
    return intersection / union

# 9
def fibonacci(n):
    if n <= 0:
        return []
    fib = [0, 1]
    while len(fib) < n:
        fib.append(fib[-1] + fib[-2])
    return fib[:n]

# 10
def matrix_elements():
    matrix = [[1, 2, 3], [4, 5, 6,], [7, 8, 9]]
    print([elem for row in matrix for elem in row])

if __name__ == "__main__":
    print("#1")
    guess_the_number()

    print("#2")
    is_leap_year()

    print("#3")
    duplicates()

    print("#4")
    caesar()

    print("#5")
    get_extensions()

    print("#6")
    degree_to_radian()

    print("#7")
    adder = degree_adder()
    adder(90)
    adder(360)

    print("#8")
    a = {1, 2, 3}
    b = {2, 3, 4}
    print(jaccard(a, b))

    print("#9")
    n = int(input("Enter n: "))
    print(f"Tthe first {n} fibonacci numbers are: {fibonacci(n)}")

    print("#10")
    matrix_elements()

    print("#11")
    quicksort = lambda lst: lst if len(lst) <= 1 else quicksort([x for x in lst[1:] if x < lst[0]]) + [lst[0]] + quicksort([x for x in lst[1:] if x >= lst[0]])
    print(quicksort([3, 1, 4, 1, 5, 9, 2, 6]))

    print("#12")
    import sys
    print(sys.getsizeof(range(10**10000)))
    print(sys.getsizeof(list(range(10**7))))
    print(sys.getsizeof(4))
    print(sys.getsizeof(256))
    print(sys.getsizeof(257))
    print(sys.getsizeof(100000))
    print(sys.getsizeof(2147483648))
    print(sys.getsizeof(9999999999999))
    print(sys.getsizeof(6.0))
    print(sys.getsizeof(""))
    print(sys.getsizeof("a"))
    print(sys.getsizeof([]))
    print(sys.getsizeof(["a"]))
    print(sys.getsizeof([1, 2, 3]))
    print(sys.getsizeof([1, 2, 3, 4]))
    print(sys.getsizeof(set()))
    print(sys.getsizeof(dict()))
    print(sys.getsizeof(tuple()))
    print(sys.getsizeof((1,)))
    print(sys.getsizeof(True))
    print(sys.getsizeof(None))


