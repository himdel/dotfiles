#!/bin/sh
if xrandr-output-connected 'DP2-1' && xrandr-output-connected 'DP2-2'; then
  ~/.screenlayout/eDP1,DP2-2,DP2-1
else
  ~/.screenlayout/eDP1
fi
