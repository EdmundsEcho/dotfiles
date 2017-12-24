" ------------------------------------------------------------------------------
" ~/dotfiles/nvim-deoplete.vim
" required by: ~/.config/nvim/config/init.vim
" last updated: Dec 22, 2017
" ------------------------------------------------------------------------------
" Deoplete
" IDE-like auto-complete provider
" ------------------------------------------------------------------------------
" TODO: define a function for the user-defined <c-x><c-u>

" SuperTab
" ========
" NOTE: Deoplete provides most of the context `magic` in SuperTab.
"       The rest can be easily configured manually.
"
" About SuperTab: SupterTab "context" will identify members (. or ->) and
" files (/) if found in the text before the cursor.
" let g:SuperTabContextDefaultCompletionType = "<c-n>"
" let g:SuperTabDefaultCompletionType = "context"
"
" Recall: <c-n> and <c-p> are two ways to cycle through completion
" options.  <c-n> works top to bottom (next)...

" Manual configuration of <tab>
" ============================
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
" [configured for both insert and select modes

" I - Insert mode
inoremap <silent><expr><Tab> pumvisible() ? "\<Down>"
  \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
  \ : (<SID>is_whitespace() ? "\<Tab>"
  \ : deoplete#manual_complete()))

" S - Select mode
snoremap <silent><expr><Tab> pumvisible() ? "\<Down>"
  \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
  \ : (<SID>is_whitespace() ? "\<Tab>"
  \ : deoplete#manual_complete()))

inoremap <expr><S-Tab>  pumvisible() ? "\<Up>" : "\<C-h>"

" select item with enter or space
inoremap <expr> <CR>      pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <c-space> pumvisible() ? "\<C-y>\<space>" : "\<space>"
" Note: see help: complete-items and set completeopt+=noinsert
"       to do more.

" close the popup and/or temporarily disable deoplete with esc
" TODO: fix getting `0` inserted into the document
inoremap <expr> <esc> pumvisible()? deoplete#mappings#close_popup() : "\<esc>"
inoremap <expr> <esc><esc> pumvisible()? ToggleDeoplete() : "\<esc>"
augroup deo
  au!
  au InsertEnter * :call EnableDeoplete()
augroup END

function! s:is_whitespace()
  let col = col('.') - 1
  return ! col || getline('.')[col - 1] =~? '\s'
endfunction

" close the preview window
" [populated with type and documentation about the chosen option]
" Manual: :pc, :pclose, :q
autocmd InsertLeave * if !pumvisible() | pclose | endif

" Enable vim's built-in omni-complete feature
" uses defaults informed by syntax to populate completion suggestions
" Note: This is the default; deoplete will take over when and if
"       configured. They can be what deoplete uses if
"       g:deoplete#omni#input_patterns is *not* {}
" ------------------------------------------------------------------------------
" set omnifunc=syntaxcomplete#Complete
" ------------------------------------------------------------------------------
set completeopt=longest,menuone,preview
set pumheight=30  " max height of popup before using scroll
" ------------------------------------------------------------------------------
" Note: deoplete has max candidates = 100
" Here are explicit settings of vim's built-in omnifunc capacity
" augroup omnifuncs
"   au!
"   au FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"   au FileType python setlocal omnifunc=pythoncomplete#Complete
"   au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end

" deoplete
" ========
" Note: Make sure to use Plug to install and start the
" *tern* server with the  --persistent flag, --verbose when debugging
"
" Debugging:
" 1. :echo &tags to make sure you are getting an expanded
"    absolute file location
" 2. if using deoplete `omni` :echo &omnifunc -> should be the wrapper jspc#omni
"    (it wraps tern#Complete, or deoplete-terns's equivalent)
" 3. fire-up a tern server with --verbose and --persistent options
"    from the same root project directory to view what is being
"    sent to deoplete throughout your coding session
" 4. turn deoplete debugging on and track the changing log with tail
"    (at best it gives you the sources being used)
" 5. call ctags from the terminal ctags -R <list directories>;
"    [specify options in .guttags or .ctags]

nnoremap <leader>dx :call ToggleDeoplete()<CR>

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 0
let g:deoplete#auto_complete_delay = 3
" let g:deoplete#complete_method='omnifunc'
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1       " required for continous search
let g:deoplete#max_list = 100                  " default
let g:deoplete#max_menu_width = 30
let g:deoplete#skip_chars = ['(', ')', '<', '>']

let g:deoplete#tag#cache_limit_size = 800000
call deoplete#custom#source('_', 'matchers', ['matcher_head'])
call deoplete#custom#set('_', 'converters', ['converter_auto_paren'])
" DEBUG
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')
" call deoplete#custom#source('jspc#omni', 'is_debug_enabled', 1)
" call deoplete#custom#source('tern#Complete', 'is_debug_enabled', 1)

"" Deoplete TernJS source configuration
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#guess = 0
let g:deoplete#sources#ternjs#sort = 1
let g:deoplete#sources#ternjs#expand_word_forward = 1
let g:deoplete#sources#ternjs#include_keywords = 0

" use deoplete-specific settings if not using method 'omnifunc'
" See: deoplete issue 352
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = ['tern#Complete', 'jspc#omni']
let g:deoplete#omni#functions.haskell = ['necoghc#omnifunc']

" Sources: Default is a long list including file, dictionary etc.
"          Turn on deoplete logging to see what is being sourced
"          for any one popup.
"
" let g:deoplete#sources = {}
" let g:deoplete#sources['javascript'] = ['around', 'neosnippet', 'tern', 'file/include']
" let g:deoplete#sources['javascript'] = ['file', 'file/include', 'tern']
" let g:deoplete#sources['haskell'] = ['file', 'neosnippet', 'ghc']

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

" ------------------------------------------------------------------------------
