# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="mrtazz"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git heroku brew knife)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=~/bin:$PATH

export EDITOR="vim"

alias knife="nocorrect knife"

[ -n "$TMUX" ] && export TERM=screen-256color

source ~/.profile

export LC_ALL=en_US.UTF-8
eval "$(hub alias -s)"

# shell function to graph graphite data via spark
function graphline() {
  if [ ! -n "$1" ]; then print "Usage: $0 metric [minutes]"; return 1; fi
  if [ ! -n "$2" ]; then MINUTES=10 ; else MINUTES=$2; fi
  curl -s "${GRAPHITEHOST}/render?from=-${MINUTES}minutes&target=${1}&format=raw" | cut -d"|" -f 2 | spark ;
}
