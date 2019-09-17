" -------------------------------------------------------------------------------
" ~/.config/nvim/init.vim
" last updated: Dec 21, 2017
" -------------------------------------------------------------------------------
" Debugging tips
" insert :finish anywhere where you want the script to stop
"         use a binary search to split in half the source of the problem
"         with each iteration.
" :set verbose=[0-9]
"   e.g., set verbose=2 | :w | set verbose=0
"   e.g., set verbosefile=~/tmp | 15verbose echo "foo" | vsplit /tmp
" :debug <cmd>
" :see help >cont, :breakadd _del and _list
" :scriptnames to see what is running
" :GetSettingsFor <setting>
" :TabMessage <command>
" :syntax list
" :call ToggleVerbose()
" :setlocal makeprg=... , confirm: echo &makeprg
" :$VIMRUNTIME/debugscript.vim

" TODO: Coordinate any conflicts between Haskell and JS
" TODO: map to a macro that copies the word above the cursor
" TESTING
" inoremap <ctr-g><ctr-f> <esc>kbywj0pA

set nocompatible " No VI compatibility
set autoread     " Detect file changes outside vim

" Improves how C-x C-f works
" use set noautochdir to turn it off
set autochdir    " change working dir to current buffer

" -------------------------------------------------------------------------------
" Neovim's Python provider(s)
" -------------------------------------------------------------------------------
let g:loaded_python_provider = 1
let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
" Note: disable by setting g:loaded_python_provider = 1
" Note: disable by setting g:loaded_python3_provider = 1
" -------------------------------------------------------------------------------

" -------------------------------------------------------------------------------
"  Change the underlying shell to support vim/neovim
" -------------------------------------------------------------------------------
" if $shell =~# 'fish$'
  " set shell=zsh
" endif
set shell=zsh
" set shell=fish

" esc key with cursor moved forward
inoremap df <esc>l

" Leader key and timeout
let mapleader = "\<SPACE>"
set tm=1100

" Spelling
set spelllang=en
set spellfile=$HOME/dotfiles/en.utf-8.add

" TODO: This relates to passing commands to tmux
"       It may not be required anymore.
"       Recall using it to enable alt-hjkl to size window
"disable submode timeouts:
let g:submode_timeout = 500
" don't consume submode-leaving key
let g:submode_keep_leaving_key = 1

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,
      \i-ci:ver25-Cursor/lCursor,
      \r:hor50-Cursor

" Line formatting
" TODO: how does it work with syntax based formatting
" Note: ALE may also set this option
set formatprg=par
let $PARINIT = 'rTbgqR B=.,?_A_a Q=_s>|'

" use autoformat plugin instead
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" Kill the damned Ex mode (no operation).
nnoremap Q <nop>

" Make <c-h> work like <c-h> again (a 2015 libterm issue)
nnoremap <BS> <C-w>h

" Save and load views
" Recall using bang silences errors not finding .vim
augroup SaveView
  au!
  au BufWinLeave *.* mkview
  au BufWinEnter *.* silent! loadview
augroup END

" ---------------------------
" Tweaks to default mappings
" ---------------------------
" TESTING to solve the problem that EasyMotion does not trigger
" TODO: Update with noremap
" <Leader>f{char} to move to {char}

" echodoc
" =======
" toggle set noshowmode || set cmdheight=2 (see elsewhere)
" toggle activation: :EchoDocEnable
let g:echodoc_enable_at_startup = 1
let g:echodoc#enable_force_overwrite = 1


" Improve Vim capacity to capture tmux active/inactive events
" vim-tmux-focus-events
" vim-diminactive
" =====================
let g:diminactive_enable_focus = 1

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

" CtrlP plugin
" ============
" set the root directory to vim's working directory
" let g:ctrlp_cmd='CtrlP :pwd'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" HTML plugin
" ===========
"inoremap <buffer> > ></<C-x><C-o><C-y><C-o>%<CR><C-o>O
inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>
" vim-closetag
let g:closetag_filenames = '*.html, *,xhtml, *.phtml'
let g:closetag_xhtml_filenames = '*.xhtml, *.js, *,jsx'
let g:closetag_emptyTags_caseSensitive = 1

