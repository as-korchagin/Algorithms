#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

sub get_last_fib_digit {
    my ($fib1, $fib2, $fib_num) = (0, 1, shift);
    if ($fib_num == 0 or $fib_num == 1) {
        return $fib_num . "first_block\n";
    }
    for (my $i = 0; $i < $fib_num; $i++) {
        ($fib1, $fib2) = ($fib2 < 10 ? $fib2 : $fib2 % 10, $fib1 + $fib2 <= 9 ? $fib1 + $fib2 : ($fib1 + $fib2) % 10);
    }
    return $fib1;
}


chomp (my $fib_num = <STDIN>);
print get_last_fib_digit($fib_num) . "\n";