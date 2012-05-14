function trash() {
  if [ -d "$1" ] || [ -e "$1" ]; then
    mv $1 ~/.Trash
  fi
}