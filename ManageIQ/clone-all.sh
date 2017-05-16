#!/bin/sh
cd "`dirname "$0"`"

# per_page won't accept more than 100
(
  curl -s 'https://api.github.com/orgs/ManageIQ/repos?per_page=100&page=1' | jq -r '.[] | .clone_url'
  curl -s 'https://api.github.com/orgs/ManageIQ/repos?per_page=100&page=2' | jq -r '.[] | .clone_url'
) | while read url; do
  git clone "$url"
done
