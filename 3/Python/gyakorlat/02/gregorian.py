year = int(input("Year: "))

'''if year < 1582:
    print("Not in Gregorian calendar!")
elif year % 4 != 0:
    print("Nem szökőév!")
elif year % 100 != 0:
    print("Szökőév!")
elif year % 400 != 0:
    print("Nem szökőév!")
else:
    print("Szökőév!")'''

def is_leap_year(year : int) -> bool:
    """Decides if the given year is a leap year or not"""
    return year % 400 == 0 or (year % 4 == 0 and year % 100 != 0)

print(is_leap_year(year))