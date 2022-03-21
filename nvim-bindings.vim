" -------------------------------------------------------------------------------
" ~/.config/nvim/nvim-bindings.vim
" last change: Feb 9, 2022
" -------------------------------------------------------------------------------
" -------------------------------------------------------------------------------
" Tweaks to default mappings
" Capture most of the keybindings. Excludes bindings that don't often
" change e.g., <leader>, esc etc. see nvim-other and nvim-deoplete
"
" Debugging tips:
" 1. use :verbose nmap <leader>d to see sequence of setters
" 2. to use yanked content in command mode <C-R><C-O>"
" use :registers to see the full contents of registers
" in normal mode, hit " : p to print the previous command (a cmd)
" from normal mode, y j : @ " <Enter> will execute the contents of the unamed
" buffer, "
" -------------------------------------------------------------------------------

nnoremap <leader>n :call HiGroupEnable()<CR>

" Additional options to engage cmd mode from normal-mode
" nnoremap <leader>c :
" nnoremap <leader>n /
nnoremap <leader>m :%s/
nnoremap <leader>v :@:<CR>
" v is next to c, v is mac pasting
" recall, the `gc` postfix engages user-confirmed search and replace

" Remap start of the line; end of the file and EOF
nnoremap 0 :call GoToFrontLine()<CR>
nnoremap gg :0<CR>
nnoremap G G0

" Writing to file with <ctr-a>
nnoremap <C-a> :w<CR>
inoremap <C-a> <Esc>:w<CR>l
vnoremap <C-a> <Esc>:w<CR>

" Copy filename and filepath
nnoremap <leader>file :let @*=expand("%")<CR>
nnoremap <leader>fp :let @*=expand("%:p")<CR>

" Open file prompt with current path
nnoremap <leader>o :e <C-R>=expand("%:p:h") . '/'<CR>

" Write to file with sudo privileges
cnoremap w!! execute 'silent! write !SUDO_ASKPASS=`which ssh-askpass` sudo tee % >/dev/null' <bar> edit!

" run curl under cursor
nnoremap <leader>c :lua require("rest-nvim").run()<CR>
" <Plug>RestNvimPreview, preview the request cURL command
" <Plug>RestNvimLast, re-run the last request

" Ctags and Cscope (hscope for Haskell)
" =====================================
" Note: Haskell specific configurations of tag and csprg registers
"       and function LoadHscope()
"
" TODO: Configure for JS
" place cursor over the symbol to lookup
" :help cs for details
" Cscope limited to hscope functionality
noremap <C-\> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
noremap <C-_> :cs find 1 <C-R>=expand("<cword>")<CR><CR>

" Ctags
noremap <C-]> :cstag <C-R>=expand("<cword>")<CR><CR>
" Update files: codex update -> codex.tag
"               git-hscope -X TemplateHaskell -> hscope.out

" Map esc to remove highlighting of previous search
" Disable in favor of using it to close the float window
" 🔗 see nvim-coc.vim
" nnoremap <esc> :noh<return><esc>

" Display .vimrc in a new window; source when done
" ===============================================
nnoremap <leader>forc :sp ${HOME}/.config/nvim/init.vim <CR>
augroup sourcing
  autocmd!
  autocmd bufwritepost init.vim :source $MYVIMRC
augroup END

" coc
" ===
" See the coc config file

"
" EasyMotion
" ==========
map  <leader><leader>f <Plug>(easymotion-bd-f)
nmap <leader><leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map  <leader><leader>l <Plug>(easymotion-bd-jk)
nmap <leader><leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <leader><leader>w <Plug>(easymotion-bd-w)
nmap <leader><leader>w <Plug>(easymotion-overwin-w)

" NerdTree
" ========
" If nerd tree is closed, find current file, if open, close it
nnoremap <silent><leader>F <ESC>:NERDTreeToggle<CR>

" Jan 2022 NEW 🦀 ?
command! Fix lua require'lsp_fixcurrent'()
command! FixAll mF:%!eslint_d --stdin --fix-to-stdout<CR>`F
nnoremap <leader>f mF:%!eslint_d --stdin --fix-to-stdout<CR>`F

