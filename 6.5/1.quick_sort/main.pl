#!/usr/bin/perl
use Data::Dumper;


sub partition {
	my ($arr, $left, $right) = @_;
	my $core = $$arr[$left];
	my $border = $left;
	foreach my $id ($left + 1 .. $right) {
		if ($$arr[$id] <= $core) {
			$border += 1;
			($$arr[$id], $$arr[$border]) = ($$arr[$border], $$arr[$id]);
		}
	}
	($$arr[$left], $$arr[$border]) = ($$arr[$border], $$arr[$left]);
	return $border;
}


sub quick_sort {
	my ($arr, $left, $right) = @_;
	return if $left >= $right;
	my $core = partition($arr, $left, $right);
	quick_sort($arr, $left, $core - 1);
	quick_sort($arr, $core + 1, $right);
}

sub lines_and_dots {

}

$arr = [-6, 9, 0, -4, -9, 8, 9, 4, 0, 9, -4, 4, -6, -3, 0, -10, 6, 5, 8, -9, 6, 10, 5, -7, 7, -2, 7, -2, -4, 4, 4, -10, -9, -7, -8, -10, 3, 8, -5, -2, 3, 8, -7, -8, 4, -4, -8, -7, -8, 0, -4, 0, -5, 6, -7, -5, 6, 10, 7, -8, 1, -1, 2, -7, 7, 10, -4, 2, 3, 9, 9, -1, -8, 2, -2, -2, 0, -3, 2, 0, 0, 10, -3, -5, -4, -9, -7, 7, 9, -8, 10, -7, -6, -6, 5, 9, 0, -7, 6, -9];
quick_sort($arr, 0, $#{$arr});
print "@{$arr}";