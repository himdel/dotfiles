#!/bin/sh
# TODO replace by a perl script
# TODO dont scale if last state == current state
# called by /etc/udev/rules.d/90-monitor.rules

[ `id -u` -eq 0 ] && exec su - himdel -c $0
export DISPLAY=:0

date >> /tmp/monitor.log
case `cat /sys/class/drm/card0-VGA-1/status` in
	connected)
		xrandr --output VGA1 --primary
		xrandr --output VGA1 --auto
		xrandr --output VGA1 --same-as LVDS1
		xrandr --output LVDS1 --off
		echo connect >> /tmp/monitor.log
		echo 1280x1024 > ~/.res
	;;
	disconnected)
		grep -q 1024x768 ~/.res && exit 0
		xrandr --output LVDS1 --primary
		xrandr --output LVDS1 --auto
		xrandr --output LVDS1 --scale 1.25x1.334
		echo disconnect >> /tmp/monitor.log
	;;
	*)
		exit 1
	;;
esac
xset dpms force on
sleep 1
sudo chvt 1
sleep 1
sudo chvt 7
# protoze to proste zapomene
xset -b
xset r rate 180 80
setxkbmap -option grp:switch,grp:alts_toggle,grp_led:scroll us,cz
