--------------------------------------------------------------------------------
-- ✅ Parsing for deep highlighting
require("nvim-treesitter.configs").setup({
    --------------------------------------------------------------------------------
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        "css",
        "dockerfile",
        "fish",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
    auto_install = true,
    sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
    },
    indent = { enable = true },
    extensions = { "quickfix" },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
})
