# ========================================
# Shell preferences
# ========================================

export EDITOR=pico

# customize Terminal prompt
# http://osxdaily.com/2006/12/11/how-to-customize-your-terminal-prompt/
# http://www.mactricksandtips.com/2008/10/customizing-the-mac-terminal-bash-prompt.html
# http://sos.blog-city.com/mac_os_x__bash_customize_your_terminal_prompt_a_little_color.htm
export PS1="\W: "


# ========================================
# Path settings
# ========================================

# add home bin dir if it exists
if [ -d ~/.bin ]; then
  export PATH=$HOME/.bin:$PATH
fi

# rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# node
if [ -d ~/.node ]; then
  export PATH="$HOME/.node/bin:$PATH"
fi


# ========================================
# Aliases
# ========================================

if [ -e ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi


# ========================================
# Completions
# ========================================

# git auto complete on tab
source /usr/local/git/contrib/completion/git-completion.bash


# ========================================
# Per-machine extras
# ========================================

# system specific settings
if [ -f ~/.bash_local ]; then
  source ~/.bash_local
fi
