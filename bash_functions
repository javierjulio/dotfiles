# Open Dictionary app with word lookup
function dict () {
  open dict:///"$@";
}

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# Source (with minor tweaks): http://www.anthonysmith.me.uk/2008/01/08/moving-files-to-trash-from-the-mac-command-line/
function trash() {
  local path
  for path in "$@"; do
    osascript -e "tell application \"Finder\"" -e "delete POSIX file \"${PWD}/$path\"" -e "end tell"
  done
}
