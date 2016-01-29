#!/bin/bash

if [ -d "$1" ]; then
	cd "$1"
	shift
fi

if ! [ -d .git ]; then
	echo "$0 [repo] since [mail]" 1>&2
	echo no git dir in $( /bin/pwd )
	exit 1
fi

since=$1
shift
if [ -z "$since" ] || ! date -d "$since" > /dev/null; then
	echo "$0 [repo] since [mail]" 1>&2
	exit 2
fi

if [ $# -lt 1 ]; then
	git log --format=format:'%ae' --since="$since" | sort -u
else
	mail=$1
	git log --format=format:'%h %ae %ai %s' --since="$since" | awk '($2 == "'$mail'") { print }' | tac | while read line; do
		ref=$( echo $line | awk '{ print $1 }' )
		stat=$( git log --format=format:%h --numstat "$ref" -1 | sed 1d | awk 'BEGIN{ plus = 0; minus = 0 }; { plus += $1; minus += $2 }; END { print "="(plus - minus)" +"plus" -"minus }' )
		awk '{ $2="  '"$stat"'\t"; print }' <<< $line
	done
fi
