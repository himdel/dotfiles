#!/bin/bash
in=$1
out=$2

if [ -z "$out" ]; then
	out="$in".d
fi
mkdir -pv -- "$out"

if echo "$0" | grep -q trim; then
	convert -trim -- "$in" "$out"/layer-%03d.png
else
	convert -set dispose Background -coalesce -- "$in" "$out"/layer-%03d.png
fi

layers=`convert "$in" -format "%[label]" info: | LC_ALL=C perl -npe 'chomp; s/[^ -~]//g; $_ .= "\n"'`
i=0
ls "$out" | while read fn; do
	i=`expr $i + 1`
	convert "$out"/"$fn" -background Transparent -flatten "$out"/_tmp.png
	mv -v "$out"/_tmp.png "$out"/"$fn"
	rename 's/(.*)\./$1-'"$(echo "$layers" | head -n$i | tail -n1)"'./' -v "$out"/"$fn"
done