" Do not use this compatibility feature; breaks clean use of <c-k>
" let g:neosnippet#enable_snipmate_compatibility = 1

" Notes:
" 1. It must be "imap" and "smap".  It uses <Plug> mappings
" 2. Potential interaction with SuperTab
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" NerdTree configuration
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
" let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

autocmd FileType json syntax match Comment +\/\/.\+$+

"" ALE - live linting
"" ==================
"" Linter
"" Let ALE be what is called when manually calling for a linter
"" set omnifunc=ale#completion#OmniFunc
"
"" set when the linting is triggered (on change of buffer)
"
"" let g:ale_lint_on_text_changed = 'never'
"" let g:ale_lint_on_insert_leave = 1
"" let g:ale_lint_on_save = 0
"" let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1
let g:ale_fix_on_save = 1
"
let g:ale_rust_rls_config = {
  \ 'rust': {
    \ 'all_targets': 1,
    \ 'build_on_save': 1,
    \ 'clippy_preference': 'on'
  \ }
\ }
let g:ale_rust_rls_toolchain = ''
let g:ale_sign_error = ">>"
let g:ale_sign_warning = "->"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"
"
"nnoremap <silent> K :ALEHover<CR>
"nnoremap <silent> gd :ALEGoToDefinition<CR>
"let g:ale_completion_enabled = 1
let g:ale_rust_cargo_use_clippy = 1         "improves code syntax
let g:ale_rust_cargo_clippy_options =
      \'-- -W clippy::nursery -W clippy::pedantic'

"" live piping of eslint and prettier linting
"" information to my file
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 0
"let g:ale_open_list = 0                " open the quickfix window
"let g:ale_sign_column_always = 0
"" let g:airline#extensions#ale#enabled = 1
"" JS specific Notes:
"" 1. jscs merged with eslint (jscs is not jspc)
"" 2. I'm chosing to run prettier through eslint
""    (so where I see eslint, think eslint and prettier)
""    .eslint.json include:  extends: ["prettier"] to unify formatting
"" 3. prettier only needs ALE to work
"" 4. add the following to package.json
""    eslint-check: eslint --print-config .eslintrc.js | eslint-config-prettier-check
"" 5. eslint should be installed locally (not global)
let b:ale_linters = {}
let b:ale_linters = {
      \'javascript': ['eslint'],
      \'javascript.jsx': ['eslint'],
      \'jsx': ['eslint'],
      \'json': ['jsonlint','prettier'],
      \'css': ['csslint','prettier'],
      \'haskell': ['stack-ghc-mod','hdevtools'],
      \'rust': ['rls'],
      \'python': ['flake8'],
      \}
"" \'rust': ['rustc', 'rls'],
"" \'haskell': ['hlint','stack-ghc-mod','stack-build','stack-ghc','hdevtools'],
"" : ['eslint', 'flow', 'flow-language-server', 'jscs', 'jshint', 'standard', 'tsserver', 'xo']
"" let g:ale_fixers['javascript'] = ['eslint', 'importjs']
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fixers['javascript.jsx'] = ['eslint']
let g:ale_fixers['jsx'] = ['eslint']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['rust'] = ['rustfmt']
let g:ale_fixers['python'] = ['yapf']
"" let g:ale_javascript_prettier_use_local_config = 1
"" let g:ale_linter_aliases = {'jsx': 'css'}
"" " requires npm installs e.g., of prettier-eslint and config
"" " autocmd FileType javascript set formatprg=prettier-eslint\ --stdin

" ctags gutentags -- <C-[>
" ========================
let g:gutentags_enabled = 1
let g:gutentags_resolve_symlinks = 1
let g:gutentags_generate_on_missing = 1   " default = 1
" let g:gutentags_generate_on_new = 0       " default

