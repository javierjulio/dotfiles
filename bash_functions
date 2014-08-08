# e.g. countdown 5 'Importing database'
countdown() {
  for (( i=$1; i>0; i--)); do
    printf "\r$2 in $i seconds. Hit any key to continue."
    read -s -n 1 -t 1 key
    if [ $? -eq 0 ]; then
      break
    fi
  done
  echo ''
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

ghwd() {
  if ! git rev-parse --is-inside-work-tree ; then
    open "https://github.com/javierjulio"
    return
  fi
  
  # https://github.com/zeke/ghwd
  # Figure out github repo base URL
  base_url=$(git config --get remote.origin.url)
  base_url=${base_url%\.git} # remove .git from end of string
  
  # Fix git@github.com: URLs
  base_url=${base_url//git@github\.com:/https:\/\/github\.com\/}
  
  # Fix git://github.com URLS
  base_url=${base_url//git:\/\/github\.com/https:\/\/github\.com\/}  
  
  # Find current directory relative to .git parent
  full_path=$(pwd)
  git_base_path=$(cd ./$(git rev-parse --show-cdup); pwd)
  relative_path=${full_path#$git_base_path} # remove leading git_base_path from working directory
  
  # If filename argument is present, append it
  if [ $1 ]; then
    relative_path="$relative_path/$1"
  fi
  
  # Figure out current git branch
  # git_where=$(command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
  git_where=$(command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
  
  # Remove cruft from branchname
  branch=${git_where#refs\/heads\/}
  
  url="$base_url/tree/$branch$relative_path"
  
  open $url
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
