" ------------------------------------------------------------------------------
" ~/dotfiles/init.vim
" symlinked to: ~/.config/nvim/config/init.vim
" last updated: Mar 20, 2022
" ------------------------------------------------------------------------------
" Note: Sequence of sourcing matters.
" ------------------------------------------------------------------------------
source $HOME/dotfiles/nvim-plugins.vim
source $HOME/dotfiles/nvim-functions.vim
source $HOME/dotfiles/nvim-other.vim
" Lua files
" -- configs
source $HOME/dotfiles/nvim-cmp-npm.lua
source $HOME/dotfiles/nvim-lualine.lua
source $HOME/dotfiles/nvim-autotag.lua
source $HOME/dotfiles/nvim-tree.lua
source $HOME/dotfiles/nvim-null_ls.lua
source $HOME/dotfiles/nvim-cmd.lua
source $HOME/dotfiles/nvim-denols.lua
source $HOME/dotfiles/nvim-treesitter.lua
source $HOME/dotfiles/nvim-rust-tools.lua
source $HOME/dotfiles/nvim-mason.lua
" -- lspconfig is defined here
source $HOME/dotfiles/nvim-lsp.lua
" -- require lspconfig
" source $HOME/dotfiles/nvim-rust-analyzer.lua
source $HOME/dotfiles/nvim-sqlls.lua
" source $HOME/dotfiles/nvim-sumneko-lua.lua
" source $HOME/dotfiles/nvim-spectral.lua
source $HOME/dotfiles/nvim-yamlls.lua
source $HOME/dotfiles/nvim-tsserver.lua
source $HOME/dotfiles/nvim-eslint.lua
" source $HOME/dotfiles/nvim-lsp.vim
source $HOME/dotfiles/nvim-bindings.vim
source $HOME/dotfiles/nvim-emoji-bindings.vim
source $HOME/dotfiles/nvim-typo-db.vim

" Options written in lua
source $HOME/dotfiles/nvim-options.lua
