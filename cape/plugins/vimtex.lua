return {
    ---@diagnostic disable: inject-field
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
        -- VimTeX configuration goes here, e.g.
        --
        -- vim.g.maplocalleader = ","
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_view_skim_activate = 1
        vim.g.vimtex_view_skim_reading_bar = 1
        vim.g.vimtex_compiler_method = "latexmk"
    end,
}
