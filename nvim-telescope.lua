-- Telescope configuration file
--------------------------------------------------------------------------------
-- Last updated: May 15, 2024
--
-- see `:help telescope.setup()`
--------------------------------------------------------------------------------
local M = {}

local required_modules = {
    "telescope",
}

function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format("x %s not found. telescope error: %s", module_name, err),
                vim.log.levels.ERROR
            )
        end
    end
    local opts = {
        defaults = {
            file_ignore_patterns = { "node_modules", ".git/" },
            layout_strategy = "horizontal",
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            prompt_prefix = "> ",
            selection_caret = "> ",
            path_display = { "truncate" },
            mappings = {
                i = {
                    ["<C-n>"] = require("telescope.actions").move_selection_next,
                    ["<C-p>"] = require("telescope.actions").move_selection_previous,
                    ["<C-c>"] = require("telescope.actions").close,
                },
                n = {
                    ["<C-n>"] = require("telescope.actions").move_selection_next,
                    ["<C-p>"] = require("telescope.actions").move_selection_previous,
                },
            },
        },
        pickers = {
            find_files = {
                theme = "dropdown",
            },
            live_grep = { theme = "dropdown" },
        },
        extensions = {
            project = {
                base_dirs = {
                    "~/projects",
                    { "~/workspace", max_depth = 2 },
                },
                hidden_files = true, -- default: false
                theme = "dropdown",
                order_by = "asc",
                search_by = "title",
                sync_with_nvim_tree = true, -- default: false
            },
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({
                    -- even more opts
                }),
            },
        },
    }

    -- initialize the plugin
    pcall(require("telescope").setup, opts)
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set
    -- local opts = { noremap = true, silent = true }
    -- <ctr-p>
    map("n", "<C-p>", builtin.find_files, { desc = "[S]earch [F]iles" })
    map({ "i", "v" }, "<C-p>", builtin.find_files, { desc = "[S]earch [F]iles" })
    map("c", "<C-p>", builtin.find_files, { desc = "[S]earch [F]iles" })

    map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    map(
        "n",
        "<leader>s.",
        builtin.oldfiles,
        { desc = '[S]earch Recent Files ("." for repeat)' }
    )
    map(
        "n",
        "<leader><leader>",
        builtin.buffers,
        { desc = "[ ] Find existing buffers" }
    )
    -- Slightly advanced example of overriding default behavior and theme
    -- Search with <leader>/
    map("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
        }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    map(
        "n",
        "<leader>s/",
        function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end,
        { desc = "[S]earch [/] in Open Files" }
    )

    -- Shortcut for searching your Neovim configuration files
    map(
        "n",
        "<leader>sn",
        function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end,
        { desc = "[S]earch [N]eovim files" }
    )
end

return M
