#!/bin/bash
cd "$(dirname "$0")"

WALL=$(randomfile .)

./.set.sh "$(pwd)"/"$WALL"
