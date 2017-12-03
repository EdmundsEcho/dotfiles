# tracking
# echo reading .zshrc

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Fire up tmux
#export TERM=xterm-256color
ZSH_TMUX_AUTOSTART="true"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
#time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Nov 7, 2017; to enable use of tmuxp (see tmux online book)
# Uncomment the following line to disable auto-setting terminal title.
export DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git history history-substring-search osx cabal brew nanoc)

# ---------------------------------------------------------
# User configuration
# ---------------------------------------------------------

# export MANPATH="/usr/local/man:$MANPATH"
source $ZSH/oh-my-zsh.sh

# Nov 30, 2017
# Shortcut for chrome
chrome () {
   open -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "$1"
}

# Nov 7, 2017
# use MOST as my Pager for man
source $HOME/.config/most.sh

# Nov 28, 2017
# provide option to view man pages in preview app
# Usage: pman man_app_file
pman() {
   man -t ${@} | open -f -a /Applications/Preview.app/
}

# To problem solve tern - a js vim plugin
ulimit -n 2048

# Required for Tern to access webpack (where webpack requires
# process.env.NODE_ENV be defined with terminal scope (not just Node)
export NODE_ENV='development'

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
<<<<<<< HEAD
export EDITOR='nvim'
=======
>>>>>> origin/master

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# ---------------------------------------------------------
# Aliases
# ---------------------------------------------------------
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias reload='. ~/.zshrc; echo "Executed: . ~/.zshrc" '
alias sd="spindrive_toggle"

# May 25, 2016
alias vi='nvim'
alias vim='nvim'

alias nvim="stty stop '' -ixoff; nvim"
alias ghc='stack exec -- ghc'
alias ghci='stack exec -- ghci'
alias runghc='stack runghc'

# Jan 14, 2017
alias code="cd ~/Dropbox/Programming"
alias tnc="cd ~/Dropbox/Programming/TnC"

# Jul 25, 2017
alias mongod="mongod --config /usr/local/etc/mongod.conf"

# Nov 13, 2017
alias client-app="cd ~/Dropbox/Programming/TnC/ui/client-app/"

# Variables for editing brew formula
export HOMEBREW_EDITOR=nvim
export VISUAL=nvim

# Jul 12th, 2016
bat() {
   ioreg -l |awk 'BEGIN{FS="=";max=0;cur=0;}
   $1~/CurrentCapacity/{cur=$2}
   $1~/MaxCapacity/{max=$2}
END{if (max>0) {printf "%.0f%%\n",cur/max*100} else {print "?"}}'
}

# ---------------------------------------------------------
# Homebrew doctor: make sure /usr/local/bin appears first.
# Note: edit /etc/paths - it manages sequence of PATH
# Warning: do not forget to export the final path (for child processes)
PATH="/usr/local/bin:"
# Addition Feb 8, 2016 (system upgrade)
PATH+="/usr/bin:/bin:"
PATH+="/usr/sbin:/sbin:"
# ---------------------------------------------------------
# Other path settings
# ---------------------------------------------------------
# Addition for Haskell (July 12, 2015)
<<<<<<< HEAD
PATH+="/Users/${USER}/Library/Haskell/bin:"
PATH+="/Users/${USER}/.local/bin:"
=======
PATH="/Users/${USER}/Library/Haskell/bin:${PATH}"
PATH="/Users/${USER}/.local/bin:${PATH}"

>>>>>>> origin/master
<<<<<< HEAD
PATH+="/usr/local/opt/texinfo/bin:"
# Jun 7, 2017: PATH to python Jupyter notebook
#PATH="/Users/${USER}/anaconda3/bin:$PATH"
# Jul 1, 2017: PATH to user-defined bin
PATH+="/Users/${USER}/Code/bin:"
# ~2017
PATH+="/usr/local/opt/sqlite/bin:"
PATH+="/usr/local/opt/qt/bin:"
PATH+="/usr/local/opt/qt/bin:"

export PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# -------------------
# Use VIM keybindings
bindkey -v
bindkey -M viins 'df' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
=======
PATH="/usr/local/opt/texinfo/bin:$PATH"

# Jun 7, 2017: PATH to python Jupyter notebook
PATH="/Users/${USER}/anaconda3/bin:$PATH"

# ---------------------------------------------------------
# Homebrew doctor: make sure /usr/local/bin appears first.
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
>>>>>>> origin/master
