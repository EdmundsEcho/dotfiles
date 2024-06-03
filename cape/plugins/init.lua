-- Basic Plugins
return {
    "tpope/vim-repeat",
    "kana/vim-submode",
    "famiu/bufdelete.nvim",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
    },
    -- Theme
    { "algmyr/vim-wombat-lua" },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
