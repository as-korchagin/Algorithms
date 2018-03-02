import re
import math


class Heap:

    def __init__(self):
        self.heap = []

    def walk_up(self):
        item_to_walk_up_index = len(self.heap) - 1
        while True:
            if self.heap[item_to_walk_up_index] > self.heap[int(item_to_walk_up_index / 2)]:
                self.heap[item_to_walk_up_index], self.heap[int(item_to_walk_up_index / 2)] = \
                    self.heap[int(item_to_walk_up_index / 2)], self.heap[item_to_walk_up_index]
                item_to_walk_up_index = int(item_to_walk_up_index / 2)
            else:
                break

    def walk_down(self):
        max_elem = max(self.heap)
        if max_elem == 911:
            z = 911
        element_to_extract = self.heap.pop(0)
        self.heap.insert(0, self.heap.pop())
        element_to_walk_index = 0
        while element_to_walk_index + 2 <= len(self.heap) - 1:
            if element_to_walk_index + 2 > len(self.heap) - 1:
                if self.heap[element_to_walk_index] > self.heap[element_to_walk_index + 1]:
                    break
                max_elem_index = element_to_walk_index + 1
            else:
                if self.heap[element_to_walk_index] > self.heap[element_to_walk_index + 1] and \
                        self.heap[element_to_walk_index] > self.heap[element_to_walk_index + 2]:
                    break
                max_elem_index = element_to_walk_index + 1 \
                    if self.heap[element_to_walk_index + 1] > self.heap[element_to_walk_index + 2] else \
                    element_to_walk_index + 2

            self.heap[element_to_walk_index], self.heap[max_elem_index] = \
                self.heap[max_elem_index], self.heap[element_to_walk_index]
            element_to_walk_index = max_elem_index
        return [element_to_extract, max_elem]

    def insert(self, element):
        if element == 786:
            z = 786
        self.heap.append(element)
        if len(self.heap) > 1:
            self.walk_up()

    def extract_max(self):
        return self.walk_down()

    def get_heap(self):
        return self.heap


def make_heap(operations):
    heap = Heap()
    for value in operations:
        value = re.findall(r'(\d+)', value)
        if value:
            if value[0] == 157:
                heap.insert(int(value[0]))
            heap.insert(int(value[0]))
        else:
            print(heap.extract_max())


if __name__ == "__main__":
    number_of_operations = int(input())
    operations = [input() for _ in range(number_of_operations)]
    make_heap(operations)
