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
-- check status of plugin
--    :Lazy
--    `?` in the menu for help
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup(
-- Plugins
  {
    "tpope/vim-sleuth",     -- detects tabstop and shiftwidth
    "tpope/vim-repeat",
    { "numToStr/Comment.nvim",              opts = {} },
    "kana/vim-submode",
    "michaeljsmith/vim-indent-object",
    "famiu/bufdelete.nvim",
    "jiangmiao/auto-pairs",
    "windwp/nvim-ts-autotag",
    {
      -- "tpope/vim-surround",
      "kylechui/nvim-surround",
      version = "*",       -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end,
    },
    {
      "echasnovski/mini.nvim",
      config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()
      end,
    },
    {     -- nextgen easymotion

      "smoka7/hop.nvim",
      version = "*",
      opts = {
        keys = "etovxqpdygfblzhckisuran",
      },
    },
    {     -- Show you pending keybinds
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        local plugin = require("which-key")
        plugin.setup()
        -- Document existing key chains
        plugin.register({
          ["<leader><leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
          ["<leader><leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
          ["<leader><leader>r"] = {
            name = "[R]ename",
            _ = "which_key_ignore",
          },
          ["<leader><leader>s"] = {
            name = "[S]earch",
            _ = "which_key_ignore",
          },
          ["<leader><leader>w"] = {
            name = "[W]orkspace",
            _ = "which_key_ignore",
          },
          ["<leader><leader>t"] = {
            name = "[T]oggle",
            _ = "which_key_ignore",
          },
          ["<leader><leader>h"] = {
            name = "Git [H]unk",
            _ = "which_key_ignore",
          },
        })
        -- visual mode
        require("which-key").register({
          ["<leader><leader>h"] = { "Git [H]unk" },
        }, { mode = "v" })
      end,
    },

    {     -- Adds git related signs to the gutter, as well as utilities for managing changes
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      },
    },

    -- Ripgrep integration
    "duane9/nvim-rg",

    -- Typescript
    "jose-elias-alvarez/typescript.nvim",
    -- Helm
    "towolf/vim-helm",
    -- Text manipulation
    "godlygeek/tabular",
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

    -- Noice - v. pretty
    -- see: https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
    --{
    --  "folke/noice.nvim",
    --  event = "VeryLazy",
    --  opts = require("nvim-noice-cfg"),
    --  dependencies = {
    --    "MunifTanjim/nui.nvim",
    --    "hrsh7th/nvim-cmp",
    --    {
    --      "rcarriga/nvim-notify",
    --      enabled = false,
    --      opts = {
    --        timeout = 10000,
    --      },
    --    },
    --  },
    --},

    -- Tmux integration
    { "benmills/vimux",                     lazy = false },
    { "tmux-plugins/vim-tmux-focus-events", lazy = false },
    {
      -- todo: integrate with global keybindings
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
      branch = "dev",       -- IMPORTANT!
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
      opts = {},       -- for default options, refer to the configuration section for custom setup.
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
      config = function() require("rest-nvim").setup() end,
    },
    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      event = "VimEnter",
      branch = "0.1.x",
      config = function() require("nvim-telescope").setup() end,
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          -- when to install
          cond = function() return vim.fn.executable("make") == 1 end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        -- Useful for getting pretty icons, but requires a Nerd Font.
        {
          "nvim-tree/nvim-web-devicons",
          enabled = vim.g.have_nerd_font,
        },
        "nvim-treesitter/nvim-treesitter",
        "ahmedkhalf/project.nvim",
        "sharkdp/fd",
      },
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
      config = function() require("nvim-lualine") end,
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
      config = function() require("nvim-indentline").setup() end,
    },

    -- Tabs
    {
      "romgrk/barbar.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },       -- For file icons (if needed)
      init = function()
        vim.g.barbar_auto_setup = false                       -- Disable default setup
      end,
      config = function() require("nvim-barbar").setup() end,
    },

    -- Completion framework
    {
      "hrsh7th/nvim-cmp",
      lazy = false,
      config = function() require("nvim-cmp").setup() end,
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
        "lukas-reineke/cmp-rg",
        "andersevenrud/cmp-tmux",
        "mtoohey31/cmp-fish",
        "nvim-telescope/telescope-ui-select.nvim",
        "onsails/lspkind-nvim",         -- may remove
        {
          "tzachar/cmp-tabnine",
          build = "./install.sh",
          dependencies = { "hrsh7th/nvim-cmp" },           -- Ensure nvim-cmp is a dependency
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
        {
          "zbirenbaum/copilot-cmp",
          config = function() require("copilot_cmp").setup() end,
        },
      },
    },

    -- Formatting manager
    {
      "stevearc/conform.nvim",
      lazy = false,
      event = { "BufWritePre", "BufNewFile" },
      cmd = { "ConformInfo" },
      config = function() require("nvim-conform") end,
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
        {
          "nvim-treesitter/playground",
          lazy = true,
        },
      },
      lazy = false,
      build = "TSUpdate",
      opts = {
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
          "rust",
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { "yaml" },
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
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
        },
      },
      config = function(_, opts)
        require("nvim-treesitter.install").prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup(opts)

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      end,
    },

    {
      "windwp/nvim-ts-autotag",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    -- LSP
    {
      "neovim/nvim-lspconfig",
      config = function() require("nvim-lspconfig") end,
      dependencies = {
        { "williamboman/mason.nvim", opts = require("nvim-mason") },
        "williamboman/mason-lspconfig.nvim",
        "nvim-telescope/telescope.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "b0o/SchemaStore.nvim",
        {
          "j-hui/fidget.nvim",
          config = function() require("nvim-fidget") end,
        },
        -- configures Lua LSP for your Neovim config, runtime and plugins
        { "folke/neodev.nvim",       opts = {} },
      },
    },
    -- Rust
    {
      "mrcjkb/rustaceanvim",
      version = "^4",       -- Recommended
      lazy = false,         -- This plugin is already lazy
      config = function() require("nvim-rustacean").setup() end,
      dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        "neovim/nvim-lspconfig",         -- Language Server Protocol configurations
      },
    },

    -- Rust formating
    "vappolinario/cmp-clippy",
    {
      "mfussenegger/nvim-dap",
      lazy = true,
      config = function() require("nvim-dap").setup() end,
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
      event = "InsertEnter",         -- Lazy load on entering Insert mode (optional)
      cmd = "Copilot",               -- To be able to call `:Copilot` if lazy loaded (optional)
      build = ":Copilot auth",       -- For authentication if required
      config = function() require("nvim-copilot").setup() end,
    },

    -- Gemini
    {
      "meinside/gemini.nvim",
      lazy = true,
      config = function() require("nvim-gemini").setup() end,
      dependencies = { { "nvim-lua/plenary.nvim" } },
    },

    -- UI Enhancements
    -- usage: FineCmdLine
    -- {
    --     "VonHeikemen/fine-cmdline.nvim",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --     },
    -- },

    ------------------------------------------------------------------------
    -- Highlight todo, notes, etc in comments
    {
      "folke/todo-comments.nvim",
      event = "VimEnter",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = { signs = false },
    },
    ------------------------------------------------------------------------
    -- Theme
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
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",         -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      },
    },
  }
)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
