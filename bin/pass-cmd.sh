#!/bin/sh
P=`~/bin/pass-gui.tcl`
M=`echo -n s4''$P''1t | md5sum | awk '{ print $1 }'`

if [ "$M" = 123 ]; then
	exec $@
fi
