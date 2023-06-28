--------------------------------------------------------------------------------
-- mason
-- Manages all lsp server installations
-- See also nvim-lsp.lua
--------------------------------------------------------------------------------
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    },
})
