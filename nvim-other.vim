" -------------------------------------------------------------------------------
" ~/.config/nvim/init.vim
" last updated: Mar 20, 2022
" -------------------------------------------------------------------------------
" Next: Keep an eye on nvim-lsp; it is going to be the built-in lsp. It would
" obviate the need for coc
"
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

" ⬜ map to a macro that copies the word above the cursor
"
" 🔧 Tools to use more often
" Send command output to the clipboard
" :redir @*
" :redir END
"
" TESTING
" inoremap <ctr-g><ctr-f> <esc>kbywj0pA

" -------------------------------------------------------------------------------
"  Change the underlying shell to support vim/neovim
"  (fish shell is insufficiently POSIX compliant)
" -------------------------------------------------------------------------------
if $SHELL =~ 'bin/fish'
  set shell=/bin/sh
endif
" Prepend mise shims to PATH
let $PATH = $HOME . '/.local/share/mise/shims:' . $PATH

set nocompatible " No VI compatibility
set autoread     " Detect file changes outside vim

" Improves how C-x C-f works
" use set noautochdir to turn it off
" manually :lcd %:p:h
set autochdir    " change working dir to current buffer

" turn off default services
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0

" enable virtual text
let g:diagnostic_enable_virtual_text = 1
" let g:diagnostic_virtual_text_prefix = ' '

" -------------------------------------------------------------------------------
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


" Line formatting
" TODO: how does it work with syntax based formatting
set formatprg=par
let $PARINIT = 'rTbgqR B=.,?_A_a Q=_s>|'

" ripgrep
" Option 1 using :Rg
" ==================
" Installed using cargo; must be in PATH
" Usage
" Search for foo in current working directory: :grep foo.
" Search for foo in files under src/: :grep foo src.
" Search for foo in current file directory: :grep foo %:h1.
" Search for foo in current file directory’s parent directory: :grep foo %:h:h (and so on).
" :grep foo `git ls-files --modified`
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif
" Option 2 using :Rg
let g:rg_path = "$HOME/.cargo/bin/rg"

" markdown composer
" =================
let g:markdown_composer_autostart = 1
" let g:markdown_composer_external_renderer='pandoc -f markdown -t html'

" vim-autoformat
" ==============
" use autoformat plugin instead
" augment pointers to formatters
let g:formatterpath = ['/Users/edmund/.local/bin/ormolu', '/Users/edmund/.local/bin/stylish-haskell']
" let g:formatterpath = ['/Users/edmund/.local/bin/hindent']
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
" set the formatter for haskell (default is p)
" formatters_<filetype>
" let g:formatdef_custom_haskell = '"ormolu"'
let g:formatdef_custom_haskell = '"stylish-haskell"'
let g:formatters_haskell = ['custom_haskell']
" debug
" let g:autoformat_verbosemode=1

" vimspector
" ==========
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70

" Kill the damned Ex mode (no operation).
nnoremap Q <nop>

" Make <c-h> work like <c-h> again (a 2015 libterm issue)
nnoremap <BS> <C-w>h

" Save and load views
" Recall using bang silences errors not finding .vim
augroup SaveView
  autocmd!
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup END
set viewoptions=folds,cursor
set sessionoptions=folds

" ---------------------------
" Tweaks to default mappings
" ---------------------------
" TESTING to solve the problem that EasyMotion does not trigger
" TODO: Update with noremap
" <Leader>f{char} to move to {char}

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

