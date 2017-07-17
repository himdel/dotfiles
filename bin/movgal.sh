#!/bin/sh
set -e

for f in "$@"; do
	DIR=`mktemp -d -p. tmp.movgal.XXXXXXX`
	OUTPUT=`mktemp -up. movgal.XXXXXXX`

	echo "$f" "->" "$OUTPUT" "..."

	# 0.05 = 1/20 .. capture every 20 seconds
	ffmpeg  -i "$f" -r 0.05 -vf scale=-1:120 -vcodec png "$DIR"/capture-%03d.png

	montage -title "$f" -geometry +4+4 "$DIR"/capture*.png "$OUTPUT".png
	echo "$OUTPUT".png

	rm -rf "$DIR"
done
