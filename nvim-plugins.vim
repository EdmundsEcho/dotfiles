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
Plug 'tpope/vim-surround'                " visual mode S to surround text with ()
Plug 'tpope/vim-repeat'                  " Dot . to repeat command
Plug 'tpope/vim-dispatch'                " Manages compiler
Plug 'kana/vim-submode'                  " Enables repeated use of key after leader
Plug 'michaeljsmith/vim-indent-object'   " obj schema for lines with same indentation
Plug 'moll/vim-bbye'                     " closes buffers without closing windows
Plug 'haya14busa/incsearch.vim'          " Better search highlighting
Plug 'jiangmiao/auto-pairs'              " Redundant with neopairs? closes pair of brackets etc.
Plug 'neomake/neomake'                   " async, fast replacement for :make; see automake setting for when it fires (linting)

" buffer manager (Nov 2020 addition)
Plug 'fholgado/minibufexpl.vim'          " explorer for buffers

" Terminal integration
"Plug 'vimlab/split-term.vim'             " provides user-friendly bindings for neovim's built-in Terminal functionality

" tmux integration
Plug 'christoomey/vim-tmux-navigator'     " Allow pane movement to jump out of vim into tmux
Plug 'benmills/vimux'                     " Send commands to tmux and vice versa
Plug 'tmux-plugins/vim-tmux-focus-events' " Captures active/inactive pane events

" Dim inactive windows (split views)
Plug 'TaDaa/vimade'                       " dims inactive window; depends on tmux-focus events
" Plug 'blueyed/vim-diminactive'            " dims inactive window; depends on tmux-focus events

" folding
Plug 'tmhedberg/SimpylFold'

" Auto-completion related (alternative to LaunguageClient-neovim)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'expipiplus1/coc.nvim', {'branch': 'release'}

" Formater (TEST)
Plug 'Chiel92/vim-autoformat'            " Uses external programs to format code

Plug 'Shougo/context_filetype.vim'       " adds the context filetype feature

" Language-specific sources for deoplete
" Note: see haskell below

" rust
Plug 'rust-lang/rust.vim'                " rust-lang.org
" optional
Plug 'mattn/webapi-vim'                  " enables sending code to online playpen

" typescript
Plug 'HerringtonDarkholme/yats.vim'      " REQUIRED syntax file
Plug 'mhartington/nvim-typescript',      {'do': './install.sh'}


" Ctags
Plug 'ludovicchabant/vim-gutentags'
Plug 'mkasa/neco-ghc-lushtags',       { 'for': 'haskell' }

" " Visual tab guides - Does not work with Haskell
Plug 'Yggdroot/indentLine'

" Git
Plug 'vim-scripts/gitignore'
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'

" Bars, panels, and files
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Register, but do not load... until invoking function call
Plug 'Xuyuanp/nerdtree-git-plugin'
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

" GraphQL
Plug 'jparise/vim-graphql'               " .gql .graphql .graphqls syntax highlighting

" Toml (used by rust)
Plug 'cespare/vim-toml'

" fish scripts
Plug 'Stautob/vim-fish'

" Haskell
Plug 'neovimhaskell/haskell-vim',     { 'for': [ 'haskell', 'cabal' ] }
" Plug 'alx741/vim-hindent',            { 'for': [ 'haskell' ] }
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' } " does not work with indentLine
" Plug 'eagletmt/ghcmod-vim',           { 'for': 'haskell' }
" Plug 'eagletmt/neco-ghc',             { 'for': 'haskell' }
" Plug 'Twinside/vim-hoogle',           { 'for': 'haskell' }
" Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
" TESTING
" Plug 'bitc/vim-hdevtools',            { 'for': 'haskell' }

" Elm
Plug 'elmcast/elm-vim',               { 'for': 'elm' }

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
Plug 'gabrielelana/vim-markdown'
" MDN documentation grabber: :Mdn <search terms>
Plug 'mklabs/mdn.vim', { 'do': 'yarn install --prefer-offline mdn-cli' }

" HTML (note: this is in addition to custom shorthand)
" Plug 'alvan/vim-closetag',           { 'for': [ 'html', 'javascript', 'javascript.jsx', 'xml' ] }
Plug 'othree/html5.vim',             { 'for': 'html' }

" Snippets
" Plug 'Shougo/neosnippet'                 " snippet engine that exploits vimscript (not slower python)
" Plug 'Shougo/neosnippet-snippets'        " snippet repository; requires a separate snippet engine: neosnippet
" Plug 'honza/vim-snippets'                " alternative that seems to provide a modern JS set (including react)
" Plug 'Shougo/context_filetype.vim'       " provide filetype info within caged code

" Javascript
" jsdoc highlighting and templates
Plug 'heavenshell/vim-jsdoc', {
      \ 'for': ['javascript', 'javascript.jsx'],
      \ 'do': 'make install'
      \}
Plug 'moll/vim-node'                    " TESTING: enables jumps between CommonJS modules
" Plug 'wokalski/autocomplete-flow'       " Include flow-type in my autocomplete
" Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

" JS syntax highlighting
Plug 'chemzqm/vim-jsx-improve',           { 'for': ['javascript', 'javascript.jsx'] }
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty',          { 'for': ['javascript', 'javascript.jsx'] } " may be redundant

" Plug 'pangloss/vim-javascript'          " Disabled to enable vim-jsx-improve

Plug 'mxw/vim-jsx',                       { 'for': ['javascript', 'javascript.jsx'] } " may be redundant
" Plug 'othree/yajs.vim',                   { 'for': ['javascript', 'javascript.jsx'] } " vim-javascript alternative
Plug 'othree/es.next.syntax.vim',         { 'for': ['javascript', 'javascript.jsx'] }
Plug 'styled-components/vim-styled-components',  { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jsdoc-syntax.vim',           { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/javascript-libraries-syntax.vim',   { 'for': ['javascript', 'javascript.jsx'] }
Plug 'elzr/vim-json'
" Plug 'othree/jspc.vim',                  { 'for': ['javascript', 'javascript.jsx'] } " function parameter completion
" Plug 'flowtype/vim-flow',                { 'do': 'yarn global --prefer-offline flow-bin' }
" Note: test = :echo &omnifunc  -> jspc#omni
" (this tells us we have properly wrapped our omnifunc with this extra capability)

" Fonts - must be last plugin
Plug 'ryanoasis/vim-devicons'            " Nerd fonts (load last)

" -------------------------------------------------------------------------------
call plug#end()
" -------------------------------------------------------------------------------
"Plug 'tpope/vim-sensible'                   " a laundry list of vim configurations
"Plug 'neovim/node-host', { 'do': 'npm install --cache-min Infinity --loglevel http' }
" END PLUGINS
