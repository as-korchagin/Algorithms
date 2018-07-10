my ($fib_num, $divider) = split ' ', <STDIN>;
my $arr = [0, 1];
my $k = 0;
my $i = 2;
while (1) {
    $k += 1;
    push @$arr, ($$arr[$i-1] + $$arr[$i - 2]) % $divider;
    if ($$arr[$i-1] == 0 && $$arr[$i] == 1) {
        last;
    }
    $i += 1;
}
print $$arr[$fib_num % $k];