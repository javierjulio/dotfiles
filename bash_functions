# Open Dictionary app with word lookup
function dict () {
  open dict:///"$@"
}

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

function search() {
  searchin . "$@"
}

function searchin () {
  find "$1" -type f -print0 | xargs -0 grep -l "$2"
}

start() {
  local executinglabel="Executing:"
  local yellow="\033[1;33m"
  local cyan="\033[1;36m"
  local reset="\033[0;0m"
  local messagea
  local commanda

  if [ -f ./Procfile.dev ]; then
    messagea="Procfile.dev detected"
    commanda="foreman start -f Procfile.dev"
  elif [ -f ./Procfile ]; then
    messagea="Procfile detected"
    commanda="foreman start"
  elif [ -f ./package.json ]; then
    messagea="NPM app detected"
    commanda="npm start"
  else
    messagea="Could not detect app type, do nothing"
  fi

  echo -e "$yellow$messagea$reset"
  if [ -n "$commanda" ]; then
    echo -e "$cyan$executinglabel$reset $commanda"
    $commanda
  fi
}

# Source (with minor tweaks): http://www.anthonysmith.me.uk/2008/01/08/moving-files-to-trash-from-the-mac-command-line/
function trash() {
  local path
  for path in "$@"; do
    osascript -e "tell application \"Finder\"" -e "delete POSIX file \"${PWD}/$path\"" -e "end tell"
  done
}
