# helper function to reload gpg agent if it gets stuck
function reload_gpg_agent() {
  killall gpg-agent
  gpg-agent --daemon
}

# copy a nice link for a github issue/PR to the macos clipboard
function cp_gh_link() {
  gh md link $1 | pbcopy
}

# get some HTTP timings through curl
function curl_with_timings() {
  curl -s -o /dev/null -w " \
    DNS Lookup:      %{time_namelookup}s\n \
    TCP Connect:     %{time_connect}s\n \
    App/TLS Connect: %{time_appconnect}s\n \
    Pre-transfer:    %{time_pretransfer}s\n \
    Start Transfer:  %{time_starttransfer}s\n \
    ----------\n \
    Total Time:      %{time_total}s\n" "${1}"
}

# codespace helper function. If no repo is given or there exists a codespace
# for that repo it runs the ssh selection menu. Otherwise it creates a
# codespace for that repo
function cssh() {
  local repo=${1}

  if [ -z "${repo}"]; then
    gh cs ssh
  else
    existing_codespaces=$(gh cs list --repo ${repo} | wc -l)
    if [ ${existing_codespaces} -neq 0 ]; then
      gh cs ssh
    else
      gh cs create --repo ${repo}
    fi
  fi
}


# custom aliases
alias irc='set_iTerm_title irc;mosh portal.unwiredcouch.com -- tmux attach -d -t werk'
alias mutt='MUTT_IDENTITY=~/.config/dotoverrides/identity-unwiredcouch mutt'
alias fcd="cd \$(FZF_DEFAULT_COMMAND='fd --type directory' fzf --height 40%)"
alias ggrep='grep -R -I -i --exclude=tags --color=auto'
alias v=vim
alias fv='vim $(fzf)'
