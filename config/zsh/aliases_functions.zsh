# helper function to reload gpg agent if it gets stuck
function reload_gpg_agent() {
  killall gpg-agent
  gpg-agent --daemon
}

# copy a nice link for a github issue/PR to the macos clipboard
function cp_gh_link() {
  gh md link $1 | pbcopy
}


# custom aliases
alias irc='set_iTerm_title irc;mosh portal.unwiredcouch.com -- tmux attach -d -t werk'
alias mutt='MUTT_IDENTITY=~/.config/dotoverrides/identity-unwiredcouch mutt'
alias fcd="cd \$(FZF_DEFAULT_COMMAND='fd --type directory' fzf --height 40%)"
alias ggrep='grep -R -I -i --exclude=tags --color=auto'
alias cssh='gh cs ssh'
