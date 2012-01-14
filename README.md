These are my dot files and configuration scripts for bash, git, ruby, irb, etc.

# Installation

* `mkdir ~/.dotfiles`
* `cd ~/.dotfiles`
* `git clone git://github.com/javierjulio/dotfiles.git`
* `rake install`
  * Will link all files to home directory. For any files that require input, it will prompt (e.g. gitconfig).
  * To update system with future changes just re-run `rake install` and it will check for identical files and prompt if a replace will occur. The replace action preserves existing file in `file.orig`.
* Create a `~/.bash_local` file for system specific settings (bashrc will automatically source if file exists).

# Resources

* https://github.com/ascarter/dotfiles
* https://github.com/holman/dotfiles
* https://github.com/rtomayko/dotfiles
* https://github.com/ryanb/dotfiles
* https://github.com/minhajuddin/dotfiles
