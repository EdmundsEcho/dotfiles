-- Telescope configuration file
local M = {}

local required_modules = {
    "telescope",
}

function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. telescope error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end
    require("telescope").setup({
        defaults = {
            file_ignore_patterns = { "node_modules", ".git/" },
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
            live_grep = {
                theme = "dropdown",
            },
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
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
end

return M
