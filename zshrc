# source all extra config files
ZSHDIR="${HOME}/.zsh"
source ${ZSHDIR}/history.zsh
source ${ZSHDIR}/completion.zsh
source ${ZSHDIR}/look.zsh
source ${ZSHDIR}/iterm.zsh

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

# go setup
export GOPATH=$HOME
export GO15VENDOREXPERIMENT=1

if [ "$(uname)" = "Darwin" ]; then
  source ${ZSHDIR}/osx.zsh
fi

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/texlive/2015/bin/universal-darwin:$PATH

export EDITOR="vim"

alias knife="nocorrect knife"

[ -n "$TMUX" ] && export TERM=screen-256color

source ~/.profile
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

export LC_ALL=en_US.UTF-8

compdef mosh=ssh

export GREP_OPTIONS="--exclude=tags --color=auto"
export GREP_COLOR="1;32"
alias ack='ag'

unset TMUX

# todos are stored in simplenote
alias tma='tmux attach -d -t'
alias irc='set_iTerm_title irc;mosh leviathan.unwiredcouch.com -- tmux attach -d -t werk'
alias mutt='MUTT_IDENTITY=~/.dotoverrides/identity-unwiredcouch /usr/local/bin/mutt'
alias git-tmux='tmux new -s $(basename $(pwd))'
alias notes='vim -c "cd ~/ownCloud/Notebooks" -c "NERDTreeToggle"'
alias leoric='leoric -I ~/.leoric/macros -s ~/.leoric '
alias journal='vim -c Goyo ~/ownCloud/Notebooks/Writing/journal/current.md'

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
  uru system > /dev/null
fi

function tmux_in_directory() {
  local dir="${1}"
  (cd "${dir}" && ~/bin/mx)
}

function reload_gpg_agent() {
  killall gpg-agent
  gpg-agent --daemon
}

# added by travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

# source overrides (should be the last line)
[ -f ${HOME}/.dotoverrides/zshrc ] && source ${HOME}/.dotoverrides/zshrc
