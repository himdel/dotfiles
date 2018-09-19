#!/bin/sh
set -e

cd `dirname $0`

STATUS="$1"
TARGET=himdel.eu:/var/www/html/miq
DATE=`date --rfc-3339=s | sed -e 's/ /T/' -e 's/+00:00/Z/'`

ssh himdel.eu mkdir -p /var/www/html/miq/"$DATE"."$STATUS"/

rev() {
	DIR=`pwd`
	REPO=`basename $DIR`
	COMMIT=`git rev-parse HEAD`

	FILE=$1
	scp "$FILE" "$TARGET"/"$DATE"."$STATUS"/"$FILE"."$REPO"."$COMMIT"
}

(
cd manageiq
rev Gemfile.lock
)

(
cd manageiq-ui-classic
rev Gemfile.lock
rev yarn.lock

for f in test.* ; do
	rev "$f"
	rm "$f"
done
)
