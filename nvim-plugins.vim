" -------------------------------------------------------------------------------
" ~/dotfiles/nvim-plugins.vim
" required in: ~/dotfiles/init.vim
" last updated: Jan 11, 2022
" -------------------------------------------------------------------------------
" PLUGINS
" Note: Plugins are lazzy-loaded. Depends on either Plug or fileType events
" -------------------------------------------------------------------------------
call plug#begin('~/.config/nvim/bundle')
" -------------------------------------------------------------------------------

" Support bundles
Plug 'junegunn/vim-plug'                 " Vim-plug itself to access documentation with help
Plug 'tpope/vim-surround'                " visual mode S to surround text with ()
Plug 'tpope/vim-repeat'                  " Dot . to repeat command
Plug 'tpope/vim-dispatch'                " Manages compiler
Plug 'kana/vim-submode'                  " Enables repeated use of key after leader
Plug 'michaeljsmith/vim-indent-object'   " obj schema for lines with same indentation
Plug 'moll/vim-bbye'                     " closes buffers without closing windows
Plug 'haya14busa/incsearch.vim'          " Better search highlighting
Plug 'neomake/neomake'                   " async, fast replacement for :make; see automake setting for when it fires (linting)
Plug 'jiangmiao/auto-pairs'              " Redundant with neopairs? closes pair of brackets etc.
Plug 'windwp/nvim-ts-autotag'            " html and xml tag-pairing

" Color preview (depends on go)
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Bars, panels, and files
Plug 'ctrlpvim/ctrlp.vim'                " Filename search
Plug 'majutsushi/tagbar'
Plug 'nvim-lualine/lualine.nvim'         " replaces airline

" tabs
Plug 'romgrk/barbar.nvim'                " tabline (tabs)
Plug 'lewis6991/gitsigns.nvim'           " OPTIONAL: for git status
Plug 'nvim-tree/nvim-web-devicons'       " OPTIONAL: for file icons

" Text manipulation
Plug 'godlygeek/tabular'                 " aligns text into table format
Plug 'tpope/vim-commentary'              " gcc or gc or :7,17Commentary
Plug 'easymotion/vim-easymotion'         " <leader><leader> to provide markers for jumping
Plug 'ConradIrwin/vim-bracketed-paste'   " Enables cmd-v in insert mode

" Distraction-free txt
Plug 'junegunn/goyo.vim'                 " :Goyo to activate :Goyo! to deactivate

" Terminal integration
" Nothing

" tmux integration
Plug 'christoomey/vim-tmux-navigator'     " Allow pane movement to jump out of vim into tmux
Plug 'benmills/vimux'                     " Send commands to tmux and vice versa
Plug 'tmux-plugins/vim-tmux-focus-events' " Captures active/inactive pane events

" Dim inactive windows (split views)
Plug 'blueyed/vim-diminactive'            " dims inactive window; depends on tmux-focus events

" compare blocks of code within the same file
" :help line diff
Plug 'AndrewRadev/linediff.vim'


" folding
Plug 'tmhedberg/SimpylFold'

" running curl from a buffer; very cool
Plug 'NTBBloodbath/rest.nvim'

"--- LSP
Plug 'folke/lsp-trouble.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'williamboman/mason.nvim', { 'do': 'MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'

"--- Functional
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'rcarriga/nvim-notify' 🦀 ? when not using
Plug 'dag/vim-fish'                  " may be redundant with cmp-fish

" Completion framework
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-cmdline'

" completion sources for nvim-cmp
Plug 'David-Kunz/cmp-npm'       " package.json triggered source
Plug 'andersevenrud/cmp-tmux'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'lambdalisue/suda.vim'     " enables sudo with password entry SudaWrite
Plug 'lukas-reineke/cmp-rg'     " ripgrep (depends on having it installed)
Plug 'mtoohey31/cmp-fish'
Plug 'ray-x/cmp-treesitter'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }  " AI for completion
Plug 'vappolinario/cmp-clippy'  " ⚠️  experimental, and useful?


" Typescript
Plug 'jose-elias-alvarez/typescript.nvim'

" Prettier
Plug 'MunifTanjim/prettier.nvim'

" Helm
Plug 'towolf/vim-helm'        " helm yaml + gotmpl + sprig + custom
" See hrsh7th's other plugins for more completion sources!

" status line content
" Plug 'nvim-lua/lsp-status.nvim' 🦀 when not using?

" treesitter configuration
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " updating the parsers on update
Plug 'nvim-treesitter/playground'

" html and css
Plug 'mattn/emmet-vim'

" Optional dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Rust (no longer uses telescope)
Plug 'simrat39/rust-tools.nvim'

" Docker
Plug 'ekalinin/Dockerfile.vim'

" Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" Ctags
Plug 'ludovicchabant/vim-gutentags'     " requires brew install universal-ctags
" Plug 'mkasa/neco-ghc-lushtags',       { 'for': 'haskell' }

" Visual tab guides - Does not work with Haskell
Plug 'Yggdroot/indentLine'

"--- Git
Plug 'vim-scripts/gitignore'
Plug 'tpope/vim-fugitive'

" Haskell
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' } " does not work with indentLine

" Lisp
Plug 'vim-scripts/paredit.vim',      { 'for': [ 'scheme', 'lisp', 'commonlisp' ] }
Plug 'maksimr/vim-jsbeautify',       { 'for': 'html' }

" Pandoc / Markdown
" Plug 'vim-pandoc/vim-pandoc',        { 'for': [ 'pandoc', 'markdown' ] }
" Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
Plug 'euclio/vim-markdown-composer',   { 'do': 'cargo build --release --locked' }
" If you have nodejs and yarn
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" MDN documentation grabber: :Mdn <search terms>
Plug 'mklabs/mdn.vim', { 'do': 'yarn install --prefer-offline mdn-cli' }

" " Color schemes
Plug 'vim-scripts/wombat256.vim'

" Tree and font - must be last plugin
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" -------------------------------------------------------------------------------
call plug#end()
" -------------------------------------------------------------------------------
" END PLUGINS
