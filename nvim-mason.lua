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
local M = {}

local logger = require("nvim-logging")

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
  log_level = vim.log.levels.TRACE,
  use_icons = true,
  max_concurrent_installers = 3,
  -- 🦀 todo: popup seems to ignore these
  keymaps = {
    ---@since 1.0.0
    -- Keymap to expand a package
    toggle_package_expand = "<CR>",
    ---@since 1.0.0
    -- Keymap to install the package under the current cursor position
    install_package = "i",
    ---@since 1.0.0
    -- Keymap to reinstall/update the package under the current cursor position
    update_package = "u",
    ---@since 1.0.0
    -- Keymap to check for new version for the package under the current cursor position
    check_package_version = "c",
    ---@since 1.0.0
    -- Keymap to update all installed packages
    update_all_packages = "U",
    ---@since 1.0.0
    -- Keymap to check which installed packages are outdated
    check_outdated_packages = "C",
    ---@since 1.0.0
    -- Keymap to uninstall a package
    uninstall_package = "X",
    ---@since 1.0.0
    -- Keymap to cancel a package installation
    cancel_installation = "<C-c>",
    ---@since 1.0.0
    -- Keymap to apply language filter
    apply_language_filter = "<C-f>",
    ---@since 1.1.0
    -- Keymap to toggle viewing package installation log
    toggle_package_install_log = "<CR>",
    ---@since 1.8.0
    -- Keymap to toggle the help view
    toggle_help = "g?",
  },
}

M.setup = function()
  logger.log("HERE", vim.log.levels.TRACE)
  if opts == nil then
    logger.log("👉 No opts", vim.log.levels.TRACE)
    return
  end
  for k, _ in pairs(opts) do
    logger.log("👉 Key: " .. k, vim.log.levels.TRACE)
  end
  require("mason").setup(opts)
end

return M.setup()

-- END
