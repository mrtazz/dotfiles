# include rusts cargo bin path in PATH
export PATH=~/.cargo/bin:$PATH
# source overrides (should be the last line)
[ -f ${HOME}/.config/dotoverrides/zshrc ] && source ${HOME}/.config/dotoverrides/zshrc
