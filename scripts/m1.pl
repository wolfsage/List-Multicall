use strict;
use warnings;

use lib qw(blib/lib blib/arch);

use Time::HiRes qw(gettimeofday);
use List::Multicall qw(multicall);

# 8GB of RAM recommended!!!
my @list =  (1..10_000_000);
my @list2 = (1..10_000_000);
my @list3 = (1..10_000_000);

sub thing {
	$_ *= -1;
}

my ($s1, $s2, $s3, $e1, $e2, $e3);

$s1 = gettimeofday;
multicall(\&thing, @list);
$e1 = gettimeofday;

$s2 = gettimeofday;
thing() for @list2;
$e2 = gettimeofday;

$s3 = gettimeofday;
$_ *= -1 for @list3;
$e3 = gettimeofday;

printf("Multicall: %.02fs\nForsub: %.02fs\nFor: %.02fs\n",
	$e1-$s1,
	$e2-$s2,
	$e3-$s3
);

# Verify all lists changed
if ($list[0] ne '-1') {
	die "List not modified (Got $list[0], expected -1!\n";
}

for my $i (0..$#list) {
	if ($list[$i] ne $list2[$i]) {
		die "Bad: (l1/l2): $list[$i], $list2[$i]\n";
	}
	if ($list[$i] ne $list3[$i]) {
		die "Bad: (l1/l3): $list[$i], $list2[$i]\n";
	}
}

print "Press enter...\n";
<>;
