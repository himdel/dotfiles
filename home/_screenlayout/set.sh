#!/bin/bash

W=1920
H=1080
left=0
top=0

cmd=(xrandr)
while [ $# -gt 0 ]; do
	output="$1"; shift

	HH="$H"
	if [ $output = 'HDMI-2' ]; then HH=2160; fi
	# TODO WW=1920 or 3840, depending on actual available modes

	cmd+=( --output "$output" --mode "$W"x"$HH" --pos "$left"x"$top" --rotate "normal" )
	left=$((left + W))
done

"${cmd[@]}"
