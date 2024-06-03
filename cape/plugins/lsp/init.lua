-- LSP
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "williamboman/mason.nvim",
            config = function() require("lsp-cfgs/mason").setup() end,
        },
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "nvim-telescope/telescope.nvim",
        { "folke/neodev.nvim", opts = {} },
        "b0o/SchemaStore.nvim",
        {
            "j-hui/fidget.nvim",
            config = function() require("cape.plugins.fidget") end,
        },
    },
    config = function()
        require("lsp-cfgs/lspconfig").setup()
        -- not managed by mason
        require("lspconfig").taplo.setup({
            config_file = {
                enabled = true,
                path = vim.env.HOME .. "/.taplo.toml",
            },
            cmd = { "taplo", "lsp", "stdio" },
            filetypes = { "toml" },
            root_dir = function(fname)
                local util = require("lspconfig.util")
                return util.root_pattern("*.toml")(fname) or util.find_git_ancestor(fname)
            end,
            single_file_support = true,
        })
    end,
}
