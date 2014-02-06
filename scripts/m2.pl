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
	if (/2/) {
		s/^2/two/;
	}
}

my ($s1, $s2, $s3, $e1, $e2, $e3);

$s1 = gettimeofday;
multicall(\&thing, @list);
$e1 = gettimeofday;

$s2 = gettimeofday;
thing() for @list2;
$e2 = gettimeofday;


$s3 = gettimeofday;
for (@list3) {
	if (/2/) {
		s/^2/two/;
	}
}
$e3 = gettimeofday;

printf("Multicall: %.02fs\nForsub: %.02fs\nFor: %0.02fs\n",
	$e1-$s1,
	$e2-$s2,
	$e3-$s3,
);

# Verify all lists changed
if ($list[1] ne 'two') {
	die "List not modified! (got $list[0], expected 'two')\n";
}

for my $i (0..$#list) {
	if ($list[$i] ne $list2[$i]) {
		die "Bad: $list[$i], $list2[$i]\n";
	}
}

print "Press enter...\n";
<>;
