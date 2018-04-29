" -------------------------------------------------------------------------------
" ~/dotfiles/nvim-plugins.vim
" required in: ~/dotfiles/init.vim
" last updated: Dec 21, 2017
" -------------------------------------------------------------------------------
" PLUGINS
"
" Note: This does not imply they are going to be loaded _per se_; that is
"       something that depends on either Plug or fileType events
" -------------------------------------------------------------------------------
call plug#begin('~/.config/nvim/bundle')
" -------------------------------------------------------------------------------

" Support bundles
Plug 'junegunn/vim-plug'                 " Vim-plug itself to access documentation with help
Plug 'Raimondi/delimitMate'              " auto complete the second bracket
Plug 'tpope/vim-surround'                " visual mode S to surround text with ()
Plug 'tpope/vim-repeat'                  " Dot . to repeat command
Plug 'tpope/vim-dispatch'                " Manages compiler
Plug 'kana/vim-submode'                  " Enables repeated use of key after leader
Plug 'michaeljsmith/vim-indent-object'   " obj schema for lines with same indentation
Plug 'moll/vim-bbye'                     " closes buffers without closing windows
Plug 'rizzatti/dash.vim'                 " Documentation viewer (activate with: :Dash)
Plug 'haya14busa/incsearch.vim'          " Better search highlighting
Plug 'junegunn/vader.vim'                " Vimscript debugger/test engine
Plug 'Shougo/echodoc.vim'                " Show function signature in insert mode
Plug 'haya14busa/vim-debugger'           " Debugg vimscript

" Generates menus - works with oh-my-vim
Plug 'Shougo/unite.vim'                  " TESTING can source a search using multiple sources

" Terminal integration
Plug 'vimlab/split-term.vim'             " provides user-friendly bindings for neovim's built-in Terminal functionality

" tmux integration
Plug 'christoomey/vim-tmux-navigator'     " Allow pane movement to jump out of vim into tmux
Plug 'benmills/vimux'                     " Send commands to tmux and vice versa
Plug 'tmux-plugins/vim-tmux-focus-events' " Captures active/inactive pane events
     Plug 'blueyed/vim-diminactive'       " dims inactive window; depends on tmux-focus events

" Linting
Plug 'w0rp/ale'                          " Live linting that uses eslint and prettier

" Auto-completion related
" Plug 'ervandew/supertab'               " Functionality mostly accomplished with deoplete
Plug 'Shougo/deoplete.nvim',     { 'do': ':UpdateRemotePlugins' } " neocomplete for neovim
Plug 'Shougo/context_filetype.vim'       " adds the context filetype feature
Plug 'Shougo/neoinclude.vim'             " source completions from the included files and file paths
Plug 'Shougo/neopairs.vim'               " Inserts the parentheses pairs automatically

" Language-specific sources for deoplete
" Note: see haskell below
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': ' yarn global install --prefer-offline tern && tern --persistent' }
Plug 'Shougo/neco-syntax'                " source completions from syntax files
Plug 'Shougo/neco-vim'                   " source completions for vimscript

" Plug 'roxma/nvim-yarp'

" Ctags
Plug 'ludovicchabant/vim-gutentags',  { 'for': 'javascript' }
Plug 'mkasa/neco-ghc-lushtags',       { 'for': 'haskell' }

" " Visual tab guides - Does not work with Haskell
Plug 'Yggdroot/indentLine'

" Git
Plug 'vim-scripts/gitignore'
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'

" Bars, panels, and files
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Register, but do not load... until invoking function call
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Text manipulation
Plug 'godlygeek/tabular'                 " aligns text into table format
Plug 'tpope/vim-commentary'              " gcc or gc or :7,17Commentary
Plug 'easymotion/vim-easymotion'         " <leader><leader> to provide markers for jumping
Plug 'ConradIrwin/vim-bracketed-paste'   " Enables cmd-v in insert mode

" Distraction-free txt
Plug 'junegunn/goyo.vim'                 " :Goyo to activate :Goyo! to deactivate

" Haskell
Plug 'neovimhaskell/haskell-vim',     { 'for': [ 'haskell', 'cabal' ] }
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' } " does not work with indentLine
Plug 'eagletmt/ghcmod-vim',           { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc',             { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle',           { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
Plug 'Shougo/vimproc.vim',            { 'for': 'haskell', 'do': 'make' } " not required for asynch in neovim
" TESTING
Plug 'bitc/vim-hdevtools',            { 'for': 'haskell' }

" Lisp
Plug 'vim-scripts/paredit.vim',       { 'for': [ 'scheme', 'lisp', 'commonlisp' ] }

" " Color schemes
Plug 'vim-scripts/wombat256.vim'
" Plug 'trevordmiller/nova-vim'
" Plug 'lifepillar/vim-solarized8'

" Language specific highlighting
Plug 'shmup/vim-sql-syntax',          { 'for': [ 'sql' ] }
Plug 'chrisbra/csv.vim',              { 'for': [ 'csv' ] }
Plug 'jalvesaq/nvim-r',               { 'for': [ 'r', 'rscript' ] }
Plug 'xu-cheng/brew.vim'
Plug 'hail2u/vim-css3-syntax',        { 'for': 'css' }

" Pandoc / Markdown
Plug 'vim-pandoc/vim-pandoc',        { 'for': [ 'pandoc', 'markdown' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
Plug 'euclio/vim-markdown-composer',   { 'do': 'cargo build --release' }

" MDN documentation grabber: :Mdn <search terms>
Plug 'mklabs/mdn.vim', { 'do': 'yarn install --prefer-offline mdn-cli' }

" HTML (note: this is in addition to custom shorthand)
" Plug 'alvan/vim-closetag',           { 'for': [ 'html', 'javascript', 'javascript.jsx', 'xml' ] }
Plug 'othree/html5.vim',             { 'for': 'html' }

" Snippets
Plug 'Shougo/neosnippet'                 " snippet engine that exploits vimscript (not slower python)
Plug 'Shougo/neosnippet-snippets'        " snippet repository; requires a separate snippet engine: neosnippet
Plug 'honza/vim-snippets'                " alternative that seems to provide a modern JS set (including react)
Plug 'Shougo/context_filetype.vim'       " provide filetype info within caged code

" Dialogue to generate jsdoc required comments
Plug 'heavenshell/vim-jsdoc',          { 'for': ['javascript', 'javascript.jsx'] }

" Javascript
Plug 'moll/vim-node'                    " TESTING: enables jumps between CommonJS modules
Plug 'othree/jspc.vim',                  { 'for': ['javascript', 'javascript.jsx'] } " function parameter completion
" Note: test = :echo &omnifunc  -> jspc#omni
" (this tells us we have properly wrapped our omnifunc with this extra capability)

" JS syntax highlighting
"Plug 'pangloss/vim-javascript'          " Disabled to enable vim-jsx-improve
"Plug 'mxw/vim-jsx'
"Plug 'jelera/vim-javascript-syntax'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim',                { 'for': ['javascript', 'javascript.jsx'] }
Plug 'chemzqm/vim-jsx-improve',                  { 'for': ['javascript', 'javascript.jsx'] }
Plug 'styled-components/vim-styled-components',  { 'for': ['javascript', 'javascript.jsx'] }

" Fonts - must be last plugin
Plug 'ryanoasis/vim-devicons'            " Nerd fonts (load last)

" -------------------------------------------------------------------------------
call plug#end()
" -------------------------------------------------------------------------------
"Plug 'tpope/vim-sensible'                   " a laundry list of vim configurations
"Plug 'neovim/node-host', { 'do': 'npm install --cache-min Infinity --loglevel http' }
" END PLUGINS
