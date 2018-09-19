#!/bin/sh
set -e

cd `dirname $0`

git clone https://github.com/ManageIQ/manageiq.git
git clone https://github.com/ManageIQ/manageiq-ui-classic.git

( cd manageiq/bundler.d ; echo "override_gem 'manageiq-ui-classic', :path => File.expand_path('../../manageiq-ui-classic', __dir__)" > Gemfile.dev.rb )
( cd manageiq-ui-classic/spec ; ln -s ../../manageiq . )

sudo apt install ruby-dev libpq-dev libxml2-dev cmake libsqlite3-dev libcurl4-openssl-dev yarn memcached

(
cd manageiq
bundle install --path vendor/bundle/
bin/setup
)

(
cd manageiq-ui-classic
bundle install --path ../manageiq/vendor/bundle/
)

( cd manageiq ; bin/update )
