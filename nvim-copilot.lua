--------------------------------------------------------------------------------
-- copilot plugin using lua
--------------------------------------------------------------------------------
local plugin = require("copilot")
--------------------------------------------------------------------------------
local M = {}

local opts = {
    event = { "InsertEnter", "LspAttach" },
    fix_pairs = true,
    suggestion = {
        auto_trigger = true,
        debounce = 300,
        -- keymap that maps control-y to accept suggestion
        keymap = {
            -- <C-y>
            accept = "<C-y>",
            -- <C-f>
            next = "<C-n>",
            -- <C-b>
            prev = "<C-b>",
            -- <C-d>
            dismiss = "<C-d>",
        },
    },
    filetypes = {
        javascript = true,
        javascriptreact = true,
        python = true,
        perl = true,
        rust = true,
        haskell = true,
        sql = true,
        lua = true,
    },
}

function M.setup() plugin.setup(opts) end

return M

-- END
