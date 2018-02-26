def fib(n):
    a = 0
    b = 1
    for j in range(1, n + 1):
        a, b = b if b < 10 else b % 10, a + b if a + b <= 9 else (a + b) % 10
    return a


def main():
    print(fib(int(input())))


if __name__ == "__main__":
    main()
