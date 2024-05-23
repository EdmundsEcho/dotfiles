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
}

return opts

-- END
