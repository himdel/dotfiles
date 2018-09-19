#!/bin/sh
set -e

cd `dirname $0`

cd manageiq-ui-classic
bundle exec rake spec
bundle exec rake spec:javascript
bundle exec rake spec:jest
