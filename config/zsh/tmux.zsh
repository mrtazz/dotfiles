# tmux related things

# aliases
alias tma='tmux attach -d -t'
alias tmn='tmux new -s $(basename ${PWD})'

# set colors properly
[ -n "$TMUX" ] && export TERM=screen-256color
unset TMUX
