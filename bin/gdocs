#!/bin/sh
for f in "$@"; do
	out=`google docs upload "$f" 2>&1`
	echo "$out"
	if [ $? -ne 0 ]; then
		echo upload fail 1>&2
		continue
	fi
	url=`echo "$out" | grep 'Direct link:' | sed 's/^.*Direct link://'`

	echo "$url"
	$BROWSER "$url"
done
