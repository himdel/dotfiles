#!/bin/bash
D=`dirname "$0"`
for foo in "$@"; do
	n=$(md5sum "$foo" | awk '{print $1}').$(echo "$foo" | perl -npe 'chomp; s/^.*\.//; $_ = lc $_; y[A-Z][a-z]; s/[^a-z0-9]//g')
	mv -v "$foo" "$D"/"$n"
done
