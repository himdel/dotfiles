#!/bin/sh
cd "`dirname "$0"`"

for dir in */; do
  cd "$dir"
  echo "$dir"
  if [ -d .git ]; then
    git reset --hard
    git up
  fi
  cd ..
done
