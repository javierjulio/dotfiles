# ========================================
# Shell preferences
# ========================================

export EDITOR=pico

# customize Terminal prompt
# http://osxdaily.com/2006/12/11/how-to-customize-your-terminal-prompt/
# http://www.mactricksandtips.com/2008/10/customizing-the-mac-terminal-bash-prompt.html
# http://sos.blog-city.com/mac_os_x__bash_customize_your_terminal_prompt_a_little_color.htm
export PS1="\[\e[0;36m\]\W:\[\e[0m\] "


# ========================================
# Path settings
# ========================================

if [ -d ~/.bin ]; then
  export PATH=$HOME/.bin:$PATH
fi

if [ -d ~/.node ]; then
  export PATH="$HOME/.node/bin:$PATH"
fi

if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi


# ========================================
# Completions
# ========================================

# git auto complete on tab
source /usr/local/git/contrib/completion/git-completion.bash


# ========================================
# Aliases
# ========================================

source ~/.bash_aliases


# ========================================
# Functions
# ========================================

source ~/.bash_functions


# ========================================
# System specific settings
# ========================================

if [ -f ~/.bash_local ]; then
  source ~/.bash_local
fi
