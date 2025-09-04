--------------------------------------------------------------------------------
-- ruff
-- Used by lspconfig
-- Return M.setup()
--------------------------------------------------------------------------------

local M = {}

function M.setup()
    local logger = require("cape.core.nvim-logging")
    logger.log("Injecting opts into ruff ", vim.log.levels.INFO)

    return {
        settings = {
            args = {},
        },
    }
end

return M

-- END
