--------------------------------------------------------------------------------
-- tabs at the top of the window
-- barbar tab
--------------------------------------------------------------------------------
return {
    "romgrk/barbar.nvim",
    enabled = true,
    dependencies = {
        "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        icons = {
            -- Configure the base icons on the bufferline.
            -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
            buffer_index = false,
            buffer_number = false,
            button = "×",
            -- Enables / disables diagnostic symbols
            separator = { left = "|", right = "" },
            inactive = { button = "×" },

            -- Configure the icons on the bufferline based on the visibility of a buffer.
            -- Supports all the base icon options, plus `modified` and `pinned`.
            alternate = { filetype = { enabled = false } },
            current = { buffer_index = true },
            visible = { modified = { buffer_number = false } },
            diagnostics = {
                [vim.diagnostic.severity.ERROR] = {
                    enabled = true,
                    icon = "ﬀ",
                },
                [vim.diagnostic.severity.WARN] = { enabled = false },
                [vim.diagnostic.severity.INFO] = { enabled = false },
                [vim.diagnostic.severity.HINT] = { enabled = true },
            },
        },
    },
}
