" ------------------------------------------------------------------------------
" ~/dotfiles/nvim-deoplete.vim
" required by: ~/.config/nvim/config/init.vim
" last updated: Sep 6, 2019
" ------------------------------------------------------------------------------
" Deoplete -- No longer, move to ncm2 and coc
"
" IDE-like auto-complete provider
" Toggle control in nvim-bindings.vim
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" nvim popup options
" ------------------------------------------------------------------------------
" Completion
" and don't hijack my enter key
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

set completeopt=noinsert,menuone,noselect
" set completeopt=menuone,preview
" set completeopt+=noselect
" set completeopt+=noinsert
set pumheight=7                " max height of popup before using scroll
set shortmess+=c               " disable showing index and search count


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
"
" S - Select mode
snoremap <silent><expr> <Tab>    (pumvisible() ? "\<C-n>" : "\<Tab>")
snoremap <silent><expr> <S-Tab>  (pumvisible() ? "\<C-p>" : "\<Tab>")

" I - Insert mode
inoremap <silent><expr> <Tab>    (pumvisible() ? "\<C-n>" : "\<Tab>")
inoremap <silent><expr> <S-Tab>  (pumvisible() ? "\<C-p>" : "\<Tab>")

function! s:is_whitespace()
  let col = col('.') - 1
  return ! col || getline('.')[col - 1] =~? '\s'
endfunction

" ------------------------------------------------------------------------------
" select item with space (preferred over enter)
" keeps the cursor moving forward when ignoring input.
" Note: bindings for <c-space> and .
" ------------------------------------------------------------------------------
inoremap <expr><space>   pumvisible() ? "\<C-y>\<space>" : "\<space>"
snoremap <expr><space>   pumvisible() ? "\<C-y>\<space>" : "\<space>"
inoremap <expr><c-space> pumvisible() ? "\<C-y>" : "\<space>"
snoremap <expr><c-space> pumvisible() ? "\<C-y>" : "\<space>"

inoremap <expr> . pumvisible() ? "\<C-y>." : "."
snoremap <expr> . pumvisible() ? "\<C-y>." : "."

" ------------------------------------------------------------------------------
" coc configuration
" Use the command `:CocConfig` to open the json configuration file.
" It is separate from what we are doing here.
" ------------------------------------------------------------------------------
"
" always show signcolumns
" set signcolumn=no

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" navigate diagnostics
" nnoremap <silent><leader>k <Plug>(coc-diagnostic-prev)
" nnoremap <silent><leader>j <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"
"" ------------------------------------------------------------------------------
