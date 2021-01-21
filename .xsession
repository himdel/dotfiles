. ~/.environment
HOSTNAME=`hostname`
#CLAWS_MACHINE="niniel"
#BTSYNC_MACHINE=yavanna
#WM=fvwm-crystal
WM=i3

xrdb -merge ~/.Xresources
xset -b
xset r rate 180 80
#setxkbmap -option grp:switch,grp:alts_toggle,grp_led:scroll,grp:alt_shift_toggle,compose:lwin us,cz
setxkbmap -option grp:switch,grp:alts_toggle,grp_led:scroll,compose:lwin us,cz

#sonata &
#gdeskcal --first-day=7 &
fbxkb &
#pidgin &
#xbattbar -c &
#x11vnc -forever &
#temptray.py &

#if [ "yavanna" = "$HOSTNAME" ]; then
#	GEOM_NCMPC="102x52+3+30"
#	GEOM_ALSA="63x24-3-30"
#fi
#if [ "nienna" = "$HOSTNAME" ]; then
#	GEOM_NCMPC="80x55+3-32"
#	GEOM_ALSA="80x24-3-30"
#	GEOM_TODO="51x22+588+65"
#fi
#if [ "mjollnir" = "$HOSTNAME" ]; then
#	GEOM_NCMPC="80x24+6+35"
#	GEOM_ALSA="80x24-6-35"
#	GEOM_TODO="80x24+508+35"
#	GEOM_AUTOSAVE="80x24+272-35"
#fi
#if [ "yggdrasil" = "$HOSTNAME" ]; then
#	WM=awesome
#fi
#rxvt-unicode -name DesktopTerm -geometry "$GEOM_NCMPC" -internalBorder 10 -e ncmpc &
#rxvt-unicode -name DesktopTerm -geometry "$GEOM_ALSA" -internalBorder 10 -e alsamixer -g &
#rxvt-unicode -name DesktopTerm -geometry "$GEOM_TODO" -internalBorder 10 -e vim TODO."$HOSTNAME" &
#rxvt-unicode -name DesktopTerm -geometry "$GEOM_AUTOSAVE" -internalBorder 10 -e autosave &

# synclient TapButton1=1
# task_track &
# skype &
# adesklets &
# conky
# wicd-client &
# xcompmgr -n &
# fatrat
# ffkill &
# smart-notifier &
# habak -ms -hi /home/himdel/wallpapers/ -mS -hi ~/pic.RAND/braille.png
# gdesklets start --translucent --no-tray-icon
# chromium &
# xflux -l 49.5 -g 15.5 &

[ -f ~/.xmodmaprc ] && xmodmap ~/.xmodmaprc &
[ -f ~/.xbindkeysrc ] && xbindkeys &

#[ "$CLAWS_MACHINE" = "$HOSTNAME" ] && claws-mail &
#[ "$BTSYNC_MACHINE" = "$HOSTNAME" ] && btsync
#[ "yavanna" = "$HOSTNAME" ] && trayer --edge top --align right --margin 220 --widthtype request --transparent true --tint black &
#[ "yavanna" = "$HOSTNAME" ] && sh -c 'echo 1024x768 > .res'

#[ -x /usr/bin/dropbox ] && dropbox start

#( sleep 2 ; konversation ) &

#xrandr --output DP2 --auto

# disable mouse buttons 8 & 9
xmodmap -e 'pointer = 1 2 3 4 5 0 0 0 0 0 0 0 0'

# druhy memcached kvuli cfme
#memcached -p 11212 -l 127.0.0.1 -d

#[ -x /usr/bin/qasmixer ] && qasmixer --tray &

[ -x /usr/bin/pulseaudio ] && pulseaudio -D &
[ -x /usr/bin/pasystray ] && pasystray &
[ -x /usr/bin/pnmixer ] && pnmixer &

[ -x ~/bin/pushbullet-thing ] && ~/bin/pushbullet-thing &

xrandr --auto
[ -x ~/.screenlayout/detect.sh ] && ~/.screenlayout/detect.sh
~/wallpapers/.random.sh

[ -x /usr/bin/redshift ] && redshift -l 49.19522:16.60796 &

#i3-traycmds &

xsetroot -cursor_name arrow # X_cursor

[ -f ~/.barrier.conf ] && barriers --name `hostname` --enable-crypto -c ~/.barrier.conf --address :24800 &
[ -f ~/.barrier.ip ] && barrierc --name `hostname` --enable-crypto `cat ~/.barrier.ip` &

# disable screen blanking
xset s noblank
# xset -dpms
# xset dpms 0 0 0

exec "$WM"
