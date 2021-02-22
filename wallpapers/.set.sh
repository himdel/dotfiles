#!/bin/bash
CMD=hsetroot

if [ `hostname -s` = 'niniel' -a `xrandr | grep ' connected' | wc -l` -eq 1 ]; then
  CMD=/usr/bin/hsetroot
fi

WALL="$1"
fullpath=$(cd "$(dirname "$WALL")" ; pwd)/$(basename "$WALL")

"$CMD" -fill "$WALL"

echo "Wallpaper-Set '$fullpath'" > ~/.fvwm/preferences/LastChoosenWallpaper
