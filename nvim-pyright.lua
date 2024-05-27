--------------------------------------------------------------------------------
-- pyright
-- Used by lspconfig
-- Return M.setup()
--------------------------------------------------------------------------------

local logger = require("nvim-logging")

local M = {}

function M.setup()
    logger.log("Injecting opts into pyright ", vim.log.levels.INFO)

    return {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        settings = {
            pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
            },
            -- python = {
            --     pythonPath = ".venv/bin/python",
            --     analysis = {
            --         autoSearchPaths = true,
            --         diagnosticMode = "workspace",
            --         useLibraryCodeForTypes = true,
            --         extraPaths = { "./.venv/lib/python3.11/site-packages" },
            --         ignore = { "*" }, -- Ignore all files for analysis to exclusively use Ruff for linting
            --     },
            -- },
        },
    }
end

return M.setup()

-- END
