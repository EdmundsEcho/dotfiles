-- $HOME/dotfies/nvim-keybindings.lua
-------------------------------------------------------------------------------
-- Keybinding
-- Last updated: May 14th, 2024
--
--  See `:help vim.keymap.set()`
-------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- Tweaks to default mappings
-- Capture most of the keybindings. Excludes bindings that don't often
--
-- Debugging tips:
--
-- 1. Use :verbose nmap <leader>d to see the sequence of setters
-- 2. To use yanked content in command mode <C-R><C-O>
-- 3. pause between key combinations to see possible bindings
--
-------------------------------------------------------------------------------
-- NOTE: regarding Registers
-------------------------------------------------------------------------------
-- Use :registers to see the full contents of registers
-- Redirect command output to a new window (that can then be copied)
-- :redir @+ | silent set all | redir END
-- <silent> <F3> :redir @+<CR>@:<CR>:redir END<CR>
-- nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>
-- In normal mode, hit ":p" to print the previous command (a cmd)
-- From normal mode, yj:@<Enter> will execute the contents of the unnamed buffer
--------------------------------------------------------------------------------
-- local utilities
--------------------------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-------------------------------------------------------------------------------
-- Save a file using ctrl-a in normal, insert and visual modes
-------------------------------------------------------------------------------
map({ "n", "v" }, "<C-a>", ":w<CR>", opts)
map("i", "<C-a>", "<Esc>:w<CR>", opts)
-- map("i", "<C-a>", "<Esc>:w<CR>a", opts)

-------------------------------------------------------------------------------
-- Resize vim windows
-------------------------------------------------------------------------------
-- see orginal setup

-------------------------------------------------------------------------------
-- Open nvim config
-------------------------------------------------------------------------------
map("n", "<C-c>", ":edit ~/.config/nvim/init.lua<CR>", opts)
map("n", "<leader>cfg", ":edit ~/.config/nvim/init.lua<CR>", opts)

-------------------------------------------------------------------------------
-- execute files
-------------------------------------------------------------------------------
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "E[x]ecute the current line" })
map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "E[x]ecute the current file" })

-------------------------------------------------------------------------------
-- go to tab number, index tabs 1..n
-------------------------------------------------------------------------------
for i = 1, 9, 1 do
    map("n", string.format("<leader>%d", i), string.format(":BufferGoto %d<CR>", i), opts)
end

-------------------------------------------------------------------------------
-- [[ Basic Keymaps ]]
-- Set highlight on search, but clear on pressing <Esc> in normal mode
-------------------------------------------------------------------------------
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- set the diagnostic formatting
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        update_in_insert = false,
        virtual_text = true,
    })

