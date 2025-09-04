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
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
            -- minimum number of file buffers that need to be open to save
            -- Set to 0 to always save
            need = 1,
            branch = true, -- use git branch to save session
        },
    },
    { "mg979/vim-visual-multi", enabled = false },
    { "algmyr/vim-wombat-lua" },
}

-- The `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
