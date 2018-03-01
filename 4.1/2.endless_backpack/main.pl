#!/usr/bin/perl
##  <StartHeader> ********************************************************************
##
##  Script counts maximum price of items that user can put into backpack
##
##  Project Name:       <Algorithms>
##  Language:           <Perl>
##  </EndHeader> *********************************************************************

use strict;
use warnings FATAL => 'all';

#-----------------------------------------------------------------------------------------

# @brief getPrice                                  - counts maximum price of items that
#                                                    can be put into the backpack
#
# @param {integer} $backpack_capacity              - backpack capacity
# @param {array of arrays of integer} @items       - $items[counter]->[0] is item's price
#                                                    $items[counter]->[1] is item's volume
#
# @return {string}                                 - maximum price of given items
#-----------------------------------------------------------------------------------------

sub getPrice {

    my ($backpack_capacity, @items) = (shift, @_);
    ((defined $backpack_capacity) && ($backpack_capacity > 0)) or return "Backpack capacity is not specified or it's value <= 0";
    my $capacity_left = $backpack_capacity;
    (@items) or return "Items count cannot be <= 0 ";
    my $total_price = 0;

    eval {
        @items = sort {$b->[0] / $b->[1] <=> $a->[0] / $a->[1]} @items;
    };
    if ($@) {
        return "Wrong input";
    }
    while (@items && $capacity_left > 0) {
        my $item = shift @items;
        if ($item->[1] < $capacity_left) {
            $total_price += $item->[0];
            $capacity_left -= $item->[1];
        }
        else {
            $total_price += ($item->[0] / $item->[1]) * $capacity_left;
            $capacity_left = 0;
        }

    }
    return sprintf "%.3f", $total_price;
}

my $items_and_capacity;
chomp($items_and_capacity = <STDIN>);
my ($items_count, $backpack_capacity) = split(/ /, $items_and_capacity);
my @items;

foreach (0 .. ($items_count - 1)) {
    my $input;
    chomp($input = <STDIN>);
    push @items, [ split(/ /, $input) ]
}

print getPrice($backpack_capacity, @items);