-- Diagnostic keymaps
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
    desc = "Go to previous [D]iagnostic message",
    noremap = true,
    silent = true,
})
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, {
    desc = "Go to previous [D]iagnostic message",
    noremap = true,
    silent = true,
})
vim.keymap.set(
    "n",
    "]d",
    vim.diagnostic.goto_next,
    { desc = "Go to next [D]iagnostic message", noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "<leader>j",
    vim.diagnostic.goto_next,
    { desc = "Go to next [D]iagnostic message", noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { desc = "Show diagnostic [E]rror messages", noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "<leader>q",
    vim.diagnostic.setloclist,
    { desc = "Open diagnostic [Q]uickfix list", noremap = true, silent = true }
)

-- Operator-pending maps
-- =====================
-- the operators: d[elete] c[hange] y[ank]
-- p -> parentheses
-- b -> bracket
-- e.g., change contents between () with cp

vim.keymap.set(
    "o",
    "p",
    "i(",
    { noremap = true, silent = true, desc = "Operator pending map for parentheses" }
)
vim.keymap.set(
    "o",
    "b",
    "i[",
    { noremap = true, silent = true, desc = "Operator pending map for brackets" }
)
-- Include the surrounding brackets
vim.keymap.set("o", "P", "i(<esc>i<Del>xi", {
    noremap = true,
    silent = true,
    desc = "Operator pending map for surrounding parentheses",
})
vim.keymap.set("o", "B", "i[<esc>i<Del>xi", {
    noremap = true,
    silent = true,
    desc = "Operator pending map for surrounding brackets",
})

-- Next and previous brackets
vim.keymap.set(
    "o",
    "np",
    ":<c-u>normal! f(lvi(<cr>",
    { noremap = true, silent = true, desc = "Next parentheses" }
)
vim.keymap.set(
    "o",
    "nb",
    ":<c-u>normal! f[lvi[<cr>",
    { noremap = true, silent = true, desc = "Next brackets" }
)
vim.keymap.set(
    "o",
    "pp",
    ":<c-u>normal! F(lvi(<cr>",
    { noremap = true, silent = true, desc = "Previous parentheses" }
)
vim.keymap.set(
    "o",
    "pb",
    ":<c-u>normal! F[lvi[<cr>",
    { noremap = true, silent = true, desc = "Previous brackets" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set(
    "t",
    "<Esc><Esc>",
    "<C-\\><C-n>",
    { desc = "Exit terminal mode", noremap = true, silent = true }
)

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
-- Toggle File Explorer <leader>te
-------------------------------------------------------------------------------
vim.g.neotree_open = vim.g.neotree_open or false
map("n", "<leader>te", function()
    if vim.g.neotree_open then
        -- If Neo-tree is open, close it
        vim.cmd("Neotree close")
        vim.g.neotree_open = false
    else
        -- If Neo-tree is closed, open it
        vim.cmd("Neotree reveal")
        vim.g.neotree_open = true
    end
end, { desc = "[T]oggle [E]xplorer with neotree", noremap = true, silent = true })

-- Additional options to engage cmd mode from normal-mode
-- Default: nnoremap <leader>c :
-- Default: nnoremap <leader>n /
vim.keymap.set("n", "<leader>m", ":%s/", { noremap = true, desc = "Start search and replace" })
vim.keymap.set("n", "<leader>v", ":@:<CR>", { noremap = true, desc = "Execute last command" })
-- Note: v is next to c, v is mac pasting
-- Recall, the `gc` postfix engages user-confirmed search and replace

-------------------------------------------------------------------------------
-- File-related keybindings <leader>f*
-------------------------------------------------------------------------------
-- Copy filename and filepath
vim.keymap.set(
    "n",
    "<leader>fn",
    ':let @*=expand("%")<CR>',
    { noremap = true, silent = true, desc = "[F]ile - Copy file [N]ame" }
)
vim.keymap.set(
    "n",
    "<leader>fp",
    ':let @*=expand("%:p")<CR>',
    { noremap = true, silent = true, desc = "[F]ile - Copy file [P]ath" }
)
-- Open file prompt with current path
vim.keymap.set(
    "n",
    "<leader>fo",
    ":e <C-R>=expand(\"%:p:h\") . '/'<CR>",
    { noremap = true, silent = true, desc = "[F]ile - [O]pen file prompt with current path" }
)
-------------------------------------------------------------------------------
-- Change local working directory <leader>cd
vim.keymap.set(
    "n",
    "<leader>cd",
    ":lcd %:p:h<CR>:pwd<CR>",
    { noremap = true, silent = true, desc = "[C]hange local working [D]irectory" }
)
-------------------------------------------------------------------------------

-- Inserting a line (or tab)
-- ========================
-- From normal mode, default: o to insert below, O to insert above
-- From normal, without insert mode
--
-- Delete a line; including the line break
-- Default: dd
-- ... keep the line break (and delete to the right without 0)
-- Default: 0D
--
vim.keymap.set("n", "<Enter>", "O<esc>j", {
    noremap = true,
    silent = true,
    desc = "Insert line above and return to normal mode",
})
-- 🦀 The line that follows prevents use of C-I to compliment C-O
vim.keymap.set("n", "<Tab>", "i<space><space><esc>l", {
    noremap = true,
    silent = true,
    desc = "Insert two spaces and return to normal mode",
})

-- Above the cursor
vim.keymap.set(
    "n",
    "[<space>",
    ":call append(line('.')-1,'')<CR><ESC>da",
    { noremap = true, silent = true, desc = "Insert empty line above cursor" }
)

-- Insert mode
-- ===========
-- C-O generally allows you to use a single normal mode command
-- e.g.,
--       C-O D  delete line to the right of the cursor
--       C-U    delete line to the left of the cursor

-- Insert the first word from the line above (often a fn name)
vim.keymap.set(
    "i",
    "<C-F>",
    "<space><space><esc>kbywjPlli<C-V> <BS><BS>",
    { noremap = true, silent = true, desc = "Insert first word from line above" }
)

-- Shortcut to making arrows (note: - key maps to underscore)
vim.keymap.set("i", "<C-_>", "-><space>", { noremap = true, silent = true, desc = "Insert ->" })
-- vim.keymap.set(
--     "i",
--     "<C-m>",
--     "=><space>",
--     { noremap = true, silent = true, desc = "Insert [m]atch =>" }
-- )
vim.keymap.set(
    "n",
    "<leader>;",
    "mzA;<Esc>`z",
    { noremap = true, silent = true, desc = "Insert ; at the end of the line" }
)
vim.keymap.set(
    "i",
    "<C-k>",
    "<Esc>0i",
    { noremap = true, silent = true, desc = "Jump to start of line in insert mode" }
)
vim.keymap.set(
    "i",
    "<C-j>",
    "<Esc>A;",
    { noremap = true, silent = true, desc = "Jump to end of line and insert ;" }
)
vim.keymap.set(
    "i",
    "<C-b>",
    "<Esc>ui",
    { noremap = true, silent = true, desc = "Undo from insert mode" }
)

-- C-H Backspace - default (uses vim navigation)
vim.keymap.set("i", "<C-l>", "<Del>", {
    noremap = true,
    silent = true,
    desc = "Delete character under cursor in insert mode",
})

-- Related defaults
-- Default: C-[ Esc
-- Default: C-T Tab between line start and first char (uses spaces :)
-- Default: C-M Enter
-- Default: C-H Backspace
-- Default: C-W Backspace word
-- Default: C-U Backspace to beginning of the line

-- Zoom a vim pane, <C-w>= to re-balance
vim.keymap.set(
    "n",
    "<leader>z",
    ":wincmd _<CR>:wincmd \\|<CR>",
    { noremap = true, silent = true, desc = "[Z]oom vim pane" }
)
vim.keymap.set(
    "n",
    "<leader>Z",
    ":wincmd =<CR>",
    { noremap = true, silent = true, desc = "Rebalance vim panes" }
)
-- Close a buffer without changing the window splits
vim.keymap.set("n", "<leader>q", ":bp<bar>vsp<bar>bn<bar>bd<CR>", {
    noremap = true,
    silent = true,
    desc = "[Q]uit buffer without changing window splits",
})
vim.keymap.set("n", "<leader>bd", ":bp<bar>vsp<bar>bn<bar>bd<CR>", {
    noremap = true,
    silent = true,
    desc = "[D]elete buffer without changing window splits",
})

-- Options to engage cmd mode from normal-mode
-- ===========================

-- Change local working directory
vim.keymap.set(
    "n",
    "<leader>cd",
    ":lcd %:p:h<CR>:pwd<CR>",
    { noremap = true, silent = true, desc = "Change local working directory" }
)

-- Uncommented options for engaging cmd mode
-- vim.keymap.set('n', '<leader>c', ':', { noremap = true, desc = 'Enter command mode' })
-- vim.keymap.set('n', '<leader>n', '/', { noremap = true, desc = 'Enter search mode' })

vim.keymap.set("n", "<leader>m", ":%s/", { noremap = true, desc = "Start search and replace" })
vim.keymap.set(
    "n",
    "<leader>v",
    ":@:<CR>",
    { noremap = true, silent = true, desc = "Execute last command" }
)
-- v is next to c, v is mac pasting
-- Recall, the `gc` postfix engages user-confirmed search and replace

--------------------------------------------------------------------------------
-- buffers vim-bby
--------------------------------------------------------------------------------
-- Close buffers, not windows
vim.keymap.set(
    "n",
    "<Leader>q",
    ":Bdelete<CR>",
    { noremap = true, silent = true, desc = "[Q] buffer" }
)
vim.keymap.set(
    "n",
    "<leader>bd",
    ":Bdelete<CR>",
    { noremap = true, silent = true, desc = "buffer [D]elete buffer" }
)
-- vim.keymap.set('n', '<leader>bd', ':bp<bar>sp<bar>bn<bar>bd<CR>', { noremap = true, silent = true, desc = 'Close buffer and switch to next' })

-- Next, previous buffer
vim.keymap.set(
    "n",
    "<leader>bp",
    ":bp<CR>",
    { noremap = true, silent = true, desc = "buffer [P]revious buffer" }
)
vim.keymap.set(
    "n",
    "<leader>bn",
    ":bn<CR>",
    { noremap = true, silent = true, desc = "buffer [N]ext buffer" }
)

-- Close every window except the current (o = other)
vim.keymap.set(
    "n",
    "<leader>bo",
    "<C-W>o",
    { noremap = true, silent = true, desc = "buffer close [O]thers" }
)

-- List buffers and option to jump
vim.keymap.set(
    "n",
    "<leader>bb",
    ":buffers<CR>:buffer<Space>",
    { noremap = true, silent = true, desc = "buffer List and jump to buffer" }
)

-- Select all text in current buffer
vim.keymap.set(
    "n",
    "<leader>aa",
    "ggVG",
    { noremap = true, silent = true, desc = "Select all text in current buffer" }
)

-- Jump to previous edit point (default mappings)
-- vim.keymap.set('n', 'g;', '', { noremap = true, silent = true, desc = 'Jump to previous edit point' })
-- vim.keymap.set('n', 'g,', '', { noremap = true, silent = true, desc = 'Jump to previous edit point' })

--------------------------------------------------------------------------------
-- Tabularize
--------------------------------------------------------------------------------
-- Formats text to align in a table format
vim.g.haskell_tabular = 1

-- Visual mode mappings for tabularizing
vim.keymap.set(
    "v",
    "a=",
    ":Tabularize /=/l1r1<CR>",
    { noremap = true, silent = true, desc = "Align by =" }
)
vim.keymap.set(
    "v",
    "a;",
    ":Tabularize /:/l1r0l0r1<CR>",
    { noremap = true, silent = true, desc = "Align by :" }
)
vim.keymap.set(
    "v",
    "a-",
    ":Tabularize /->/l1r0l0r1<CR>",
    { noremap = true, silent = true, desc = "Align by ->" }
)
vim.keymap.set(
    "v",
    "a{",
    ":Tabularize /{><CR>",
    { noremap = true, silent = true, desc = "Align by {" }
)

-- Normal mode mappings for tabularizing
vim.keymap.set(
    "n",
    "<leader>ta",
    ":Tabularize /<space>/",
    { noremap = true, silent = true, desc = "Align by space" }
)
-- Align records in Haskell
vim.keymap.set(
    "n",
    "<leader>tr",
    ":Tabularize /[:,{}]/l1l1l1r0l0l1l1<CR>",
    { noremap = true, silent = true, desc = "Align Haskell records" }
)

-- Open window splits in various places
vim.keymap.set(
    "n",
    "<leader>sh",
    ":leftabove vnew<CR>",
    { noremap = true, silent = true, desc = "Open split on the left" }
)
vim.keymap.set(
    "n",
    "<leader>sl",
    ":rightbelow vnew<CR>",
    { noremap = true, silent = true, desc = "Open split on the right" }
)
vim.keymap.set(
    "n",
    "<leader>sk",
    ":leftabove new<CR>",
    { noremap = true, silent = true, desc = "Open split above" }
)
vim.keymap.set(
    "n",
    "<leader>sj",
    ":rightbelow new<CR>",
    { noremap = true, silent = true, desc = "Open split below" }
)

-- Copy/Paste
-- ==========

-- Access clipboard from yank while in insert-mode
vim.keymap.set(
    "i",
    "<C-p>",
    "<C-r>*",
    { noremap = true, silent = true, desc = "Paste from clipboard in insert mode" }
)

-- OS Clipboard
-- Copy and paste to OS clipboard
-- Note: Ctrp uses <leader>p_
vim.keymap.set(
    "n",
    "<leader>y",
    '"*y',
    { noremap = true, silent = true, desc = "[Y]ank to OS clipboard" }
)
vim.keymap.set(
    "v",
    "<leader>y",
    '"*y',
    { noremap = true, silent = true, desc = "[Y]ank to OS clipboard" }
)
vim.keymap.set(
    "n",
    "<leader>p",
    '"*p',
    { noremap = true, silent = true, desc = "[P]aste from OS clipboard" }
)
vim.keymap.set(
    "v",
    "<leader>p",
    '"*p',
    { noremap = true, silent = true, desc = "[P]aste from OS clipboard" }
)

-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
vim.keymap.set(
    "v",
    "*",
    ':call VisualSelection("f", "")<CR>',
    { noremap = true, silent = true, desc = "Search for current selection forward" }
)
vim.keymap.set(
    "v",
    "#",
    ':call VisualSelection("b", "")<CR>',
    { noremap = true, silent = true, desc = "Search for current selection backward" }
)

-- Treat long lines as break lines (useful when moving around in them)
vim.keymap.set(
    "n",
    "j",
    "gj",
    { noremap = true, silent = true, desc = "[G]o j Move down by screen line" }
)
vim.keymap.set(
    "n",
    "k",
    "gk",
    { noremap = true, silent = true, desc = "[G]o k Move up by screen line" }
)

-- Return to last edit position when opening files
vim.api.nvim_create_augroup("last_edit", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = "last_edit",
    callback = function()
        local line = vim.fn.line
        if line("'\"") > 0 and line("'\"") <= line("$") then vim.cmd('normal! g`"') end
    end,
    desc = "Return to last edit position when opening files",
})

-- Remember info about open buffers on close
---@diagnostic disable-next-line: undefined-field
vim.opt.viminfo:append("%")

--------------------------------------------------------------------------------
-- Lspsaga
--------------------------------------------------------------------------------
--wk.register({
--    l = {
--        name = "Lspsaga",
--        c = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
--        o = { "<cmd>Lspsaga outline<cr>", "Outline" },
--        r = { "<cmd>Lspsaga rename<cr>", "Rename" },
--        d = { "<cmd>Lspsaga goto_definition<cr>", "Lsp GoTo Definition" },
--        f = { "<cmd>Lspsaga finder<cr>", "Lsp Finder" },
--        p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
--        s = { "<cmd>Lspsaga signature_help<cr>", "Signature Help" },
--        w = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Show Workspace Diagnostics" },
--    },
--}, { prefix = "<leader>" })

--------------------------------------------------------------------------------
-- Vim-visual-multi
-- Perhaps a substitute for failing tabularize
--------------------------------------------------------------------------------
local function visual_cursors_with_delay()
    -- Execute the vm-visual-cursors command.
    vim.cmd('silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"')
    -- Introduce delay via VimScript's 'sleep' (set to 500 milliseconds here).
    vim.cmd("sleep 200m")
    -- Press 'A' in normal mode after the delay.
    vim.cmd('silent! execute "normal! A"')
end

vim.keymap.set(
    "n",
    "<leader>ma",
    "<Plug>(VM-Select-All)<Tab>",
    { noremap = true, silent = true, desc = "[M]ulti-cursor Select [A]ll" }
)
vim.keymap.set(
    "n",
    "<leader>mr",
    "<Plug>(VM-Start-Regex-Search)",
    { noremap = true, silent = true, desc = "[M]ulti-cursor Start-[R]egex-Search" }
)
vim.keymap.set(
    "n",
    "<leader>mp",
    "<Plug>(VM-Add-Cursor-At-Pos)",
    { noremap = true, silent = true, desc = "[M]ulti-cursor app cursor at [P]osition" }
)
vim.keymap.set(
    "n",
    "<leader>mo",
    "<Plug>(VM-Toggle-Mappings)",
    { noremap = true, silent = true, desc = "[M]ulti-cursor toggle [O]n [O]ff mappings" }
)
-- Visual mode mappings
vim.keymap.set(
    "v",
    "<leader>mv",
    visual_cursors_with_delay,
    { noremap = true, silent = true, desc = "[M]ulti-cursor [V]isual cursors" }
)

-- END
