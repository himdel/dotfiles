# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

. /etc/profile
export PATH=~/.rbenv/bin:~/bin:~/.local/bin:$PATH:~/.rakudobrew/bin:~/.gopath/bin:~/.perl6/bin:~/.yarn/bin:~/.cargo/bin
. ~/.environment

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=8192
export HISTFILESIZE=16384
export HISTTIMEFORMAT="%F %T  "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# enable color support of ls
if [ -x /usr/bin/dircolors ] && [ "$TERM" != "dumb" ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

ulimit -c unlimited

alias ls='ls --color=tty -N'
alias ll='ls -l'
alias l=ls
alias ltr='ls -ltr'
alias L=less

alias apt='sudo apt'
alias apt-get='sudo apt-get'
alias aptitude='sudo aptitude'

SSHFS="sudo sshfs -o reconnect,allow_other,fsname=sshfs,transform_symlinks,IdentityFile=/home/himdel/.ssh/id_ed25519"
alias mntorome="$SSHFS himdel@orome:/media/ /mnt"

alias xs='sleep 4 ; xset dpms force off'
alias wcat='wget -qO-'

alias Au='apt update'
alias Ap='apt policy'
alias Ai='apt install'

alias UNZIP='set -e; for foo in *.zip; do D=$(echo $foo | sed '\''s/\.zip$//'\''); mkdir -v "$D"; cd "$D"; unzip ../"$foo"; cd .. ; rm -v "$foo"; done; set +e'
alias UNRAR='set -e; for foo in *.rar; do D=$(echo $foo | sed '\''s/\.rar$//'\''); mkdir -v "$D"; cd "$D"; unrar x ../"$foo"; cd .. ; rm -v "$foo"; done; set +e'

function apt-drop {
  for pkg; do _apt-drop "$pkg"; done
}

function _apt-drop {
  F="/var/lib/apt/extended_states"
  if grep -q "^Package: $1$" "$F"; then
    echo '/^Package: '"$1"'$/
    +1
    s/0/1/
    w
    q' | sudo ed "$F"
  else
    sudo sh -c 'echo "Package: '"$1"'" >> "'"$F"\"
    sudo sh -c 'echo "Auto-Installed: 1" >> "'"$F"\"
    sudo sh -c 'echo >> "'"$F"\"
  fi
}

alias ifconfig='sudo ifconfig'

export PERLBREW_ROOT="/home/himdel/.perlbrew"
[ -d "$PERLBREW_ROOT" ] && source "$PERLBREW_ROOT"/etc/bashrc

function Unpack {
  f=~/IN/`ls -tr ~/IN | tail -n1`
  if file "$f" | sed 's/^[^:]*:\s*//' | grep -Eq 'archive|compressed'; then
    CMD=""
    case `basename "$f"` in
      *.bz2|*.tar|*.gz|*.tgz|*.tbz2)
        CMD="tar xvf"
        ;;
      *.zip)
        CMD="unzip"
        ;;
      *.rar)
        CMD="unrar x"
        ;;
    esac

    if [ -z "$CMD" ]; then
      echo "Unpack: wtf is $f"
    else
      $CMD "$f" && rm -v "$f"
    fi
  fi
}

function @ {
  "$BROWSER" "$@" &
}
function g {
  @ "https://encrypted.google.com/search?q=$*"
}
function gl {
  @ "https://encrypted.google.com/search?q=$*&btnI"
}
function im {
  @ "https://encrypted.google.com/search?q=$*&tbm=isch"
}
function wo {
  @ "http://www.wolframalpha.com/input?i=$*"
}
function yt {
  @ "http://www.youtube.com/results?search_query=$*"
}

function brno {
  @ idos.cz/brno/spojeni/\?f="$1"\&t="$2"\&submit=true
}

function vlak {
  @ idos.cz/vlaky/spojeni/\?f="$1"\&t="$2"\&submit=true
}


