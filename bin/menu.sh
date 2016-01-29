#!/bin/bash
n=2
if [ $1 = "--alt" ]; then
	shift
	n=3
fi

lbl="$1"
cmd=`grep "^$lbl	" ~/.menu | cut -d'	' -f$n`
echo urxvt -e $cmd | sh
