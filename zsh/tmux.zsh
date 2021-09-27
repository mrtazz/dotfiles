# tmux related things

# functions
# this lets me cd into a directory and open tmux via the `mx` script in there
function tmux_in_directory() {
  local dir="${1}"
  (cd "${dir}" && tmux new -s ${PWD##*/})
}

# aliases
alias tma='tmux attach -d -t'
alias tid='tmux_in_directory'
alias tmn='tmux new -s $(basename ${PWD})'
