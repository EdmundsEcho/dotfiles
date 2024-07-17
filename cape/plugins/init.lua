-- Basic Plugins
return {
    "tpope/vim-repeat",
    "kana/vim-submode",
    "famiu/bufdelete.nvim",
    "godlygeek/tabular",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
    },
    { "mg979/vim-visual-multi", enabled = false },
    { "algmyr/vim-wombat-lua" },
}

-- The `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
