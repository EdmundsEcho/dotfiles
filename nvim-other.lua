--------------------------------------------------------------------------------
-- Neovim config using lua
-- Last updated May 12, 2024
--
-- Includes
-- 1. automgroup
-- 2. global settings for various plugins
-- 3. diagnostics popup settings
--
--------------------------------------------------------------------------------
local logger = require("nvim-logging")

-- Spelling
vim.o.spelllang = "en"
vim.o.spellfile = os.getenv("HOME") .. "/dotfiles/en.utf-8.add"

--------------------------------------------------------------------------------
-- Open quickfix window after grep
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "*grep*",
    callback = function()
        vim.cmd("cwindow")
    end,
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
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "q",
            ":q<CR>",
            { noremap = true, silent = true }
        )
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "q",
            ":q<CR>",
            { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<CR>",
            "<CR>",
            { noremap = true, silent = true }
        )
    end,
})

--------------------------------------------------------------------------------
-- Turn off default services
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

--------------------------------------------------------------------------------
-- Markdown
vim.g.markdown_composer_autostart = 1
vim.g.autoformat_autoindent = 0
vim.g.autoformat_retab = 0
vim.g.autoformat_remove_trailing_spaces = 0
vim.g.formatdef_custom_haskell = '"stylish-haskell"'
vim.g.formatters_haskell = { "custom_haskell" }

--------------------------------------------------------------------------------
-- Vimspector
vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70

--------------------------------------------------------------------------------
-- Fixes to other norms
-- Kill the 'Q' key in normal mode (prevent entering Ex mode)
vim.api.nvim_set_keymap("n", "Q", "<nop>", { noremap = true, silent = true })
-- Make <c-h> work like <c-h> again (to navigate to the left window)
vim.api.nvim_set_keymap(
    "n",
    "<BS>",
    "<C-w>h",
    { noremap = true, silent = true }
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
vim.g.diminactive_enable_focus = 1

--------------------------------------------------------------------------------
-- Session Settings for vim-sessions Plugin
vim.g.session_autosave = "yes"

--------------------------------------------------------------------------------
-- Netrw Plugin Settings
vim.g.netrw_list_hide = {}
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------------------
-- HTML and JSX Plugin Mappings and Settings
vim.api.nvim_set_keymap(
    "i",
    "><Tab>",
    '><Esc>F<lyt>o/<C-r>"><Esc>O<Space>',
    { noremap = true }
)
vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml"
vim.g.closetag_xhtml_filenames = "*.xhtml,*.js,*.jsx"
vim.g.closetag_emptyTags_caseSensitive = 1

-- Autocommands Setup
local autocmd = vim.api.nvim_create_autocmd

-- Treesitter folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- format on save
autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local success, _ = pcall(function()
            vim.lsp.buf.format({ async = false })
        end)
        if not success then
            local bufnr = vim.api.nvim_get_current_buf()
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            logger.log(
                "Error formatting buffer: " .. bufname,
                vim.log.levels.WARN
            )
        end
    end,
})

-- Popup when hover
autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
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
