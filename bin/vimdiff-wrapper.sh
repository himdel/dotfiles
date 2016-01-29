#!/bin/sh
[ $# -gt 0 ] && exec /usr/bin/vimdiff "$@"

TMP=`tempfile`
for foo in `git diff --numstat | cut -f3`; do
	git diff "$foo" > "$TMP"
	vim -O "$foo" "$TMP"
done
git status
