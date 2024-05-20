--------------------------------------------------------------------------------
-- init.lua
-- Symlink located in ~/.config/nvim/init.lua to ~/dotfiles/init.lua
--------------------------------------------------------------------------------
-- Reads files located in ~/dotfiles as the root
--------------------------------------------------------------------------------
local home = vim.fn.expand("~")
local cfg_path = home .. "/dotfiles/?.lua"
package.path = package.path .. ";" .. cfg_path

local logger = require("nvim-logging")
logger.log("🎉 configuration started", vim.log.levels.INFO)
logger.log("🔗 Lua package path: " .. package.path, vim.log.levels.DEBUG)

logger.log("📋 Logging to: " .. logger.get_logfile())

--------------------------------------------------------------------------------
local function hide_semantic_highlights()
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Clear LSP highlight groups",
    callback = hide_semantic_highlights,
})
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Track the log
-- :echo stdpath('log')
-- tail -f ~/.config/nvim/state/log
-- or vim -V3vimlog
--------------------------------------------------------------------------------

require("nvim-settings")
require("nvim-plugins")
require("nvim-other")
require("nvim-lua-functions")  -- this deprecates nvim-functions.lua
require("nvim-keybindings")    -- this has legacy vim WIP update
require("nvim-emoji-abbr").setup()
require("nvim-highlights-vim") -- legacy hi WIP deprecate
require("nvim-pmenu-highlights")
require("nvim-noice-highlights")
require("nvim-highlight-groups").update_highlights()

-- END
