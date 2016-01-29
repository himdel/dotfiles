#!/usr/bin/env perl
# pkg .. a tool to query the package manager and provide responses via terse outputs and exit statuses
# usage: pkg [options] package

# options:
#	-e		package exists; bool; default when no other options provided
#	-i		package installed; bool
#	-v		package version; stdout (but exit 1 unless -i)
# TODO more
#
# bool options use only exit status

use Getopt::Std;

my $opt = {};
getopts("eiv", $opt);

my $pkg = shift;
die "need pkg" unless $pkg;

# -v
grep { print "$1\n" if /^Version:\s*(.+)$/ } `dpkg -s '$pkg' 2>/dev/null` if $opt->{v};

# -i
if ($opt->{i} or $opt->{v}) {
	exit 0 if grep /^Status: install ok installed$/, `dpkg -s '$pkg' 2>/dev/null`;
	exit 1;
}

# -e; is the default
`apt-cache show '$pkg' 2>/dev/null`;
exit 1 if $? >> 8;

exit 0;
