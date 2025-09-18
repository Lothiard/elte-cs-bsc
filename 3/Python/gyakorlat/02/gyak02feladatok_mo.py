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


if __name__ == "__main__":
    # print("#1")
    # guess_the_number()
    # print("#2")
    # is_leap_year()
    # print("#3")
    # duplicates()
    # print("#4")
    # caesar()
    # print("#5")
    # get_extensions()
    print("#6")
    degree_to_radian()


