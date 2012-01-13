# git auto complete on tab
source /usr/local/git/contrib/completion/git-completion.bash

# add .bin to path
export PATH="$HOME/.bin:$PATH

# preferred editor
export EDITOR=pico

# customize Terminal prompt
# http://osxdaily.com/2006/12/11/how-to-customize-your-terminal-prompt/
# http://www.mactricksandtips.com/2008/10/customizing-the-mac-terminal-bash-prompt.html
# http://sos.blog-city.com/mac_os_x__bash_customize_your_terminal_prompt_a_little_color.htm
export PS1="\h:\W "

# use .localrc if found for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
