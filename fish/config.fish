# Required for Tern to access webpack (where webpack requires
# process.env.NODE_ENV be defined with terminal scope (not just Node)
set --export NODE_ENV development

# You may need to manually set your language environment
set --export LANG en_US.UTF-8
# set --export LC_CTYPE C
# set --export LANG C

# Preferred editor for local and remote sessions\
set --export EDITOR nvim

# Preferred browser
set --export BROWSER firefox

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Variables for editing brew formula
set --export HOMEBREW_EDITOR nvim
set --export VISUAL nvim

# ---------------------------------------------------------
# Homebrew doctor: make sure /usr/local/bin appears first.
# Note: edit /etc/paths - it manages sequence of PATH
# Warning: do not forget to export the final path
# (for child processes)
set -gx PATH $PATH /usr/local/bin
set -gx PATH $PATH /usr/bin:/bin
set -gx PATH $PATH /usr/sbin:/sbin

# ---------------------------------------------------------
# Other path settings
# ---------------------------------------------------------
set -gx PATH $PATH "/usr/local/opt/python/libexec/bin:"
set -gx PATH $PATH "/usr/local/opt/sqlite/bin:"
set -gx PATH $PATH "/usr/local/opt/qt/bin:"
set -gx PATH $PATH "/usr/local/opt/texinfo/bin:"
set -gx PATH $PATH "/usr/local/CrossPack-AVR/bin:"

# User - defined code
set -gx PATH $PATH "/Users/$USER/.local/bin:"
set -gx PATH $PATH "/Users/$USER/Library/Haskell/bin:"
set -gx PATH $PATH "/Users/$USER/Code/bin:"
set -gx PATH $PATH "/Users/$USER/.cargo/bin:"

# ---------------------------------------------------------
# End with system paths
# ---------------------------------------------------------
# export PATH

# node related
set --export NVM_DIR "$HOME/.nvm"

# ---------------------------------------------------------
# Aliases
# ---------------------------------------------------------
alias vim nvim
alias vi nvim
alias firefox "/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox"
alias grep ggrep

set -gx EDITOR nvim

fish_vi_key_bindings
set -g fish_key_bindings my_vi_bindings

echo "read config.fish"


# ---------------------------------------------------------
# Functions
# ---------------------------------------------------------
function find_replace
  # $argv regex filename
  sed -i '' "$argv[1]" $argv[2]
end
