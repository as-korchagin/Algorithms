use 5.22.1;
use strict;
use warnings;
$|++;

sub fib {
    ($a, $b) = (0, 1);
    if ($_[0] == 0 or $_[0] == 1) {
        return $_[0];
    }
    for (my $i = 0; $i < $_[0]; $i++) {
        ($a, $b) = ($b, $a + $b);
    }
    return $a;
}

for (my $var = 0; $var < 3; $var++){
    chomp(my $fib_num = <STDIN>);
    say fib($fib_num);
}