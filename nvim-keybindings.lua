-- $HOME/dotfies/nvim-keybindings.lua
-------------------------------------------------------------------------------
-- Keybinding
-- Last updated: May 14th, 2024
--
--  See `:help vim.keymap.set()`
-------------------------------------------------------------------------------
-- WARNING conflicting keymap exists for mode **"o"**, lhs: **"  "**
-- rhs: `<Plug>(easymotion-prefix)`
-- WARNING conflicting keymap exists for mode **"o"**, lhs: **"p"**
-- rhs: `i(`
-- WARNING conflicting keymap exists for mode **"v"**, lhs: **"  "**
-- rhs: `<Plug>(easymotion-prefix)`
-- WARNING conflicting keymap exists for mode **"n"**, lhs: **"  "**
-- rhs: `<Plug>(easymotion-prefix)`
-- WARNING conflicting keymap exists for mode **"n"**, lhs: **" r"**
-- rhs: `:redraw!<CR>`
-- WARNING conflicting keymap exists for mode **"n"**, lhs: **" x"**
-- rhs: `<Cmd>.lua<CR>`
-- WARNING conflicting keymap exists for mode **"n"**, lhs: **" f"**
-- rhs: ` `
-- WARNING conflicting keymap exists for mode **"n"**, lhs: **"gc"**
-- rhs: `<Plug>(comment_toggle_linewise)`
-- WARNING conflicting keymap exists for mode **"n"**, lhs: **"gb"**
-- rhs: `<Plug>(comment_toggle_blockwise)`
-- WARNING conflicting keymap exists for mode **"n"**, lhs: **"ys"**
-- rhs: `<Plug>Ysurround`
-- WARNING conflicting keymap exists for mode **"n"**, lhs: **"yS"**
-- rhs: `<Plug>YSurround`
-------------------------------------------------------------------------------
-- local utilities
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-------------------------------------------------------------------------------
-- Save a file using ctrl-a in normal, insert and visual modes
-------------------------------------------------------------------------------
map({ "n", "v" }, "<C-a>", ":w<CR>", opts)
map("i", "<C-a>", "<Esc>:w<CR>a", opts)

-------------------------------------------------------------------------------
-- Resize vim windows
-------------------------------------------------------------------------------
-- see orginal setup

-------------------------------------------------------------------------------
-- Open nvim config
-------------------------------------------------------------------------------
map("n", "<C-c>", ":edit ~/.config/nvim/init.lua<CR>", opts)

-------------------------------------------------------------------------------
-- execute files
-------------------------------------------------------------------------------
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "execute the current line" })
map(
    "n",
    "<leader><leader>x",
    "<cmd>source %<CR>",
    { desc = "execute the current file" }
)

-------------------------------------------------------------------------------
-- go to tab number, index tabs 1..n
-------------------------------------------------------------------------------
for i = 1, 9, 1 do
    map(
        "n",
        string.format("<leader>%d", i),
        string.format(":BufferGoto %d<CR>", i),
        opts
    )
end

