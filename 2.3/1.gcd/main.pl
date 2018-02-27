#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
sub get_gcd {
    my ($var1, $var2) = @_;
    my $min = $var1 < $var2 ? $var1 : $var2;
    if ($var1 != $var2 and $min != 0) {
        while ($var1 != 0 and $var2 != 0) {
            if ($var1 >= $var2) {
                $var1 = $var1 % $var2;
            }
            else {
                $var2 = $var2 % $var1;
            }
        }
    }
    return $var1 > $var2 ? $var1 : $var2

}

chomp (my $input = <STDIN>);
print get_gcd(split / /, $input) . "\n";