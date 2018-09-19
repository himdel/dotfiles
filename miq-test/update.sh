#!/bin/sh
set -e

cd `dirname $0`

cd manageiq
git reset --hard
git checkout master
git fetch --all --prune
git merge --ff-only origin/master
cd -

cd manageiq-ui-classic
git reset --hard
git checkout master
git fetch --all --prune
git merge --ff-only origin/master
cd -

( cd manageiq ; bin/update )
( cd manageiq-ui-classic ; bundle update )
