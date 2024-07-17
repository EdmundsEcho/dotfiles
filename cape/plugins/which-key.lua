return { -- Show you pending keybinds
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {

        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "→", -- symbol used between a key and its label
            group = "+", -- symbol prepended to a group
        },
        keys = {

            {
                "df",
                hidden = true,
                group = "Escape",
                mode = "i",
            },
        },
    },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
}