#alias vimdate="vim `date +%F`"
function vimdate {
  E="$EDITOR"
  if [ -z "$E" ]; then
    E=vim
  fi

  D=
  X=
  if [ $# -eq 1 ]; then
    if echo "$1" | grep -q ^\\. ; then
      X="$1"
    else
      D="$1"/
    fi
  else
    if [ $# -eq 0 ]; then
      D="$1"
    else
      D="$1"/
    fi
    X="$2"
  fi

  F=`date +%F`

  "$E" "$D$F$X"
}

alias vim=vim-wrapper.pl
alias vimdiff=vimdiff-wrapper.sh

alias ifre='sudo ifdown wlan0 ; sleep 0.5 ; sudo killall dhcpcd ; sudo killall wpa_supplicant ; sleep 0.5 ; sudo ifup wlan0'

alias ':q'=exit
alias ':e'="$EDITOR"
complete -cf :e

host="\h"
window_title=""
if [ "$TERM" = "rxvt-unicode-256color" -o "$TERM" = "tmux-256color" ]; then
  window_title="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]"

  [ `hostname` = aule ] && host=`echo -ne '\[\e[38;5;226m\]\h\[\e[0m\]'`
  [ `hostname` = durin ] && host=`echo -ne '\[\e[38;5;40m\]\h\[\e[0m\]'`
  [ `hostname` = lorien ] && host=`echo -ne '\[\e[38;5;34m\]\h\[\e[0m\]'`
  [ `hostname` = niniel ] && host=`echo -ne '\[\e[38;5;160m\]\h\[\e[0m\]'`
  [ `hostname` = orome ] && host=`echo -ne '\[\e[38;5;39m\]\h\[\e[0m\]'`
  [ `hostname` = thror ] && host=`echo -ne '\[\e[38;5;33m\]\h\[\e[0m\]'`
fi
if [ "$TERM" = "rxvt-unicode" ]; then
  window_title="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]"

  [ `hostname` = durin ] && host=`echo -ne '\[\e[38;5;24m\]\h\[\e[0m\]'`
  [ `hostname` = mjollnir ] && host=`echo -ne '\[\e[38;5;14m\]\h\[\e[0m\]'`
  [ `hostname` = nienna ] && host=`echo -ne '\[\e[38;5;22m\]\h\[\e[0m\]'`
  [ `hostname` = niniel ] && host=`echo -ne '\[\e[38;5;48m\]\h\[\e[0m\]'`
  [ `hostname` = thror ] && host=`echo -ne '\[\e[38;5;23m\]\h\[\e[0m\]'`
  [ `hostname` = yavanna ] && host=`echo -ne '\[\e[38;5;40m\]\h\[\e[0m\]'`
  [ `hostname` = yggdrasil ] && host=`echo -ne '\[\e[38;5;5m\]\h\[\e[0m\]'`
fi
colorat='\[`[[ $? -gt 0 ]] && printf "\033[01;31m" || printf "\033[01;32m"`\]@'`echo -ne '\[\e[0m\]'`
export PS1="${window_title}${debian_chroot:+($debian_chroot)}\\u${colorat}${host}:\\w\\$ "
unset host window_title

alias service='sudo service'
alias vo,='vim'
alias v=vim
alias imdb='gl imdb'

export PYTHONDONTWRITEBYTECODE="true"
export PYTHONPYCACHEPREFIX="${HOME}/.cache/python"
mkdir -p "$PYTHONPYCACHEPREFIX"

# alias col1="awk '{ print \$1 }'"
for c in {1..16}; do alias col$c="awk '{ print \$$c }'"; done

alias '@:'='@&:q'

function pvf {
  FS=$( ls -l "$1" | cut -d' ' -f5 )
  shift
  pv -s "$FS" "$@"
}

function vimx {
  touch "$@"
  chmod +x "$@"
  vim "$@"
}

# switch to rv, gem.coop
#if [ -d ~/.rbenv ]; then
#  eval "$(rbenv init -)"
#  export GEMS=~/.rbenv/versions/`cat ~/.rbenv/version`/lib/ruby/gems/*/gems/
#fi

# same as python -mSimpleHTTPServer, but serves utf8
alias httpdir='python -m http.server'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export CHROMIUM_FLAGS='--enable-remote-extensions'
alias netflix='google-chrome-beta https://www.netflix.com/'

alias dmesg='sudo dmesg'

alias altchromium='chromium --user-data-dir=$HOME/.config/altchromium'
alias altfox='firefox --profile $HOME/.config/altfox'

alias pg_dump='pg_dump -Fc'
alias pg_restore='pg_restore -j8'

function movrename {
  rename 's/^(.*?)(\d{4}).*(\....)$/$2-$1/; my $ext = $3; s/[\. ](.)/\u$1/g; s/[\.\(\[\]]$//; s/[^-a-zA-Z0-9]/_/g; s/_$//; s/$/$ext/' -n "$@"
}

# strips BOMs off utf-8 files
alias debom='perl -i -npe s/\\xef\\xbb\\xbf//'

alias ytmp3="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'"

alias ffmpeg="ffmpeg -nostdin"

alias grc='git rebase --continue'
alias gcm='git checkout main'

alias timestamp='date --iso-8601=s | tee -a ~/.timestamp'
alias xunrar='unrar x'

alias otp='otpclient-cli show -sa OATH459230A0'

export FZF_DEFAULT_COMMAND='fdfind . --type f --strip-cwd-prefix --hidden --exclude ".git" --exclude "node_modules"'
export FZF_DEFAULT_OPTS='--border --layout=reverse-list --height=~100% --info=inline'
alias vf='vim `fzf -m | tee /dev/stderr`'
alias cdf='cd $(find . -type d | fzf --preview="tree -C {} | head -n 50")'

if [ -d ~/oci_env ]; then
  OCI_ENV_PATH=`cd ~/oci_env; pwd`
  export OCI_ENV_PATH
fi

alias pip-install='pip3 install --break-system-packages --user --upgrade'

alias gn='headphones off ; sleep 3m; light off; xss; exit'

export JIRA_USERNAME=mhradil@redhat.com
export JIRA_API_TOKEN=`cat ~/.jira.cli 2>/dev/null`
export JIRA_SERVER=https://redhat.atlassian.net
unset JIRA_AUTH_TYPE
export JIRA_AUTH_TYPE
which jira > /dev/null && source <(jira completion bash)
alias jira-me='jira issues list -a $(jira me) -R Unresolved'

alias cal='ncal -b'
alias rg='rg --sort=path'

alias pu='cd ~/pulp-ui'

function aap {
  @ "https://issues.redhat.com/browse/AAP-$1"
}

eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

alias uvr="uv run"
alias uvm="uv run python manage.py"
#alias uvm="uv run --env-file=.env python ./manage.py"

alias ytdlp="yt-dlp --cookies-from-browser chrome:~/.config/google-chrome-beta --js-runtimes node --remote-components ejs:github"

alias ma='cd ~/metrics/awx'
alias md='cd ~/metrics/aap-dev'
alias mg='cd ~/metrics/aap-gateway'
alias mh='cd ~/metrics/handbook-metrics'
alias mhp='cd ~/metrics/handbook-proposals'
alias mhs='cd ~/metrics/handbook-sdp'
alias mi='cd ~/metrics/insights-analytics-collector'
alias mm='cd ~/metrics/metrics-utility'
alias ms='cd ~/metrics/metrics-service'
alias mu='cd ~/metrics/metrics-utility'
alias mn='cd ~/metrics/_notes'

alias kw='kubectl --kubeconfig=/home/himdel/metrics/aap-dev/.tmp/27.kubeconfig get pods -n aap27 -w'
alias kl='kubectl --kubeconfig=/home/himdel/metrics/aap-dev/.tmp/27.kubeconfig logs -n aap27 -f'

alias pqivn='pqiv -n --sort-key=mtime --disable-backends=libav'

export CLAUDE_CODE_USE_VERTEX=1
#export CLOUD_ML_REGION=us-east5
export CLOUD_ML_REGION=global
export ANTHROPIC_VERTEX_PROJECT_ID=your-vertex-project
#export ANTHROPIC_MODEL='claude-sonnet-4@20250514'
#export ANTHROPIC_SMALL_FAST_MODEL='claude-3-5-haiku@20241022'
alias claude='echo claude.work ?' #claude --verbose'

# notes
mkdir -p ~/notes
[ -d ~/notes/.git/ ] || (cd ~/notes; git init .)
alias vn='vim ~/notes/`date +%F`'
function rgn {
  rg "$@" ~/notes/
}

#alias dos='dosbox ~/dos/nc.bat'

export GH_TELEMETRY=false
export DO_NOT_TRACK=true

export HF_TOKEN=`cat ~/.hf.token 2>/dev/null`
export HF_HUB_DISABLE_XET=1
