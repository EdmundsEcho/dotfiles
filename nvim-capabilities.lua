--------------------------------------------------------------------------------
-- Generic cmp_nvim_lsp capabilities
-- Usage: Set the capabilities property of a lsp configuration.
--
-- Configures cmp with the lsp servers.
--------------------------------------------------------------------------------

local M = {}

local required_modules = {
    "cmp_nvim_lsp",
}

for _, module_name in ipairs(required_modules) do
    local ok, err = pcall(require, module_name)
    if not ok then
        vim.notify(
            string.format(
                "✗ %s not found. Generic cmp_nvim_lsp capabilities error: %s",
                module_name,
                err
            ),
            vim.log.levels.ERROR
        )
    end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

return M
