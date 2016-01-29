#!/usr/bin/env perl
use v5.14;

#start 1st 1375355883 ( 2013-08-01 11:18 )
#stop 1st 1375356155 ( 2013-08-01 11:22 )
#1st: 4m 32s (= 272 )

my $date = undef;
my $time = 0;

while (<>) {
	chomp;

	if (/^start.*(\d{4}-\d{2}-\d{2}).*$/) {
		my $today = $1;
		next if $date eq $today;

		say sprintf("%s\t%d", $date, $time) if $date and $time;
		$date = $today;
		$time = 0;
	}

	if (/=\s*(\d+)/) {
		my $secs = $1;
		$time += $secs if $secs > 60;
	}
}
