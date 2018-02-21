from collections import Counter
import heapq


class Leaf:
    def __init__(self, freq, letter):
        self.freq = freq
        self.letter = letter

    def get_freq(self):
        return self.freq

    def get_letter(self):
        return self.letter

    def walk(self, code, prefix):
        code[self.get_letter()] = prefix or '0'

    def __lt__(self, other):
        return self.get_freq() < other.get_freq()


class Node:
    def __init__(self, left_leaf, right_leaf):
        self.left_leaf = left_leaf
        self.right_leaf = right_leaf
        self.freq = left_leaf.get_freq() + right_leaf.get_freq()

    def get_freq(self):
        return self.freq

    def walk(self, code, prefix):
        self.left_leaf.walk(code, prefix + '0')
        self.right_leaf.walk(code, prefix + '1')

    def __lt__(self, other):
        return self.get_freq() < other.get_freq()


def encode(str_to_encode):
    heap = [Leaf(freq, letter) for letter, freq in Counter(str_to_encode).items()]
    heapq.heapify(heap)
    while len(heap) > 1:
        left_leaf = heapq.heappop(heap)
        right_leaf = heapq.heappop(heap)
        heapq.heappush(heap, Node(left_leaf, right_leaf))
    codes = {}
    if heap:
        root = heap[0]
        root.walk(codes, '')
    return codes


if __name__ == "__main__":
    input_str = input()
    codes = encode(input_str)
    encoded_str = ''.join(codes.get(letter) for letter in input_str)
    print(len(Counter(input_str).items()), len(encoded_str))
    for letter in sorted(codes):
        print("{}: {}".format(letter, codes.get(letter)))
    print(encoded_str)
