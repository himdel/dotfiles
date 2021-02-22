#!/bin/bash
if [ $# != 1 ]; then
	echo syntax: $0 target_dir 1>&2
	echo "  wallpapers/.sync ../other_wallpapers" 1>&2
	echo "  wallpapers/.sync other_host:wallpapers" 1>&2
	exit 1
fi

if grep -q : <<< "$1"; then
	SSH=true
else
	SSH=false
fi

if $SSH; then
	cd "$1"
	TARGET=`/bin/pwd`
	cd -
else
	TARGET="$1"
fi

cd "`dirname "$0"`"

$SSH && ./.clean.sh

RSYNC_OPT='-aPvu'
rsync $RSYNC_OPT "$TARGET"/ ./
rsync $RSYNC_OPT ./ "$TARGET"/

./.clean.sh
$SSH || ( [ -x "$TARGET/.clean.sh" ] && "$TARGET"/.clean.sh )
