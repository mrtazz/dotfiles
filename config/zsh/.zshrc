# source all extra config files
ZSHDIR="${HOME}/.config/zsh"
source ${ZSHDIR}/history.zsh
source ${ZSHDIR}/look.zsh
source ${ZSHDIR}/completion.zsh
source ${ZSHDIR}/aliases_functions.zsh
[ -z "$CODESPACES" ] && source ${ZSHDIR}/gpg.zsh
source ${ZSHDIR}/tmux.zsh
source ${ZSHDIR}/path.zsh

if [[ "$OSTYPE" == "darwin"* ]]; then
  source ${ZSHDIR}/osx.zsh
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  source ${ZSHDIR}/freebsd.zsh
fi

# load plugins that I took from oh-my-zsh
plugins=(brew)
for plugin ($plugins); do
  fpath=(${ZSHDIR}/$plugin $fpath)
done

# autocorrect
setopt correct_all

# Load and run compinit
autoload -U compinit
compinit -i

# some basic exports
export EDITOR="vim"
export LC_ALL=en_US.UTF-8

# enable helpful shell shortcuts
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# this makes it so ssh host completion works with mosh
compdef mosh=ssh

export GREP_COLORS="mt=1;32"

# config file setups for rg and bat
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
export BAT_CONFIG_PATH="$HOME/.config/bat/config"

# mutt files are now always in the same place
export MUTT_HOME=$HOME/.config/mutt

# go setup
export GOPATH=$HOME

# source codespaces related things if we are in one
[ -n "$CODESPACES" ] && source ${ZSHDIR}/codespaces.zsh

# source 3rd party setups at the end
source ${ZSHDIR}/3rd-party.zsh
