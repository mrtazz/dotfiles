# this is needed because by default SHELL=/bin/bash even after changing the
# default shell thus making tmux start bash
export SHELL=/bin/zsh

# github go proxy setup
export GOPROXY=https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct
export GOPRIVATE=
export GONOPROXY=
export GONOSUMDB=github.com/github/*
