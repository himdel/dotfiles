#!/usr/bin/perl
# called by /etc/udev/rules.d/90-monitor.rules
use v5.14;

# TODO maybe figure out a way to authorize root for the display
sub ensure_root {
	return if $> == 0;
	exec("su - himdel -c $0");
}

# TODO either enum for all displays or figure out the right one
sub set_dislay {
	my $display = shift // ":1";
	$ENV{DISPLAY} = $display;
}

sub log {
	my $status = shift // "unknown";
	system("echo `date`: $status >> /tmp/monitor.log");
}

sub status {
	`cat /sys/class/drm/card0-VGA-1/status`;
}

	connected)
		xrandr --output VGA1 --primary
		xrandr --output VGA1 --auto
		xrandr --output VGA1 --same-as LVDS1
		xrandr --output LVDS1 --off
		echo connect >> /tmp/monitor.log
	;;
	disconnected)
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
