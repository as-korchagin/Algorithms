#  <StartHeader> ********************************************************************
#
#  Script implements a binary search algorithm
#
#  Project Name:       <Algorithms>
#  Language:           <Python>
#  </EndHeader> *********************************************************************


# ------------------------------------------------------------------------------
# @brief binarySearch                      - implements binary search algorithm
#
# @param {array_ref} $array                - array with values, in which
#                                            algorithm need to find an index
#                                            of searching value
#
# @param {integer} $value                  - a value which index algorithm
#                                            have to find
#
# @return {integer}                        -index of $value of exist, else -1
# ------------------------------------------------------------------------------
def binary_search(array, value):
    left = 1
    right = len(array) - 1
    while right >= left:
        mean = int((left + right) / 2)
        if array[mean] == value:
            return mean
        elif array[mean] > value:
            right = mean - 1
        else:
            left = mean + 1
    return -1


if __name__ == "__main__":
    first_line = [int(i) for i in input().split()]
    second_line = [int(i) for i in input().split()]
    for i in second_line[1:]:
        print(binary_search(first_line, i), end=' ')
