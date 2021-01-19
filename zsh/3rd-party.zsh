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

# added by travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

# source overrides (should be the last line)
[ -f ${HOME}/.dotoverrides/zshrc ] && source ${HOME}/.dotoverrides/zshrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dschauenberg/.gcloud/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/dschauenberg/.gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dschauenberg/.gcloud/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/dschauenberg/.gcloud/google-cloud-sdk/completion.zsh.inc'; fi
