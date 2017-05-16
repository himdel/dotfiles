#!/bin/sh
cd "`dirname "$0"`"

for dir in */; do
  cd "$dir"
  echo "$dir"
  git up
  cd ..
done
