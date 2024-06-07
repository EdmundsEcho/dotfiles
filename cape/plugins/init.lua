-- Basic Plugins
return {
    "tpope/vim-repeat",
    "kana/vim-submode",
    "famiu/bufdelete.nvim",
    "godlygeek/tabular",
    { "algmyr/vim-wombat-lua" },
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
    { "mg979/vim-visual-multi" },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
