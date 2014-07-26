# e.g. countdown 5 'Importing database'
countdown() {
  for (( i=$1; i>0; i--)); do
    printf "\r$2 in $i seconds. Hit any key to continue."
    read -s -n 1 -t 1 key
    if [ $? -eq 0 ]; then
      echo ''
      break
    fi
  done
}

pause_and_prompt_to_continue() {
  read -s -p "Press Enter key to continue..."
  echo ''
}

# Open Dictionary app with word lookup
dict() {
  open dict:///"$@"
}

# Create a new directory and enter it
md() {
  mkdir -p "$@" && cd "$@"
}

executable() {
  chmod +x $@
}

search() {
  searchin . "$@"
}

searchin () {
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
    messagea="Could not detect app type... Looking for Procile or package.json"
  fi

  echo -e "$yellow$messagea$reset"
  if [ -n "$commanda" ]; then
    if [ -f ./config/boot.rb ]; then
      echo "Removing logs..."
      bundle exec rake log:clear
    fi
    
    echo -e "$cyan$executinglabel$reset $commanda"
    $commanda
  fi
}

# with edits: http://www.anthonysmith.me.uk/2008/01/08/moving-files-to-trash-from-the-mac-command-line/
trash() {
  local path
  for path in "$@"; do
    osascript -e "tell application \"Finder\"" -e "delete POSIX file \"${PWD}/$path\"" -e "end tell"
  done
}
