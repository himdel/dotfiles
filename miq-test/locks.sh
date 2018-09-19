#!/bin/sh
set -e

cd `dirname $0`

rev() {
	DIR=`pwd`
	REPO=`basename $DIR`
	COMMIT=`git rev-parse HEAD`
	DATE=`date --rfc-3339=s | sed -e 's/ /T/' -e 's/+00:00/Z/'`

	FILE=$1
	TARGET=himdel.eu:/var/www/html/miq
	cp -a "$FILE" "$TARGET"/"$FILE"."$REPO"."$COMMIT"."$DATE"
}

(
cd manageiq
rev Gemfile.lock
)

(
cd manageiq-ui-classic
rev Gemfile.lock
rev yarn.lock
)
