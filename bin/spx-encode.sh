#!/bin/bash
set -e

while [ $# -ge 1 ]; do
	orig=$1
	new=${orig/%mp3/spx}
	if [ -f "$new" ]; then
		echo "warn: $new already exists, skipping" 1>&2
		shift
		continue
	fi
	tmp=$(mktemp)

	mplayer -vc null -vo null -ao pcm:file="$tmp" -af pan=1:0.5:0.5,format=s16le -srate 32000 "$orig"
	speexenc --vbr "$tmp" "$new"
	rm "$tmp"

	shift
done
