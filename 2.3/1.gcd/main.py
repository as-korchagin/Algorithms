a, b = map(lambda x: int(x), input().split())
if a == b or min(a, b) == 0:
    pass
else:
    while a != 0 and b != 0:
        if a >= b:
            a = a % b
        else:
            b = b % a
print(max(a, b))
