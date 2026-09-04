#!/bin/sh
if xrandr-output-connected 'DP-2-1' && xrandr-output-connected 'DP-2-2'; then
  ~/.screenlayout/set.sh DP-2-1 DP-2-2 eDP-1
else if xrandr-output-connected 'DP-2-2'; then
  ~/.screenlayout/set.sh DP-2-2 eDP-1
else if xrandr-output-connected 'HDMI-2'; then
  ~/.screenlayout/set.sh HDMI-2 eDP-1
else
  ~/.screenlayout/set.sh eDP-1
fi; fi; fi
