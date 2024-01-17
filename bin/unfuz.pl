#!/usr/bin/env perl
use v5.30;

my $fuzzy = 0;
my $msgstr = 0;
while (<>) {
  # empty line resets
  $fuzzy = 0 if /^$/;
  $msgstr = 0 if /^$/;

  # detect fuzzy
  $fuzzy = 1 if /^#, fuzzy/;

  # skip fuzzy msgid original
  next if /#| msgid/ and $fuzzy;

  # skip fuzzy msgstr
  if ($fuzzy && /^msgstr/) {
    print qq(msgstr ""\n);
    $msgstr = 1;
  }
  next if $msgstr;

  print;
}
