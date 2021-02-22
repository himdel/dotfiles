#!/bin/bash
if [ "$#" -ge 1 ]; then
	file="$1"
else
	file=`cat ~/.fvwm/preferences/LastChoosenWallpaper | cut -d\' -f2`
fi
if ! [ -e "$file" ]; then
	echo "no files (can't detect wallpaper?)" 1>&2
	exit 1
fi

convert "$file"[0] -resize 25% -colors 16 -unique-colors txt:- | sed 1d | awk '{ print $3 }'
