These are my dot files and configuration scripts for bash, git, ruby, irb, etc.

# Installation

Run [my laptop script](https://github.com/javierjulio/laptop) which will install dotfiles in `~/Projects/dotfiles` folder.

## Standalone installation

* `git clone https://github.com/javierjulio/dotfiles.git ~/Projects/dotfiles`
* `rake install`
  * Will link all files to home directory.
  * Prompted on any files that require input (e.g. gitconfig).
  * To update just re-run `rake install` and it will check for identical files and prompt if a replace will occur. The replace action preserves the existing file in `file.orig`.
* Create a `~/.bash_local` file for system specific settings.

# Resources

* https://github.com/ascarter/dotfiles
* https://github.com/holman/dotfiles
* https://github.com/rtomayko/dotfiles
* https://github.com/ryanb/dotfiles
* https://github.com/minhajuddin/dotfiles
* https://github.com/mathiasbynens/dotfiles
* https://github.com/gf3/dotfiles
* https://github.com/janmoesen/tilde
* https://github.com/krishicks/dotfiles
