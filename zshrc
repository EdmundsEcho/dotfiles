# tracking
# echo reading .zshrc

# fpath=(/usr/local/share/zsh-completions $fpath)

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Fire up tmux
# ZSH_TMUX_AUTOSTART="true"

# Do not set the terminal here (bad policy)
#export TERM=screen-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
#time that oh-my-zsh is loaded.

ZSH_THEME="robbyrussell"
# ZSH_THEME="nothing"

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
## export DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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

plugins=(
  brew
  cabal
  git
  history
  history-substring-search
  jsontools
  osx
  tmux
  vi-mode
  yarn
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# ---------------------------------------------------------
# User defined functions
# ---------------------------------------------------------
swapzt() {
  swap-zsh-themes.sh $@;
}
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
# source $HOME/.config/most.sh

# Nov 28, 2017
# provide option to view man pages in preview app
# Usage: pman man_app_file
pman() {
  man -t ${@} | open -f -a /Applications/Preview.app/
}

# Increase the cache size for ternJS
ulimit -n 2048

# Required for Tern to access webpack (where webpack requires
# process.env.NODE_ENV be defined with terminal scope (not just Node)
## export NODE_ENV='development'

# You may need to manually set your language environment
## export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
## export EDITOR='nvim'

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
alias reload='. ~/.zshrc; echo "Sourced ~/.zshrc" '

# July 1, 2018
alias fixVideo="sudo killall VDCAssistant"
#alias sd="spindrive_toggle"

# May 25, 2016
alias vi='nvim'
alias vim='nvim'
alias ctags="`brew --prefix`/bin/ctags"

# Dec 15, 2017
alias plugins='cd ~/.config/nvim/bundle'
alias snippets='cd ~/.config/nvim/snippets'

#TESTING - related to Ctr-Z to send NVIM to background
# alias nvim="stty stop '' -ixoff; nvim"

alias ghc='stack exec -- ghc'
alias ghci='stack exec -- ghci'
alias runghc='stack runghc'

# Jan 14, 2017
alias code="cd ~/Dropbox/Programming"
alias tnc="cd ~/Dropbox/Programming/Tnc"
# Nov 13, 2017
alias client-app="cd ~/Dropbox/Programming/TnC/ui/client-app/"
# Dec 15, 2017
alias plural="cd ~/Dropbox/Programming/react/pluralsight"
# Jul 25, 2017
alias mongod="mongod --config /usr/local/etc/mongod.conf"

# Dec 5, 2017 node.js REPL with es6 compilation support
alias node-es6="NODE_NO_READLINE=1 npx rlwrap --always-readline babel-node"

# Variables for editing brew formula
## export HOMEBREW_EDITOR=nvim
## export VISUAL=nvim

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
# Warning: do not forget to export the final path
# (for child processes)
##PATH="/usr/local/bin:"
##PATH+="/usr/bin:/bin:"
##PATH+="/usr/sbin:/sbin:"
### ---------------------------------------------------------
### Other path settings
### ---------------------------------------------------------
##PATH+="/usr/local/opt/python/libexec/bin:"
##PATH+="/usr/local/opt/sqlite/bin:"
##PATH+="/usr/local/opt/qt/bin:"
##PATH+="/usr/local/opt/texinfo/bin:"
##
### User - defined code
##PATH+="/Users/${USER}/.local/bin:"
##PATH+="/Users/${USER}/Library/Haskell/bin:"
##PATH+="/Users/${USER}/Code/bin:"
##PATH+="/Users/${USER}/.cargo/bin:"
##
### ---------------------------------------------------------
### End with system paths
### ---------------------------------------------------------
##export PATH

# node related
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ---------------------------------------------------------
# VIM and iTerm integration
# ---------------------------------------------------------
bindkey -v
bindkey -M viins 'df' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

# binding for autosuggestions
bindkey '^ ' autosuggest-accept


# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Ruby - version manager to avoid overwriting system
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
