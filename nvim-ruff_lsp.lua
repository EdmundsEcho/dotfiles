--------------------------------------------------------------------------------
-- ruff_ls
-- Used by lspconfig
-- Return M.setup()
--------------------------------------------------------------------------------

local logger = require("nvim-logging")

local M = {}

function M.setup()
    logger.log("Injecting opts into ruff_lsp ", vim.log.levels.INFO)
    return {
        init_options = {
            settings = {
                cmd = {
                    "ruff-lsp",
                },
                filetypes = { "python" },
                -- Any extra CLI arguments for `ruff` go here.
                args = {},
            },
        },
    }
end

return M.setup()

-- END
