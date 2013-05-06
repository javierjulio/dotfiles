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

# setup auto complete for git alias "g"
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \ || complete -o default -o nospace -F _git g


# ========================================
# Shell preferences
# ========================================

export EDITOR=pico

codapath="/Applications/Coda 2.app"

if [ -d "$codapath" ]; then
  export EDITOR="$codapath -w"
fi

CYAN='\[\e[0;36m\]'
BLUE='\[\e[0;34m\]'
RED='\[\e[0;31m\]'
YELLOW='\[\e[0;33m\]'
GREEN='\[\e[0;32m\]'
END='\[\e[0m\]' # reset text to default color

# customize Terminal prompt
# http://osxdaily.com/2006/12/11/how-to-customize-your-terminal-prompt/
# http://www.mactricksandtips.com/2008/10/customizing-the-mac-terminal-bash-prompt.html
# http://sos.blog-city.com/mac_os_x__bash_customize_your_terminal_prompt_a_little_color.htm
# For the git branch output: http://markdotto.com/2012/10/18/terminal-hotness/ (Very Buggy)
# export PS1='\e[0:36m\W:\e[m \e[0:33m`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`\e[m'
# http://richardhulse.blogspot.com/2008/06/using-git.html
# http://chakra-linux.org/wiki/index.php/Color_Bash_Prompt
# http://stackoverflow.com/questions/5379986/why-doesnt-my-bash-prompt-update
export PS1="${CYAN}\W:${END}${YELLOW}\$(__git_ps1)${END} "


# ========================================
# Bash
# ========================================

source ~/.bash_aliases

source ~/.bash_functions

# System specific settings if defined
if [ -f ~/.bash_local ]; then
  source ~/.bash_local
fi
