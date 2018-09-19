#!/bin/sh
set -e

cd `dirname $0`

./update.sh

if ./test.sh; then
  ./locks.sh pass
else
  ./locks.sh fail
fi
