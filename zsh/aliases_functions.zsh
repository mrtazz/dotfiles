# helper function to reload gpg agent if it gets stuck
function reload_gpg_agent() {
  killall gpg-agent
  gpg-agent --daemon
}

# this lets me cd into a directory and open tmux via the `mx` script in there
function tmux_in_directory() {
  local dir="${1}"
  (cd "${dir}" && ~/bin/mx)
}

# custom aliases
alias tma='tmux attach -d -t'
alias irc='set_iTerm_title irc;mosh portal.unwiredcouch.com -- tmux attach -d -t werk'
alias mutt='MUTT_IDENTITY=~/.dotoverrides/identity-unwiredcouch /usr/local/bin/mutt'
alias leoric='leoric -I ~/.leoric/macros -s ~/.leoric '
alias tid='tmux_in_directory'
alias knife="nocorrect knife"
alias ack='ag'
alias fcd="cd \$(FZF_DEFAULT_COMMAND='fd --type directory' fzf --height 40%)"
alias grep='grep -R -i --exclude=tags --color=auto'
