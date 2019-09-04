#!/usr/bin/perl
# git log --decorate=short | release-log.pl [<stop_tag>]
# <stop_tag> - stop before processing this tag

use v5.20;
use List::MoreUtils qw(uniq);

my $stop = shift @ARGV if @ARGV;
my $repo = $ENV{REPO} || "ManageIQ/ui-components";

my @bzs = ();
my @merges = ();
my $tag = "(unreleased)";

sub output {
    say("$tag");
    for my $merge (sort @merges) {
        say("    $repo#$merge");
    }
    say("") if +@bzs && +@merges;
    for my $bz (uniq(sort @bzs)) {
        say("    $bz");
    }
    say("") if +@bzs + @merges;

    @merges = ();
    @bzs = ();
}

while (<>) {
    # parse commit line for tags
    if (/^commit/) {
        if (/[(,] *tag: (.*?)[,)]/) {
            output() if +@merges + @bzs;
            $tag = $1;

            last if $tag eq $stop;
        }
        next;
    }

    # output merges
    if (/Merge pull request \#(\d+)/) {
        push @merges, $1;
    }

    # output BZs
    if (/http[^ ]*bugzilla.redhat.com[^ ]*\d+/) {
        push @bzs, $&;
    }
}
