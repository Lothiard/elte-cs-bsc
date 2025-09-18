def collatz_sequence(n):
    sequence = [n]
    while n != 1:
        if n % 2 == 0:
            n = n // 2
        else:
            n = 3 * n + 1
        sequence.append(n)
    return sequence

if __name__ == "__main__":
    try:
        num = int(input("Enter a positive integer: "))
        if num < 1:
            print("Please enter a positive integer.")
        else:
            seq = collatz_sequence(num)
            print("Collatz sequence:", seq)
    except ValueError:
        print("Invalid input. Please enter a valid integer.")
