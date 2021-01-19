# look and appearance
# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

setopt auto_cd
setopt multios
setopt cdablevarS

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Apply theming defaults
PS1="%n@%m:%~%# "

# Setup the prompt with pretty colors
setopt prompt_subst

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
parse_git_dirty() {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# k8s stuff
_kubectl-installed() {
which kubectl > /dev/null 2>&1
}

function kube_context_prompt() {
  if _kubectl-installed && [ -n "${SHOW_K8S_PROMPT}" ]; then
    echo "[k8s:%{$fg_bold[cyan]%}$(kubectl config current-context)]%{$reset_color%}"
  fi
}

function k8s_toggle_prompt() {
  if [ -z "${SHOW_K8S_PROMPT}" ]; then
    export SHOW_K8S_PROMPT=true
  else
    unset SHOW_K8S_PROMPT
  fi
}

ORIG_PROMPT=$PROMPT
set_prompt() {
  PROMPT="%{$fg_bold[white]%}%2m%{$reset_color%} $(kube_context_prompt) ${ORIG_PROMPT}"
}

PROMPT='%{$fg_bold[red]%}%m%{$reset_color%}:%{$fg[cyan]%}%c%{$reset_color%}%{$fg_bold[green]%}$(git_prompt_info)$(kube_context_prompt)%{$reset_color%}%:%# '

ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}✗%{$fg[green]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}]"

