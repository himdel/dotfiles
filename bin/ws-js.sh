#!/bin/sh

WHERE="$@"
if [ -z "$WHERE" ]; then
	WHERE=`find -type f -name \*.js`
fi

perl -i -npe '
	# leading mezery
	s/^((  )+)/"\t" x (length($1) \/ 2)/e;

	# crlf
	s/\r//g;

	# mezera za carkou
	s/\s*,[ \t]*/, /g;

	# trailing spaces
	s/\s*$/\n/;

	# mezera pred {
	s/\s*{$/ {/;

	# mezera za if/while/for/foreach/switch/catch
	s/^(\s*)(if|while|for|foreach|switch|catch)\s*\(/$1$2 (/;
' "$WHERE"
