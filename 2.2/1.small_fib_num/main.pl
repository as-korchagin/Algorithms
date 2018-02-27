use 5.22.1;
use strict;
use warnings;
$|++;

sub fib {
    my ($fib1, $fib2) = (0, 1);
    if ($_[0] == 0 or $_[0] == 1) {
        return $_[0];
    }
    for (my $i = 0; $i < $_[0]; $i++) {
        ($fib1, $fib2) = ($fib2, $fib1 + $fib2);
    }
    return $fib1;
}

chomp(my $var = <STDIN>);
say fib($var);