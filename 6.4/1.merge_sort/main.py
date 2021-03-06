counter = 0


def merge(merge_item_1, merge_item_2):
    merged = []
    global counter
    item_1_current = 0
    item_2_current = 0
    while len(merged) != (len(merge_item_1) + len(merge_item_2)):
        if item_1_current < len(merge_item_1) and item_2_current < len(merge_item_2):
            if merge_item_1[item_1_current] <= merge_item_2[item_2_current]:
                merged.append(merge_item_1[item_1_current])
                item_1_current += 1
            else:
                counter += 1
                merged.append(merge_item_2[item_2_current])
                item_2_current += 1
        elif item_1_current >= len(merge_item_1):
            merged.append(merge_item_2[item_2_current])
            item_2_current += 1
        else:
            merged.append(merge_item_1[item_1_current])
            item_1_current += 1
    return merged


def merge_sort(array, left, right):
    if left < right:
        median = int((left + right) / 2)
        array[left: right + 1] = merge(merge_sort(array, left, median), merge_sort(array, median + 1, right))
    return array[left: right + 1]


if __name__ == "__main__":
    # array_length = int(input())
    array_length = 5
    # array = list(map(int, input().split()))
    array = [2, 3, 9, 2, 9]
    assert len(array) == array_length, "Array length invalid"
    print(merge_sort(array, 0, array_length - 1))
    print(counter)
