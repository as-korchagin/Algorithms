use 5.22.1;
use strict;
use warnings;
$|++;


sub fib {
    my ($fib1, $fib2, $fib_num) = (0, 1, shift);
    if ($fib_num == 0 or $fib_num == 1) {
        return $fib_num;
    }
    for (my $i = 0; $i < $fib_num; $i++) {
        ($fib1, $fib2) = ($fib2, $fib1 + $fib2);
    }
    return $fib1;
}


my $var = '';
chomp($var = <STDIN>);
print fib($var) . "\n";