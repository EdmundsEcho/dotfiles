" ------------------------------------------------------------------------------
" ~/dotfiles/nvim-deoplete.vim
" required by: ~/.config/nvim/config/init.vim
" last updated: Jun 24, 2019
" ------------------------------------------------------------------------------
" Deoplete -- No longer, move to ncm2
"
" IDE-like auto-complete provider
" Toggle control in nvim-bindings.vim
" ------------------------------------------------------------------------------
" TODO: define a function for the user-defined <c-x><c-u>

" ------------------------------------------------------------------------------
" Option to enable vim's built-in omni-complete feature
" uses defaults informed by syntax to populate completion suggestions
" Note: This is the default; deoplete will take over when and if
"       configured. They can be what deoplete uses if
"       g:deoplete#omni#input_patterns is *not* {}
" ------------------------------------------------------------------------------
" set omnifunc=syntaxcomplete#Complete
" ------------------------------------------------------------------------------
"
" ------------------------------------------------------------------------------
" nvim popup options
" ------------------------------------------------------------------------------
" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
" tab to select
" and don't hijack my enter key
" inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

set completeopt=noinsert,menuone,noselect
" set completeopt=menuone,preview
" set completeopt+=noselect
" set completeopt+=noinsert
set pumheight=7                " max height of popup before using scroll
" set shortmess+=c               " disable showing index and search count


" Note: deoplete has max candidates = 100
" ------------------------------------------------------------------------------
" Here are explicit settings of vim's built-in omnifunc capacity
" augroup omnifuncs
"   au!
"   au FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"   au FileType python setlocal omnifunc=pythoncomplete#Complete
"   au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end

" ------------------------------------------------------------------------------
" SuperTab
" ------------------------------------------------------------------------------
" NOTE: Deoplete provides most of the context `magic` in SuperTab.
"       The rest is straightforward to configure manually.
"
" About SuperTab: SupterTab "context" will identify members (. or ->) and
" files (/) if found in the text before the cursor.
" let g:SuperTabContextDefaultCompletionType = "<c-n>"
" let g:SuperTabDefaultCompletionType = "context"

" ------------------------------------------------------------------------------
" Manual configuration of <tab>
" ------------------------------------------------------------------------------
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
" [configured for both insert and select modes
"
" Recall: <c-n> and <c-p> are two ways to cycle through completion
" options.  <c-n> works top to bottom (next)...
" DEBUGGING
" inoremap <silent><expr><Tab> :call GetVimVariables() "\<Tab>"
" snoremap <silent><expr><Tab> :call GetVimVariables() "\<Tab>"
" inoremap <silent><space>     :call GetVimVariables() "\<space>"
" snoremap <silent><space>     :call GetVimVariables() "\<space>"

" I - Insert mode
" TESTING to regain C-I for use in insert-mode
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

function! s:is_whitespace()
  let col = col('.') - 1
  return ! col || getline('.')[col - 1] =~? '\s'
endfunction