" 🦀 ??
" REQUIRED (Dec 2017)
" Make Vim recognize XTerm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
"if &term =~ '^screen'
"  " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
"  execute "set t_kP=\e[5;*~"
"  execute "set t_kN=\e[6;*~"
"
"  " Arrow keys http://unix.stackexchange.com/a/34723
"  execute "set <xUp>=\e[1;*A"
"  execute "set <xDown>=\e[1;*B"
"  execute "set <xRight>=\e[1;*C"
"  execute "set <xLeft>=\e[1;*D"
"endif

" SimpylFold fold plugin (Python focus)
" =====================================
let g:SimpylFold_docstring_preview=1

" CtrlP plugin
" ============
" set the root directory to vim's working directory
" let g:ctrlp_cmd='CtrlP :pwd'
let g:ctrlp_working_path_mode = 'ra'
" inactive when using user_command (see below)
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|hg|svn)|node_modules|build|dist$',
"   \ 'file': '\v\.(exe|so|dll)$',
"   \ 'link': 'some_bad_symbolic_links',
"   \ }
" file listing command for MacOSX
let g:ctrlp_user_command = 'find %s -type d \( ' .
                         \ '-name target ' .
                         \ '-o -name node_modules ' .
                         \ '-o -name .git ' .
                         \ '-o -name build ' .
                         \ '-o -name include ' .
                         \ '-o -name .venv ' .
                         \ '-o -name .pytest_cache ' .
                         \ '-o -name .mypy_cache ' .
                         \ '-o -name .ruff_cache ' .
                         \ '\) -prune -o -type f'
" list of files to hide in Explore
let g:netrw_list_hide = {}
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

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

" lspconfig
" format on save
" =================
" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" ctags gutentags -- <C-[>
" ========================
let g:gutentags_enabled = 1
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', 'Cargo.toml', '.git', '.gitignore']

let g:gutentags_resolve_symlinks = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
" put the ctags into a single cache
let g:gutentags_cache_dir = expand('~/.cache/ctags/')
set tags=./tags;,tags;

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
  " au BufNewFile,BufRead *.md          setf markdown.pandoc
  au BufNewFile,BufRead *.jsx         setf javascript.jsx
  " oh-my-zsh file types
  au BufNewFile,BufRead *.zsh-theme   setfiletype sh
  au BufNewFile,BufRead *.zsh         setfiletype sh
augroup END

" javascript
" https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
" TODO: move this to after/ftplugin
augroup JavaScript
  autocmd!
  " au FileType javascript setlocal foldmethod=indent
  " au BufWritePre *.{js,jsx,ts,tsx} call CocAction('runCommand', 'eslint.executeAutoFix')
  au BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  " prevent highlighting mistakes
  au BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  " au BufWritePre *.{js,jsx,ts,tsx} EslintFixAll
  " NEW 🦀 ?
augroup END

augroup misc
  au!
  " set the working directory to the active file
  " au BufEnter * silent! lcd %:p:h
  " [see set autochdir]

  " Create a new directory if required
  au BufWritePre * call MkDir()

  " Trim trailing white space on save
  au BufWrite * call TrimWhitespace()

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
  au Filetype qf   nnoremap <buffer> <CR> <CR>

  " Resize panes whenever containing window resized.
  au VimResized * wincmd =

  " TEST formatting on save
  " au BufWrite * :Autoformat
augroup END

augroup previewWindow
  au!
  au WinEnter * if &previewwindow |
        \ setlocal wrap nonumber colorcolumn= |
        \ echom "preview set wrap and nonumber" |
        \ endif
augroup END

" HASKELL specific
" TODO: Integrate with after/ftplugin
" source $HOME/dotfiles/nvim-haskell-extras.vim

" TODO: Find a better place for these settings
let g:jsx_ext_required = 0          " Enable jsx for *.js files

" vim-javascript
" ==============
let g:javascript_plugin_jsdoc = 1   " syntax highlighting for jsdoc
let g:javascript_plugin_flow = 1    " integrate flow

let g:vim_json_syntax_conceal = 0   " Don't hide Json syntax.
let g:plug_timeout = 5              " Low vim-plug timeout to prevent long freeze

" barbar tabline
" ==============
" NOTE: If barbar's option dict isn't created yet, create it
" TODO: Update configuration in lua
" color of the tabs
" let bg_current  = s:bg(['Normal'], '#000000')
" let bg_visible  = s:bg(['TabLineSel', 'Normal'], '#000000')
" let bg_inactive = s:bg(['TabLineFill', 'StatusLine'], '#000000')

" Other neovim settings
" =====================
set shortmess+=c                " Linting
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
set nowritebackup               " Request from coc
set nowb
set noswapfile

set splitbelow                  " Horizontal splits - below
set splitright                  " Vertical splits - right
set autowrite                   " Write for me when I take any action
set relativenumber              " Combined with number; line number preference
set clipboard=unnamed           " Copy/paste in vi with Sierra OS
set encoding=UTF-8
set showmode                    " Toggle this to noshowmode to enable echodoc

set updatetime=300              " Faster cursor hold; Change updatetime to faster than default 4 sec
set lazyredraw                  " Don't redraw while executing macros (good performance config)
" set ruler                       " Always show current position
set number
set cmdheight=1                 " Height of the command bar
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
set scrolloff=10                " Keep at least X lines below cursor
set sidescrolloff=5
set sidescroll=1

" configure gf (built-in) for js codebase
set path=.,src,node_nodules
set suffixesadd=.js,.jsx
fun! LoadMainNodeModule(fname)
    let nodeModules = "./node_modules/"
    let packageJsonPath = nodeModules . a:fname . "/package.json"
    if filereadable(packageJsonPath)
        return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    else
        return nodeModules . a:fname
    endif
endfunction
" gf searches here when otherwise fails
set includeexpr=LoadMainNodeModule(v:fname)


" indentLine
" ===========
" Note: not compatible with Haskell
let g:indentLine_char = '┊'

let g:indentLine_fileTypeExclude =
      \ ['haskell','haskellstack','cabal','haskellhpack',
      \  'json','yaml','markdown','pandoc','text','txt',
      \  'sh','vim','tmux','help' ]

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
set wildmode=list:longest
" set wildmode=list:longest,full

set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db
set wildignore+=*.min.js,*.swp,publish/*,intermediate/*,*.o
set wildignore+=build,cache,dist,coverage,node_modules
set wildignore+=release,rls,debug
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox

" Visual tweaks
" =============
"set cursorcolumn " Highlight the column of the cursor
set textwidth=80
set colorcolumn=+1
set nowrap
set linebreak
set ttyfast     " faster rendering

" Folding
" =======
set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr() -- moved to lua
set foldnestmax=10
set nofoldenable
"set foldlevelstart
set foldminlines=1
set foldlevel=1
" Note: nofoldenable gets toggled with the first use of zc
"       setting the value here now as `no` prevents folds
"       being closed upon opening the buffer.

" Real programmers don't use TABs
" ===============================
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab
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
let g:vim_jsx_pretty_colorful_config = 1              " default 0
let g:vim_jsx_pretty_template_tags = ['html', 'jsx']  " default
let g:vim_jsx_pretty_enable_jsx_highlight = 0         " default 1


" typescript
let g:yats_host_keyword = 1  " syntax config file for yats

" Limit the use of devicon fonts
let g:WebDevIconsUnicodeDecorateFileNodes = 0

"-----------------------
" go to tab number
" index tabs 1..n
"-----------------------
lua<<EOF
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }
  for i = 1,9,1
  do
     map('n',
       string.format('<leader>%d', i),
       string.format(':BufferGoto %d<CR>',i),
       opts
       )
  end
EOF

" Color Themes
" ============
" Notes:
" 1. Set before setting the colorscheme
" 2. Visit https://github.com/ryanoasis/nerd-fonts#font-installation
"    to see the range of options for setting icon displays
set termguicolors    " Enable true color support in terminal
set background=dark  " best for my transparent term configuration

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

" Custom colors
" =============
" Notes:
" 1. Overwrites loaded colorscheme
" 2. iTerm2 v3 controls the cursor color and how bold
"    fonts are displayed
" 3. Call :hi to see a full list of syntax objects
" 4. Use :Inspect and :TSNodeUnderCursor

" Use same color behind concealed unicode characters
hi clear Conceal

" useful: https://colorhex.net/78b830
" jsx pretty syntax highlighting
" scheme:
hi YELLOW       guifg=#D0C050
hi RED          guifg=#FF5F55
hi ORANGE       guifg=#D4AC0D
hi TURQUOISE    guifg=#78c0b0
hi PURPLE       guifg=#8048b0
hi GREEN        guifg=#78b830
hi GRAY         guifg=#808080
hi MUTED_GREEN  guifg=#609326
hi MUTED_PURPLE guifg=#BA5D7E
hi MUTED_BLUE   guifg=#83A8C1
hi MUTED_BROWN  guifg=#A07A2F
hi MUTED_YELLOW guifg=#A79414

" playing with TYPE, use link
hi TYPE1        guifg=#bc990c
hi TYPE2        guifg=#ecbf0e
hi TYPE3        guifg=#e0c455
hi TYPE4        guifg=#D2BD7F
hi TYPE5        guifg=#B9BA1E
hi! link TYPE    TYPE2
hi! link VARIANT TYPE5

" playing with IDENTIFIER, use link
hi IDENTIFIER1  guifg=#DBd263
hi IDENTIFIER2  guifg=#f5e77d
hi IDENTIFIER3  guifg=#dbd263
hi IDENTIFIER4  guifg=#dbe667
hi! link IDENTIFIER IDENTIFIER2

" playing with FUNCTION, use link
hi FUNCTION1        guifg=#A2CE68
hi FUNCTION2        guifg=#95F5CB
hi FUNCTION3        guifg=#BBC1F6
hi FUNCTION4        guifg=#4F78C2
hi FUNCTION5        guifg=#D3FA73
hi! link FUNCTION FUNCTION5

" playing with STRING, use link
hi STRING1        guifg=#72CF7B gui=italic
hi STRING2        guifg=#78b830 gui=italic
hi STRING3        guifg=#679933 gui=italic
hi STRING4        guifg=#d6d6d6 gui=italic
hi! link STRING STRING1
hi! link LIFETIME STRING2

" playing with COMMENT, use link for both COMMENT & DOCUMENTATION
hi COMMENT1        guifg=#609199 gui=italic
hi COMMENT2        guifg=#8ca375 gui=italic
hi! link COMMENT COMMENT1
hi! link DOCUMENTATION COMMENT2

hi MACRO guifg=#CF745D
hi MYLIB guifg=#4784DF

hi TRAIT  guifg=#A270A7
hi TRAIT2 guifg=#ab8ac1

" Parent highlighting groups
" ==========================
" Note: Normal gui=NONE is required to enable the active/inactive pane
" configuration in tmux (and the like)
hi! Normal        ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi! NonText       ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi! Error         ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi! ErrorMsg      ctermbg=NONE guibg=NONE cterm=NONE gui=NONE

hi! link LineNr   COMMENT
hi! link LineNrAbove GRAY
hi! link LineNrBelow GRAY

" ------------------------------------------------------------------------------
" Floating window settings
" ------------------------------------------------------------------------------
" 🔖 :set pumblend=0 ~ opaque
"    See ~/.config/nvm/bundle/nvim-lspconfig/after/ftplugin/lspinfo.lua
"    for popup setting
"
"    blend
" ------------------------------------------------------------------------------
hi! Pmenu        guifg=#ccdddd guibg=#202025
hi! FloatBorder  guifg=#70bdbd guibg=#202025

"
hi! CmpItemAbbrDefault             guifg=#70bdbd
hi! CmpItemMenuDefault             guifg=#bdbd11
hi! CmpItemAbbrMatchDefault        guifg=#11dddd gui=bold
" WIP
hi! CmpItemAbbrMatchFuzzyDefault   guifg=#000000
hi! CmpItemAbbrDeprecatedDefault   guifg=#ffffff
hi! CmpItemKindDefault             guifg=#ffff00
hi! CmpItemKind         guibg=NONE guifg=NONE
"    ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" vim-diminactive
" 🔖 Align the color scheme with tmux active/inactive window
" ------------------------------------------------------------------------------
hi! ColorColumn   ctermbg=235 guibg=#212121  " 1E1E1E is also good
" ------------------------------------------------------------------------------

" Match with Tmux inactive and lualine
" Search - improve contrast and match Airline Theme
hi Search ctermfg=214 ctermbg=238 guifg=#ffa724 guibg=#45413b
hi Visual ctermfg=51  ctermbg=238 guifg=#ACFFFF guibg=#002222

" White space and related
" [link undefined to defined]
hi! NonText           ctermfg=244  guifg=#808080 cterm=NONE gui=NONE
hi! link SpecialKey   NonText

" Messages
hi ErrorMsg           ctermfg=203  guifg=#FF5F55
hi! link Error ErrorMsg
hi WarningMsg         ctermfg=192  guifg=#CAE982
hi! link MoreMsg Question
hi DiagnosticInfo     ctermfg=72   guifg=#808080
hi DiagnosticHint     ctermfg=72   guifg=#588080
hi Todo               ctermfg=234  guifg=#1C1C1C ctermbg=227 guibg=#FFFF5F gui=NONE
hi def link DiagnosticError RED
hi DiagnosticWarn  ctermfg=5 guifg=#B79632

" Tabs
hi link  BufferCurrent       ORANGE
hi link  BufferCurrentMod    TURQUOISE
hi link  BufferVisible       PURPLE
hi link  BufferInactive      GRAY
hi link  BufferTabpages      MUTED_PURPLE
hi link  BufferDefaultInactiveMod MUTED_BROWN

" Window and folds
hi VertSplit    ctermfg=51   guifg=#00FFFF " turquoise
hi StatusLine   ctermfg=51   guifg=#00FFFF " turquoise
hi StatusLineNC ctermfg=51   guifg=#00FFFF " turquoise
hi Folded       ctermfg=250  ctermbg=235 guifg=#A8A8A8 guibg=#262626
hi FoldedColumn ctermfg=250  ctermbg=235 guifg=#A8A8A8 guibg=#262626
hi! link SignColumn LineNr

" JSX
hi link  jsxElement        YELLOW
hi link  jsxAttribute      PURPLE
hi link  jsxComponentName  ORANGE
hi link  jsxTag            TURQUOISE
hi link  jsxTagName        TURQUOISE
hi link  jsxCloseString    YELLOW
hi link  jsxCloseTag       YELLOW
hi link  jsxComment        Comment
hi link  jsxDot            Identifier
hi link  jsxEqual          Type
hi link  jsxEscapeJs       jsxEscapeJs
hi link  jsxNameSpace      RED
hi link  jsxString         String
hi link  jsxPunct          YELLOW

hi link  TSCjsxBraces      GREEN
hi link  jsFuncName        GREEN
hi link  jsFunction        MUTED_YELLOW
hi link  jsBraces          MUTED_GREEN

hi link  jsxClass          ORANGE
hi link  jsxCloseClass     jsxClass
hi link  xmlTagName        jsxClass
hi link  xmlEndTag         jsxClass
hi link  jsClassDefinition jsxClass
hi link  jsObjectKey       Identifier
hi link  xmlAttrib         PURPLE

" treesitter jsx
hi! link @constructor.javascript jsxClass
hi! link @tag.attribute.javascript jsxAttribute
hi! link @none.javascript STRING4

" lsp rust
hi! link @lsp.mod.attribute.rust GRAY
hi! link @lsp.mod.constant.rust ORANGE
hi! link @lsp.type.derive.rust TRAIT
hi! link @lsp.type.enumMember.rust VARIANT
hi! link @lsp.type.interface.rust TRAIT
hi! link @lsp.type.macro.rust MACRO
hi! link @lsp.type.namespace.rust GRAY
hi! link @lsp.type.typeAlias.rust TYPE2
hi! link @lsp.type.unresolvedReference.rust RED
hi! link @lsp.typemod.namespace.declaration.rust MYLIB
hi! link @lsp.typemod.method.trait.rust TRAIT2

" treesitter rust
hi! link @comment.rust COMMENT
hi! link @comment.documentation.rust DOCUMENTATION
hi! link @constant.rust ORANGE
hi! link @function.rust FUNCTION
hi! link @identifier.rust IDENTIFIER
hi! link @include.rust MUTED_BROWN
hi! link @namespace.rust MUTED_YELLOW
hi! link @punctuation.type_param.rust GRAY
hi! link @storageclass.lifetime.rust LIFETIME

" treesitter other
hi! link @comment.vim COMMENT
hi! link @comment.py COMMENT
hi! link @string.documentation.python DOCUMENTATION


