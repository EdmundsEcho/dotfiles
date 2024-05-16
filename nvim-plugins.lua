-- nvim-plugins.lua
--------------------------------------------------------------------------------
-- Uses lazy.nvim to load plugins as needed.  This said, there are several
-- that need to be eagerly loaded.  They are those plugins with lazy = false.
--
-- The trickiest part has to do with making sure mason, mason-lspconfig and
-- lspconfig work in sequence (one after the other in that sequence).
--
-- Last updated: May 15, 2024
--------------------------------------------------------------------------------
-- bootstrap lazy
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup(
-- Plugins
    {
        -- Support bundles
        "tpope/vim-surround",
        "tpope/vim-repeat",
        "kana/vim-submode",
        "michaeljsmith/vim-indent-object",
        "moll/vim-bbye",
        "jiangmiao/auto-pairs",
        "windwp/nvim-ts-autotag",

        -- Ripgrep integration
        "duane9/nvim-rg",

        -- Typescript
        "jose-elias-alvarez/typescript.nvim",
        -- Helm
        "towolf/vim-helm",
        "lewis6991/gitsigns.nvim",
        -- Text manipulation
        "godlygeek/tabular",
        "tpope/vim-commentary",
        "easymotion/vim-easymotion",
        "ConradIrwin/vim-bracketed-paste",
        -- Distraction-free txt
        "junegunn/goyo.vim",
        -- Dim inactive windows
        "blueyed/vim-diminactive",
        -- Compare blocks of code
        "AndrewRadev/linediff.vim",
        -- Folding
        "tmhedberg/SimpylFold",
        -- Functional
        "dag/vim-fish",

        -- Notify - v. pretty
        {
            "rcarriga/nvim-notify",
            lazy = false,
            opts = {
                -- used to make transparent
                -- NotifyBackground
                background_colour = "#000000",
            },
        },
        -- Noice - v. pretty
        {
            "folke/noice.nvim",
            lazy = false,
            event = "VeryLazy",
            opts = {
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            },
            dependencies = {
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
                "hrsh7th/nvim-cmp",
            },
        },

        -- Tmux integration
        { "benmills/vimux",                     lazy = false },
        { "tmux-plugins/vim-tmux-focus-events", lazy = false },
        {
            "christoomey/vim-tmux-navigator",
            lazy = false,
            cmd = {
                "TmuxNavigateLeft",
                "TmuxNavigateDown",
                "TmuxNavigateUp",
                "TmuxNavigateRight",
                "TmuxNavigatePrevious",
            },
            keys = {
                { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
                { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
                { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
                { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
                { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
            },
        },

        -- Trouble
        {
            "folke/trouble.nvim",
            branch = "dev", -- IMPORTANT!
            keys = {
                {
                    "<leader>xx",
                    "<cmd>Trouble diagnostics toggle<cr>",
                    desc = "Diagnostics (Trouble)",
                },
                {
                    "<leader>xX",
                    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                    desc = "Buffer Diagnostics (Trouble)",
                },
                {
                    "<leader>cs",
                    "<cmd>Trouble symbols toggle focus=false<cr>",
                    desc = "Symbols (Trouble)",
                },
                {
                    "<leader>cl",
                    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                    desc = "LSP Definitions / references / ... (Trouble)",
                },
                {
                    "<leader>xL",
                    "<cmd>Trouble loclist toggle<cr>",
                    desc = "Location List (Trouble)",
                },
                {
                    "<leader>xQ",
                    "<cmd>Trouble qflist toggle<cr>",
                    desc = "Quickfix List (Trouble)",
                },
            },
            opts = {}, -- for default options, refer to the configuration section for custom setup.
        },

        -- Color preview (depends on go)
        {
            "rrethy/vim-hexokinase",
            build = "make hexokinase",
        },
        -- Rest plugin
        {
            "vhyrro/luarocks.nvim",
            priority = 1000,
            config = true,
            opts = {
                rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
            },
        },
        {
            "rest-nvim/rest.nvim",
            ft = "http",
            dependencies = { "luarocks.nvim" },
            config = function()
                require("rest-nvim").setup()
            end,
        },
        -- Telescope
        {
            "nvim-telescope/telescope.nvim",
            lazy = true,
            -- tag = '0.1.6',
            branch = "0.1.x",
            dependencies = {
                "nvim-telescope/telescope-fzf-native.nvim",
                "nvim-treesitter/nvim-treesitter",
                "nvim-lua/plenary.nvim",
                "ahmedkhalf/project.nvim",
                "ahmedkhalf/project.nvim",
                "rcarriga/nvim-notify", -- v. pretty
                "sharkdp/fd",
            },
            config = function()
                require("nvim-telescope").setup()
            end,
        },
        -- Telescope fzf-native extension
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            lazy = true,
            build = "make",
        },
        -- Project root directory
        {
            "ahmedkhalf/project.nvim",
            config = function()
                require("project_nvim").setup({
                    detection_methods = { "lsp", "pattern" },
                    exclude_dir = {
                        "~/.cargo/*",
                    },
                    patterns = {
                        ".git",
                        "_darcs",
                        ".hg",
                        ".bzr",
                        ".svn",
                        "Makefile",
                        "package.json",
                        "pyproject.toml",
                        "stack.yaml",
                        "cabal.project",
                        "Cargo.toml",
                    },
                })
            end,
        },
        -- Lualine
        {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("nvim-lualine")
            end,
            dependencies = { "nvim-tree/nvim-web-devicons" },
        },

        -- Vertical indent lines
        {
            "lukas-reineke/indent-blankline.nvim",
            lazy = false,
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
            },
            main = "ibl",
            config = function()
                require("nvim-indentline").setup()
            end,
        },

        -- Tabs
        {
            "romgrk/barbar.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" }, -- For file icons (if needed)
            init = function()
                vim.g.barbar_auto_setup = false               -- Disable default setup
            end,
            config = function()
                require("nvim-barbar").setup()
            end,
        },

        -- Completion framework
        {
            "hrsh7th/nvim-cmp",
            lazy = false,
            config = function()
                require("nvim-cmp").setup()
            end,
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-vsnip",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/vim-vsnip",
                "ray-x/cmp-treesitter",
                "hrsh7th/cmp-nvim-lua",
                "tzachar/cmp-tabnine",
                "lukas-reineke/cmp-rg",
                "David-Kunz/cmp-npm",
                "andersevenrud/cmp-tmux",
                "mtoohey31/cmp-fish",
                "nvim-telescope/telescope-ui-select.nvim",
                "onsails/lspkind-nvim", -- may remove
            },
        },

        {
            "tzachar/cmp-tabnine",
            build = "./install.sh",
            dependencies = { "hrsh7th/nvim-cmp" }, -- Ensure nvim-cmp is a dependency
            config = function()
                require("cmp_tabnine.config"):setup({
                    max_lines = 1000,
                    max_num_results = 10,
                    sort = true,
                    run_on_every_keystroke = true,
                    snippet_placeholder = "..",
                })
            end,
        },

        -- Formatting manager
        {
            "stevearc/conform.nvim",
            config = function()
                require("nvim-conform")
            end,
        },
        {
            "mhartington/formatter.nvim",
            config = function()
                require("nvim-formatting")
            end,
        },

        -- Treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            dependencies = {
                { "nvim-treesitter/playground", lazy = true },
            },
            lazy = false,
            build = function()
                vim.cmd("TSUpdate") -- Command to update parsers
            end,
            config = function()
                require("nvim-treesitter.configs").setup({
                    build = ":TSUpdate",
                    sync_install = true,
                    ignore_install = {},
                    modules = {},
                    ensure_installed = {
                        "bash",
                        "c",
                        "cpp",
                        "css",
                        "html",
                        "javascript",
                        "json",
                        "lua",
                        "python",
                        "typescript",
                        "yaml",
                        "markdown",
                        "haskell",
                    },
                    auto_install = true,
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                    },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "gnn",
                            node_incremental = "grn",
                            scope_incremental = "grc",
                            node_decremental = "grm",
                        },
                    },
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                -- You can use the capture groups defined in textobjects.scm
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                ["ic"] = "@class.inner",
                            },
                        },
                    },
                    indent = {
                        enable = true,
                        disable = { "yaml" },
                    },
                    playground = {
                        enable = true,
                        disable = {},
                        updatetime = 25,
                        persist_queries = false,
                    },
                })
            end,
        },

        {
            "windwp/nvim-ts-autotag",
            dependencies = { "nvim-treesitter/nvim-treesitter" },
        },

        -- LSP
        {
            "williamboman/mason.nvim",
            lazy = false,
            config = function()
                require("nvim-mason").setup()                                 -- calls mason.setup(opts)
                local mason_ref =
                    require("mason-lspconfig").setup({ auto_install = true }) -- presumably refs mason
                if mason_ref then
                    vim.notify(
                        "👉 mason servers: " .. mason_ref.get_servers(),
                        vim.log.levels.INFO
                    )
                end
                require("nvim-lspconfig").setup()
            end,
            dependencies = {
                "williamboman/mason-lspconfig.nvim",
                "neovim/nvim-lspconfig",
                "nvimtools/none-ls.nvim",
                "nvimtools/none-ls-extras.nvim",
                "jayp0521/mason-null-ls.nvim",
            },
        },
        -- Rust
        {
            "mrcjkb/rustaceanvim",
            priority = 90,
            disable = true,
            version = "^4", -- Recommended
            lazy = false,   -- This plugin is already lazy
            config = function()
                require("nvim-rustacean").setup()
            end,
            dependencies = {
                "mfussenegger/nvim-dap",
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "nvim-telescope/telescope.nvim",
                "neovim/nvim-lspconfig", -- Language Server Protocol configurations
            },
        },
        -- null-ls (none-ls)
        {
            "jayp0521/mason-null-ls.nvim",
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                require("nvim-null_ls")
            end,
            dependencies = {
                "williamboman/mason.nvim",
                "nvimtools/none-ls.nvim",
                "nvim-lua/plenary.nvim",
            },
        },
        {
            "nvimtools/none-ls.nvim",
            config = function()
                require("nvim-null_ls").setup()
            end,
            dependencies = {
                "nvimtools/none-ls-extras.nvim",
                "nvim-telescope/telescope.nvim",
                "nvim-lua/plenary.nvim",
            },
        },

        -- Rust formating
        "vappolinario/cmp-clippy",
        {
            "mfussenegger/nvim-dap",
            lazy = true,
            config = function()
                require("nvim-dap").setup()
            end,
            dependencies = {
                "rcarriga/nvim-dap-ui",
                "folke/neodev.nvim",
            },
        },
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "mfussenegger/nvim-dap",
                "nvim-neotest/nvim-nio",
            },
        },
        -- Haskell
        "enomsg/vim-haskellConcealPlus",
        "mrcjkb/haskell-tools.nvim",

        -- Copilot
        {
            "zbirenbaum/copilot.lua",
            event = "InsertEnter",   -- Lazy load on entering Insert mode (optional)
            cmd = "Copilot",         -- To be able to call `:Copilot` if lazy loaded (optional)
            build = ":Copilot auth", -- For authentication if required
            config = function()
                require("nvim-copilot").setup()
            end,
        },

        -- Gemini
        {
            "meinside/gemini.nvim",
            lazy = true,
            config = function()
                require("nvim-gemini").setup()
            end,
            dependencies = { { "nvim-lua/plenary.nvim" } },
        },

        -- Lspsaga (UI for linting).. useful?
        {
            "nvimdev/lspsaga.nvim",
            config = function()
                require("lspsaga").setup({})
            end,
            dependencies = {
                "nvim-treesitter/nvim-treesitter", -- optional
                "nvim-tree/nvim-web-devicons",     -- optional
            },
        },

        -- UI Enhancements
        -- usage: FineCmdLine
        {
            "VonHeikemen/fine-cmdline.nvim",
            dependencies = {
                "MunifTanjim/nui.nvim",
            },
        },

        { "algmyr/vim-wombat-lua" },

        {
            "Tsuzat/NeoSolarized.nvim",
            config = function()
                -- vim.cmd("colorscheme NeoSolarized")
            end,
        },
        {
            "ray-x/aurora",
            config = function()
                -- vim.cmd 'colorscheme aurora'
            end,
        },
        {
            "scottmckendry/cyberdream.nvim",
            config = function()
                -- vim.cmd 'colorscheme cyberdream'
            end,
        },
        {
            "projekt0n/github-nvim-theme",
            config = function()
                -- require("github-theme").setup()
            end,
        },

        -- Tree (keep these at the end)
        {
            "nvim-tree/nvim-tree.lua",
            lazy = false,
            dependencies = {
                "ahmedkhalf/project.nvim",
                "nvim-tree/nvim-web-devicons",
                "yamatsum/nvim-nonicons", -- extended icons
            },
            config = function()
                require("nvim-tree").setup()
            end,
        },
    }
)
