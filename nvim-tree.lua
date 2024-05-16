--------------------------------------------------------------------------------
-- directory tree finder
-- Note: Disable netrw (see nvim-other.vim)
-- Note: Do not use nonicons (not as nice as default)
--------------------------------------------------------------------------------
local M = {}

M.setup = function()
    ----------------------------------------------------------------------------
    local plugin = require("nvim-tree")
    ----------------------------------------------------------------------------
    plugin.setup({
        -- integration with project
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true,
        },
        filters = {
            dotfiles = false,
            custom = {},
            exclude = {},
        },
        git = {
            enable = true,
            ignore = false,
            timeout = 400,
        },
    })
end

return M

-- END
