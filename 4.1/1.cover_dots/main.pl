#!/usr/bin/perl
##  <StartHeader> ********************************************************************
##
##  Script makes a minimal set of dots that belongs to user's input segments
##
##  Project Name:       <Algorithms>
##  Language:           <Perl>
##  </EndHeader> *********************************************************************

use strict;
use warnings FATAL => 'all';


#-----------------------------------------------------------------------------------------
# @brief  cover                                            - searches minimal set of dots
#
# @param  {array of arrays of integer}  @segments          - user's segments
#
# @return {array}                                          - array of dots || array of
#                                                            errors because of wrong input
#-----------------------------------------------------------------------------------------

sub cover {
    my @segments = @_;
    (@segments) or return qw /"No values given"/;
    my @dots;
    eval {
        @segments = sort {$a->[1] <=> $b->[1]} @segments;
        push @dots, (shift @segments)->[1];
        while (@segments) {
            my $left = (shift @segments)->[0];
            if ($left > $dots[-1]) {
                push @dots, $left;
            }
            else {
                next;
            }
        }
    };
    if ($@) {
        return qw/"Wrong input"/;
    }
    return @dots;
}

my $segment_count;
my @segments;
chomp($segment_count = <STDIN>);
($segment_count > 0) or die "Number of segments must be > 0";
foreach (0 .. ($segment_count - 1)) {
    my $segment;
    chomp($segment = <STDIN>);
    push @segments, [ split(/ /, $segment) ];
}

my @covering_dots = cover(@segments);
print scalar @covering_dots . "\n@covering_dots";