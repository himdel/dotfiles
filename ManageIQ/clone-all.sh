#!/bin/sh
cd "`dirname "$0"`"

TOKEN=""
[ -f ~/.github-tokens.json ] && TOKEN=`jq -r '.clone_all' < ~/.github-tokens.json`
[ -n "$TOKEN" ] && TOKEN="-u "`whoami`:"$TOKEN"

# per_page won't accept more than 100
(
  curl $TOKEN -s 'https://api.github.com/orgs/ManageIQ/repos?per_page=100&page=1' | jq -r '.[] | .clone_url'
  curl $TOKEN -s 'https://api.github.com/orgs/ManageIQ/repos?per_page=100&page=2' | jq -r '.[] | .clone_url'
) | while read url; do
  git clone "$url"
done
