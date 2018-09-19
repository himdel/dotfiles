#!/bin/sh
set -e

cd `dirname $0`

run() {
	WHAT=$1
	NICE=`echo "$1" | sed s/:/./`
	FILE=test."$NICE"

	if bundle exec rake "$WHAT" > $FILE.out 2> $FILE.err ; then
		touch $FILE.pass
	else
		touch $FILE.fail
		exit 1
	fi
}

cd manageiq-ui-classic
run spec
run spec:javascript
run spec:jest
