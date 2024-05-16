-- File: ~/dotfiles/statusline-colors.lua
local M = {}

-- require nvim-colors.lua
M.colors = require("nvim-colors")

-- Example function to get the foreground color for different modes
function M.get_mode_color()
    local mode = vim.fn.mode()
    local mode_color = {
        n = M.colors.red,
        i = M.colors.green,
        v = M.colors.dark_blue,
        [''] = M.colors.dark_blue,
        V = M.colors.dark_blue,
        c = M.colors.magenta,
    }
    return mode_color[mode] or M.colors.fg  -- default to fg if mode not found
end

return M
