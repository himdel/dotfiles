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

md5=`md5sum "$file" | awk '{ print $1 }'`
echo md5 = "$md5"

cd `dirname "$0"`
db=".likes.`hostname -s`.$md5"
echo >> "$db"

echo -n 'likes = '
wc -l .likes.*."$md5" | awk '{ print $1 }' | ( sumlines || cat )
