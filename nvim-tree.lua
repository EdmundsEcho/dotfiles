--------------------------------------------------------------------------------
-- directory tree finder
-- Note: Disables netrw (see nvim-other.vim)
--------------------------------------------------------------------------------
local plugin = require("nvim-tree")
--------------------------------------------------------------------------------
plugin.setup({
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
