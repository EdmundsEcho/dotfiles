__Last updated May 14, 2024__

A near full transition to lua.  This included a major reorganization of the configuration files.

The features include:

1. lazy.nvim for lazy loading of plugins
2. use of mason and friends to manage lsp
3. A mostly unified means of configuring the lsp
4. A new color scheme that is based on wombat that includes extra detail
   using treesitter around key differences in syntax (espetially good
   for Rust).
5. Several removed and some replaced plugins.


## Orinal description

This directory has all of the .config files that are sufficiently complex to
save and maintain over multiple systems.

Below is the git repository update sequence.

$ cd ~/dotfiles
$ git pull  (git init : to build a new repository)
$ git add .
$ git commit -m 'Description of update'
$ [setup only] git remote add origin git@github.com:yourgithubusername/dotfiles.git
$ git push origin master

$ Use git mergetool to resolve conflicts

Straightforward git howto: http://rogerdudler.github.io/git-guide/
