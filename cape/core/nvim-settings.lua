--------------------------------------------------------------------------------
-- Settings
--------------------------------------------------------------------------------
-- Last updated June 23, 2024
--
-- see :help vim.opt
---@diagnostic disable: inject-field, undefined-field
--------------------------------------------------------------------------------
local set = vim.opt -- Shortcut to set options
--------------------------------------------------------------------------------
-- Set shell if the current shell is fish
--------------------------------------------------------------------------------
local shell = os.getenv("SHELL")
if shell and string.match(shell, "bin/fish") then set.shell = "/bin/sh" end

-- 🦀 fix to avoid ml_get error - does not work
-- vim.g.netrw_use_noswf = 0

--------------------------------------------------------------------------------
-- Display style of builtin explorer
--------------------------------------------------------------------------------
vim.cmd("let g:netrw_liststyle = 3")

--------------------------------------------------------------------------------
-- Path
-- Prepend mise shims to PATH
--------------------------------------------------------------------------------
-- vim.env.PATH = os.getenv("HOME") .. "/.local/share/mise/shims:" .. vim.env.PATH
-- notify which version of python is being used

--------------------------------------------------------------------------------
-- Escape and leader keys
--------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("i", "df", "<ESC>l", { noremap = true, silent = true })

----------------------------------------------------------------------------------
---- Nerd font - true if loaded in the terminal
----------------------------------------------------------------------------------
vim.g.have_nerd_font = true

----------------------------------------------------------------------------------
---- Color Themes
----------------------------------------------------------------------------------
---- Notes:
---- 1. Set before setting the colorscheme
---- 2. Visit https://github.com/ryanoasis/nerd-fonts#font-installation
----    to see the range of options for setting icon displays
set.background = "dark"
vim.opt.termguicolors = true

--------------------------------------------------------------------------------
-- Vim basic settings
vim.opt.showmode = false -- already in status line
vim.o.spell = false
vim.o.autoread = true -- Detect file changes outside vim
vim.o.autochdir = true -- Change working dir to current buffer
set.clipboard = "unnamedplus" -- copy to system clipboard
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.breakindent = true -- WARN: ?
vim.opt.cursorline = true -- WARN: ?
vim.g.diagnostic_enable_virtual_text = 1 -- Enable virtual text

-- NOTE: which-key will over-write these settings
vim.o.timeout = true
vim.o.timeoutlen = 500

--------------------------------------------------------------------------------
-- Linting, history, and search behavior
set.shortmess:append("c")
set.hidden = true
set.history = 2000
vim.opt.viminfo = "'101,f1"
set.ignorecase = true
set.smartcase = true
set.gdefault = true
set.magic = true

-- Mouse and file format settings
set.mouse = "a"
set.fileformats = { "unix", "dos", "mac" }

-- Backup and swapfile settings
set.backup = false
set.writebackup = false
set.swapfile = false

-- Split behavior
set.splitbelow = true
set.splitright = true
set.autowrite = true

-- UI and search settings
set.inccommand = "split" -- New
set.number = true
set.relativenumber = true
set.clipboard = "unnamed"
set.encoding = "UTF-8"
set.showmode = true
set.updatetime = 300
set.lazyredraw = false
set.cmdheight = 1
set.incsearch = true
set.showmatch = true
set.matchtime = 2
set.errorbells = false
set.visualbell = true
set.list = true

--------------------------------------------------------------------------------
set.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
--------------------------------------------------------------------------------
-- Set the undo and directory settings
local undodir = vim.fn.expand("~/.vimdid")
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, "p") end
set.undodir = { undodir }
set.undofile = true
set.undolevels = 1000
--------------------------------------------------------------------------------

-- List characters, only show interesting whitespace
-- Note: `vim.fn` is used here to check existing settings conditionally
-- if vim.opt.listchars:get() == "eol:$" then
--     set.listchars = { "tab:>\\ ,trail:-,extends:>,precedes:<,nbsp:+" }
-- end
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

--------------------------------------------------------------------------------
-- Backspace and wrapping settings
set.backspace = { "eol", "start", "indent" }
set.whichwrap:append("<,>,h,l")
--------------------------------------------------------------------------------
-- Scrolling settings
set.scrolloff = 10
set.sidescrolloff = 5
set.sidescroll = 1
--------------------------------------------------------------------------------
-- Set visual tweaks
set.textwidth = 88
set.colorcolumn = "+1"
set.wrap = false
set.linebreak = true
set.ttyfast = true

--------------------------------------------------------------------------------
-- Folding settings
-- see: https://neovim.io/doc/user/fold.html
set.foldmethod = "indent"
set.foldlevel = 8
set.foldnestmax = 20
set.foldenable = true
set.viewoptions = "folds,cursor"
set.sessionoptions = "folds"
-- Assuming you have moved the fold expression setup to a separate Lua config
-- vim.opt.foldexpr = vim.api.nvim_get_var('nvim_treesitter#foldexpr()')
--------------------------------------------------------------------------------
-- Tab and indentation settings
set.shiftwidth = 4
set.softtabstop = 4
set.tabstop = 4
set.expandtab = true -- To use spaces instead of tabs
set.autoindent = true
set.smartindent = true
set.smarttab = true

