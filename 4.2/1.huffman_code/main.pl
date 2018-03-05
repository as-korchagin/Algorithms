#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use 5.010;

$|++;

##  <StartHeader> ********************************************************************
##
##  Package implements a Min Heap algorithm
##
##  Project Name:       <Algorithms>
##  Language:           <Perl>
##  </EndHeader> *********************************************************************
package Heap; {

    #------------------------------------------------------------------------------
    # @brief new                                      - creates a new Heap object
    #
    # @return                                         - returns created heap object
    #------------------------------------------------------------------------------
    sub new() {
        my ($class) = @_;
        my $self = {};
        push @{$self->{'heap'}}, (0);
        bless $self, $class;
        return $self
    }

    #------------------------------------------------------------------------------
    # @brief walkUp                              - raises the last appended element
    #                                              to his place in heap
    #------------------------------------------------------------------------------
    sub walkUp {
        my ($self) = @_;
        my $item_to_walk_up_index = scalar(@{$self->{'heap'}}) - 1;
        while (1) {
            if ($item_to_walk_up_index == 1) {
                last
            }

            if ($self->{'heap'}->[$item_to_walk_up_index] < $self->{'heap'}->[int($item_to_walk_up_index / 2)]) {
                ($self->{'heap'}->[$item_to_walk_up_index], $self->{'heap'}->[int($item_to_walk_up_index / 2)]) = ($self->{'heap'}->[int($item_to_walk_up_index / 2)], $self->{'heap'}->[$item_to_walk_up_index]);
                $item_to_walk_up_index = int($item_to_walk_up_index / 2);
            }
            else {
                last;
            }
        }
    }

    #------------------------------------------------------------------------------
    # @brief walkDown                              - lowers the element down to his
    #                                                place in heap
    #                                                and removing the smallest one
    #------------------------------------------------------------------------------
    sub walkDown {
        my ($self) = @_;
        my $element_to_walk_index = 1;
        splice @{$self->{'heap'}}, 1, 0, (pop @{$self->{'heap'}});
        while (1) {
            if ($element_to_walk_index * 2 + 1 <= scalar(@{$self->{'heap'}}) - 1) {
                if ($self->{'heap'}->[$element_to_walk_index * 2] < $self->{'heap'}->[$element_to_walk_index] || $self->{'heap'}->[$element_to_walk_index * 2 + 1] < $self->{'heap'}->[$element_to_walk_index]) {
                    my $min_elem_index = $self->{'heap'}->[$element_to_walk_index * 2] < $self->{'heap'}->[$element_to_walk_index * 2 + 1] ? $element_to_walk_index * 2 : $element_to_walk_index * 2 + 1;
                    ($self->{'heap'}->[$element_to_walk_index], $self->{'heap'}->[$min_elem_index]) = ($self->{'heap'}->[$min_elem_index], $self->{'heap'}->[$element_to_walk_index]);
                    $element_to_walk_index = $min_elem_index;
                }
                else {
                    last;
                }
            }
            elsif ($element_to_walk_index * 2 == scalar(@{$self->{'heap'}}) - 1) {
                if ($self->{'heap'}->[$element_to_walk_index] > $self->{'heap'}->[$element_to_walk_index * 2]) {
                    ($self->{'heap'}->[$element_to_walk_index * 2], $self->{'heap'}->[$element_to_walk_index]) = ($self->{'heap'}->[$element_to_walk_index], $self->{'heap'}->[$element_to_walk_index * 2]);

                }
                else {
                    last;
                }
            }
            else {
                last;
            }
        }
    }

    #------------------------------------------------------------------------------
    # @brief extractMin                             - searching the smallest element
    #                                                 in heap ($self{'heap'}->[0])
    #
    # @return {integer}                             - the smallest value in heap
    #------------------------------------------------------------------------------
    sub extractMin {
        my ($self) = @_;
        my $element_to_extract = splice @{$self->{'heap'}}, 1, 1;
        unless (scalar(@{$self->{'heap'}}) == 1) {
            $self->walkDown()
        }
        return $element_to_extract;
    }

    #------------------------------------------------------------------------------
    # @brief insert                                - inserting an element into heap
    #
    # @param {integer} $element                    - an element that user want to
    #                                                add to heap
    #------------------------------------------------------------------------------
    sub insert {
        my ($self, $element) = @_;
        push @{$self->{'heap'}}, $element;
        if (scalar(@{$self->{'heap'}}) > 2) {
            $self->walkUp;
        }

    }

    #------------------------------------------------------------------------------
    # @brief getLength                                         - counts heap's size
    #
    # @return                                                  - heap size
    #------------------------------------------------------------------------------
    sub getLength {
        my ($self) = @_;
        return scalar(@{$self->{'heap'}}) - 1;
    }

}


