#!/bin/sh
SIZE=256x256
LIMIT=10

convert -resize $SIZE'!' "$1" tmp.a.jpg
convert -resize $SIZE'!' "$2" tmp.b.jpg

compare -verbose -metric mae tmp.a.jpg tmp.b.jpg tmp.diff.jpg 2> tmp.mae

num=` grep all: tmp.mae | perl -nE '/\(([\d.]+)\)/ && say int($1 * 100)' `

rm -f tmp.a.jpg tmp.b.jpg tmp.diff.jpg tmp.mae

if [ "$num" -le "$LIMIT" ]; then
	echo "OK($num): $1 $2"
	return 0
else
	echo "BAD($num): $1 $2"
	return 1
fi
