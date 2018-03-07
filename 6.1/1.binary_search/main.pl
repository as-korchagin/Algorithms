#!/usr/bin/perl
##  <StartHeader> ********************************************************************
##
##  Script implements a binary search algorithm
##
##  Project Name:       <Algorithms>
##  Language:           <Perl>
##  </EndHeader> *********************************************************************

use strict;
use warnings FATAL => 'all';


#------------------------------------------------------------------------------
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
#------------------------------------------------------------------------------
sub binarySearch {
    my ($array, $value) = @_;
    my $left = 1;
    my $right = scalar(@{$array}) - 1;
    while ($left <= $right) {
        my $mean = int(($left + $right) / 2);
        next unless (defined $array->[$mean]);
        if ($array->[$mean] == $value) {
            return $mean;
        }
        elsif ($array->[$mean] > $value) {
            $right = $mean - 1;
        }
        else {
            $left = $mean + 1;
        }
    }
    return -1;
}

my $first_line;
my $second_line;
chomp($first_line = <STDIN>);
chomp($second_line = <STDIN>);
my @array = split / /, $first_line;
my @values_to_search = split / /, $second_line;
my @result;
foreach (@values_to_search[1 .. $#values_to_search]) {
    push @result, binarySearch(\@array, $_)
}
print join ' ', @result;