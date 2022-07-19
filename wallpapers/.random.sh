#!/bin/bash
cd "$(dirname "$0")"

WALL=$( randomfile . --exclude=.mp4,.webm )

./.set.sh "$(pwd)"/"$WALL"
