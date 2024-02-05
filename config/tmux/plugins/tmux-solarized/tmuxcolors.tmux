#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

theme_option="@colors-solarized"
default_theme="256"

get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value="$(tmux show-option -gqv "$option")"
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

main() {
	local theme="$(get_tmux_option "$theme_option" "$default_theme")"
	tmux source-file "$CURRENT_DIR/tmuxcolors-${theme}.conf"
}
main
