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
export PATH=~/bin:/usr/local/bin:$PATH

export EDITOR="vim"

alias knife="nocorrect knife"

[ -n "$TMUX" ] && export TERM=screen-256color

source ~/.profile
bindkey '^R' history-incremental-search-backward

export LC_ALL=en_US.UTF-8
eval "$(hub alias -s)"

# shell function to graph graphite data via spark
function graphline() {
  if [ ! -n "$1" ]; then print "Usage: $0 metric [minutes]"; return 1; fi
  if [ ! -n "$2" ]; then MINUTES=10 ; else MINUTES=$2; fi
  curl -s "${GRAPHITEHOST}/render?from=-${MINUTES}minutes&target=${1}&format=raw" | cut -d"|" -f 2 | spark ;
}

# todos are stored in simplenote
alias todos='vim -c "Simplenote -l todo"'
alias inbox='vim -c "Simplenote -o agtzaW1wbGUtbm90ZXINCxIETm90ZRjVvJMNDA"'
alias simplenote='vim -c "Simplenote -l"'
alias tma='tmux attach -d -t'
alias irc='mosh batou.unwiredcouch.com -- tmux attach -d -t comm'
alias etsyirc='mosh etsyvm -- tmux attach -d -t comm'

