# You may need to manually set your language environment
set --export LANG en_US.UTF-8

# tmux related
set --export DISABLE_AUTO_TITLE "true"
set --export TMUX_TMPDIR /Users/edmund/tmp/tmux
set -g fish_escape_delay_ms 30
set --export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX YES

# set --export LC_CTYPE C
# set --export LANG C

# Preferred editor for local and remote sessions\
set --export EDITOR nvim

# Preferred browser
# set --export BROWSER firefox
set --export BROWSER "/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox"

# term color
# Friendly overide if things get hairy
# set --export LSCOLORS Gxfxcxdxbxegedabagacad
# Not required if ls is run using -G option
# set --export CLICOLOR 1

# GREP colors
# Note: Use alias to change ag colors
set --export GREP_COLORS "ms:05;31;42;214;48;5;0"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Rust test output setting
set --export RUST_BACKTRACE 0

# App specific env
# Required for Tern to access webpack (where webpack requires
# process.env.NODE_ENV be defined with terminal scope (not just Node)
set --export NODE_ENV development
# set --export EXTEND_ESLINT true
set --export ESLINT_CONFIG_PRETTIER_NO_DEPRECATED true

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Variables for editing brew formula
set --export HOMEBREW_EDITOR nvim
set --export VISUAL nvim

# ---------------------------------------------------------
# Set PATH using fish_user_paths
# Note: 3.2.0 will have fish_add_path function
# ---------------------------------------------------------
set -e fish_user_paths
# allow python pyenv control over path
set -U PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
contains $PYENV_ROOT/bin fish_user_paths; or set --append fish_user_paths $PYENV_ROOT/bin

# ---------------------------------------------------------
# Homebrew doctor: make sure /usr/local/bin appears first.
# Note: edit /etc/paths - it manages sequence of PATH
# Warning: do not forget to export the final path
# (for child processes)
set --erase PATH
set TMP /usr/local/bin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH /usr/local/bin
set TMP /usr/local/sbin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH /usr/local/sbin
set TMP /usr/bin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /usr/bin
set TMP /bin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /bin
set TMP /usr/sbin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /usr/sbin
set TMP /sbin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /sbin
set TMP /usr/local/opt/python/libexec/bin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /usr/local/opt/python/libexec/bin
# set PATH $PATH "/Users/$USER/.rbenv/shims"
# ---------------------------------------------------------
# ---------------------------------------------------------
# Other path settings
# ---------------------------------------------------------
set TMP /usr/local/opt/sqlite/bin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /usr/local/opt/sqlite/bin
set TMP /usr/local/opt/qt/bin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /usr/local/opt/qt/bin
set TMP /usr/local/opt/texinfo/bin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /usr/local/opt/texinfo/bin
# gmake as make
set TMP /usr/local/opt/make/libexec/gnubin
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH /usr/local/opt/make/libexec/gnubin

# User - defined code
set TMP "/Users/$USER/.local/bin"
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH "/Users/$USER/.local/bin"
set TMP "/Users/$USER/Apps"
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH "/Users/$USER/Apps"
set TMP "/Users/$USER/.cargo/bin"
contains $TMP fish_user_paths; or set --append fish_user_paths $TMP
# set PATH $PATH "/Users/$USER/.cargo/bin"

# ---------------------------------------------------------
# Directories that are likely ready to be deleted
# ---------------------------------------------------------
# set PATH $PATH "/Users/$USER/Library/Haskell/bin"
# set PATH $PATH "/Users/$USER/Code/bin"

# export PATH for other shells
# set -gx PATH $PATH

# node version manager related
# set --export NVM_DIR "$HOME/.nvm"

# fnm - a fish alternative to node manager
# fnm env --multi | source

# gtk related
# set --export PKG_CONFIG_PATH "/usr/local/opt/libffi/lib/pkgconfig"
# set --export LDFLAGS "-L/usr/local/opt/libffi/lib"

# openssl
# set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
# set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig"
# set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"

# ---------------------------------------------------------
# Aliases
# To circumvent the alias run 'command alias'
# To remove an alias, use functions --erase alias
# To list active aliases, use functions -n
# ---------------------------------------------------------
alias vim nvim
alias vi nvim
alias node-es6 "NODE_NO_READLINE=1 npx rlwrap --always-readline babel-node"
alias ag "ag --color-match='05;31;42;214;48;5;0' "

# other aliases defined using a function
# grep grepp with color
# ls ls with color
# tmux tmux with extra settings
# alias firefox --- see function firefox

set -g fish_key_bindings my_vi_bindings

# ---------------------------------------------------------
# Shims to the PATH value
# Note: May require that PATH be exported and thus position
# near the end of the config file.
# ---------------------------------------------------------
# status --is-interactive; and source (rbenv init -|psub)
# status --is-interactive; and pyenv init - | source

# TEMP
# pyenv init - | source

# status --is-interactive; and pyenv virtualenv-init - | source
# set PATH $PATH "/Users/$USER/.nvm/versions/node/v10.15.0/bin"

echo "read config.fish"

# status --is-interactive; and source (rbenv init -|psub)
# if which rbenv -gt /dev/null
  # eval (rbenv init -)
# end
