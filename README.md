These are my configuration scripts for bash, git, ruby, irb, etc. I've only 
become more comfortable with CLI tools so I'm using this project to organize 
and add as I learn more.

# Installation

* Clone by running `git clone git://github.com/javierjulio/dotfiles.git ~/.dotfiles`
* Run `rake install` to link to home directory. For any files that require input, it will prompt (e.g. gitconfig)
* Running `rake install` again will check for identical files and prompt if a replace will occur. Replace preserves existing file in `file.orig`
* Create a `~/.localrc` file for settings specific to a system

# Resources

* https://github.com/ascarter/dotfiles
* https://github.com/holman/dotfiles
* https://github.com/rtomayko/dotfiles
* https://github.com/ryanb/dotfiles
* https://github.com/minhajuddin/dotfiles
