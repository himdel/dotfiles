# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

. /etc/profile
export PATH=~/.rbenv/bin:~/bin:$PATH:~/.rakudobrew/bin:~/.gopath/bin:~/.perl6/bin:~/.local/bin:~/.yarn/bin
. ~/.environment

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=4096
export HISTFILESIZE=8192
export HISTTIMEFORMAT="%F %T	"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# enable color support of ls
if [ -x /usr/bin/dircolors ] && [ "$TERM" != "dumb" ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias ls='ls --color=tty -N'
alias ll='ls -l'
alias l=ls
alias L=less

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias apt='sudo apt'
alias apt-get='sudo apt-get'
alias aptitude='sudo aptitude'

alias sshim='ssh -X yavanna.himdel.eu'
#alias aisa='ssh xhrad1@aisa.fi.muni.cz'
alias durin='ssh -X 10.8.8.6'
alias niniel='ssh -X 10.8.8.10'
alias thror='ssh -X 10.8.8.14'

SSHFS="sudo sshfs -o reconnect,allow_other,fsname=sshfs,transform_symlinks,IdentityFile=/home/himdel/.ssh/id_dsa"
#alias mntpenny="$SSHFS him@penny:/ /media/penny"
#alias mntluthien="$SSHFS himdel@luthien:/ /media/luthien -o nonempty"
#alias mnthim="$SSHFS him@himdel.mine.nu:/ /media/penny"
#alias mntaisa="$SSHFS xhrad1@aisa.fi.muni.cz: /media/aisa"
#alias mntpb071="$SSHFS xhrad1@aisa.fi.muni.cz:/export/e1/pb071 /media/pb071"
#alias mntpin="$SSHFS himdel@192.168.1.103:/ /media/pindrusenka"

#function susp {
#	echo Suspend in 4 sec...
#	STATUS=`purple-remote getstatus`
#	purple-remote 'setstatus?status=offline'
#	killall sonata
#	sleep 1
#	killall -9 sonata
#	sudo umount /media/tmp
##	sudo ifdown wlan0
##	sudo umount /media/luthien
#	sleep 2
#	mpc pause
#	sync
#	sudo s2ram -f
#	sleep 0.5
##	sudo ifup wlan0
#	echo purple-remote \"setstatus?status=$STATUS\"
##	twitter post 'just started the notebook'
#	mode.rb detect
#	(sonata & exit)
#}
#
function wifi_school {
#	sudo ifdown eth0
#	sudo ifdown eth2
#	sudo killall wpa_supplicant #should really just send a cmd or sth
#	sudo iwconfig eth2 essid wlan_fi
#	sudo iwconfig eth2 txpower auto
#	sudo ifup eth2
	firefox https://fadmin.fi.muni.cz/auth/sit/wireless/login.mpl &
}

function wifi_modules {
	sudo rmmod b43 b44 ssb
	sudo modprobe ndiswrapper
}

function wifi_supp {
	sudo ifdown eth0
	sudo ifdown eth2
	ps -A | grep wpa_supplicant || sudo wpa_supplicant -Dwext -ieth2 -C/var/run/wpa_supplicant &
	#ps -A | grep wpa_supplicant || sudo wpa_supplicant -Dwext -ieth2 -c/etc/wpa_supplicant/wpa_supplicant.conf &
	sudo wpa_gui -p/var/run/wpa_supplicant
	sudo ifup eth2
}

#function popice {
#	sudo ifdown eth0
#	sudo ifdown eth2
#	sudo ip link set eth0 up
#	sudo ip addr add 192.168.114.199 dev eth0
#	sudo ip route add 192.168.114.254/32 dev eth0
#	sudo ip route add default via 192.168.114.254
#	sudo sh -c 'echo "nameserver 62.168.35.129" > /etc/resolv.conf'
#}

#function eth {
#	sudo ifup eth0
#}

alias xs='sleep 4 ; xset dpms force off'
alias ct1='mplayer http://cdn4.nacevi.cz/CT1-High'
alias ct2='mplayer http://cdn4.nacevi.cz/CT2-High'
alias wcat='wget -qO-'

function status {
	if [ "$#" -eq 0 ]; then	
		msg='getstatus'
	else
		msg='setstatus'
	fi
	if [ "$#" -ge 1 ]; then
		msg="$msg?status=$1"
	fi
	msg="$msg&message="
	if [ "$#" -ge 2 ]; then
		msg="$msg$2"
	fi
	purple-remote "$msg"
}

alias q3a=quake3

function umri_pak_sys {
	echo umri_pak_sys
	cd /sys/class/power_supply/C1BC
	while [ $(cat charge_now) -gt 320000 ]; do
		sleep 1m
	done
	cd -
}

function umri_pak_proc {
	echo umri_pak_proc
	cd /proc/acpi/battery/C1BC
	while [ $(grep ^rema state | awk '{ print $3 }') -gt 320 ]; do
		sleep 1m
	done
	cd -
}

function pak_umri {
	if [ -d /proc/acpi/battery/C1BC ]; then
		umri_pak_proc
	else
		umri_pak_sys
	fi
	susp
}

alias scrim='sshim -t screen'
alias scrims='sshim -t /home/him/bin/screens'
#alias xss='for foo in {1..8}; do sleep=$((2 ** $foo)); echo "foo=$foo; sleep=$sleep"; sleep $sleep; xs; done'

alias Au='apt update'
alias Ap='apt policy'
alias As='apt search'
alias Ai='apt install'
alias Ar='apt remove'
alias As='apt source'
alias Ab='apt build-dep'
alias radior='mplayer -cache 8192 http://quark3.video.muni.cz:8000/FSS_ogg-q8.ogg'
alias bax='firefox https://is.muni.cz/auth/el/1421/podzim2009/BAX403/um/'

ulimit -c unlimited

alias dyna='dosbox ~/dyna/dyna.exe'
alias dm2='dosbox ~/dosgames/games/dm2/dm2.bat'
alias mm='dosbox ~/dosgames/games/mm/micro.exe'
alias moo2='dosbox ~/moo2/moo2.bat'
alias atomic='cd /media/luthien/mnt/xp/AtomicBomberman/; wine BM95.EXE; cd -'
#alias game=<<EOG
#ruby -e 'class Array; def pick; x = sort_by{ rand }.first; yield x; end; end; [:dyna, :mm].pick {|i| puts i; p `grep "alias #{i.to_s}" ~/.bashrc | cut -d \\'\'' -f 2 | sh` }'
#EOG
alias UNZIP='set -e; for foo in *.zip; do D=$(echo $foo | sed '\''s/\.zip$//'\''); mkdir -v "$D"; cd "$D"; unzip ../"$foo"; cd .. ; rm -v "$foo"; done; set +e'
alias UNRAR='set -e; for foo in *.rar; do D=$(echo $foo | sed '\''s/\.rar$//'\''); mkdir -v "$D"; cd "$D"; unrar x ../"$foo"; cd .. ; rm -v "$foo"; done; set +e'

function apt-drop {
	for pkg; do _apt-drop "$pkg"; done
}

function _apt-drop {
	F="/var/lib/apt/extended_states"
	if grep -q "^Package: $1$" "$F"; then
		echo '/^Package: '"$1"'$/
		+1
		s/0/1/
		w
		q' | sudo ed "$F"
	else
		sudo sh -c 'echo "Package: '"$1"'" >> "'"$F"\"
		sudo sh -c 'echo "Auto-Installed: 1" >> "'"$F"\"
		sudo sh -c 'echo >> "'"$F"\"
	fi
}
alias ifconfig='sudo ifconfig'
alias rs='wget -c --load-cookies ~/.cookies/rapidshare'
alias picasa="wine ~/.wine/drive_c/Program\ Files/Google/Picasa3/Picasa3.exe"

alias proper_czech='iconv -f utf8 -t cp852//TRANSLIT | iconv -f cp437 -t utf8'
alias cdr='cd "`find -maxdepth 1 -type d | perl -e '\''srand; @_ = sort { rand() <=> rand() } <>; print $_[0];'\''`"'

alias bumprace='bumprace -w -s -n -t -o'
#alias bzr='bzrgit bzr'
#alias git='bzrgit git'
#alias svn='bzrgit svn'
#alias hg='bzrgit hg'

#function hawking {
#	(
#	while [ $# -gt 0 ]; do
#		echo "($1)"
#		shift
#	done
#	perl -nE 'BEGIN { $| = 1 } chomp; s/"/\\"/g; s/’/'\''/g; say "(SayText \"$_\")"'
#	) | festival
#}

export PERLBREW_ROOT="/home/himdel/.perlbrew"
[ -d "$PERLBREW_ROOT" ] && source "$PERLBREW_ROOT"/etc/bashrc

#export LANG=en_US.UTF-8
#export LC_COLLATE=C

MOTD=~/.motd
if [ -e "$MOTD" ]; then
	cat "$MOTD"
	echo -en '\e[37m'
	echo vim "$MOTD"
	echo -en '\e[0m'
fi
#if [ -d ~/.notes.d ]; then
#	echo
#	notes
#	echo
#fi
#if which jrnl 2>&1 >/dev/null; then
#	echo jrnl:
#	jrnl -n5 -short
#fi

function Unpack {
	f=~/IN/`ls -tr ~/IN | tail -n1`
	if file "$f" | sed 's/^[^:]*:\s*//' | grep -Eq 'archive|compressed'; then
		CMD=""
		case `basename "$f"` in
			*.bz2|*.tar|*.gz|*.tgz|*.tbz2)
				CMD="tar xvf"
				;;
			*.zip)
				CMD="unzip"
				;;
			*.rar)
				CMD="unrar x"
				;;
		esac

		if [ -z "$CMD" ]; then
			echo "Unpack: wtf is $f"
		else
			$CMD "$f" && rm -v "$f"
		fi
	fi
}

#alias @="$BROWSER"
function @ {
	"$BROWSER" "$@" &
}
function g {
	@ "https://encrypted.google.com/search?q=$*"
}
function gl {
	@ "https://encrypted.google.com/search?q=$*&btnI"
}
function im {
	@ "https://encrypted.google.com/search?q=$*&tbm=isch"
}
function wo {
	@ "http://www.wolframalpha.com/input?i=$*"
}
function yt {
	@ "http://www.youtube.com/results?search_query=$*"
}
alias fb="@ https://www.facebook.com"
alias rea="@ https://theoldreader.com/posts/all"
alias grd=rea
alias ismuni="@ https://is.muni.cz/auth"
alias is="@ https://is.mendelu.cz/auth/student/moje_studium.pl?lang=cz"

alias wb="@ http://www.wolframalpha.com/input?i=brno+weather"
alias lfm="@ http://www.last.fm/user/himdel"
alias em="@ https://email.seznam.cz"
alias mai="@ https://mail.google.com"

function red {
	if [ $# -eq 0 ]; then
		@ https://www.reddit.com
	else
		while [ $# -ge 1 ]; do
			@ https://www.reddit.com/r/$1
			shift
		done
	fi
}

function brno {
	@ idos.cz/brno/spojeni/\?f="$1"\&t="$2"\&submit=true
}

function vlak {
	@ idos.cz/vlaky/spojeni/\?f="$1"\&t="$2"\&submit=true
}

alias ltr='ls -ltr'

#alias vimdate="vim `date +%F`"
function vimdate {
	E="$EDITOR"
	if [ -z "$E" ]; then
		E=vim
	fi

	D=
	X=
	if [ $# -eq 1 ]; then
		if echo "$1" | grep -q ^\\. ; then
			X="$1"
		else
			D="$1"/
		fi
	else
		if [ $# -eq 0 ]; then
			D="$1"
		else
			D="$1"/
		fi
		X="$2"
	fi

	F=`date +%F`

	"$E" "$D$F$X"
}

alias vim=vim-wrapper.pl
alias vimdiff=vimdiff-wrapper.sh

alias trek='mpl -R -fs /l/{tos,tas,tng,ds9,voy,ent}'
alias ifre='sudo ifdown wlan0 ; sleep 0.5 ; sudo ifup wlan0'

function gn {
	. ~/.gn
	# cpu down
	sudo bash -c 'echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
	sudo bash -c 'echo userspace > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor'
	sudo bash -c "echo $FREQ > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed"
	sudo bash -c "echo $FREQ > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed"

	# fix volume, play music
	echo $VOL1 | sed 's/^/set /' | amixer -s
	mpc play

	# volume up for mplayer; xss
	(
		sleep 6
		echo $VOL2 | sed 's/^/set /' | amixer -s
	) &
	rxvt -e bash -c 'xttitle xss ; sleep 15 ; xss' &

	# play, wait and sleep
	if echo "$@" | egrep -q '^-|^/'; then
		# absolute path or a param, generic mpl
		mpl "$@"
	else
		# relpath, assuming nowshow
		mpl -ss=30 -R1 /l/nowshow/"$@"
	fi
	sleep 1h
	$SUSP && susp

	## wakeup
	# cpu up
	sudo bash -c "echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
	sudo bash -c "echo ondemand > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor"

	# cleanup
	wait
}

alias ':q'=exit
alias ':e'="$EDITOR"
complete -cf :e

#alias ack='ack-grep'

host="\h"
window_title=""
if [ "$TERM" = "rxvt-unicode-256color" ]; then
	echo "Using 256color rxvt :(" 1>&2
fi
if [ "$TERM" = "rxvt-unicode" ]; then
	window_title="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]"

	[ `hostname` = mjollnir ] && host=`echo -ne '\[\e[38;5;14m\]\h\[\e[0m\]'`
	[ `hostname` = yavanna ] && host=`echo -ne '\[\e[38;5;40m\]\h\[\e[0m\]'`
	[ `hostname` = nienna ] && host=`echo -ne '\[\e[38;5;22m\]\h\[\e[0m\]'`
	[ `hostname` = yggdrasil ] && host=`echo -ne '\[\e[38;5;5m\]\h\[\e[0m\]'`
	[ `hostname` = niniel ] && host=`echo -ne '\[\e[38;5;48m\]\h\[\e[0m\]'`
	[ `hostname` = durin ] && host=`echo -ne '\[\e[38;5;24m\]\h\[\e[0m\]'`
	[ `hostname` = thror ] && host=`echo -ne '\[\e[38;5;23m\]\h\[\e[0m\]'`
fi
#export PS1=' `if [ $? -eq 0 ]; then echo -e "\e[32m:)\e[0m"; else echo -e "\e[31m:(\e[0m"; fi` C:${PWD//\//\\\}>'
export PS1="${window_title}${debian_chroot:+($debian_chroot)}\\u@${host}:\\w\\$ "
unset host window_title

alias mysql='mysql --user=root --default-character-set=utf8'
alias mysqldump='mysqldump --user=root'
alias l=ls

alias service='sudo service'
alias vo,='vim'

export PYTHONDONTWRITEBYTECODE="true"
alias v=vim

function rt {
	if [ $# -eq 1 ] && echo "$1" | perl -ne 'exit 1 if /[^\d\s]/; exit 0'; then
		@ 'rt.matesova.cz/Ticket/Display.html?id='"$1"
	else
		/usr/bin/rt "$@"
	fi
}

alias imdb='gl imdb'
alias vncustredna='vncviewer -bgr233 -quality 0 10.230.0.14'
alias vncjanca='vncviewer -bgr233 -quality 0 192.168.1.100'
alias wakejanca='wakeonlan  -i 192.168.2.4 BC:AE:C5:AE:D1:3C'
alias psql-lepsiobec='psql lepsiobec lepsiobec -h localhost'
alias psql-selfaudit='psql selfaudit -U root -h localhost'
alias composer='composer.phar'

# alias col1="awk '{ print \$1 }'"
for c in {1..16}; do alias col$c="awk '{ print \$$c }'"; done

alias '@:'='@&:q'

function pvf {
	FS=$( ls -l "$1" | cut -d' ' -f5 )
	shift
	pv -s "$FS" "$@"
}

function vimx {
	touch "$@"
	chmod +x "$@"
	vim "$@"
}

alias gdrive='gdocs.sh'
alias docker='sudo docker'
alias minecraft="java -jar ~/.minecraft/launcher.jar"
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias vmdb='cd ~/manageiq/vmdb || cd ~/manageiq'
alias phinx='~/wrk/prihlasky/vendor/bin/phinx'

function bugz {
	id="$1"
	if [ -n "$id" ]; then
		bugzilla query -fb "$id"
	else
		bugzilla query --product="Red Hat CloudForms Management Engine" --bug_status=NEW,ASSIGNED,ON_DEV --outputformat="%{id} %{status} %{severity}:%{priority} %{summary}" --assigned_to=mhradil | ~/bin/bzcolors
	fi
}

eval "$(rbenv init -)"
export GEMS=~/.rbenv/versions/`cat ~/.rbenv/version`/lib/ruby/gems/*/gems/
shopt -s globstar

# same as python -mSimpleHTTPServer, but serves utf8
alias httpdir='python -c "import SimpleHTTPServer; m = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map; m[''] = 'text/plain'; m.update(dict([(k, v + ';charset=UTF-8') for k, v in m.items()])); SimpleHTTPServer.test();"'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function bj {
	url=${1:-7642919332}
	chromium --no-sandbox --app="https://redhat.bluejeans.com/$url"
}

alias berc="(cd ~/manageiq ; be bin/rails c)"
alias bers="(cd ~/manageiq ; SKIP_TEST_RESET=1 SKIP_AUTOMATE_RESET=1 WEBPACK_EXCLUDE_NODE_MODULES=1 bin/update ; be bin/rails s)"
alias berS="(cd ~/manageiq ; be bin/rails s)"
alias .berS="be bin/rails s"
alias suis="(cd ~/manageiq-ui-service ; yarn start)"

export CHROMIUM_FLAGS='--enable-remote-extensions'
alias netflix='google-chrome-beta https://www.netflix.com/'

alias dmesg='sudo dmesg'
alias mcedit='(cd ~/mcedit; . ENV/bin/activate ; ./mcedit.py )'

# ruby2.5 - disable inverted stacktrace
# alias ruby="rc -c 'ruby $* |[2] cat'"

alias miq='cd ~/manageiq'
alias miqui='cd ~/manageiq-ui-classic'
alias miqsui='cd ~/manageiq-ui-service'
alias miquic='cd ~/ui-components'
alias miqapi='cd ~/manageiq-api'

alias factorio='~/.steam/steam/steamapps/common/Factorio/bin/x64/factorio'
alias steam-wine='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe'

alias altchromium='chromium --user-data-dir=$HOME/.config/altchromium'

#alias screenshot='sleep 1 ; xwd | convert xwd:-'
#alias screenrec='recordmydesktop --on-the-fly-encoding --v_bitrate 2000000'

function screenrec {
	out="$1"
	[ $# -ne 1 ] && out=`date +%Y%m%d%H%M%S`.mp4

	x=0
	y=0
	w=1920
	h=1080
	slop -f '%x %y %w %h' | (
		read x y w h
		ffmpeg -video_size "$w"x"$h" -framerate 25 -f x11grab -i :0.0+"$x","$y" "$out"
	)
}

# alias screenshot='sleep 1 ; xwd | convert xwd:-'
function screenshot {
	out="$1"
	[ $# -ne 1 ] && out=`date +%Y%m%d%H%M%S`.png

	sleep 1
	xwd | convert xwd:- "$out"
}

alias pg_dump='pg_dump -Fc'
alias pg_restore='pg_restore -j8'

function movrename {
	rename 's/^(.*?)(\d{4}).*(\....)$/$2-$1/; my $ext = $3; s/[\. ](.)/\u$1/g; s/[\.\(\[\]]$//; s/[^-a-zA-Z0-9]/_/g; s/_$//; s/$/$ext/' -n "$@"
}

# light <on|off>
alias light='wemo switch "WeMo Insight"'

# strips BOMs off utf-8 files
alias debom='perl -i -npe s/\\xef\\xbb\\xbf//'

alias ytmp3="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'"
