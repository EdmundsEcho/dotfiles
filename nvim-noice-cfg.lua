-- nvim-noice-cfg.lua
--------------------------------------------------------------------------------
--
--
--------------------------------------------------------------------------------
local M = {}

function M.setup()
    --[[
    require("nvim-notify").setup({
        -- Animation style (see below for details)
        stages = "fade_in_slide_out",
        -- Default timeout for notifications
        timeout = 45000,
        -- For stages that change opacity this is treated as the highlight behind the window
        background_highlight = "Normal",
    }) ]]
    return {
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        -- routes = {
        --     {
        --         view = "mini",
        --         filter = { event = "msg_showmode" },
        --     },
        -- },
        -- views = {
        --     notify = {
        --         replace = true,
        --     },
        -- },
        -- lsp = {
        --     progress = {
        --         enabled = false,
        --         format = "lsp_progress",
        --         format_done = "lsp_progress_done",
        --         -- throttle = 1000 / 30,
        --         view = "notify",
        --     },

        --     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        --     override = {
        --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        --         ["vim.lsp.util.stylize_markdown"] = true,
        --         ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        --     },
        --     -- hover = { enabled = false },
        --     -- signature = { enabled = false },
        -- },
        -- cmdline = {
        --     opts = {
        --         relative = "cursor",
        --         position = { row = -2, col = 0 },
        --     },
        -- },
    }
end

return M.setup()