-------------------------------------------------------------------------------
-- [[ Basic Keymaps ]]
-- Set highlight on search, but clear on pressing <Esc> in normal mode
-------------------------------------------------------------------------------
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set(
    "n",
    "[d",
    vim.diagnostic.goto_prev,
    { desc = "Go to previous [D]iagnostic message" }
)
vim.keymap.set(
    "n",
    "]d",
    vim.diagnostic.goto_next,
    { desc = "Go to next [D]iagnostic message" }
)
vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { desc = "Show diagnostic [E]rror messages" }
)
vim.keymap.set(
    "n",
    "<leader>q",
    vim.diagnostic.setloclist,
    { desc = "Open diagnostic [Q]uickfix list" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
--  Todo: coordinate with tmux and previous config that works nicely
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-------------------------------------------------------------------------------
-- Keybindings for LSP navigation using Telescope
-- see nvim-telescope.lua
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Write to file with sudo privileges
-------------------------------------------------------------------------------
map("c", "w!!", function()
    vim.cmd("silent! write !SUDO_ASKPASS=`which ssh-askpass` sudo tee % >/dev/null")
    vim.cmd("edit!")
end, { noremap = true, silent = true })

-------------------------------------------------------------------------------
-- Show/Hide File Tree
-------------------------------------------------------------------------------
vim.g.neotree_open = vim.g.neotree_open or false
map("n", "<leader>t", function()
    if vim.g.neotree_open then
        -- If Neo-tree is open, close it
        vim.cmd("Neotree close")
        vim.g.neotree_open = false
    else
        -- If Neo-tree is closed, open it
        vim.cmd("Neotree reveal")
        vim.g.neotree_open = true
    end
end, opts)

vim.cmd([[
" -------------------------------------------------------------------------------
" ~/.config/nvim/nvim-bindings.vim
" last change: March 27, 2022
" -------------------------------------------------------------------------------
" -------------------------------------------------------------------------------
" Tweaks to default mappings
" Capture most of the keybindings. Excludes bindings that don't often
" change e.g., <leader>, esc etc. see nvim-other and nvim-deoplete
"
" Debugging tips:
"
" 1. use :verbose nmap <leader>d to see sequence of setters
"
" 2. to use yanked content in command mode <C-R><C-O>"
"
" use :registers to see the full contents of registers
" in normal mode, hit " : p to print the previous command (a cmd)
" from normal mode, y j : @ " <Enter> will execute the contents of the unamed
" buffer, "
" -------------------------------------------------------------------------------

" File type specific bindings
autocmd FileType json nnoremap <buffer> <C-f>:%!jq .<CR>
autocmd FileType json syntax match Comment +\/\/.\+$+

" change local workding directory
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

" Additional options to engage cmd mode from normal-mode
" nnoremap <leader>c :
" nnoremap <leader>n /
nnoremap <leader>m :%s/
nnoremap <leader>v :@:<CR>
" v is next to c, v is mac pasting
" recall, the `gc` postfix engages user-confirmed search and replace

" Copy filename and filepath
nnoremap <leader>file :let @*=expand("%")<CR>
nnoremap <leader>fp :let @*=expand("%:p")<CR>

" Open file prompt with current path
nnoremap <leader>o :e <C-R>=expand("%:p:h") . '/'<CR>


" Ctags and Cscope (hscope for Haskell)
" =====================================
" Note: Haskell specific configurations of tag and csprg registers
"       and function LoadHscope()
"
" place cursor over the symbol to lookup
" :help cs for details
" Cscope limited to hscope functionality
noremap <C-\> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
noremap <C-_> :cs find 1 <C-R>=expand("<cword>")<CR><CR>

" Ctags
noremap <C-]> :cstag <C-R>=expand("<cword>")<CR><CR>
" Update files: codex update -> codex.tag
"               git-hscope -X TemplateHaskell -> hscope.out


" 🚧
" Jan 2022 NEW 🦀 WIP
" command! Fix lua require'lsp_fixcurrent'()
" command! FixAll mF:%!eslint_d --stdin --fix-to-stdout<CR>`F
" nnoremap <leader>f mF:%!eslint_d --stdin --fix-to-stdout<CR>`F

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
inoremap <C-=> =><space>

" Place `;` at the end of the line
" Note: . and ; cannot be mapped.
" inoremap <C-;> <Esc>A;<CR>

" jump to start and end of the line
inoremap <C-J> <Esc>0i
inoremap <C-K> <Esc>A;

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

" Force redraw
nnoremap <silent> <leader>r :redraw!<CR>

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
" 🔖 <C-p> in normal mode activates Ctrp
inoremap <C-p> <C-r>*

" OS Clipboard
" Copy and paste to os clipboard
" Note: Ctrp uses <leader>p_
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>p "*p
vnoremap <leader>p "*p

" Prettier
nnoremap <leader>P :Prettier<CR>

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

" --------------------------------------
" 🪟 Pane resizing coordinated with tmux
" vim-tmux-navigator
" ======================================
let g:tmux_navigator_no_mappings = 1
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" pass the same information onto tmux
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

" 🚧 WIP pass-through from tmux ?
" issue: does not pass the event to tmux
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>

" 🦀 ? split {n}vim window
nnoremap <leader>- :sp<CR>
nnoremap <leader>/ :vsp<CR>
nnoremap <leader>\ :vsp<CR>

" Open window splits in various places
nnoremap <leader>sh :leftabove  vnew<CR>
nnoremap <leader>sl :rightbelow vnew<CR>
nnoremap <leader>sk :leftabove  new<CR>
nnoremap <leader>sj :rightbelow new<CR>
" --------------------------------------

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


]])
