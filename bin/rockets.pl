#!/usr/bin/env perl
use v5.14;

my ($max, $lines, $first);

sub res {
	$max = 0;
	$lines = 0;
	$first = undef;
}
res();

BEGIN {
	say "# perl -i this_output.pl file";
	say "while (<>) {";
}
END {
	say "\tprint;";
	say "}";
}

while (<>) {
	if (/^\s*#.*$/) {
		$lines++ if $lines;
		next;
	}

	unless (/=>/) {
		if ($lines > 1) {
			say("\t", 's/^(.*?)\s*=>/$1 . (" " x (', $max + 1, ' - length($1))) . "=>"/e if ($. >= ', $first, ') && ($. < ', $first + $lines, ');');
		}
		res();

		next;
	}

	/^(.*?)\s*=>/;
	my $text = length($1);

	$max = $text if $text > $max;
	$lines++;
	$first //= $.;
}
