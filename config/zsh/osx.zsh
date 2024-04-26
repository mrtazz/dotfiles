# this file holds OSX specific configuration and is sourced from zshrc for
# Darwin systems only

# make sure homebrew bin is in PATH. This is only the location on arm macs but
# I don't run any intel macs anymore, so this should be fine.
export PATH=/opt/homebrew/bin:$PATH

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

