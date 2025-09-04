-- Treesitter
return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        {
            "windwp/nvim-ts-autotag",
            opts = {
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false, -- Auto close on trailing </
            },
        },
        {
            "nvim-treesitter/playground",
            lazy = true,
        },

        "folke/which-key.nvim",
    },
    config = function(_, opts)
        -- Overwrite fold setting in core/nvim-settings.lua
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = true

        require("nvim-treesitter.install").prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup(opts)

        -- Custom keybindings for Treesitter incremental selection
        vim.keymap.set(
            "n",
            "snn",
            function() require("nvim-treesitter.incremental_selection").node_initial() end,
            { silent = true, desc = "[S]elect [N]ode [N]ew" }
        )
        vim.keymap.set(
            "n",
            "snm",
            function() require("nvim-treesitter.incremental_selection").node_decremental() end,
            { silent = true, desc = "[S]elect [N]ode [M].. less" }
        )
        vim.keymap.set(
            "n",
            "snc",
            function() require("nvim-treesitter.incremental_selection").scope_incremental() end,
            { silent = true, desc = "[S]elect [N]ew [C]ontext" }
        )
    end,
    opts = {
        sync_install = true,
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "dockerfile",
            "fish",
            "gitignore",
            "haskell",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "nu",
            "python",
            "rust",
            "svelte",
            "toml",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        },
        highlight = {
            enable = true,
            disable = {},
        },
        indent = {
            enable = true,
            disable = { "yaml", "ruby" },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "snn", -- set to `false` to disable one of the mappings
                node_incremental = "snn",
                node_decremental = "snm",
                scope_incremental = "snc",
            },
        },
        playground = {
            enable = true,
            updatetime = 25,
            persist_queries = false,
            keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?",
            },
        },
    },
}
