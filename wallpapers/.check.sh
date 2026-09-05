#!/bin/bash
if [ $# != 0 ]; then
    echo syntax: $0 1>&2
    exit 1
fi

cd "`dirname "$0"`"

for f in *; do
  md5sum "$f" | perl -ne 'print unless /^([0-9a-f]{32})\s+\1\./'
done
