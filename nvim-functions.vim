" -------------------------------------------------------------------------------
" ~/dotfiles/nvim-support.vim
" symlinked to: ~/.config/nvim/config/nvim-support.vim
" last updated: Dec 21, 2017
" -------------------------------------------------------------------------------
" Support functions
" -------------------------------------------------------------------------------
"
" Check for .vimrc before loading
fun! HasVimrc()
  return findfile(".vimrc", ".")
endfun

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

" Deoplete activation
fun! ToggleDeoplete()
  call deoplete#toggle()
  echom "Toggled deoplete (0:disabled 1:enabled): " . deoplete#is_enabled()
endfun
command! -complete=command ToggleDeoplete call ToggleDeoplete()

fun! EnableDeoplete()
  if !deoplete#is_enabled()
    call deoplete#toggle()
  endif
  echom "Deoplete enabled: " . deoplete#is_enabled()
endfun
command! -complete=command EnableDeoplete call EnableDeoplete()

" Debugging functions
fun! GetSettingsFor (term)
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
    execute "put a"
    normal! gg
    execute setreg('a',[])
  endif
endfun
command! -nargs=+ -complete=command GetSettingsFor call GetSettingsFor (<q-args>)

" Send command output to a new tab
" =================================
" Usage:  :TabMessage <command>
" Note: At it's simplest
" :redir @a   - redirect output to the a register
" :set all    - run a command that generates output
" :redir END  - end the redirect
"             - create a new buffer and paste in @a
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

" Gutentags
" =========
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
      " let buf_del = bufnr("$")
      " exe "bd" . buf_del
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
fun! ToggleVerbose()
  if !&verbose
    set verbosefile=/tmp/vim.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfun

" Reveal current color scheme
" Usage: :call ShowColorSchemeName()
fun! ShowColorSchemeName()
  try
    echo g:colors_name
  catch /^Vim:E121/
    echo "default
  endtry
endfun

" Reveal highlight group of word below the cursor
" Usage: :set statusline+=%{HiGroup()}
fun! HiGroup()
  return synIDattr(synID(line("."),col("."),1),"name")
endfun

" Haskell
" =======
" Automatically make cscope connections
" Called with .hs specific autocmd
fun! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfun

" Helper functions
" ================
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
