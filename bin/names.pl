#!/usr/bin/perl -w
my @files = split /\n/, `ls`;
my $counter = 0;

while (@files and @ARGV) {
	my $file = shift @files;
	my $name = shift @ARGV;
	my $ext = $file; $ext =~ s/^.*\.//;
	printf( "mv -iv '%s' '1x%02d-%s.%s'\n", $file, ++$counter, $name, $ext );
}
