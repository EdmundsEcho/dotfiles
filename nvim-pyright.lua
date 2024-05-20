--------------------------------------------------------------------------------
-- pyright
-- Used by lspconfig
-- Return M.setup()
--------------------------------------------------------------------------------

local logger = require("nvim-logging")

local M = {}

function M.setup()
    logger.log("Injecting opts into pyright ", vim.log.level.INFO)

    return {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        settings = {
            pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    -- Ignore all files for analysis to exclusively use Ruff for linting
                    ignore = { "*" },
                },
            },
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        },
    }
end

return M.setup()

-- END
