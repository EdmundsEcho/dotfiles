" -------------------------------------------------------------------------------
" ~/.config/nvim/init.vim
" last updated: Dec 21, 2017
" -------------------------------------------------------------------------------
" Debugging tips
" :scriptnames to see what is running
" :GetSettingsFor <setting>
" :TabMessage <command>
" :syntax list
" :debug <cmd>
" :call ToggleVerbose()
" :setlocal makeprg=... , confirm: echo &makeprg
" :$VIMRUNTIME/debugscript.vim

function! GetSettingsFor (term)
  redir => message
  silent execute "let"
  redir END
  if empty(message)
    echoerr "no result"
  else
    enew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
    execute "g/" . a:term . "/y A"
    enew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    execute "put A"
    normal! gg
  endif
endfun
command! -nargs=+ -complete=command GetSettingsFor call GetSettingsFor (<q-args>)

"
" TODO: generate a version for Haskell

set nocompatible " No VI compatibility
set autoread     " Detect file changes outside vim
set autochdir    " change working dir to current buffer
" TODO: may improve how C-x C-f works

" Paths to `included` files
" -------------------------------------------------------------------------------
let path_plugins        = expand(resolve($HOME . "/dotfiles/nvim-plugins.vim"))
let path_typo_repair_db = expand(resolve($HOME . "/dotfiles/nvim-iabbrev-db.vim"))
" Project specific configurations
" NVIM will also source .vimrc if present in the project directory
" -------------------------------------------------------------------------------

" -------------------------------------------------------------------------------
" Neovim's Python provider(s)
" -------------------------------------------------------------------------------
let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
" Note: disable by setting g:loaded_python_provider = 1
" -------------------------------------------------------------------------------

" esc key with cursor moved forward
" (faster than `ff` for instance)
inoremap df <esc><esc>l

" Leader key and timeout
let mapleader = "\<SPACE>"
set tm=2000

" Cursor (note color is controlled by iTerm)
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,
      \i-ci:ver25-Cursor/lCursor,
      \r:hor50-Cursor

" Line formatting
" TODO: how does it work with syntax based formatting
" Note: ALE may also set this option
set formatprg=par
let $PARINIT = 'rTbgqR B=.,?_A_a Q=_s>|'

" Kill the damned Ex mode (no operation).
nnoremap Q <nop>

" Make <c-h> work like <c-h> again (a 2015 libterm issue)
nnoremap <BS> <C-w>h

" ---------------------------
" Tweaks to default mappings
" ---------------------------
" Remap start of the line; end of the file and EOF
nnoremap 0 ^
nnoremap gg :0<CR>
nnoremap G G$

nnoremap <M-:> :
inoremap <M-:> :

" Writing to file with <ctr-a>
nnoremap <C-a> :w<CR>
inoremap <C-a> <Esc>:w<CR>l
vnoremap <C-a> <Esc>:w<CR>

" Copy filename and filepath
nnoremap <Leader>fc :let @+=expand("%")<CR>
nnoremap <leader>fn :let @*=expand("%")<CR>
nnoremap <leader>fp :let @*=expand("%:p")<CR>

" Open file prompt with current path
nnoremap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

" NerdTree
" ========
" If nerd tree is closed, find current file, if open, close it
nnoremap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nnoremap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

" vim-bby
" =======
" close buffers without impacting windows
nnoremap <Leader>q :Bdelete<CR>

" Display .vimrc in a new window; source when done
nnoremap <leader>forc :sp ${HOME}/.config/nvim/init.vim <CR>
augroup sourcing
  autocmd!
  autocmd bufwritepost init.vim :source $MYVIMRC
augroup END

" Select all text in current buffer
nnoremap <Leader>a ggVG

