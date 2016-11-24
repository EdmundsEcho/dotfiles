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
