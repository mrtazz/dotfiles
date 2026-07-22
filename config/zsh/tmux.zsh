# tmux related things

# aliases
alias tma='tmux attach -d -t'

# tmux helper to attach a session if there is one or start a new one if there
# isn't
function tmx() {
  sessions=$(tmux list-sessions -F '#S' 2>/dev/null)
  if [ -z "${sessions}" ]; then
    # no sessions exist so we create a new one
    tmux new -s $(basename ${PWD})
  else
    session_count=$(echo ${sessions} | wc -l)

    if [ ${session_count} -eq 1 ]; then
      # base case we have one session to attach to
      tmux attach -d
    elif [ ${session_count} -gt 1 ]; then
      # there is more than one session so let's choose one
      chosen_session=$(echo ${sessions} | fzf)
      tmux attach -d -t ${chosen_session}
    else
    fi
  fi
}


# set colors properly
[ -n "$TMUX" ] && export TERM=screen-256color
unset TMUX
