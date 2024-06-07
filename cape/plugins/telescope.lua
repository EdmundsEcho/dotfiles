-- Telescope
return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            -- when to install
            cond = function() return vim.fn.executable("make") == 1 end,
        },
        { "jonarrien/telescope-cmdline.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        {
            "nvim-tree/nvim-web-devicons",
            enabled = vim.g.have_nerd_font,
        },
        "nvim-treesitter/nvim-treesitter",
        -- Project root directory
        {
            "ahmedkhalf/project.nvim",
            enabled = false,
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
        "sharkdp/fd",
    },
    keys = {
        -- { ":", "<cmd>Telescope cmdline<cr>", desc = "[:] Cmdline" },
    },
    opts = {
        extensions = {
            cmdline = {
                output_pane = {
                    enabled = true,
                },
                picker = {
                    layout_config = {
                        width = 120,
                        height = 25,
                    },
                },
                mappings = {
                    complete = "<Tab>",
                    run_selection = "<C-CR>",
                    run_input = "<CR>",
                },
            },
        },
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("cmdline")
        local actions = require("telescope.actions")
        -- local transform_mod = require("telescope.actions.mt").transform_mod

        -- local trouble = require("trouble")
        -- local trouble_sources = require("trouble.sources.telescope")

        -- or create your custom action
        -- local custom_actions = transform_mod({
        -- open_trouble_qflist = function(prompt_bufnr)
        -- trouble.toggle("quickfix")
        -- end,
        -- })

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        -- ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
                        -- ["<C-t>"] = trouble_sources.open(),
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set(
            "n",
            "<C-p>",
            "<cmd>Telescope find_files<cr>",
            { desc = "[F]ile Ctrl-[P] like fuzzy find files in cwd" }
        )
        keymap.set(
            "n",
            "<leader>ff",
            "<cmd>Telescope find_files<cr>",
            { desc = "[F]ile [F]uzzy find files in cwd" }
        )
        keymap.set(
            "n",
            "<leader>fr",
            "<cmd>Telescope oldfiles<cr>",
            { desc = "[F]ile Fuzzy find [R]ecent files" }
        )
        keymap.set(
            "n",
            "<leader>fs",
            "<cmd>Telescope live_grep<cr>",
            { desc = "[F]ind [S]tring in cwd" }
        )
        keymap.set(
            "n",
            "<leader>fc",
            "<cmd>Telescope grep_string<cr>",
            { desc = "[F]ind string under [C]ursor in cwd" }
        )
        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]odos" })
    end,
}
