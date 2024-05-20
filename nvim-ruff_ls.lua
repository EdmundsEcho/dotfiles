--------------------------------------------------------------------------------
-- ruff_ls
-- Used by lspconfig
-- Return M.setup()
--------------------------------------------------------------------------------

local logger = require("nvim-logging")

local M = {}

function M.setup()
    logger.log("Injecting opts into ruff_ls ", vim.log.level.INFO)
    return {}
end

return M.setup()

-- END
