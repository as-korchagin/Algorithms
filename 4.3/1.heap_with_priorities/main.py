#  <StartHeader> ********************************************************************
#
#  Script implements a Max Heap algorithm
#
#  Project Name:       <Algorithms>
#  Language:           <Python>
#  </EndHeader> *********************************************************************

import re


class Heap:

    # ------------------------------------------------------------------------------
    # @brief new                                      - creates a new Heap object
    #
    # @return                                         - returns created heap object
    # ------------------------------------------------------------------------------

    def __init__(self):
        self.heap = [0]

    # ------------------------------------------------------------------------------
    # @brief walkUp                              - raises the last appended element
    #                                              to his place in heap
    # ------------------------------------------------------------------------------

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

    # ------------------------------------------------------------------------------
    # @brief walkDown                            - lowers the element down to his
    #                                              place in heap
    #                                              and removing the biggest one
    # ------------------------------------------------------------------------------

    def walk_down(self):
        if len(self.heap) == 0:
            z = 0
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

    # ------------------------------------------------------------------------------
    # @brief insert                                - inserting an element into heap
    #
    # @param {integer} $element                    - an element that user want to
    #                                                add to heap
    # ------------------------------------------------------------------------------

    def insert(self, element):
        self.heap.append(element)
        if len(self.heap) > 2:
            self.walk_up()

    # ------------------------------------------------------------------------------
    # @brief extractMax                             - searching the biggest element
    #                                                 in heap ($self{'heap'}->[0])
    #
    # @return {integer}                             - the biggest value in heap
    # ------------------------------------------------------------------------------

    def extract_max(self):
        return self.walk_down()


def make_heap(operations):
    heap = Heap()
    for value in operations:
        value = re.findall(r'(\d+)', value)
        if value:
            heap.insert(int(value[0]))
        else:
            heap.extract_max()


if __name__ == "__main__":
    number_of_operations = int(input())
    operations = [input() for _ in range(number_of_operations)]
    make_heap(operations)