" Operator-pending maps
" =====================
" the operators: d[elete] c[hange] y[ank]
" p -> parentheses
" b -> bracket
" e.g., change contents between () with cp
onoremap p i(
onoremap b i[
" Include the surrounding brackets
onoremap P i(<esc><Del>xi
onoremap B i[<esc><Del>xi

" Next and previous brackets
onoremap np :<c-u>normal! f(lvi(<cr>
onoremap nb :<c-u>normal! f[lvi[<cr>
onoremap pp :<c-u>normal! F(lvi(<cr>
onoremap pb :<c-u>normal! F[lvi[<cr>

" Inserting a line (or tab)
" ========================
" From normal mode, default
" o  to insert below, O to insert above
"
" From normal, without insert mode
noremap <Enter> O<esc>j
" The line that follows prevents use of C-I to compliment C-O
" noremap <Tab> i<space><space><esc>l

" above the cursor
nnoremap [<space> :call append(line('.')-1,'')<cr>

" Delete a line; including the line break
" dd
" ... keep the line break (and delete to the right without 0)
" 0D

" Insert mode
" ===========
" C-O generally allows you to use a single normal mode command
" e.g.,
"       C-O D  delete line to the right of the cursor
"       C-U    delete line to the left  of the cursor
"
" Note: <C-I> seems to point to Tab.  When I remap it, deoplete
" stops working with <Tab>.

" Registers:
" Use :reg to see them all!
" In insert-mode accessed with <C-R> aka `"`
" In cmd-mode no need for `"` e.g., :so %
" paste most recent typed text with <C-R>. while in insert mode

" Insert the first word from the line above (often a fn name)
inoremap <C-F> <space><space><esc>kbywjPlli<C-V> <BS><BS>

" shortcut to making arrows (note: - key maps to underscore)
inoremap <C-_> -><space>
inoremap <C-\> =><space>

" Place `;` at the end of the line
" Note: . and ; cannot be mapped.
inoremap <C-]> <Esc>A;<CR>

" Undo from insertmode
inoremap <C-B> <Esc>ui

" C-H Backspace - default (uses vim navigation)
inoremap <C-L> <Del>

" Related defaults
" C-[ Esc
" C-T Tab between line start and first char (uses spaces :)
" C-M Enter
" C-H Backspace
" C-W Backspace word
" C-U Backspace to beginning of the line

" TODO
" Insert spaces until lined up with a search term in the line above
" nnoremap <C-G> <esc>kf...

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>z :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>Z :wincmd =<cr><Paste>

" close a buffer without changing the window splits
noremap <leader>q :bp<bar>vsp<bar>bn<bar>bd<CR>
"
"" BUFFERS vim-bby & fugitive
" ===========================
" close buffers, not windows
nnoremap <Leader>q  :Bdelete<CR>
nnoremap <leader>bd :Bdelete<CR>
" nnoremap <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
"
" Rename a buffer
" and in git, add if missing with write
nnoremap <Leader>br :Gmove<space>
nnoremap <Leader>bw :Gwrite<space>

" next, prev
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

" explore in a split
nnoremap <leader>be :Sex<CR>

" switch to the window with the buffer if exists
" DEBUGGING
set switchbuf=useopen

" close every window except the current (o = other)
nnoremap <leader>bo <c-w>o

" list files and option to jump (not buffers)
nnoremap<leader>bb :buffers<CR>:buffer<Space>

" Jump to previous edit point g; g,

" Select all text in current buffer
nnoremap <leader>aa ggVG

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
nnoremap <leader>ss :setlocal spell!<cr>

" Tags and Tagbar
" ===============
nnoremap <leader>tt :TagbarToggle<CR>

" Force redraw
nnoremap <silent> <leader>r :redraw!<CR>

" Force formatting
" nnoremap <leader>d magg=G`a

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

" Copy/Paste
" ==========
" Access clipboard from yank while in insert-mode
inoremap <c-p> <c-r>*

" OS Clipboard
" Copy and paste to os clipboard
" Note: Ctrp uses <leader>p_
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>p "*p
vnoremap <leader>p "*p

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Redirect command output to a new window (that can then be copied)
" :redir @+ | silent set all | redir END
nnoremap <silent> <F3> :redir @+<CR>@:<CR>:redir END<CR>
" nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

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

" settings for fish
augroup fish
  autocmd!
  autocmd FileType fish
        \ set textwidth=79 |
        \ set foldmethod=expr
augroup END

" VIMUX - a new Slime
" ====================
nnoremap <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
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

" tabularize
" ===========
" formats text to align in a table format
let g:haskell_tabular = 1
vnoremap a= :Tabularize /=/l1r1<CR>
vnoremap a; :Tabularize /:/l1r0l0r1<CR>
vnoremap a- :Tabularize /->/l1r0l0r1<CR>
vnoremap a{ :Tabularize /{><CR>
nnoremap <leader>ta :Tabularize<space>/
" Align records in Hask
nnoremap <leader>tr :Tabularize<space>/[:,{}]/l1l1l1r0l0l1l1<CR>

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
nnoremap <leader>pr :CtrlPMRUFiles<CR>
" Fuzzy find files
nnoremap <silent> <Leader>pf<space> :CtrlP<CR>
" fuzzy find buffers
nnoremap <silent> <leader>pb<space> :CtrlPBuffer<cr>

" hlint-refactor-vim keybindings
nnoremap <silent> <leader>hr :call ApplyOneSuggestion()<CR>
nnoremap <silent> <leader>hR :call ApplyOneSuggestion()<CR>

" ghc-mod - type checker
nnoremap <silent> <leader>ht :GhcModType<CR>
nnoremap <silent> <leader>hT :GhcModTypeInsert<CR>
nnoremap <silent> <leader>hs :GhcModSplitFunCase<CR>
nnoremap <silent> <leader>hc :GhcModTypeClear<CR>
" haskell aucmd TypeClear is also mapped to <leader><CR>

" Hoogle
" ======
nnoremap <silent> <leader>hh :Hoogle<CR>
" prompt for input
nnoremap <leader>hH :Hoogle
" detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>
" detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo
" close the Hoogle window

" Haskell specific TODO: fix the bindings
vnoremap <silent> <leader>h. :call Pointfree()<CR>
vnoremap <silent> <leader>h> :call Pointful()<CR>

" ------------------------------------------------------------------------------
" call to refresh after reload
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
" ------------------------------------------------------------------------------
