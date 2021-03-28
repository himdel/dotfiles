#!/usr/bin/env perl
use v5.14;
use Carp;

my $VIM='/usr/bin/vim';

# /a/foo (or b) -> GIT_ROOT/foo
sub gitfind {
	$_ = shift;

	return $_ unless m#^[ab]/#;
	return $_ if -e $_;

	my $f = s#^[ab]/##r;

	for (my $i = 0; $i < 100 ; $i++) {
		my $pfx = ('../' x $i) || './';
		if (-d ($pfx . '.git')) {
			return($pfx . $f);
		}
	}

	carp "gitfind: $_ not found";
	return ();
}

my @a = map { /^(.*):(\d+)(:.*)?$/ ? ($1, "+$2") : $_ } @ARGV;
@a = map { gitfind $_ } @a;

exec ($VIM, @a);
