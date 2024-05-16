--------------------------------------------------------------------------------
-- Neovim settings using lua
-- Last updated May 12, 2024
--------------------------------------------------------------------------------
local set = vim.opt -- Shortcut to set options
--------------------------------------------------------------------------------
-- Set shell if the current shell is fish
--------------------------------------------------------------------------------
local shell = os.getenv("SHELL")
if shell and string.match(shell, "bin/fish") then
    set.shell = "/bin/sh"
end
--------------------------------------------------------------------------------
-- Path
-- Prepend mise shims to PATH
--------------------------------------------------------------------------------
vim.env.PATH = os.getenv("HOME") .. "/.local/share/mise/shims:" .. vim.env.PATH

--------------------------------------------------------------------------------
-- Escape and leader keys
--------------------------------------------------------------------------------
-- Esc key with cursor moved forward
vim.api.nvim_set_keymap("i", "df", "<esc>l", { noremap = true, silent = true })
-- Leader key and timeout
vim.g.mapleader = " "

----------------------------------------------------------------------------------
---- Color Themes
----------------------------------------------------------------------------------
---- Notes:
---- 1. Set before setting the colorscheme
---- 2. Visit https://github.com/ryanoasis/nerd-fonts#font-installation
----    to see the range of options for setting icon displays
set.background = "dark"
vim.opt.termguicolors = true

----------------------------------------------------------------------------------
---- nvim-tree requirements
----------------------------------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------------------
-- high priority behavior
-- Set up command-line completion mappings
vim.api.nvim_set_keymap(
    "c",
    "<Tab>",
    'pumvisible() ? "\\<C-n>" : "\\<C-z>"',
    { expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
    "c",
    "<S-Tab>",
    'pumvisible() ? "\\<C-p>" : "\\<C-z>"',
    { expr = true, noremap = true }
)

--------------------------------------------------------------------------------
-- Vim basic settings
vim.o.spell = false
vim.o.autoread = true                    -- Detect file changes outside vim
vim.o.autochdir = true                   -- Change working dir to current buffer
vim.o.timeoutlen = 1100
vim.g.diagnostic_enable_virtual_text = 1 -- Enable virtual text
set.clipboard = "unnamedplus"            -- copy to system clipboard
vim.opt.signcolumn = "yes"               -- Always show sign column

--------------------------------------------------------------------------------
-- Linting, history, and search behavior
set.shortmess:append("c")
set.hidden = true
set.history = 1000
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
set.relativenumber = true
set.clipboard = "unnamed"
set.encoding = "UTF-8"
set.showmode = true
set.updatetime = 300
set.lazyredraw = true
set.number = true
set.cmdheight = 1
set.incsearch = true
set.hlsearch = true
set.showmatch = true
set.matchtime = 2
set.errorbells = false
set.visualbell = true
set.list = true

-- Set the undo and directory settings
local undodir = vim.fn.expand("~/.vimdid")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
set.undodir = { undodir }
set.undofile = true
set.undolevels = 1000

-- List characters, only show interesting whitespace
-- Note: `vim.fn` is used here to check existing settings conditionally
if vim.opt.listchars:get() == "eol:$" then
    set.listchars = { "tab:>\\ ,trail:-,extends:>,precedes:<,nbsp:+" }
end

-- Backspace and wrapping settings
set.backspace = { "eol", "start", "indent" }
set.whichwrap:append("<,>,h,l")

-- Scrolling settings
set.scrolloff = 10
set.sidescrolloff = 5
set.sidescroll = 1

--------------------------------------------------------------------------------
-- Set visual tweaks
set.textwidth = 80
set.colorcolumn = "+1"
set.wrap = false
set.linebreak = true
set.ttyfast = true
--------------------------------------------------------------------------------
-- Folding settings
set.foldmethod = "expr"
set.viewoptions = "folds,cursor"
set.sessionoptions = "folds"
-- Assuming you have moved the fold expression setup to a separate Lua config
-- vim.opt.foldexpr = vim.api.nvim_get_var('nvim_treesitter#foldexpr()')
set.foldnestmax = 10
set.foldenable = false
set.foldminlines = 1
set.foldlevel = 1
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
-- GUI-specific options
if vim.fn.has("gui_running") == 1 then
    vim.opt.guioptions:remove("T")
    vim.opt.guioptions:remove("e")
    vim.opt.guitablabel = "%M %t"
end
--------------------------------------------------------------------------------
-- Command completion settings
set.wildmenu = true
set.wildmode = "list:longest"
-- Uncomment below if you want to extend wildmode behavior
-- vim.opt.wildmode = 'list:longest,full'
-- Configure patterns to ignore during file completion
set.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db"
set.wildignore:append("*.min.js,*.swp,publish/*,intermediate/*,*.o")
set.wildignore:append("build,cache,dist,coverage,node_modules")
set.wildignore:append("release,rls,debug")
set.wildignore:append("*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox")
--------------------------------------------------------------------------------
-- Set up filetype detection, plugins, and indentation
set.filetype = "on"
set.expandtab = true -- Assuming you might want to set expandtab here or any other related options

-- END
