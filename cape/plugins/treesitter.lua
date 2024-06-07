-- Treesitter
return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        {
            "windwp/nvim-ts-autotag",
        },
        {
            "nvim-treesitter/playground",
            lazy = true,
        },
    },
    opts = {
        sync_install = true,
        ignore_install = { "" },
        modules = {},
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
            "python",
            "rust",
            "toml",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        },
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
            disable = { "yaml" },
        },
        autotag = {
            enable = true,
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },

        textobjects = {
            move = {
                enable = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                },
            },
        },

        playground = {
            enable = true,
            disable = {},
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
