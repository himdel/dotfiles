#!/bin/bash
cd "$(dirname "$0")"

WALL=$( cat ~/.fvwm/preferences/LastChoosenWallpaper\~ | cut -d\' -f2 )
./.set.sh "$WALL"
