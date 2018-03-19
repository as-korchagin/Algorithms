def partition(array, left, right):
    swapped = False
    core = array[left]
    border = left
    for id in range(left + 1, right + 1):
        if array[id] <= core:
            border += 1
            swapped = True
            array[border], array[id] = array[id], array[border]
    array[left], array[border] = array[border], array[left]
    return {"border": border,
            "swapped": swapped}


def quick_sort(array, left, right):
    if left >= right:
        return
    core = partition(array, left, right)
    if not core.get('swapped'):
        return
    quick_sort(array, left, core.get('border') - 1)
    quick_sort(array, core.get('border') + 1, right)


def dots_and_lines(lines, dots):
    print(dots)


if __name__ == "__main__":
    # number_of_lines, number_of_dots = map(int, input().split())
    # lines = list(list(map(int, input().split())) for i in range(number_of_lines))
    # dots = list(map(int, input().split()))
    # dots_and_lines(lines, dots)
    arr = [5, 7, 2, 5, 8, 9, 223, 6, 5, 6, -1]
    quick_sort(arr, 0, 10)
    print(arr)
