use strict;
use warnings;

use Test::More;

use List::Multicall qw(multicall);

my @list = qw(cat dog mouse horse);

sub remove_pests {
	if ($_ eq 'mouse') {
		$_ = "removed_$_";
	}
}

multicall(\&remove_pests, @list);

is_deeply(\@list, [qw(cat dog removed_mouse horse)]);

done_testing;
