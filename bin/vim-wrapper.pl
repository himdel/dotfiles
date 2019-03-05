#!/usr/bin/env perl
use v5.14;
use Carp;
use Data::Dumper;
use File::Globstar qw(globstar);

my $VIM='/usr/bin/vim';

sub gitfind {
	$_ = shift;

	return $_ unless m#^[ab]/# or m#^vmdb/#;
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

sub railsfind {
	$_ = shift;

	return $_ unless m#^([A-Z]\w+)(\#(\w+))?$#;
	return $_ if -e $_;

	my ($class, $func) = ($1, $3);

	my $file = $class;
	$file =~ s/^[A-Z]/\l$&/;
	$file =~ s/[A-Z]/_\l$&/g;
	$file =~ s/$/.rb/;

	my @files = globstar("**/$file");
	if ($func) {
		@files = map { ($_, '+/def ' . $func . '/') } @files;
	}
	return @files;

	carp "railsfind: $_ not found";
	return ();
}

my @a = map { /^(.*):(\d+)(:in)?$/ ? ($1, "+$2") : $_ } @ARGV;
@a = map { gitfind $_ } @a;
@a = map { railsfind $_ } @a;

exec ($VIM, @a);