" DEBUG set to 1
let g:gutentags_trace = 0
let g:gutentags_debug = 0

" FileType (mostly) autocmd
" Note: vim puts these commands in a command group already.
" Miscellaneous file types to augment vim's default
augroup FiletypeGroup
    autocmd!
au BufNewFile,BufRead .babelrc      setf javascript
au BufNewFile,BufRead .eslintrc     setf json
au BufNewFile,BufRead *.reduxrc     setf json
au BufNewFile,BufRead .tern-config  setf json
au BufNewFile,BufRead .tern-project setf json
au BufNewFile,BufRead gitconfig     setf gitconfig
au BufNewFile,BufRead *.hs          setf haskell
au BufNewFile,BufRead *.yaml        setf yaml
au BufNewFile,BufRead *.toml        setf toml
au BufNewFile,BufRead *.fish        setf fish
au BufNewFile,BufRead *.md          setf markdown.pandoc
au BufNewFile,BufRead *.jsx         setf javascript.jsx
au Filetype fish :compiler fish
" oh-my-zsh file types
au BufNewFile,BufRead *.zsh-theme   setfiletype sh
au BufNewFile,BufRead *.zsh         setfiletype sh
augroup END

augroup misc
  au!
  " set the working directory to the active file
  " au BufEnter * silent! lcd %:p:h
  " [see set autochdir]

  " Create a new directory if required
  au BufWritePre * call MkDir()

  " Trim trailing white space on save
  au BufWrite * :call TrimWhitespace()

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

" HASKELL specific
" SOURCE
source $HOME/dotfiles/nvim-haskell-extras.vim

" Must be set when first loaded
" TODO: figure out impact on Haskell versus JS
set csprg=hscope   " cscope for haskell
set cscoperelative " this generates a full path

" Linting
" au FileType haskell let g:hdevtools_options = '-g -isrc -g -Wall -g -hide-package -g transformers -g -v'
let g:hdevtools_options = '-g -isrc -g -Wall -g -hide-package -g transformers -g -v'
" let g:ale_haskell_hdevtools_options = '-g -isrc -g -Wall -g -hide-package -g transformers -g -v'
" let g:ale_haskell_ghc_options = '-g -isrc -g -Wall -g -hide-package -g transformers -g -v'

" neco-ghc
" ========
" disable vim default (necoghc set in haskell filetype)
let g:haskellmode_completion_ghc = 0
" Use stack
let g:necoghc_use_stack = 1
" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1
" Disable hlint-refactor-vim's default keybindings
let g:hlintRefactor#disableDefaultKeybindings = 1

nnoremap <silent> <leader>hz :HoogleClose<CR>
" END HASKELL specific


" TODO: Find a better place for these settings
let g:jsx_ext_required = 0          " Enable jsx for *.js files

" vim-javascript
" ==============
let g:javascript_plugin_jsdoc = 1   " syntax highlighting for jsdoc

let g:vim_json_syntax_conceal = 0   " Don't hide Json syntax.
let g:plug_timeout = 5              " Low vim-plug timeout to prevent long freeze

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

set splitbelow                  " Horizontal splits - below
set splitright                  " Vertical splits - right
set autowrite                   " Write for me when I take any action
set relativenumber              " Combined with number; line number preference
set clipboard=unnamed           " Copy/paste in vi with Sierra OS
set encoding=UTF-8
set showmode                    " Toggle this to noshowmode to enable echodoc
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox

set updatetime=300              " Change updatetime to faster than default 4 sec
set lazyredraw                  " Don't redraw while executing macros (good performance config)
" set ruler                       " Always show current position
set number
set cmdheight=2                 " Height of the command bar
set incsearch                   " Makes search act like search in modern browsers
set hlsearch                    " Highlight search results
set showmatch                   " Show matching brackets when text indicator is over them
set mat=2                       " How many tenths of a second to blink when matching brackets
set noerrorbells                " disable sound on errors
set vb t_vb=                    " disable screen flash
set list                        " Show trailing whitespace

