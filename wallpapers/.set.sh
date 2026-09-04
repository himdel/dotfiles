#!/bin/bash

WALL="$1"
hsetroot -fill "$WALL"

cp -a ~/.fvwm/preferences/LastChoosenWallpaper{,~}
fullpath=$(cd "$(dirname "$WALL")" ; pwd)/$(basename "$WALL")
echo "Wallpaper-Set '$fullpath'" > ~/.fvwm/preferences/LastChoosenWallpaper
