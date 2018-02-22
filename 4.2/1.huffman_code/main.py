from collections import Counter
import heapq
import argparse


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


def decode(codes, str_to_decode):
    decoded_str = ''
    tmp_code = ''
    for symbol in str_to_decode:
        tmp_code += symbol
        if codes.get(tmp_code) is not None:
            decoded_str += codes.get(tmp_code)
            tmp_code = ''
    return decoded_str


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-e', '--encode', help="Encodes normal string to Huffman code", action='store_true')
    parser.add_argument('-d', '--decode', help="Decodes Huffman code to normal string", action='store_true')
    args = parser.parse_args()
    if args.decode:
        letter_count, encoded_len = map(int, input().split())
        raw_codes = (input().split(": ") for _ in range(letter_count))
        codes = {code: letter for letter, code in raw_codes}
        print(decode(codes, input()))
    elif args.encode:
        input_str = input()
        codes = encode(input_str)
        encoded_str = ''.join(codes.get(letter) for letter in input_str)
        print(len(Counter(input_str).items()), len(encoded_str))
        for letter in sorted(codes):
            print("{}: {}".format(letter, codes.get(letter)))
        print(encoded_str)
