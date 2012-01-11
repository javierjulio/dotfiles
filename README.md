These are my configuration scripts for bash, git, ruby, irb, etc. I've only 
become more comfortable with CLI tools so I'm using this project to organize 
and add as I learn more.

# Installation

* `mkdir ~/.dotfiles`
* `cd ~/.dotfiles`
* `git clone git://github.com/javierjulio/dotfiles.git`
* `rake install`
** Will link all files to home directory. For any files that require input, it will prompt (e.g. gitconfig).
** To update system with changes re-run `rake install` and it will check for identical files and prompt if a replace will occur. The replace action preserves existing file in `file.orig`.
* Create a `~/.localrc` file for settings specific to a system (bashrc will automatically source if file exists).

# Resources

* https://github.com/ascarter/dotfiles
* https://github.com/holman/dotfiles
* https://github.com/rtomayko/dotfiles
* https://github.com/ryanb/dotfiles
* https://github.com/minhajuddin/dotfiles
