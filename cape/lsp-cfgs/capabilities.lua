--------------------------------------------------------------------------------
--- DEPRECATED?
-- Generic cmp_nvim_lsp capabilities
-- Usage: Set the capabilities property of a lsp configuration.
--
-- Configures cmp with the lsp servers.
--------------------------------------------------------------------------------
local M = {}
M.setup = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities =
        vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    capabilities.workspace = {
        didChangeWatchedFiles = {
            dynamicRegistration = true,
        },
    }

    return capabilities
end

return M
