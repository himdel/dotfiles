#!/usr/bin/env perl6
use v6;

my @items = $*PROGRAM-NAME ~~ /args/ ?? @*ARGS
         !! $*PROGRAM-NAME ~~ /lines/ ?? lines()
         !! @*ARGS.elems > 0 ?? @*ARGS !! lines();

my $delimiter = $*PROGRAM-NAME ~~ /avg/ ?? @items.elems
             !! $*PROGRAM-NAME ~~ /sum/ ?? 1
             !! die("invalid invocation: $*PROGRAM-NAME missing avg or sum");

say(([+] @items) / $delimiter);