" DISABLED
"" ------------------------------------------------------------------------------
"" select item with space (preferred over enter)
"" keeps the cursor moving forward when ignoring input.
"" Note: bindings for <c-space> and .
"" ------------------------------------------------------------------------------
"inoremap <expr> <space> pumvisible() ? "\<C-y>\<space>" : "\<space>"
"snoremap <expr> <space> pumvisible() ? "\<C-y>\<space>" : "\<space>"
"inoremap <expr> <c-space> pumvisible() ? "\<C-y>" : "\<space>"
"snoremap <expr> <c-space> pumvisible() ? "\<C-y>" : "\<space>"
"
"inoremap <expr> . pumvisible() ? "\<C-y>." : "."
"snoremap <expr> . pumvisible() ? "\<C-y>." : "."
"
"" Note: see help: complete-items and set completeopt+=noinsert
""       to do more.
""
"" TODO WIP Autocmd: when MenuPopup let g:userIDE=false
""
"" display:
""
"" :echo v:completed_item  by hitting esc twice before popup happens again
"" inoremap <expr> <CR> pumvisible() ?
""       \ (empty(v:completed_item) ? "\<C-e>\<CR>" : "\<C-y><CR>") : "\<CR>"
"
"" ------------------------------------------------------------------------------
"" close the popup with <esc>
"" (this setting prevents esc from exiting insert mode)
"" ------------------------------------------------------------------------------
"" TODO: fix getting `0` inserted into the document
"" inoremap <expr> <esc> pumvisible()? deoplete#mappings#close_popup() : "\<esc>"
"inoremap <expr> <esc> pumvisible()? "\<C-e>" : "\<esc>"
"" ------------------------------------------------------------------------------
"" OR disable deoplete temporarily
"" will reactivate on next entry to insert
"" ------------------------------------------------------------------------------
"" inoremap <expr> <esc><esc> pumvisible()? ToggleDeoplete() : "\<esc>"
"inoremap <expr> <esc><esc> pumvisible()? deoplete#disable() : "\<esc>"
"" ------------------------------------------------------------------------------
"
"" ------------------------------------------------------------------------------
"" close the preview window
"" (populated with type and documentation about the chosen option)
"" Manual: :pc, :pclose, :q
"autocmd InsertLeave * if !pumvisible() | pclose | endif
"" ------------------------------------------------------------------------------
""
"" ------------------------------------------------------------------------------
"" deoplete
"" ------------------------------------------------------------------------------
"" Note:
"" 1. Make sure to use Plug to install and start the
"" *tern* server with the  --persistent flag, --verbose when debugging
"" 2. Run the :UpdateRemotePlugins once loaded (vim-plug do)
""
"" Debugging:
"" 1. :echo &tags to make sure you are getting an expanded
""    absolute file location
"" 2. if using deoplete `omni` :echo &omnifunc -> should be the wrapper jspc#omni
""    (it wraps tern#Complete, or deoplete-terns's equivalent)
"" 3. fire-up a tern server with --verbose and --persistent options
""    from the same root project directory to view what is being
""    sent to deoplete throughout your coding session
"" 4. turn deoplete debugging on and track the changing log with tail
""    (at best it gives you the sources being used)
"" 5. call ctags from the terminal ctags -R <list directories>;
""    [specify options in .guttags or .ctags]
"
"" Use ALE and also some plugin 'foobar' as completion sources for all code.
"" let g:deoplete#sources = {'_': ['ale', 'foobar']}
"
"let g:auto_complete_start_length = 1
"let g:auto_complete_delay = 500       " default = 0
"let g:auto_refresh_delay = 20         " default
"let g:on_insert_enter = 1            " default
"let g:refresh_always = 1             " default, may cause flicker
"" let g:deoplete#complete_method='omnifunc'
"let g:enable_camel_case = 1
"let g:enable_refresh_always = 1       " required for continous search
"let g:max_list = 100                  " default
"let g:skip_chars = ['(', ')', '<', '>']
"let g:max_menu_width = 15             " deoplete width
"
"let g:tag#cache_limit_size = 800000
"call deoplete#custom#source('_', 'matchers', ['matcher_head'])
"call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])
"
"" For DEBUGGING
"" let g:deoplete#enable_profile = 1
"" call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')
"" call deoplete#custom#source('jspc#omni', 'is_debug_enabled', 1)
"" call deoplete#custom#source('tern#Complete', 'is_debug_enabled', 1)
"
""" Deoplete TernJS source and other lang config
"let g:deoplete#sources#ternjs#types = 0
"let g:deoplete#sources#ternjs#docs = 0
"let g:deoplete#sources#ternjs#depths = 1
"let g:deoplete#sources#ternjs#guess = 1
"let g:deoplete#sources#ternjs#sort = 1
"let g:deoplete#sources#ternjs#expand_word_forward = 1
"let g:deoplete#sources#ternjs#include_keywords = 0
"let g:deoplete#sources#rust#racer_binary='/Users/edmund/.cargo/bin/racer'
"let g:deoplete#sources#rust#rust_source_path='/Users/edmund/.local/rust/src'
"
"" use deoplete-specific settings if not using method 'omnifunc'
"" See: deoplete issue 352
"let g:deoplete#omni#functions            = {}
"let g:deoplete#omni#functions.javascript = ['tern#Complete', 'jspc#omni']
"let g:deoplete#omni#functions.haskell    = ['necoghc#omnifunc']
"
"" Sources: Default is a long list including file, dictionary etc.
""          Turn on deoplete logging to see what is being sourced
""          for any one popup.
""
"" let g:deoplete#sources               = {}
"" let g:deoplete#sources['javascript'] = ['around', 'neosnippet', 'tern', 'file/include']
"" let g:deoplete#sources['javascript'] = ['file', 'file/include', 'tern']
"" let g:deoplete#sources['haskell']    = ['file', 'neosnippet', 'ghc']
"
"" " Default rank is 100, higher is better.
"call deoplete#custom#source('omni',          'mark', '⌾')
"call deoplete#custom#source('tern',          'mark', '')  " tern not ternJS is the internal ref
"call deoplete#custom#source('ghc',           'mark', '')
"call deoplete#custom#source('vim',           'mark', '')
"call deoplete#custom#source('tag',           'mark', '⌦')
"call deoplete#custom#source('neosnippet',    'mark', '⌘')
"call deoplete#custom#source('around',        'mark', '↻')
"call deoplete#custom#source('buffer',        'mark', 'ℬ')
"call deoplete#custom#source('syntax',        'mark', '♯')
"call deoplete#custom#source('file',          'mark', 'F')
"call deoplete#custom#source('file_include',  'mark', '⌁')
"call deoplete#custom#source('member',        'mark', '.')
"
"call deoplete#custom#source('vim',           'rank', 640)
"call deoplete#custom#source('tern',          'rank', 620)
"call deoplete#custom#source('ghc',           'rank', 620)
"call deoplete#custom#source('tag',           'rank', 600)
"call deoplete#custom#source('omni',          'rank', 550)
"call deoplete#custom#source('neosnippet',    'rank', 510)
"call deoplete#custom#source('member',        'rank', 500)
"call deoplete#custom#source('file_include',  'rank', 420)
"call deoplete#custom#source('file',          'rank', 410)
"call deoplete#custom#source('around',        'rank', 330)
"call deoplete#custom#source('buffer',        'rank', 720)
"call deoplete#custom#source('dictionary',    'rank', 310)
"call deoplete#custom#source('syntax',        'rank', 200)
"
"" ------------------------------------------------------------------------------
