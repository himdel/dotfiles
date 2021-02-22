#!/usr/bin/env perl6
use v6;

my @items = $*PROGRAM-NAME ~~ /args/ ?? @*ARGS
         !! $*PROGRAM-NAME ~~ /lines/ ?? lines()
         !! @*ARGS.elems > 0 ?? @*ARGS !! lines();

my $delimiter = $*PROGRAM-NAME ~~ /avg/ ?? @items.elems
             !! $*PROGRAM-NAME ~~ /sum/ ?? 1
             !! die("invalid invocation: $*PROGRAM-NAME missing avg or sum");

sub to_num($item) {
  try {
    return $item.Rat;
  };

  # time conversion - 10:20:30 -> 37230
  if ($item ~~ /^[(\d+)\:]?(\d+)\:(\d+)\n?$/) {
    return ($0 // 0) * 3600 + $1 * 60 + $2;
  }

  # size conversion - 1M -> 1048576
  if ($item ~~ /<[kMGT]>\n?$/) {
    my %table = 'k' => 1024 ** 1, 'M' => 1024 ** 2, 'G' => 1024 ** 3, 'T' => 1024 ** 4;
    return ($/.prematch.Num * %table{ $/.Str }).Int;
  }

  return 0;
}

say(([+] @items.map(&to_num)) / $delimiter);
