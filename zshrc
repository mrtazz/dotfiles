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

# Customize to your needs...
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

export EDITOR="vim"

alias knife="nocorrect knife"

[ -n "$TMUX" ] && export TERM=screen-256color

source ~/.profile
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
stty discard undef

export LC_ALL=en_US.UTF-8
eval "$(hub alias -s)"

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
    echo "---\nlayout: post\ntitle: \"$1\"\npublished: true\n---\n\n ##[{{page.title}}]({{ page.url }})" > ./_posts/$(date +"%Y-%m-%d")-$(echo $1 | sed 's/ /-/g').markdown
  fi
}


export GREP_OPTIONS="--exclude=tags --color=auto"
export GREP_COLOR="1;32"
function ack(){ ARGS=($1 ${2-*}); grep -nRi "${ARGS[@]}" }

# todos are stored in simplenote
alias todos='vim -c "Simplenote -l todo"'
alias inbox='vim -c "Simplenote -o agtzaW1wbGUtbm90ZXINCxIETm90ZRjVvJMNDA"'
alias simplenote='vim -c "Simplenote -l"'
alias tma='tmux attach -d -t'
alias irc='mosh batou.unwiredcouch.com -- tmux attach -d -t comm'
alias etsyirc='mosh etsyvm -- tmux attach -d -t comm'
alias mutt='MUTT_IDENTITY=unwiredcouch /usr/local/bin/mutt'
alias mutt_home='MUTT_IDENTITY=unwiredcouch /usr/local/bin/mutt'
alias mutt_etsy='MUTT_IDENTITY=etsy /usr/local/bin/mutt'
alias git-tmux='tmux new -s $(basename $(pwd))'

unset TMUX
eval "$(uru_rt admin install)"
uru 1.9.3 > /dev/null
