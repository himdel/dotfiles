#!/bin/bash
#all temp files
ROUTES=`mktemp`
ALLOWEDMETHODS=`mktemp`
OLD=`mktemp`
NEW=`mktemp`

#in miq get routes
bundle exec rake routes | ag "\s#*([\S]+)$" -o | ag '(?<=#).*' -o > "$ROUTES"
echo "routes DONE"

#in miq-ui
cd ..
cd manageiq-ui-classic
echo "moved to miq-ui-classic"

if [[ -n $0 ]]; then
  git checkout $0
  bin/update
fi
ruby  /Users/zita/Desktop/all.rb > "$ALLOWEDMETHODS"
sed -i "" '/^\*/ d' "$ALLOWEDMETHODS"

echo "extra methods DONE"

debride --rails app/ --whitelist "$ROUTES" "$ALLOWEDMETHODS" | cut -d ":" -f1 >  "$OLD"

echo "old possibly dead methods DONE"

if [[ -n $1 ]]; then
  git checkout $1
  bin/update
  ruby  /Users/zita/Desktop/all.rb > "$ALLOWEDMETHODS"
  sed -i "" '/^\*/ d' "$ALLOWEDMETHODS"
  debride --rails app/ --whitelist "$ROUTES" "$ALLOWEDMETHODS" | cut -d ":" -f1 > "$NEW"
  echo "ALL DEFFERENCES"
  diff -Naur "$OLD" "$NEW"
else
  cat "$OLD" | while read line; do
    echo "$line"
  done
fi
