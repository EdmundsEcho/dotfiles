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

" TODO: generate a version for Haskell

set nocompatible " No VI compatibility
set autoread     " Detect file changes outside vim
set autochdir    " change working dir to current buffer
" TODO: may improve how C-x C-f works

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
set tm=1100

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
nnoremap 00 0
nnoremap gg :0<CR>
nnoremap G G$

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
" d[elete] c[hange] y[ank]
" p -> parentheses
" b -> bracket
" e.g., change contents between () with cp
onoremap p i(
onoremap b i{
onoremap np :<c-u>normal! f(lvi(<cr>
onoremap nb :<c-u>normal! f{lvi{<cr>
onoremap pp :<c-u>normal! F(lvi(<cr>
onoremap pb :<c-u>normal! F{lvi{<cr>

" Map esc to remove highlighting of previous search
nnoremap <esc> :noh<return><esc>

" TODO: This relates to passing commands to tmux
"       It may not be required anymore.
"       Recall using it to enable alt-hjkl to size window
"disable submode timeouts:
let g:submode_timeout = 500
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

" Git
" =====
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gg :copen<CR>:GGrep
nnoremap <leader>gl :Extradite!<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>

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

" FileType (mostly) autocmd
augroup fileTypes
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

  " Resize panes whenever containing window resized.
  au VimResized * wincmd =

augroup END

augroup previewWindow
  au!
  au WinEnter * if &previewwindow |
        \ setlocal wrap nonumber colorcolumn= |
        \ echom "preview set wrap and nonumber" |
        \ endif
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

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

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
