# helper function to reload gpg agent if it gets stuck
function reload_gpg_agent() {
  killall gpg-agent
  gpg-agent --daemon
}

# custom aliases
alias irc='set_iTerm_title irc;mosh portal.unwiredcouch.com -- tmux attach -d -t werk'
alias mutt='MUTT_IDENTITY=~/.dotoverrides/identity-unwiredcouch /usr/local/bin/mutt'
alias fcd="cd \$(FZF_DEFAULT_COMMAND='fd --type directory' fzf --height 40%)"
alias grep='grep -R -i --exclude=tags --color=auto'
alias cssh='gh cs ssh'
