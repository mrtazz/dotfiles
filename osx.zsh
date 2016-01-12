# this file holds OSX specific configuration and is sourced from zshrc for
# Darwin systems only

# turn off weird ctrl-O behaviour on OSX
stty discard undef

# helper function to show OSX notifications via apple script
#
# Parameters:
#   $1 - Title of the notification
#   $2 - Subtitle of the notification
#   $3 - Message of the notification
function notify {
  local title=${1}
  local subtitle=${2}
  local message=${3}

  local appscript="display notification \"${message}\" with title \"${title}\" subtitle \" ${subtitle}\""

  /usr/bin/osascript -e "${appscript}"
}

