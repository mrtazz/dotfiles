### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
case "$TERM" in
  screen*)
    PROMPT_COMMAND="printf '\033k$(hostname)\033\\';"${PROMPT_COMMAND}
    ;;
esac

# source overrides (should be the last line)
[ -f ${HOME}/.dotoverrides/zshrc ] && source ${HOME}/.dotoverrides/zshrc
