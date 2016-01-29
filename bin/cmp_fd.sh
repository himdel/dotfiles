#!/bin/sh
SIZE=64x64
LIMIT=10

convert -resize $SIZE'!' "$1" tmp.a.jpg

mkdir -p tmp.b
ls "$2" | while read f; do
	convert -resize $SIZE'!' "$2"/"$f" tmp.b/"$f" || rm -f tmp.b/"$f" || true
done

ls tmp.b | while read f; do
	compare -verbose -metric mae tmp.a.jpg tmp.b/"$f" tmp.diff.jpg 2> tmp.mae

	num=` grep all: tmp.mae | perl -nE '/\(([\d.]+)\)/ && say int($1 * 100)' `

	if [ "$num" -le "$LIMIT" ]; then
		echo "OK($num): $1 $2/$f"
	else
		echo "BAD($num): $1 $2/$f"
	fi
done

rm -rf tmp.a.jpg tmp.b/ tmp.diff.jpg tmp.mae
