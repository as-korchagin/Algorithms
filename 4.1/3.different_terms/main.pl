#!/usr/bin/perl
##  <StartHeader> ********************************************************************
##
##  Script finds a maximum number of terms of the entered number and terms themselves
##
##  Project Name:       <Algorithms>
##  Language:           <Perl>
##  </EndHeader> *********************************************************************
use strict;
use warnings FATAL => 'all';


#-------------------------------------------------------------------------------------
# @brief getTerms                             - finds a maximum number of terms of the
#                                               entered number and terms themselves
#
# @param {integer}                            - value which terms this script
#                                               have to find
#
# @return {array of integer}                  - terms or error data
#-------------------------------------------------------------------------------------
sub getTerms {
    my $input_value = shift;
    ($input_value >= 0) or return("Input must be >=0");
    my @terms;
    my $terms_sum = 0;
    my $current = 1;
    until (($terms_sum - $input_value) == 0) {
        $terms_sum += $current;
        if ($terms_sum > $input_value) {
            $terms_sum -= pop @terms;
        }
        push @terms, $current;
        $current += 1;
    }
    return @terms;
}

my $input_value;
chomp($input_value = <STDIN>);
my @terms = getTerms($input_value);
print scalar @terms . "\n";
print "@terms";