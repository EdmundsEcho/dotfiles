--------------------------------------------------------------------------------
-- ruff_lsp
-- Coordinates services between ruff and pyright
-- Return value ready for use in nvim-lspconfig
-- @return {table} server_cfgs
--------------------------------------------------------------------------------
local M = {}

local required_modules = {
    "lspconfig",
    "nvim-handlers",
    "nvim-capabilities",
}

function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                "Error: "
                    .. string.format(
                        "👎 %s not found. nvim-ruff error: %s",
                        module_name,
                        err
                    ),
                vim.log.levels.ERROR
            )
        end
    end

    --------------------------------------------------------------------------------
    local handlers = require("nvim-handlers")
    local capabilities = require("nvim-capabilities")
    local logger = require("nvim-logging")
    --------------------------------------------------------------------------------

    -- the configuration keyed by *lspconfig server name*
    local server_cfgs = {
        ["ruff_lsp"] = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                logger.log("3. Attaching to " .. client.name, vim.log.INFO)
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
                handlers.on_attach(client, bufnr)
            end,
        },
        ["pyright"] = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                logger.log("3. Attaching to " .. client.name, vim.log.INFO)
                handlers.on_attach(client, bufnr)
            end,
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
            },
        },
    }

    return server_cfgs
end

return M

-- END
