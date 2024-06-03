return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        local hooks = require("ibl.hooks")

        hooks.register(
            hooks.type.HIGHLIGHT_SETUP,
            function() vim.api.nvim_set_hl(0, "Whitespace", { fg = "#444444", bg = "NONE" }) end
        )

        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

        local opts = {
            debounce = 300,
            indent = {
                char = "┊",
                highlight = { "Whitespace" },
                smart_indent_cap = true,
                priority = 2,
                repeat_linebreak = false,
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "haskell",
                    "json",
                    "yaml",
                    "cabal",
                    "markdown",
                    "pandoc",
                    "text",
                    "txt",
                    "sh",
                    "vim",
                    "tmux",
                    "help",
                },
            },
        }

        require("ibl").setup(opts)
    end,
}

-- END
