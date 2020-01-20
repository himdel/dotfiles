#!/bin/bash

W=1920
H=1080
left=0
top=0

cmd=(xrandr)
while [ $# -gt 0 ]; do
	output="$1"; shift

	cmd+=( --output "$output" --mode "$W"x"$H" --pos "$left"x"$top" --rotate "normal" )
	left=$((left + W))
done

"${cmd[@]}"