--------------------------------------------------------------------------------
-- Command completion settings
-- set.wildmenu = true
-- set.wildmode = "list:longest"
-- Uncomment below if you want to extend wildmode behavior
-- vim.opt.wildmode = 'list:longest,full'
-- Configure patterns to ignore during file completion
set.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db"
set.wildignore:append("*.min.js,*.swp,publish/*,intermediate/*,*.o")
set.wildignore:append("build,cache,dist,coverage,node_modules")
set.wildignore:append("release,rls,debug")
set.wildignore:append("*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox")

--------------------------------------------------------------------------------
-- Other settings
--------------------------------------------------------------------------------
-- Neovim config using lua
-- Last updated May 12, 2024
--
-- Includes
-- 1. automgroup
-- 2. global settings for various plugins
-- 3. diagnostics popup settings
--
---@diagnostic disable: inject-field
--------------------------------------------------------------------------------
-- local logger = require("cape.core.nvim-logging")
-- Spelling
vim.o.spelllang = "en"
vim.o.spellfile = os.getenv("HOME") .. "/dotfiles/en.utf-8.add"

--------------------------------------------------------------------------------
-- Open quickfix window after grep
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "*grep*",
    callback = function() vim.cmd("cwindow") end,
})

-- Set options for quickfix filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.number = false
        vim.opt_local.colorcolumn = ""
    end,
})

-- Quick escape `q` to exit help and quickfix file
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>", { noremap = true, silent = true })
    end,
})

--------------------------------------------------------------------------------
-- Turn off default services
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

-- Activate python :-/ (for http-nvim)
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
-- vim.g.python3_host_prog = "/Users/edmund/.local/share/mise/installs/python/3.10.1/bin/python3"

--------------------------------------------------------------------------------
-- Markdown
vim.g.markdown_composer_autostart = 1
vim.g.autoformat_autoindent = 0
vim.g.autoformat_retab = 0
vim.g.autoformat_remove_trailing_spaces = 0

--------------------------------------------------------------------------------
-- Vimspector
vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70

--------------------------------------------------------------------------------
-- Fixes to other norms
-- Kill the 'Q' key in normal mode (prevent entering Ex mode)
vim.keymap.set(
    "n",
    "Q",
    "<nop>",
    { noremap = true, silent = true, desc = "Custom fix to prevent entering Ex mode" }
)
-- Make <c-h> work like <c-h> again (to navigate to the left window)
vim.keymap.set(
    "n",
    "<BS>",
    "<C-w>h",
    { noremap = true, silent = true, desc = "Custom fix for <C-h>" }
)

--------------------------------------------------------------------------------
-- Line formatting
vim.o.formatprg = "par"
vim.env.PARINIT = "rTbgqR B=.,?_A_a Q=_s>|"
--------------------------------------------------------------------------------
-- Ripgrep
if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep --smart-case --hidden"
    vim.o.grepformat = "%f:%l:%c:%m"
end
vim.g.rg_path = os.getenv("HOME") .. "/.cargo/bin/rg"
--------------------------------------------------------------------------------
-- ripgrep
-- Installed using cargo; must be in PATH
-- Option 1 using :Rg
-- ==================
-- Usage
-- Search for foo in current working directory: :grep foo.
-- Search for foo in files under src/: :grep foo src.
-- Search for foo in current file directory: :grep foo %:h1.
-- Search for foo in current file directory’s parent directory: :grep foo %:h:h (and so on).
-- :grep foo `git ls-files --modified`
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- indentLine configuration
--------------------------------------------------------------------------------
-- Note: not compatible with Haskell
--------------------------------------------------------------------------------
vim.g.indentLine_char = "┊" -- Set indent line character
-- Exclude certain file types from indentLine
vim.g.indentLine_fileTypeExclude = {
    "haskell",
    "haskellstack",
    "cabal",
    "haskellhpack",
    "json",
    "yaml",
    "markdown",
    "pandoc",
    "text",
    "txt",
    "sh",
    "vim",
    "tmux",
    "help",
}

--------------------------------------------------------------------------------
-- vim-diminactive Plugin Settings
---@class g
vim.g.diminactive_enable_focus = 1

--------------------------------------------------------------------------------
-- Session Settings for vim-sessions Plugin
vim.g.session_autosave = "yes"

--------------------------------------------------------------------------------
-- Popup when hover
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end,
})

-- Configure how nvim messages are presented
-- (Separate from cmp diagnostics)
vim.diagnostic.config({
    virtual_text = true, -- Show virtual text for diagnostics
    signs = true, -- Show signs in the gutter
    update_in_insert = true, -- Update diagnostics in insert mode
    underline = false, -- Disable underlining of diagnostic text
    severity_sort = false, -- Do not sort diagnostics by severity
    float = {
        border = "rounded", -- Use rounded borders for diagnostic floats
        source = "always", -- Always show the source of the diagnostic
        header = "", -- No header in the diagnostic float
        prefix = "", -- No prefix for the diagnostic message
    },
})

-- Create an autocommand group for custom quickfix behavior
vim.api.nvim_create_augroup("QuickfixOverrides", { clear = true })

-- Create an autocommand for the quickfix window
vim.api.nvim_create_autocmd("FileType", {
    group = "QuickfixOverrides",
    pattern = "qf",
    callback = function()
        -- Map <CR> to jump to the location in the quickfix list
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<CR>",
            "<CR>",
            { noremap = true, silent = true, nowait = true }
        )
    end,
})

-- END
