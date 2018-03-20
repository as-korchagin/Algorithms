def partition(array, left, right):
    core = array[left]
    border = left
    for id in range(left + 1, right + 1):
        if array[id] <= core:
            border += 1
            array[border], array[id] = array[id], array[border]
    array[left], array[border] = array[border], array[left]
    return border


def quick_sort(array, left, right):
    if left >= right:
        return
    core = partition(array, left, right)
    quick_sort(array, left, core - 1)
    quick_sort(array, core + 1, right)


def dots_and_lines(lines, dots):
    print(dots)


if __name__ == "__main__":
    number_of_lines, number_of_dots = map(int, input().split())
    lines = list(list(map(int, input().split())) for i in range(number_of_lines))
    dots = list(map(int, input().split()))
    dots_and_lines(lines, dots)
    arr = [-6, 9, 0, -4, -9, 8, 9, 4, 0, 9, -4, 4, -6, -3, 0, -10, 6, 5, 8, -9, 6, 10, 5, -7, 7, -2, 7, -2, -4, 4, 4, -10, -9, -7, -8, -10, 3, 8, -5, -2, 3, 8, -7, -8, 4, -4, -8, -7, -8, 0, -4, 0, -5, 6, -7, -5, 6, 10, 7, -8, 1, -1, 2, -7, 7, 10, -4, 2, 3, 9, 9, -1, -8, 2, -2, -2, 0, -3, 2, 0, 0, 10, -3, -5, -4, -9, -7, 7, 9, -8, 10, -7, -6, -6, 5, 9, 0, -7, 6, -9]
    quick_sort(arr, 0, len(arr) - 1)
    print(arr)
