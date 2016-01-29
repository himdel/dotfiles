#!/usr/bin/env perl
use v5.20;
use HTML::Entities;
use Iterator::Diamond;

die "need args ( js or css )" if ! @ARGV;
die "must be in index.html dir" unless -f 'index.html';

my @html = ();

for my $arg (@ARGV) {
	if ($arg !~ /\.(js|css)$/i) {
		say STDERR "not a js/css file, skipping: $arg";
		continue;
	}
	my $html_arg = encode_entities($arg);

	if ($1 eq 'js') {
		push @html, "<script src=\"$html_arg\"></script>";
	} elsif ($1 eq 'css') {
		push @html, "<link rel=\"stylesheet\" href=\"$html_arg\">";
	}
}

my $index_html = Iterator::Diamond->new( edit => '~', files => [ 'index.html' ] );

my $state = "";	# head, done
my $tab = "\t";

while ( <$index_html> ) {
	chomp;

	if ($state eq "") {
		$state = 'head' if /<\s*head\s*>/i;
	}

	if ($state eq "head") {
		$tab = $1 if /^(\s*)<\s*(link|script)/i;

		if (/<\s*\/(head)\s*>/i or /<!--[^>]*(local)[^>]*-->/i) {
			for (@html) {
				print $tab;
				say $_;
			}
			say "" if $1 =~ /local/i;

			$state = 'done';
		}
	}

	#if ($state eq "done") {
	#}

	say $_;
}

system(' diff -Naur index.html~ index.html ; rm index.html~ ');
