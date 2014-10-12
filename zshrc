# source all extra config files
ZSHDIR="${HOME}/.zsh"
source ${ZSHDIR}/history.zsh
source ${ZSHDIR}/completion.zsh
source ${ZSHDIR}/look.zsh

# autocorrect
setopt correct_all

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(heroku brew knife)
for plugin ($plugins); do
  fpath=(${ZSHDIR}/$plugin $fpath)
done

# Load and run compinit
autoload -U compinit
compinit -i

HAS_GO=`which go`

if [ -z ${HAS_GO} ]; then
  export GOPATH=$HOME/development/go
  if [ ! -d $GOPATH ] ;then mkdir -p $GOPATH ; fi
  export GOROOT=`/usr/local/bin/go env GOROOT`
fi

# Customize to your needs...
export PATH=~/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/bin:/usr/local/sbin:$PATH

export EDITOR="vim"

alias knife="nocorrect knife"

[ -n "$TMUX" ] && export TERM=screen-256color

source ~/.profile
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# turn off weird ctrl-O behaviour on OSX
if [ "$(uname)" = "Darwin" ]; then
stty discard undef
fi

export LC_ALL=en_US.UTF-8
#eval "$(hub alias -s)"

compdef mosh=ssh

# shell function to graph graphite data via spark
function graphline() {
  if [ ! -n "$1" ]; then print "Usage: $0 metric [minutes]"; return 1; fi
  if [ ! -n "$2" ]; then MINUTES=10 ; else MINUTES=$2; fi
  curl -s "${GRAPHITEHOST}/render?from=-${MINUTES}minutes&target=${1}&format=raw" | cut -d"|" -f 2 | spark ;
}

# function to create a new jekyll post
function create_post() {
  if [ -d ./_posts ]; then
    echo "---\nlayout: post\ntitle: \"$1\"\npublished: true\n---\n\n##[{{page.title}}]({{ page.url }})" > ./_posts/$(date +"%Y-%m-%d")-$(echo $1 | sed 's/[^0-9a-zA-Z]/-/g' | tr '[:upper:]' '[:lower:]').markdown
  fi
}
function create_journal_entry() {
  if [ -d ./_posts/journal ]; then
    cp ./_posts/journal/template.md ./_posts/journal/$(date +"%Y-%m-%d")-entry.md
  fi
}


export GREP_OPTIONS="--exclude=tags --color=auto"
export GREP_COLOR="1;32"
#function ack(){ ARGS=($1 ${2-*}); grep -nRi "${ARGS[@]}" }
alias ack='ag'

unset TMUX

# todos are stored in simplenote
alias tma='tmux attach -d -t'
alias irc='mosh vlad.unwiredcouch.com -- tmux attach -d -t comm'
alias etsyirc='mosh etsyvm -- tmux attach -d -t comm'
alias mutt='MUTT_IDENTITY=unwiredcouch /usr/local/bin/mutt'
alias mutt_home='MUTT_IDENTITY=unwiredcouch /usr/local/bin/mutt'
alias mutt_etsy='MUTT_IDENTITY=etsy /usr/local/bin/mutt'
alias git-tmux='tmux new -s $(basename $(pwd))'
alias notes='vim -c "cd ~/ownCloud/Notebooks" -c "NERDTreeToggle"'

if [ -d ~/.dotfiles/mutt ]; then
  export MUTT_HOME=$HOME/.dotfiles/mutt
else
  export MUTT_HOME=$HOME/.mutt
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
case "$TERM" in
  screen*)
    PROMPT_COMMAND="printf '\033k$(hostname)\033\\';"${PROMPT_COMMAND}
    ;;
esac

which uru_rt &> /dev/null
if [ $? -eq 0 ]; then
  eval "$(uru_rt admin install)"
  uru 1.9.3 > /dev/null
fi

# added by travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

# source overrides (should be the last line)
[ -f ${HOME}/.dotoverrides/zshrc ] && source ${HOME}/.dotoverrides/zshrc
