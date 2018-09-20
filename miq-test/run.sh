#!/bin/bash
set -e

cd `dirname $0`

export PATH=~/.rbenv/bin:~/bin:$PATH:~/.yarn/bin
export NVM_DIR="$HOME/.nvm"

(
eval "$(rbenv init -)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

./update.sh

if ./test.sh; then
  ./locks.sh pass
else
  ./locks.sh fail
fi
)
