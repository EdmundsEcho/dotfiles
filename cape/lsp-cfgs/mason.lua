--------------------------------------------------------------------------------
-- Not ever called
-- DEPRECATED
-- mason config property
-- referenced by init
-- Manages all lsp server installations
-- See lspconfig.lua
-- See mason-lspconfig
--
-- Mason will
--   * install lsps here: path.concat { vim.fn.stdpath "data", "mason" }
--   * from registry "github:mason-org/mason-registry"
--   * and prepend your PATH with its bin directory
--
--------------------------------------------------------------------------------
local M = {}
M.setup = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "→",
                package_uninstalled = "o",
                -- package_uninstalled = "×",
            },
        },
        name = "mason",
        log_level = vim.log.levels.WARN,
        use_icons = true,
        max_concurrent_installers = 3,
        pip = {
            ---@since 1.0.0
            -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
            upgrade_pip = true,

            ---@since 1.0.0
            -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
            -- and is not recommended.
            install_args = {},
        },
    })
end

-- return M

-- END