" Permanent undo
set undodir=~/.vimdid
set undolevels=1000
set undofile

" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Autoscroll
" ==========
set scrolloff=20                " Keep at least X lines below cursor
set sidescrolloff=5
set sidescroll=1

" indentLine
" ===========
" Note: not compatible with Haskell
let g:indentLine_char = '┊'

let g:indentLine_fileTypeExclude =
      \ ['haskell','haskellstack','cabal','haskellhpack',
      \  'json','yaml','markdown','pandoc','text','txt',
      \  'sh','vim','tmux','help']

let g:indentLine_setConceal=1
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_faster=1
" color
let g:indentLine_color_term=236
let g:indentLine_bgcolor_term='NONE'
" required if termguicolors is set
let g:indentLine_color_term = 239
let g:indentLine_color_gui='#555555'  "'#1E1E1E'   #303030
let g:indentLine_bgcolor_gui='NONE'

" Syntax highlighting and indentation
" ===================================
" settings that nvim runs by default
"syntax on
filetype on
filetype plugin on
filetype plugin indent on
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
set foldmethod=marker
set foldnestmax=5
set nofoldenable
"set foldlevelstart
set foldminlines=5
" Note: nofoldenable gets toggled with the first use of zc
"       setting the value here now as `no` prevents folds
"       being closed upon opening the buffer.

" Use this in combination with zm or zr to sequentially increase
" the fold levels.
autocmd BufWinEnter *
      \ let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

" Real programmers don't use TABs
" ===============================
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

" vim-jsx-pretty
" ==============
let g:vim_jsx_pretty_colorful_config = 1      " default 0
let g:vim_jsx_pretty_enable_jsx_highlight = 0 " default 1

" rustfmt
let g:rustfmt_autosave = 1

" typescript
let g:yats_host_keyword = 1  " syntax config file for yats

" HASKELL specific
" More Haskell
" stack bin path
let haskell_config_dir = $HOME
" let haskell_stack_bin = expand(resolve(haskell_config_dir . "/.stack-bin"))
let haskell_stack_bin = expand(resolve(haskell_config_dir . "/.local/bin"))
let $PATH = $PATH . expand(haskell_stack_bin) . ':'

" Pretty unicode haskell symbols
let g:haskell_conceal_wide = 1
let g:haskell_conceal_enumerations = 1
let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻w"

let g:tagbar_type_haskell = {
      \ 'ctagsbin'  : 'hasktags',
      \ 'ctagsargs' : '-x -c -o-',
      \ 'kinds'     : [
      \  'm:modules:0:1',
      \  'd:data: 0:1',
      \  'd_gadt: data gadt:0:1',
      \  't:type names:0:1',
      \  'nt:new types:0:1',
      \  'c:classes:0:1',
      \  'cons:constructors:1:1',
      \  'c_gadt:constructor gadt:1:1',
      \  'c_a:constructor accessors:1:1',
      \  'ft:function types:1:1',
      \  'fi:function implementations:0:1',
      \  'o:others:0:1'
      \ ],
      \ 'sro'        : '.',
      \ 'kind2scope' : {
      \ 'm' : 'module',
      \ 'c' : 'class',
      \ 'd' : 'data',
      \ 't' : 'type'
      \ },
      \ 'scope2kind' : {
      \ 'module' : 'm',
      \ 'class'  : 'c',
      \ 'data'   : 'd',
      \ 'type'   : 't'
      \ }
      \ }

