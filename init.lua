--------------------------------------------------------------------------------
-- init.lua
-- Symlink located in ~/.config/nvim/init.lua to ~/dotfiles/init.lua
--------------------------------------------------------------------------------
-- Reads files located in ~/dotfiles as the root
-- Sets what modules are loaded/accessible
--------------------------------------------------------------------------------
local home = vim.fn.expand("$HOME")
local root = home .. "/dotfiles"
-- Add the dotfiles directory to package.path
package.path = package.path .. ";" .. root .. "/?.lua"
package.path = package.path .. ";" .. root .. "/?/init.lua"
-- Update runtimepath to include dotfiles
-- vim.opt.runtimepath:append(root .. "/lua")

local logger = require("cape.core.nvim-logging")

logger.log("🟢 configuration started", vim.log.levels.INFO)
logger.log("🔗 Lua package path: " .. package.path, vim.log.levels.DEBUG)
logger.log(
    "🧮 Vim runtime path: " .. vim.inspect(vim.opt.runtimepath:get()),
    vim.log.levels.DEBUG
)

logger.log("📋 Logging to: " .. logger.get_logfile())

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Track the log
-- :echo stdpath('log')
-- tail -f ~/.config/nvim/state/log
-- or vim -V3vimlog
--------------------------------------------------------------------------------

require("cape.core") -- settings, not plugins
require("cape.lazy")
require("cape.lsp-cfgs")
require("cape.core.nvim-lua-functions")
-- NOTE: cape.plugins are loaded using lazy.nvim

-- END
--
