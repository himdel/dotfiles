#!/bin/bash
cmd='sed -e s/#.*// -e /^$/d'
$cmd ~/.menu | while read ln; do
	lbl=`echo "$ln" | cut -d'	' -f1`
	echo \*ApplicationPanel: \( \\
	echo   1x1, Size 22 22, Icon \"22x22/apps/default.png\" \\
	echo , echo Title \"$lbl\" \\
	echo , Action \(Mouse 1\) Exec exec bash /home/himdel/bin/menu.sh $lbl \\
	echo , Action \(Mouse 3\) Exec exec bash /home/himdel/bin/menu.sh --alt $lbl \\
	echo \)
	echo
done

i=`$cmd ~/.menu | wc -l`
echo SetEnv ApplicationPanelLength $i
