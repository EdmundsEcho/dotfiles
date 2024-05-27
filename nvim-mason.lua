--------------------------------------------------------------------------------
-- mason
-- Manages all lsp server installations
-- See also nvim-lspconfig.lua
-- See also mason-lspconfig
--
-- Mason will
--   * install lsps here: path.concat { vim.fn.stdpath "data", "mason" }
--   * from registry "github:mason-org/mason-registry"
--   * and prepend your PATH with its bin directory
--
--
--------------------------------------------------------------------------------
local opts = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
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
}

return opts

-- END
