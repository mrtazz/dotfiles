# functions and stuff related to OSX's iTerm

function set_iTerm_title() {
  echo -ne "\e]1;${1}\a"
}
