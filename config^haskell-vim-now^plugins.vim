" haskell-vim-now in the ~/.config/haskell-vim-now/.vimrc file
"   call plug#begin('~/.config/nvim/bundle')
"   call plug#begin('~/.vim/bundle')
"   --> both are symlinks to ~/.config/haskell-vim-now/.vimr
"
Plug 'rizzatti/dash.vim'                 " Documentation viewer (activate with: :Dash)
Plug 'Raimondi/delimitMate'              " auto complete the second bracket
Plug 'tpope/vim-surround'                " visual mode S to surround text with ()
Plug 'tpope/vim-repeat'                  " Dot . to repeat command
Plug 'tpope/vim-dispatch'                " Manages compiler
Plug 'kana/vim-submode'                  " Enables repeated use of key after leader
Plug 'xu-cheng/brew.vim'                 " Highlighting for Brew Formula editing
<<<<<<< HEAD
Plug 'godlygeek/tabular'                 " aligns text into table format
Plug 'Yggdroot/indentLine'               " visual tab guides

Plug 'Shougo/deoplete.nvim',         { 'do': ':UpdateRemotePlugins' } " neocomplete for neovim

Plug 'shmup/vim-sql-syntax',         { 'for': [ 'sql' ] }           " Highlighting for sql
Plug 'jalvesaq/nvim-r',              { 'for': [ 'r', 'rscript' ] }  " Highlighting for R

" Color schemes
"Plug 'flazz/vim-colorschemes'
Plug 'sickill/vim-monokai'               " js friendly color scheme

"Plug 'altercation/vim-colors-solarized'

" vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" Plugins for snipmate
"Plug 'tomtom/tlib_vim'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'garbas/vim-snipmate'

" Haskell
Plug 'neovimhaskell/haskell-vim',    { 'for': [ 'haskell', 'cabal' ] }

" Lisp
Plug 'vim-scripts/paredit.vim',      { 'for': [ 'scheme', 'lisp', 'commonlisp' ] }

" Pandoc / Markdown
Plug 'vim-pandoc/vim-pandoc',        { 'for': [ 'pandoc', 'markdown' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }

" Markdown preview
Plug 'euclio/vim-markdown-composer', { 'do': 'cargo build --release' }

" HTML (note: this is in addition to custom shorthand)
Plug 'alvan/vim-closetag',           { 'for': [ 'html', 'js', 'jsx', 'xml' ] }

" CSV
Plug 'chrisbra/csv.vim',             { 'for': [ 'csv' ] }

" Distraction-free txt
Plug 'junegunn/goyo.vim'                  " :Goyo to activate :Goyo! to deactivate
" set: wrap
" set: linebreak
" set: nolist
" set: textwidth=0
" set: wrapmargin=0

" Javascript
"Plug 'vimlab/neojs'                     " will load a set of plugins
"Plug 'pangloss/vim-javascript'          " Disabled to enable vim-jsx-improve
Plug 'tpope/vim-sensible'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neosnippet'                 " snippet engine that exploits vimscript (not slower python)
Plug 'Shougo/neosnippet-snippets'        " snippet repository; requires a separate snippet engine: neosnippet
Plug 'vimlab/split-term.vim'             " provides user-friendly bindings for neovim's built-in Terminal functionality
Plug 'moll/vim-node'
Plug 'othree/yajs.vim'
Plug 'nono/vim-handlebars'
Plug 'benekastah/neomake',               { 'do': 'npm install --cache-min Infinity --loglevel http -g eslint jsonlint' }
                                         " provides asynch capacity for linters and build tools
                                         " ... a Syntastic alternative
Plug 'neovim/node-host',                 { 'do': 'npm install --cache-min Infinity --loglevel http' }
Plug 'othree/jspc.vim',                  { 'for': ['javascript', 'javascript.jsx'] }

" JS Auto-completion
Plug 'ternjs/tern_for_vim',              { 'do': 'npm install --cache-min Infinity --loglevel http && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs',         "{ 'do': 'npm install --cache-min Infinity --loglevel http -g tern' }

" ES.Next syntax
Plug 'othree/es.next.syntax.vim',        { 'for': ['javascript', 'javascript.jsx'] }

" Syntax for JavaScript libraries
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Block comments based on a function signature
Plug 'heavenshell/vim-jsdoc',           { 'for': ['javascript', 'javascript.jsx'] }

" Syntax for styled-components
Plug 'fleischie/vim-styled-components', { 'for': ['javascript', 'javascript.jsx'] }

" JSX for React - all-in-one javascript highlighter
Plug 'chemzqm/vim-jsx-improve',         { 'for': ['javascript', 'javascript.jsx'] }

" Typescript
" Plug 'HerringtonDarkholme/deoplete-typescript'    " Provides auto-completion, view documentation and type-signature
" Plug 'HerringtonDarkholme/yats.vim'      " Typescript syntax highlighting

" CSS in a JSX file
Plug 'styled-components/vim-styled-components',  { 'for': ['javascript', 'javascript.jsx'] }
Plug 'hail2u/vim-css3-syntax'

" CTags - help lookup definitions
Plug 'ludovicchabant/vim-gutentags'       " Definition lookup. It will generate a file in root of project

"Plug 'scrooloose/nerdcommenter'
"Plug 'christoomey/vim-tmux-navigator'    " Unifies vim with tmux; windows
"Plug 'christoomey/vim-tmux-runner'       " Unifies vim with tmux; command
"Plug 'thoughtbot/vim-rspec'              " Send commands from vim
"Plug 'xolox/vim-session'                 " Automates saving sessions <leader>ss
"Plug 'xolox/vim-misc'                    " Required for vim-session Generic support plugin for xolox
"Plug 'jpalardy/vim-slime'                " Send highlighted text to tmux session (REPL)
"Plug 'vim-syntastic/syntastic'   " Crashes when used with <c-a>

"hvn Plug 'Shougo/vimproc.vim', {'do' : 'make'}
"hvn Plug 'ervandew/supertab'
"hvn Plug 'scrooloose/nerdtree'
"hvn Plug 'eagletmt/ghcmod-vim'               " Stephen Diehl 2016 suggestions
"hvn Plug 'eagletmt/neco-ghc'
"hvn Plug 'ctrlpvim/ctrlp.vim'                " Fuzzy file finder C-p
"hvn Plug 'tpope/vim-commentary'              " Comment in/out with gc
=======
>>>>>> origin/master

" Add plugins to &runtimepath
" call plug#end()
