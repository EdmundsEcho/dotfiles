" ------------------------------------------------------------------------------
" ~/dotfiles/nvim-deoplete.vim
" required by: ~/.config/nvim/config/init.vim
" last updated: Dec 18, 2020
" ------------------------------------------------------------------------------
" IDE-like auto-complete provider
" coc is a client for tsserver
" Toggle control in nvim-bindings.vim
" ------------------------------------------------------------------------------
" Recall: <c-n> and <c-p> are two ways to cycle through completion
" options.  <c-n> works top to bottom (next)...
"
set pumheight=7                " max height of popup before using scroll
set shortmess+=c               " disable showing index and search count

" ------------------------------------------------------------------------------
" coc configuration
" Use the command `:CocConfig` to open the json configuration file.
" It is separate from what we are doing here.
"
" Troubleshooting:
" 👍 watchman can consume a lot of memory; `watchman watch-del-all`
"    to reset the memory consumption.
" 👍 Use the following to verify the status of each service.
" :CocCommand workspace.showOutput
"
"" ------------------------------------------------------------------------------
" Completion
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"
" 🦀 Sequesters the manual line break when a pop-up appears just prior to
"    wanting to create a new line.
"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" ⚠️  New
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" GoTo code navigation.
" nnoremap <silent> gd <Plug>(coc-definition)
" nnoremap <silent> gy <Plug>(coc-type-definition)
" nnoremap <silent> gi <Plug>(coc-implementation)
" nnoremap <silent> gr <Plug>(coc-references)

nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> gy :call CocActionAsync('jumpTypeDefinition')<CR>
nnoremap <silent> gi :call CocActionAsync('jumpImplementation')<CR>
nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>

" ⚠️  Use K to show documentation in preview window.
" nnoremap <silent> K :call CocAction('doHover')<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

"------------------------------------------------------------------------------
" Shows documentation if a diagnostic does not exist
"
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"------------------------------------------------------------------------------
" *New*
" https://github.com/fannheyward/init.vim/blob/7b51d380ead37539b674b233d066096d4319e033/init.vim#L188-L197
" The problem is coc jump does not seem to work.  Only c-].
" This function will jump using a series of options.
" :call CocActionAsync('jumpDefinition', 'pedit')
"
function! s:GoToDefinition()
  if CocAction('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret[:5] =~ "Error"
    call searchdecl(expand('<cword>'))
  endif
endfunction

"------------------------------------------------------------------------------
"
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

"------------------------------------------------------------------------------
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"------------------------------------------------------------------------------
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"------------------------------------------------------------------------------

" 👍 use these more than you do now.
"
" ⚠️  New!
" Symbol renaming
nnoremap <leader>rn :<C-u>call CocActionAsync('rename')<CR>

" Lens Actions
nnoremap <leader>la :call CocAction('codelens-action')<CR>

" 📖 request LS code action for the buffer and line
nnoremap <leader>ac  <Plug>(coc-codeaction)
nnoremap <leader>fc  <Plug>(coc-codeaction-line)

" ✨ fix the current line
nnoremap <leader>go :CocAction quickfix<CR>
nnoremap <leader>qf <Plug>(coc-fix-current)

" Jump lists
nnoremap <silent> <leader>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>d :<C-u>CocList -I diagnostics<cr>


" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" 🛈  WIP usage
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder :call CocActionAsync('showSignatureHelp')
augroup end

" 🛈  WIP usage
" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" ------------------------------------------------------------------------------
" CocAction
" ------------------------------------------------------------------------------
" 🔑 Note the use of CocAction to run 'special' requests of the LS
" ------------------------------------------------------------------------------
" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" 🦀 this next line disables <C-i> (the compliment to <C-o>)
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" 🔖 integration with airline: see nvim-other.vim

" Mappings for CocList
" 🚧 coc-explorer
nnoremap <silent><nowait> <leader>E :CocCommand explorer --preset default<CR>
" Manage extensions.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Show all diagnostics.
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>

" 🚧 In active repair
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>

"" ------------------------------------------------------------------------------