if executable('lushtags')
  let g:tagbar_type_haskell = {
        \ 'ctagsbin' : 'lushtags',
        \ 'ctagsargs' : '--ignore-parse-error --',
        \ 'kinds' : [
        \ 'm:module:0',
        \ 'e:exports:1',
        \ 'i:imports:1',
        \ 't:declarations:0',
        \ 'F:fields:1',
        \ 'd:declarations:1',
        \ 'n:declarations:1',
        \ 'f:functions:0',
        \ 'c:constructors:0'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
        \ 'd' : 'data',
        \ 'n' : 'newtype',
        \ 'c' : 'constructor',
        \ 't' : 'type',
        \ 'F' : 'field'
        \ },
        \ 'scope2kind' : {
        \ 'data' : 'd',
        \ 'newtype' : 'n',
        \ 'constructor' : 'c',
        \ 'type' : 't',
        \ 'field' : 'F'
        \ }
        \ }
endif
" END HASKELL

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

func! Pointfree()
  call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunc

func! Pointful()
  call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunc

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
set laststatus=2   " `always` display a statusline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
" index tabs 1..n
let g:airline#extensions#tabline#buffer_idx_mode = 1
nnoremap <leader>1 :exe "normal \<Plug>AirlineSelectTab1"<CR>
nnoremap <leader>2 :exe "normal \<Plug>AirlineSelectTab2"<CR>
nnoremap <leader>3 :exe "normal \<Plug>AirlineSelectTab3"<CR>
nnoremap <leader>4 :exe "normal \<Plug>AirlineSelectTab4"<CR>
nnoremap <leader>5 :exe "normal \<Plug>AirlineSelectTab5"<CR>
nnoremap <leader>6 :exe "normal \<Plug>AirlineSelectTab6"<CR>
nnoremap <leader>7 :exe "normal \<Plug>AirlineSelectTab7"<CR>
nnoremap <leader>8 :exe "normal \<Plug>AirlineSelectTab8"<CR>
nnoremap <leader>9 :exe "normal \<Plug>AirlineSelectTab9"<CR>
" TODO: Create a function that works in combination with
"       a command to increment to the next tab.
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
      let colors[1] = '#212121'
      let colors[2] = 248
      let colors[3] = 235
    endfor
  endif
endfun

" Parent highlighting groups
" ==========================
" Note: Normal gui=NONE is required to enable the active/inactive pane
" configuration in tmux
hi Normal        ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi Error         ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi ErrorMsg      ctermbg=NONE guibg=NONE cterm=NONE gui=NONE

" Inactive vim window (plugin vim-diminactive)
hi ColorColumn   ctermbg=235 guibg=#212121  " 1E1E1E is also good
" Match with Tmux inactive and Airline

" Search - improve contrast and match Airline Theme
" may want to link to Visual
hi Search        ctermfg=214 ctermbg=238 guifg=#ffa724 guibg=#45413b

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

" Coc
hi! link CocErrorSign DiffText
hi! link CocWarningSign WarningMsg
hi! link CocInfoSign WarningMsg
hi! link CocHintSign Comment

" ALE
hi ALEVirtualTextWarning guifg=#00FFFF
hi ALEVirtualTextInfo    guifg=#00FFFF
hi ALEVirtualTextError   guifg=#00FFFF
hi ALEError guibg=None
hi ALEWarning guibg=None
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

" jsx pretty syntax highlighting
hi def link  jsxTag          Function
hi def link  jsxTagName      Function
hi def link  jsxString       String
hi def link  jsxNameSpace    Function
hi def link  jsxComment      Error
hi def link  jsxAttrib       Type
hi def link  jsxEscapeJs     jsxEscapeJs
hi def link  jsxCloseTag     Identifier
hi def link  jsxCloseString  Identifier
hi jsxClass  ctermfg=100 guifg=#D4AC0D
hi def link  xmlTagName      jsxClass
hi def link  jsxCloseClass     jsxClass
hi def link  jsClassDefinition jsxClass
hi def link  jsObjectKey       Identifier
hi xmlAttrib  ctermfg=100 guifg=#873DA0
hi jsBraces   ctermfg=100 guifg=#9AA436
" hi jsxClass  ctermfg=72 guifg=#5FAF87
