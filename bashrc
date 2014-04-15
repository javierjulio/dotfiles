# Load bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Load git completion
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
  
  # setup autocomplete for git alias "g"
  -complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \ || complete -o default -o nospace -F _git g
fi

# Load grc (Terminal colorizer)
if [ -f `brew --prefix`/etc/grc.bashrc ]; then
  . `brew --prefix`/etc/grc.bashrc
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
