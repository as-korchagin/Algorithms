import re


class Heap:

    def __init__(self):
        self.heap = [0]

    def walk_up(self):
        item_to_walk_up_index = len(self.heap) - 1
        while True:
            if item_to_walk_up_index == 1:
                break
            if self.heap[item_to_walk_up_index] > self.heap[int(item_to_walk_up_index / 2)]:
                self.heap[item_to_walk_up_index], self.heap[int(item_to_walk_up_index / 2)] = \
                    self.heap[int(item_to_walk_up_index / 2)], self.heap[item_to_walk_up_index]
                item_to_walk_up_index = int(item_to_walk_up_index / 2)
            else:
                break

    def walk_down(self):
        element_to_extract = self.heap.pop(1)
        self.heap.insert(1, self.heap.pop())
        element_to_walk_index = 1
        while True:
            if element_to_walk_index * 2 + 1 <= len(self.heap) - 1:
                if self.heap[element_to_walk_index * 2] > self.heap[element_to_walk_index] \
                        or self.heap[element_to_walk_index * 2 + 1] > self.heap[element_to_walk_index]:

                    max_elem_index = element_to_walk_index * 2 if self.heap[element_to_walk_index * 2] > self.heap[
                        element_to_walk_index * 2 + 1] else element_to_walk_index * 2 + 1

                    self.heap[element_to_walk_index], self.heap[max_elem_index] = \
                        self.heap[max_elem_index], self.heap[element_to_walk_index]
                    element_to_walk_index = max_elem_index
                else:
                    break
            elif element_to_walk_index * 2 == len(self.heap) - 1:
                if self.heap[element_to_walk_index] < self.heap[element_to_walk_index * 2]:
                    self.heap[element_to_walk_index], self.heap[element_to_walk_index * 2] = \
                        self.heap[element_to_walk_index * 2], self.heap[element_to_walk_index]
                else:
                    break
            else:
                break

        return element_to_extract

    def insert(self, element):
        self.heap.append(element)
        if len(self.heap) > 2:
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
            heap.insert(int(value[0]))
        else:
            print(heap.extract_max())


if __name__ == "__main__":
    number_of_operations = int(input())
    operations = [input() for _ in range(number_of_operations)]
    make_heap(operations)
