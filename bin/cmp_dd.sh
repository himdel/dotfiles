#!/bin/sh
SIZE=64x64
LIMIT=10

mkdir -p tmp.a
ls "$1" | while read f; do
	convert -resize $SIZE'!' "$1"/"$f" tmp.a/"$f" || rm -f tmp.a/"$f" || true
done

mkdir -p tmp.b
ls "$2" | while read f; do
	convert -resize $SIZE'!' "$2"/"$f" tmp.b/"$f" || rm -f tmp.b/"$f" || true
done

ls tmp.a | while read af; do
	echo "$af" 1>&2
	ls tmp.b | while read bf; do
		compare -verbose -metric mae tmp.a/"$af" tmp.b/"$bf" tmp.diff.jpg 2> tmp.mae

		num=` grep all: tmp.mae | perl -nE '/\(([\d.]+)\)/ && say int($1 * 100)' `

		if [ "$num" -le "$LIMIT" ]; then
			echo "OK($num)	$1/$af	$2/$bf"
		fi
	done
done

rm -rf tmp.a/ tmp.b/ tmp.diff.jpg tmp.mae
