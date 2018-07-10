def fib(n):
    a = 0
    b = 1
    if n == 1 or n == 0:
        return n
    for _ in range(n):
        a, b = b, a + b
    return a


n, m = map(int, input().split())
k = 0
S = [0, 1]
i = 2
while True:
    S.append((S[i - 1] + S[i - 2]) % m)
    k = k + 1
    if (S[i] == 1) and (S[i - 1] == 0):
        break
    i += 1
print(S[(n % k)])