" TESTING
" Operator-pending maps
" p -> parentheses
" b -> bracket
" e.g., change contents between () with cp
onoremap p i(
onoremap b i{
onoremap np :<c-u>normal! f(vi(<cr>
onoremap nb :<c-u>normal! f{ivi{<cr>

" Map esc to remove highlighting of previous search
nnoremap <esc> :noh<return><esc>

" TODO: This relates to passing commands to tmux
"       It may not be required anymore.
"       Recall using it to enable alt-hjkl to size window
"disable submode timeouts:
let g:submode_timeout = 800
" don't consume submode-leaving key
let g:submode_keep_leaving_key = 1

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>z :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>Z :wincmd =<cr><Paste>

" Working with Sessions vim-sessions
let g:session_autosave = 'no'
" e.g., manual  :mks ~/.session
"               :source ~/.session
" default: <CR-S><CR-S> to save
" default: <CR-S><CR-R> to restore

" REQUIRED (Dec 2017)
" Make Vim recognize XTerm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
if &term =~ '^screen'
   " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
   execute "set t_kP=\e[5;*~"
   execute "set t_kN=\e[6;*~"

   " Arrow keys http://unix.stackexchange.com/a/34723
   execute "set <xUp>=\e[1;*A"
   execute "set <xDown>=\e[1;*B"
   execute "set <xRight>=\e[1;*C"
   execute "set <xLeft>=\e[1;*D"
endif

" BUFFERS
" =======
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

" switch to the window with the buffer if exists
" Note: for quickfix buffers only
set switchbuf=useopen

" close a buffer without losing my window split
noremap <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>

" close every window except the current (o = other)
nnoremap <leader>bo <c-w>o

" list files and option to jump (not buffers)
nnoremap<leader>bb :buffers<CR>:buffer<Space>

" Neovim Terminal
" ===============
" Use <Esc> to escape terminal insert mode
tnoremap <Esc> <C-\><C-n>
" Make terminal split moving behave like normal neovim
tnoremap <c-h> <C-\><C-n><C-w>h
tnoremap <c-j> <C-\><C-n><C-w>j
tnoremap <c-k> <C-\><C-n><C-w>k
tnoremap <c-l> <C-\><C-n><C-w>l

" spell checking
noremap <leader>ss :setlocal spell!<cr>

" Tags and Tagbar
" ===============
noremap <leader>tt :TagbarToggle<CR>

" Force redraw
noremap <silent> <leader>r :redraw!<CR>

" WIP - set source locations at the top
" of the file
" Source: iabbrev for frequent typos
" =============
" test if file exists
" source it
inoreabbrev waht what
inoreabbrev functino function
inoreabbrev teh the

" =========
" PLUGINS
" =========
call plug#begin('~/.config/nvim/bundle')
" Support bundles
Plug 'junegunn/vim-plug'                 " Vim-plug itself to access documentation with help
Plug 'moll/vim-bbye'                     " closes buffers without closing windows
Plug 'Raimondi/delimitMate'              " auto complete the second bracket
Plug 'tpope/vim-surround'                " visual mode S to surround text with ()
Plug 'tpope/vim-repeat'                  " Dot . to repeat command
Plug 'tpope/vim-dispatch'                " Manages compiler
Plug 'kana/vim-submode'                  " Enables repeated use of key after leader
Plug 'michaeljsmith/vim-indent-object'   " obj schema for lines with same indentation
Plug 'rizzatti/dash.vim'                 " Documentation viewer (activate with: :Dash)
Plug 'haya14busa/incsearch.vim'          " Better search highlighting
Plug 'junegunn/vader.vim'                " Vimscript debugger/test engine

" Generates menus - works with oh-my-vim
Plug 'Shougo/unite.vim'                  " TESTING can source a search using multiple sources
" Low priority
Plug 'nono/vim-handlebars'               " enables use of {{templates}}

" Terminal integration
Plug 'vimlab/split-term.vim'             " provides user-friendly bindings for neovim's built-in Terminal functionality

" tmux integration
Plug 'christoomey/vim-tmux-navigator'    " Allow pane movement to jump out of vim into tmux
Plug 'benmills/vimux'                    " Send commands to tmux and vice versa
""Plug 'jgdavey/tslime.vim'

" Linting
Plug 'w0rp/ale'                          " Live linting that uses eslint and prettier

" Auto-completion related
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim',     { 'do': ':UpdateRemotePlugins' } " neocomplete for neovim
Plug 'carlitux/deoplete-ternjs', { 'do': ' yarn global install --prefer-offline tern && tern --persistent' }
Plug 'Shougo/context_filetype.vim'       " adds the context filetype feature
Plug 'Shougo/neoinclude.vim'             " source completions from the included files and file paths
Plug 'Shougo/neopairs.vim'               " Inserts the parentheses pairs automatically
" Plug 'roxma/nvim-yarp'

" Ctags
Plug 'ludovicchabant/vim-gutentags'  ", { 'for': 'javascript' }

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
" Plug 'powerline/powerline'

" Text manipulation
Plug 'godlygeek/tabular'                 " aligns text into table format
Plug 'tpope/vim-commentary'              " gcc or gc or :7,17Commentary
Plug 'easymotion/vim-easymotion'         " <leader><leader> to provide markers for jumping
Plug 'ConradIrwin/vim-bracketed-paste'   " Enables cmd-v in insert mode
"Plug 'vim-scripts/Align'                " Same as tabular

" Distraction-free txt
Plug 'junegunn/goyo.vim'                  " :Goyo to activate :Goyo! to deactivate

" Haskell
Plug 'neovimhaskell/haskell-vim',     { 'for': [ 'haskell', 'cabal' ] }
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' } " does not work with indentLine
Plug 'eagletmt/ghcmod-vim',           { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc',             { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle',           { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" Lisp
Plug 'vim-scripts/paredit.vim',       { 'for': [ 'scheme', 'lisp', 'commonlisp' ] }

" " Color schemes
" Plug 'lifepillar/vim-solarized8'
Plug 'vim-scripts/wombat256.vim'
" Plug 'trevordmiller/nova-vim'

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
Plug 'alvan/vim-closetag',           { 'for': [ 'html', 'javascript', 'javascript.jsx', 'xml' ] }
Plug 'othree/html5.vim',             { 'for': 'html' }
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'mattn/emmet-vim'

" Snippets
"Plug 'tomtom/tlib_vim'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'garbas/vim-snipmate'
Plug 'Shougo/neosnippet'                 " snippet engine that exploits vimscript (not slower python)
Plug 'Shougo/neosnippet-snippets'        " snippet repository; requires a separate snippet engine: neosnippet

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

call plug#end()
" add the plugins to the runtime
" Note: This does not imply they are going to be loaded; that is
"       something that depends on either Plug or fileType events
"Plug 'tpope/vim-sensible'                   " a laundry list of vim configurations
"Plug 'Shougo/vimproc.vim', { 'do': 'make' } " not required for asynch in neovim
"Plug 'neovim/node-host', { 'do': 'npm install --cache-min Infinity --loglevel http' }
" END PLUGINS

" TAGS
" Notes:
" 1. use of `;` makes it recursive
" 2. the `.` will be substituted with a directory
" 3. May not set once NVIM is open
" 4. Haskell uses hscope
" 5. Plugins that require tags like have their own
"    settings.  Writing to this may prevent ctag-dependent
"    plugins from working.
"set tags=./tags,tags;
"" :set tags=./tags,tags,/home/user/commontags

" Surround
" ========
" TODO: figure out what this mapping does
"nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>

" OS Clipboard
" Copy and paste to os clipboard
" Note: Ctrp uses <leader>p_
nnoremap <leader>y "*y
vnoremap <leader>y "*y
" nnoremap <leader>d "*d
" vnoremap <leader>d "*d
nnoremap <leader>p "*p
vnoremap <leader>p "*p

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Moving around, tabs, windows and buffers {{{

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

" vim-tmux-navigator
" ===================
let g:tmux_navigator_no_mappings = 1
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" Split *VIM* window
nnoremap <leader>- :sp<CR>
nnoremap <leader>\ :vsp<CR>
" Open window splits in various places
nnoremap <leader>sh :leftabove  vnew<CR>
nnoremap <leader>sl :rightbelow vnew<CR>
nnoremap <leader>sk :leftabove  new<CR>
nnoremap <leader>sj :rightbelow new<CR>

" Disable highlight when <leader><cr> is pressed
" but preserve cursor coloring
"nnoremap <silent> <leader><cr> :noh\|hi Cursor guibg=red<cr>

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

" Helper functions
fun! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfun

fun! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal! ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal! /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfun

" VIMUX - a new Slime
" ====================
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
vnoremap <silent> <Leader>rs <Plug>SendSelectionToTmux
nnoremap <silent> <Leader>rs <Plug>NormalModeSendToTmux
nnoremap <silent> <Leader>rv <Plug>SetTmuxVars
fun! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfun
" If text is selected, save it in the v buffer and send that buffer it to tmux
vnoremap <LocalLeader>vs "vy :call VimuxSlime()<CR>
" Select current paragraph and send it to tmux
nnoremap <LocalLeader>vs vip<LocalLeader>vs<CR>

" NerdTree
" ========
" Usage: <leader>f OR <leader>F
let NERDTreeQuitOnOpen = 1
fun! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfun

fun! ToggleFindNerd()
  if !(exists('*NERDTreeFind'))
    exec 'NERDTreeToggle'
    return
  endif
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfun

" Git
" =====
let g:extradite_width = 60
" Hide messy Ggrep output and :copen automatically
fun! NonintrusiveGitGrep(term)
  execute "copen"
  " Map 't' to open selected item in new tab
  execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  execute "silent! Ggrep " . a:term
  execute "redraw!"
endfun

command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gg :copen<CR>:GGrep
nnoremap <leader>gl :Extradite!<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>

fun! CommittedFiles()
  " Clear quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " Fill quickfix list with them
  call setqflist(qf_list)
endfun

" Show list of last-committed files
nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>

" DashSearch
" ===========
" Send a search term to Dash (documentation viewer)
nnoremap <silent> <leader>da <Plug>DashSearch
let g:dash_activate = 0

" HTML plugin
" ===========
"inoremap <buffer> > ></<C-x><C-o><C-y><C-o>%<CR><C-o>O
inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>
" vim-closetag
let g:closetag_filenames = '*.html, *,xhtml, *.phtml'
let g:closetag_xhtml_filenames = '*.xhtml, *.js, *,jsx'
let g:closetag_emptyTags_caseSensitive = 1

"" neco-ghc
"" ========
"" Haskell
"" disable vim default
"let g:haskellmode_completion_ghc = 0
"" Show types in completion suggestions
"let g:necoghc_enable_detailed_browse = 1
"" Disable hlint-refactor-vim's default keybindings
"let g:hlintRefactor#disableDefaultKeybindings = 1

"" hlint-refactor-vim keybindings
"map <silent> <leader>hr :call ApplyOneSuggestion()<CR>
"map <silent> <leader>hR :call ApplyOneSuggestion()<CR>

"" ghc-mod - type checker
"nnoremap <silent> <leader>ht :GhcModType<CR>
"nnoremap <silent> <leader>hT :GhcModTypeInsert<CR>
"nnoremap <silent> <leader>hs :GhcModSplitFunCase<CR>
"nnoremap <silent> <leader>he :GhcModTypeClear<CR>

"" Hoogle
"" ======
"nnoremap <silent> <leader>hh :Hoogle<CR>
"" prompt for input
"nnoremap <leader>hH :Hoogle
"" detailed documentation (e.g. "Functor")
"nnoremap <silent> <leader>hi :HoogleInfo<CR>
"" detailed documentation and prompt for input
"nnoremap <leader>hI :HoogleInfo
"" close the Hoogle window
"nnoremap <silent> <leader>hz :HoogleClose<CR>

" Enable vim's built-in omni-complete feature
" uses defaults informed by syntax to populate completion suggestions
" Note: This is the default; deoplete will take over when and if
"       configured. They can be what deoplete uses if
"       g:deoplete#omni#input_patterns is *not* {}
" Here are explicit settings of vim's built-in omnifunc capacity
" augroup omnifuncs
"   au!
"   au FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"   au FileType python setlocal omnifunc=pythoncomplete#Complete
"   au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end
"

" TODO: Maybe put this function onto functionComplete <c-x><c-u>
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview
set pumheight=30  " max height of popup before using scroll
                  " Note: deoplete has max candidates = 100

" deoplete
" ========
" Note: Make sure to use Plug to install and start tern with the
" --persistent flag, --verbose when debugging
" Debugging:
" 1. :echo &tags to make sure you are getting an
"    absolute file location; fully evaluated
" 2. :echo &omnifunc -> should be the wrapper jspc#omni
"    (it wraps tern#Complete, or deoplete-terns's equivalent)
" 3. fire-up a tern server with --verbose and --persistent options
"    from the same root project directory to view what is being
"    sent to deoplete throughout your coding session
" 4. turn deoplete debugging on and track the changing log with tail
"    (at best it gives you the sources being used)
" 5. call ctags from the terminal ctags -R <list directories>;
"    [specify options in .guttags or .ctags]
nnoremap <leader>dx :call deoplete#toggle()<CR>
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method='omnifunc'
let g:deoplete#auto_complete_start_length = 0
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1       " required for continous search
let g:deoplete#max_list = 100                  " default
let g:deoplete#max_menu_width = 30
" DEBUG
let g:deoplete#enable_profile = 1
call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')
call deoplete#custom#source('tern', 'is_debug_enabled', 1)

"" Deoplete TernJS source configuration
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#guess = 0
let g:deoplete#sources#ternjs#sort = 1
let g:deoplete#sources#ternjs#expand_word_forward = 1
let g:deoplete#sources#ternjs#include_keywords = 0

"Add extra filetypes that activate tern
"let g:deoplete#sources#ternjs#filetypes = [
"      \ 'jsx',
"      \ 'javascript',
"      \ 'javascript.jsx',
"      \ ]

" use deoplete-specific settings instead of omnifunc
" See: deoplete issue 352
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = ['ternjs#Complete', 'jspc#omni']
let g:deoplete#omni#functions.haskell = ['necoghc#omnifunc']

" Sources: Default is a long list including file, dictionary etc.
"          Turn on deoplete logging to see what is being sourced
"          for any one popup.
let g:deoplete#sources = {}
let g:deoplete#sources['javascript'] = ['around', 'neosnippet', 'tern', 'file/include']
" let g:deoplete#sources['javascript'] = ['file', 'file/include', 'tern']
" " let g:deoplete#sources['haskell'] = ['file', 'neosnippet', 'ghc']

" " Default rank is 100, higher is better.
call deoplete#custom#source('omni',          'mark', '⌾')
call deoplete#custom#source('tern',          'mark', '')  " tern not ternJS is the internal ref
call deoplete#custom#source('ghc',           'mark', '')
call deoplete#custom#source('vim',           'mark', '')
call deoplete#custom#source('tag',           'mark', '⌦')
call deoplete#custom#source('neosnippet',    'mark', '⌘')
call deoplete#custom#source('around',        'mark', '↻')
call deoplete#custom#source('buffer',        'mark', 'ℬ')
call deoplete#custom#source('syntax',        'mark', '♯')
call deoplete#custom#source('file',          'mark', 'F')
call deoplete#custom#source('file_include',  'mark', '⌁')
call deoplete#custom#source('member',        'mark', '.')

call deoplete#custom#source('vim',           'rank', 640)
call deoplete#custom#source('tern',          'rank', 620)
call deoplete#custom#source('ghc',           'rank', 620)
call deoplete#custom#source('tag',           'rank', 600)
call deoplete#custom#source('omni',          'rank', 550)
call deoplete#custom#source('neosnippet',    'rank', 510)
call deoplete#custom#source('member',        'rank', 500)
call deoplete#custom#source('file_include',  'rank', 420)
call deoplete#custom#source('file',          'rank', 410)
call deoplete#custom#source('around',        'rank', 330)
call deoplete#custom#source('buffer',        'rank', 320)
call deoplete#custom#source('dictionary',    'rank', 310)
call deoplete#custom#source('syntax',        'rank', 200)

" If using tern_for_vim
" let g:tern#command = ["tern"]
" let g:tern#arguments = ["--persistent"]

" neosnippet
" ===========
let g:my_snippet_manager = "neosnippet"
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='${HOME}/.config/nvim/snippets'
let g:neosnippet#disable_runtime_snippets = { '_' : 1, }

" Jump within a snippet with <C-k>
" Notes:
" 1. It must be "imap" and "smap".  It uses <Plug> mappings
" 2. Potential interaction with SuperTab
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab
" ========
"autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
inoremap <expr> <tab>  pumvisible() ? "\<C-n>" : "\<tab>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabDefaultCompletionType = "context"
" TODO: define a function for the user-defined <c-x><c-u>

" ALE - live linting
" ==================
" live piping of eslint and prettier linting
" information to my file
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '->'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_sign_column_always = 0
let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 1
" Notes:
" 1. jscs merged with eslint (jscs is not jspc)
" 2. I'm chosing to run prettier through eslint
"    (so where I see eslint, think eslint and prettier)
"    .eslint.json include:  extends: ["prettier"] to unify formatting
" 3. see .prettierrc for other options
" 4. prettier only needs ALE to work
" 5. add the following to package.json
"    eslint-check: eslint --print-config .eslintrc.js | eslint-config-prettier-check
let g:ale_linters = {
      \'jsx': ['eslint'],
      \'javascript': ['eslint'],
      \'json': ['jsonlint','prettier'],
      \'css': ['csslint','prettier'],
      \}
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier-eslint']
let g:ale_fixers['css'] = ['prettier']
let g:ale_javascript_prettier_use_local_config = 1
" let g:ale_linter_aliases = {'jsx': 'css'}
" " requires npm installs e.g., of prettier-eslint and config
" " autocmd FileType javascript set formatprg=prettier-eslint\ --stdin

" ALE map binding
nnoremap <silent> <leader>k <Plug>(ale_previous_wrap)
nnoremap <silent> <leader>j <Plug>(ale_next_wrap)

" Tweaks to the IDE-like popups
" remap enter when the completion menu is open (now selects the item)
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" keep searching while typing <C-n> behaves like a down arrow
inoremap <expr> <C-n> pumvisible() ? "\<C-n>" :
      \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? "\<C-n>" :
      \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" close the popup with esc
inoremap <expr> <esc> pumvisible()? deoplete#mappings#close_popup() : "\<esc>"

" Automating closing the preview window
" [populated with type and documentation about the chosen option]
" Manual: :pc, :pclose, :q
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" tabularize
" ===========
" formats text to align in a table format
" Usage:   :Tab /:\zs   |     :Tab /:
let g:haskell_tabular = 1
vnoremap a= :Tabularize /=<CR>
vnoremap a; :Tabularize /::<CR>
vnoremap a- :Tabularize /-><CR>
vnoremap a{ :Tabularize /{><CR>

" ctrl-p
" =======
" Silver search - faster and  hides unwanted
let g:ctrlp_use_caching = 0
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|.cabal-sandbox|.stack-work)$' }
" Open file menu
nnoremap <Leader>po :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>pb :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>pr :CtrlPMRUFiles<CR>
" Fuzzy find files
nnoremap <silent> <Leader>pf<space> :CtrlP<CR>
" fuzzy find buffers
nnoremap <silent> <leader>pb<space> :CtrlPBuffer<cr>

" ctags gutentags -- <C-[>
" ========================
let g:gutentags_enabled = 1
let g:gutentags_resolve_symlinks = 1
let g:gutentags_generate_on_missing = 1   " default = 1
" let g:gutentags_generate_on_new = 0       " default

" DEBUG set to 1
let g:gutentags_trace = 0
let g:gutentags_debug = 1

" Speed up searches by inserting the current directory at the top
let s:default_path = escape(&path, '\ ') " store default value of 'path'
augroup insertdir
  au!
  au BufRead *
        \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
        \ exec "set path-=".s:tempPath |
        \ exec "set path-=".s:default_path |
        \ exec "set path^=".s:tempPath |
        \ exec "set path^=".s:default_path
augroup END

" FileType (mostly) autocmd
augroup aus
  au!
  " set the working directory to the active file
  " au BufEnter * silent! lcd %:p:h
  " [see set autochdir]

  " Create a new directory if required
  au BufWritePre * call MkDir()

  " Trim trailing white space on save
  au BufWrite * :call TrimWhitespace()

  " Miscellaneous file types.
  au BufNewFile,BufRead .babelrc      setfiletype javascript
  au BufNewFile,BufRead .eslintrc     setfiletype json
  au BufNewFile,BufRead .reduxrc      setfiletype json
  au BufNewFile,BufRead .tern-config  setfiletype json
  au BufNewFile,BufRead .tern-project setfiletype json
  au BufNewFile,BufRead gitconfig     setfiletype gitconfig
  au BufNewFile,BufRead .jsx          setfiletype javascript
  au BufNewFile,BufRead .hs           setfiletype haskell
  au BufNewFile,BufRead .md           setfiletype markdown

  " oh-my-zsh file types
  au BufNewFile,BufRead *.zsh-theme   setfiletype sh
  au BufNewFile,BufRead *.zsh         setfiletype sh

  " Spellcheck for text files
  au BufNewFile,BufRead *.txt,*.md,*.mkd,*.markdown,*.rst setlocal spell
  au FileType gitcommit setlocal spell

  " Open quickfix window after grep
  au QuickFixCmdPost *grep* cwindow
  au FileType qf setlocal wrap nonumber colorcolumn=

  " Quick escape q to exit a help file
  " <buffer> means applies to current buffer only
  au Filetype help nnoremap <buffer> q :q<CR>
  au Filetype qf   nnoremap <buffer> q :q<CR>
  au WinEnter * if &previewwindow |
        \ setlocal wrap nonumber colorcolumn= |
        \ echom "preview set wrap" |
        \ endif
  " overide indentline use of conceal that hides quotes
  " au Filetype json let g:indentLine_setConceal=0
  " aka: let g:vim_json_syntax_conceal = 0

  " Resize panes whenever containing window resized.
  au VimResized * wincmd =

augroup END

" augroup haskell
"   au!
"   au FileType haskell nnoremap <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>
"   " Resolve ghcmod base directory
"   au FileType haskell let g:ghcmod_use_basedir = getcwd()
"   " Use hindent instead of par for haskell buffers
"   au FileType haskell let &formatprg="hindent --tab-size 2 -XQuasiQuotes"
"   au FileType haskell nnoremap <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>
"   au BufEnter /*.hs call LoadHscope()
"   au BufEnter hi! link Conceal Function
"   au FileType haskell set tags+=codex.tags;
"   au FileType haskell set cst
"   au FileType haskell set csverb
" augroup END
" " Must be set when first loaded
" " TODO: figure out impact on Haskell versus JS
" set csprg=hscope " cscope for haskell
" set csto=1       " search codex tags first

" Tag Generation (manual to force what is configured automagically)
au FileType javascript nnoremap <leader>tg :call GetNewTags()<cr>
fun! GetNewTags()
  call plug#load('vim-gutentags')
  if !exists("*GutentagsUpdate")
    echom "Gutentags is not active"
    return
  else
    call GutentagsUpdate
    echom "Updating Gutentags"
  endif
endfun


" TODO: Find a better place for these settings
let g:jsx_ext_required = 0          " Enable jsx for *.js files
let g:vim_json_syntax_conceal = 0   " Don't hide Json syntax.
let g:plug_timeout = 5              " Low vim-plug timeout to prevent long freeze

set shell=zsh
set hidden                      " Allow buffer change w/o saving/don't close when not visible
set history=1000                " Remember last 1000 commands
set viminfo='100,f1             " save marks and jumps for 100 files
set ignorecase                  " Make searching case insensitive
set smartcase                   " ... unless the query has capital letters.
set gdefault                    " Use 'g' flag by default with :s/foo/bar/.
set magic                       " Use 'magic' patterns (extended regular expressions).
set mouse=a                     " Default to mouse mode on
set ffs=unix,dos,mac            " Use Unix as the standard file type

set nobackup                    " No backup, since most stuff is in Git anyway...
set nowb
set noswapfile

set undofile
set undolevels=1000
set splitbelow                  " Horizontal splits - below
set splitright                  " Vertical splits - right
set autowrite                   " Write for me when I take any action
set relativenumber              " Combined with number; line number preference
set clipboard=unnamed           " Copy/paste in vi with Sierra OS
set encoding=UTF-8
set showmode
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set ut=1000                    " Change updatetime to faster than default 4 sec
set lazyredraw                 " Don't redraw while executing macros (good performance config)
set ruler                      " Always show current position
set number
set cmdheight=1                " Height of the command bar
set incsearch                  " Makes search act like search in modern browsers
set hlsearch                   " Highlight search results
set showmatch                  " Show matching brackets when text indicator is over them
set mat=2                      " How many tenths of a second to blink when matching brackets
set noerrorbells               " disable sound on errors
set vb t_vb=                   " disable screen flash
set list                       " Show trailing whitespace
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Autoscroll
" ==========
set scrolloff=10                " Keep at least X lines below cursor
set sidescrolloff=15
set sidescroll=1

" indentLine
" ===========
" Note: not compatible with Haskell
let g:indentLine_char = '┊'
let g:indentLine_fileTypeExclude = ['haskell','json','markdown','text','sh','vim']
let g:indentLine_faster=1
let g:indentLine_conceallevel=1
let g:indentLine_setConceal=1
" color
let g:indentLine_color_term=236
let g:indentLine_bgcolor_term='NONE'
" required if termguicolors is set
let g:indentLine_color_gui='#1E1E1E'  " #303030
let g:indentLine_bgcolor_gui='NONE'

" Syntax highlighting
" ===================
" settings that nvim runs by default
"syntax on
"filetype on
"filetype plugin on
"filetype plugin indent on
"filetype indent on
"if !exists("g:syntax_on")
"  syntax enable
"endif

" VIM :Command completion
" ========================
" tab-complete up to longest unambiguous prefix
set wildmenu
set wildmode=list:longest,full
set wildignore+=build,cache,dist,coverage,node_modules

" Visual tweaks
" =============
"set cursorcolumn " Highlight the column of the cursor
set textwidth=80
set colorcolumn=+1
set nowrap
set linebreak

" Folding
" =======
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
" Note: nofoldenable gets toggled with the first use of zc
"       setting the value here now as `no` prevents folds
"       being closed upon opening the buffer.

" Real programmers don't use TABs
" ===============================
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab

" vim-jsx-pretty
" ==============
let g:vim_jsx_pretty_colorful_config = 1

" Remove whitespace
" =================
" Called with autocmd
fun! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfun

" Auto magically Mkdir
" ====================
" Conditionaly create the parent directory when writing to disk
" Called with autocmd
fun! MkDir()
  if !isdirectory(expand("<afile>:p:h"))
    let confirmation=confirm("Create a new directory?", "&Yes\n&No")
    if confirmation == 1
      call mkdir(expand("<afile>:p:h"), "p")
      lcd %:p:h
      saveas %:t
      echom "Created a new directory:" expand("<afile>:p:h")
      let buf_del = bufnr("$")
      exe "bd" . buf_del
    endif
    redraw
  endif
endfun
" <afile> refers to the file we are saving
" :p is a modifier that expands to full filename
" :h is a modifier that removes the file from full filename
" :t is a modifier that generates the filename with extension
" "p" is the flag that will create all the parent directories

" Logging
" Note: use with tail -f /tmp/vim.log
func! ToggleVerbose()
  if !&verbose
    set verbosefile=/tmp/vim.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunc

" Send command output to a new tab
" =================================
" Note: At it's simplest
" :redir @a   - redirect output to the a register
" :set all    - run a command that generates output
" :redir END  - end the redirect
"             - create a new buffer and paste in @a
" Usage:  :TabMessage <:command>
"
fun! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new" for new window, "tabnew" for new tab, "enew" for new buffer
    enew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfun
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" Text file settings
fun! ToggleText()
  if !&wrap
    set wrap linebreak nolist
    set textwidth=0
    set wrapmargin=0
  else
    set nowrap
    set nolinebreak
    set list
  endif
endfun

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

" Utility fn to reveal current color scheme
" Usage: :call ShowColorSchemeName()
func! ShowColorSchemeName()
  try
    echo g:colors_name
  catch /^Vim:E121/
    echo "default
  endtry
endfunc

" Utility fn to reveal highlight group of word below the cursor
" Usage: :set statusline+=%{HiGroup()}
func! HiGroup()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunc

" nnoremap <leader>hg :call <SID>SynStack()<CR>
" fun! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc

" More Haskell
" stack bin path
" let haskell_config_dir = $HOME . "/.config/nvim/haskell"
" let haskell_stack_bin = expand(resolve(haskell_config_dir . "/.stack-bin"))
" let $PATH = $PATH . expand(haskell_stack_bin) . ':'

" " Pretty unicode haskell symbols
" let g:haskell_conceal_wide = 1
" let g:haskell_conceal_enumerations = 1
" let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻w"

" let g:tagbar_type_haskell = {
"       \ 'ctagsbin'  : 'hasktags',
"       \ 'ctagsargs' : '-x -c -o-',
"       \ 'kinds'     : [
"       \  'm:modules:0:1',
"       \  'd:data: 0:1',
"       \  'd_gadt: data gadt:0:1',
"       \  't:type names:0:1',
"       \  'nt:new types:0:1',
"       \  'c:classes:0:1',
"       \  'cons:constructors:1:1',
"       \  'c_gadt:constructor gadt:1:1',
"       \  'c_a:constructor accessors:1:1',
"       \  'ft:function types:1:1',
"       \  'fi:function implementations:0:1',
"       \  'o:others:0:1'
"       \ ],
"       \ 'sro'        : '.',
"       \ 'kind2scope' : {
"       \ 'm' : 'module',
"       \ 'c' : 'class',
"       \ 'd' : 'data',
"       \ 't' : 'type'
"       \ },
"       \ 'scope2kind' : {
"       \ 'module' : 'm',
"       \ 'class'  : 'c',
"       \ 'data'   : 'd',
"       \ 'type'   : 't'
"       \ }
"       \ }

" Automatically make cscope connections
" Called with .hs specific autocmd
func! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunc

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

func! Pointfree()
  call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunc
vnoremap <silent> <leader>h. :call Pointfree()<CR>

func! Pointful()
  call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunc
vnoremap <silent> <leader>h> :call Pointful()<CR>

" Color Themes
" ============
" Notes:
" 1. Set before setting the colorscheme
" 2. Visit https://github.com/ryanoasis/nerd-fonts#font-installation
"    to see the range of options for setting icon displays
set termguicolors    " Enable true color support in terminal
set background=dark  " best for my transparent term configuration
set guifont=Hasklig\ Light\ Nerd\ Font\ Complete:h13

" Color scheme
" ============
" Notes:
" 1. This must be at the very end of the file
" 2. Setting termguicolors will alter behavior
" 3. :help colorscheme for more information
try
  " colorscheme nova
  " colorscheme solarized8
  colorscheme wombat256mod
catch
  echom 'error with colorscheme'
endtry

" Limit the use of devicon fonts
let g:webdevicons_enable_airline_tabline = 0
let g:WebDevIconsUnicodeDecorateFileNodes = 0

" vim-airline banners
" ====================
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif

" Custom colors
" =============
" Notes:
" 1. Overwrites loaded colorscheme
" 2. iTerm2 v3 controls the cursor color and how bold
"    fonts are displayed
" 3. Call :hi to see a full list of syntax objects

" Use same color behind concealed unicode characters
hi clear Conceal

" vim-airline customization
" =========================
" colors[guifg, guibg, ctermfg, ctermbg]
let g:airline_theme_patch_func = 'AirlineThemePatch'
fun! AirlineThemePatch(palette)
  if g:airline_theme == 'badwolf'
    for colors in values(a:palette.inactive)
      let colors[0] = '#9E9E9E'
      let colors[1] = '#141414'
      let colors[2] = 248
      let colors[3] = 235
    endfor
  endif
endfun

" Parent highlighting groups
" ==========================
hi Normal        ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi Error         ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi ErrorMsg      ctermbg=NONE guibg=NONE cterm=NONE gui=NONE

" White space and related
" [link undefined to defined]
hi NonText       ctermfg=244  guifg=#808080 cterm=NONE gui=NONE
hi! link SpecialKey   NonText
hi! link LineNr       NonText
hi CursorLineNR ctermfg=227  guifg=#FFFF5F cterm=NONE gui=NONE

" Messages
hi ErrorMsg      ctermfg=203  guifg=#FF5F55
hi! link Error ErrorMsg
hi WarningMsg    ctermfg=192  guifg=#CAE982
hi! link MoreMsg Question

" Popup
" hi PMenu         ctermbg=NONE guibg=NONE gui=NONE
" hi PMenuSel      ctermbg=NONE guibg=NONE gui=NONE
" hi PMenuSbar     ctermbg=NONE guibg=NONE gui=NONE
" hi! link PMenu Folded

hi Comment       ctermfg=72   guifg=#83A8C1
hi Todo          ctermfg=234  guifg=#1C1C1C ctermbg=227 guibg=#FFFF5F gui=NONE
hi! link Visual Search

" ALE
hi! link ALEErrorSign DiffText
hi! link ALEWarningSign WarningMsg
hi! link ALEStyleErrorSign Search
" Note: SpellBad, SpellCap, Error and Todo can be
" used depending on what the linters produce

" Window and folds
hi VertSplit    ctermfg=51   guifg=#00FFFF " turquoise
hi StatusLine   ctermfg=51   guifg=#00FFFF " turquoise
hi StatusLineNC ctermfg=51   guifg=#00FFFF " turquoise
hi Folded       ctermfg=250  ctermbg=235 guifg=#A8A8A8 guibg=#262626
hi FoldedColumn ctermfg=250  ctermbg=235 guifg=#A8A8A8 guibg=#262626
hi! link SignColumn LineNr
