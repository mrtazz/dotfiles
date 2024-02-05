# this is needed because by default SHELL=/bin/bash even after changing the
# default shell thus making tmux start bash
export SHELL=/bin/zsh

# github go proxy setup
# only set github related variables when in an org repo
if [[ "$CODESPACE_NAME" =~ .*"github".* ]]; then
export GOPROXY=https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct
export GOPRIVATE=
export GONOPROXY=
export GONOSUMDB=github.com/github/*
fi
