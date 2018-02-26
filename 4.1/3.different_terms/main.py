def get_terms(n):
    terms = []
    terms_sum = 0
    current = 1
    while (terms_sum - n) != 0:
        terms_sum += current
        if terms_sum > n:
            terms_sum -= terms.pop()
        terms.append(current)
        current += 1
    print(len(terms))
    print(*terms)


get_terms(int(input()))
