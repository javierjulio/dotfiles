# ========================================
# Bash and Git Completions
# ========================================

if hash brew &> /dev/null; then
  # https://github.com/mxcl/homebrew/blob/master/Library/Contributions/brew_bash_completion.sh
  . $(brew --repository)/Library/Contributions/brew_bash_completion.sh
fi

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash

  # setup auto complete for git alias "g"
  -complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \ || complete -o default -o nospace -F _git g
fi


# ========================================
# Load and initialize
# ========================================

# Load bash files
# ~/.bash_local can be used for settings you don’t want to commit
for file in exports bash_aliases bash_functions bash_local; do
  file="$HOME/.$file"
  [ -e "$file" ] && source "$file"
done
