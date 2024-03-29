# history settings
HISTFILE=$HOME/.config/zsh/history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt inc_append_history
setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