package Node;{

    use overload
        '>' => sub {
            return $_[0]->getFreq() > $_[1]->getFreq();
        },
        '<' => sub {
            return $_[0]->getFreq() < $_[1]->getFreq();
        };

    #------------------------------------------------------------------------------
    # @brief new                                  - creates a new Node object and
    #                                               sets its frequency as the sum
    #                                               of the frequencies of its
    #                                               children
    #
    # @param {List || Node} $left_leaf            - first child element
    #
    # @param {List || Node} $right_leaf           - second child element
    #
    # @return {Node}                              - returns a Node element
    #                                               with two children
    #------------------------------------------------------------------------------
    sub new {
        my ($class, $left_leaf, $right_leaf) = @_;
        my $self = {
            "name"       => "Node",
            "freq"       => $left_leaf->getFreq() + $right_leaf->getFreq(),
            "left_leaf"  => $left_leaf,
            "right_leaf" => $right_leaf
        };
        bless $self, $class;
        return $self;
    }

    #------------------------------------------------------------------------------
    # @brief getFreq                              - gets the frequency of this Node
    #
    # @return {integer}                           - frequency of this Node
    #------------------------------------------------------------------------------
    sub getFreq {
        my ($self) = @_;
        return $self->{'freq'};
    }

    #------------------------------------------------------------------------------
    # @brief walk                               - moves from the root of the tree
    #                                             and sets up codes to letters
    #
    # @param {HASH} $codes                      - reference to hash with letters
    #                                             and their Huffman codes
    #
    # @param {string} $prefix                   - concatenates with previous Node
    #                                             code to make Huffman code
    #------------------------------------------------------------------------------
    sub walk {
        my ($self, $codes, $prefix) = @_;
        $self->{'left_leaf'}->walk($codes, $prefix . '0');
        $self->{'right_leaf'}->walk($codes, $prefix . '1');
    }

}

package Leaf;{

    use overload
        '>' => sub {
            return $_[0]->getFreq() > $_[1]->getFreq();
        },
        '<' => sub {
            return $_[0]->getFreq() < $_[1]->getFreq();
        };

    #------------------------------------------------------------------------------
    # @brief new                                  - creates a new Leaf object and
    #                                               sets its frequency as the sum
    #                                               of the frequencies of its
    #                                               children
    #
    # @param {string} $letter                     - letter in word
    #
    # @param {integer} $freq                      - letter's frequency in word
    #
    # @return {Leaf}                              - returns a Leaf element
    #                                               with frequency and letter
    #------------------------------------------------------------------------------
    sub new {
        my ($class, $letter, $freq) = @_;
        my $self = {
            "name"   => 'Leaf',
            "freq"   => $freq,
            "letter" => $letter
        };
        bless $self, $class;
        return $self;
    }

    #------------------------------------------------------------------------------
    # @brief getFreq                              - gets the frequency of this Node
    #
    # @return {integer}                           - frequency of this Node
    #------------------------------------------------------------------------------
    sub getFreq {
        my ($self) = @_;
        return $self->{'freq'};
    }

    #------------------------------------------------------------------------------
    # @brief walk                               - setting up a code to letter of
    #                                             this Leaf
    #
    # @param {HASH} $codes                      - reference to hash with letters
    #                                             and their Huffman codes
    #
    # @param {string} $prefix                   - concatenates with previous Node
    #                                             code to make Huffman code
    #------------------------------------------------------------------------------
    sub walk {
        my ($self, $codes, $prefix) = @_;
        if ($prefix eq '') {
            $codes->{$self->{'letter'}} = '0'
        }
        else {
            $codes->{$self->{'letter'}} = $prefix;
        }
    }

}

#------------------------------------------------------------------------------
# @brief encode                          - encodes a string to Huffman code
#
# @param {string}                        - string that algorithm have to encode
#------------------------------------------------------------------------------
sub encode {
    my @string_to_encode = @_;
    my %letter_usage;
    my $heap = Heap->new();

    foreach (@string_to_encode) {
        $letter_usage{$_} += 1;
    }
    foreach (keys %letter_usage) {
        $heap->insert(Leaf->new($_, $letter_usage{$_}))
    }
    my $left_leaf;
    my $right_leaf;
    while ($heap->getLength() > 1) {
        $left_leaf = $heap->extractMin();
        $right_leaf = $heap->extractMin();
        $heap->insert(Node->new($left_leaf, $right_leaf));

    }
    my %codes = ();
    my $root = ($heap->{'heap'})->[1];
    $root->walk(\%codes, "");
    print scalar(keys %codes);
    my $encoded_str = '';
    foreach (@string_to_encode) {
        $encoded_str .= $codes{$_};
    }
    print " " . (length $encoded_str) . "\n";
    foreach my $key (sort keys %codes) {
        print "$key: $codes{$key}\n"
    }
    print $encoded_str;
}

sub decode {
    my ($codes, $str_to_decode) = @_;
    my $tmp_str;
    my $decoded_str = '';
    foreach my $digit (split //, $str_to_decode) {
        $tmp_str .= $digit;
        if (defined $codes->{$tmp_str}) {
            $decoded_str .= $codes->{$tmp_str};
            $tmp_str = '';
        }
        else {
            next;
        }
    }
    print $decoded_str;
}

my $input_data;
chomp($input_data = <STDIN>);
my %codes = ();
my ($letters_count, $encoded_str_len) = split / /, $input_data;
foreach (1 .. $letters_count) {
    chomp($input_data = <STDIN>);
    $input_data =~ /(\w): (\d+)/;
    $codes{$1} = $2;
}
%codes = reverse(%codes);
my $str_to_decode;
chomp($str_to_decode = <STDIN>);

decode(\%codes, $str_to_decode);
