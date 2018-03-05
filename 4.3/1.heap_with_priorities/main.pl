#!/usr/bin/perl
##  <StartHeader> ********************************************************************
##
##  Script implements a Max Heap algorithm
##
##  Project Name:       <Algorithms>
##  Language:           <Perl>
##  </EndHeader> *********************************************************************

use strict;
use warnings FATAL => 'all';

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

            if ($self->{'heap'}->[$item_to_walk_up_index] > $self->{'heap'}->[int($item_to_walk_up_index / 2)]) {
                ($self->{'heap'}->[$item_to_walk_up_index], $self->{'heap'}->[int($item_to_walk_up_index / 2)]) = ($self->{'heap'}->[int($item_to_walk_up_index / 2)], $self->{'heap'}->[$item_to_walk_up_index]);
                $item_to_walk_up_index = int($item_to_walk_up_index / 2);
            }
            else {
                last;
            }
        }
    }

    #------------------------------------------------------------------------------
    # @brief walkDown                            - lowers the element down to his
    #                                              place in heap
    #                                              and removing the biggest one
    #------------------------------------------------------------------------------
    sub walkDown {
        my ($self) = @_;
        my $element_to_walk_index = 1;
        splice @{$self->{'heap'}}, 1, 0, (pop @{$self->{'heap'}});
        while (1) {
            if ($element_to_walk_index * 2 + 1 <= scalar(@{$self->{'heap'}}) - 1) {
                if ($self->{'heap'}->[$element_to_walk_index * 2] > $self->{'heap'}->[$element_to_walk_index] || $self->{'heap'}->[$element_to_walk_index * 2 + 1] > $self->{'heap'}->[$element_to_walk_index]) {
                    my $max_elem_index = $self->{'heap'}->[$element_to_walk_index * 2] > $self->{'heap'}->[$element_to_walk_index * 2 + 1] ? $element_to_walk_index * 2 : $element_to_walk_index * 2 + 1;
                    ($self->{'heap'}->[$element_to_walk_index], $self->{'heap'}->[$max_elem_index]) = ($self->{'heap'}->[$max_elem_index], $self->{'heap'}->[$element_to_walk_index]);
                    $element_to_walk_index = $max_elem_index;
                }
                else {
                    last;
                }
            }
            elsif ($element_to_walk_index * 2 == scalar(@{$self->{'heap'}}) - 1) {
                if ($self->{'heap'}->[$element_to_walk_index] < $self->{'heap'}->[$element_to_walk_index * 2]) {
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
    # @brief extractMax                             - searching the biggest element
    #                                                 in heap ($self{'heap'}->[0])
    #
    # @return {integer}                             - the biggest value in heap
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

}

my $heap = Heap->new();
my $number_of_operations;
my @operations;

chomp($number_of_operations = <STDIN>);

die("You need to input number of operations first") unless ($number_of_operations =~ /(^\d+$)/);

foreach (1 .. $number_of_operations) {
    my $operation;
    chomp($operation = <STDIN>);
    push @operations, $operation;
}

my @max_values;

foreach my $operation (@operations) {
    if ($operation =~ /([A-Za-z]) (\d+$)/) {
        $heap->insert($2);
    }
    elsif ($operation =~ /(^[A-Za-z]+$)/) {
        push @max_values, $heap->extractMin();
    }
    else {
        print "$operation";
        die("Wrong operation input format, see docs");
    }
}

print join "\n", @max_values;