#!/bin/bash
if [ $# != 0 ]; then
    echo syntax: $0 1>&2
    exit 1
fi

cd "`dirname "$0"`"

find -name '.picasa.ini' \
    -o -name '.directory' \
    -o -name '.*.sw[po]' \
    -o -name '.*~' \
    -o -name '.*.???.??????' \
    -o -name '*.pdf' \
| while read bad; do
    rm -v "$bad"
done

chmod -R 'a-x,go-w,a+rX' *

rename 's/(.\.)([A-Za-z0-9]+)$/"$1" . lc($2)/e' -v *
rename 's/(.\.)jpeg$/$1jpg/' -v *
