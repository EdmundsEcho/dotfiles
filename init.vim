" ------------------------------------------------------------------------------
" ~/dotfiles/init.vim
" symlinked to: ~/.config/nvim/config/init.vim
" last updated: Nov 13, 2023
" ------------------------------------------------------------------------------
" Note: Sequence of sourcing matters.
" ------------------------------------------------------------------------------
"
source $HOME/dotfiles/nvim-plugins.vim
source $HOME/dotfiles/nvim-functions.vim
source $HOME/dotfiles/nvim-other.vim
" Lua files
" source $HOME/dotfiles/nvim-rocks.lua // broken
" -- configs
" source $HOME/dotfiles/nvim-nonicons.lua
source $HOME/dotfiles/nvim-copilot.lua
source $HOME/dotfiles/nvim-chatGpt.lua
source $HOME/dotfiles/nvim-gemini.lua
source $HOME/dotfiles/nvim-lualine.lua
source $HOME/dotfiles/nvim-barbar.lua
source $HOME/dotfiles/nvim-autotag.lua
source $HOME/dotfiles/nvim-tree.lua
source $HOME/dotfiles/nvim-null_ls.lua
source $HOME/dotfiles/nvim-conform.lua
source $HOME/dotfiles/nvim-prettier.lua
" source $HOME/dotfiles/nvim-rest.lua // broken

source $HOME/dotfiles/nvim-cmp-npm.lua
source $HOME/dotfiles/nvim-cmd-completion.lua
source $HOME/dotfiles/nvim-cmd.lua
source $HOME/dotfiles/nvim-treesitter.lua
source $HOME/dotfiles/nvim-lspsaga.lua
" dap
source $HOME/dotfiles/nvim-dap.lua

" -- lspconfig is defined here
source $HOME/dotfiles/nvim-mason.lua
source $HOME/dotfiles/nvim-lspconfig.lua

" -- require lspconfig
source $HOME/dotfiles/nvim-rust-tools.lua
source $HOME/dotfiles/nvim-yamlls.lua
source $HOME/dotfiles/nvim-tsserver.lua

" legacy settings
source $HOME/dotfiles/nvim-bindings.vim
source $HOME/dotfiles/nvim-emoji-bindings.vim
source $HOME/dotfiles/nvim-typo-db.vim

" Options written in lua
source $HOME/dotfiles/nvim-options.lua

" deprecated
" source $HOME/dotfiles/nvim-lua_ls.lua
" source $HOME/dotfiles/nvim-sqlls.lua
" source $HOME/dotfiles/nvim-sumneko-lua.lua
" source $HOME/dotfiles/nvim-spectral.lua
