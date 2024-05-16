-- nvim-yamlls.lua
local M = {}

local required_modules = {
    "lspconfig",
    "nvim-handlers",
    "nvim-capabilities",
}

M.setup = function()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. yamlls error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end

    ----------------------------------------------------------------------------
    local handlers = require("nvim-handlers")
    local capabilities = require("nvim-capabilities").capabilities
    ----------------------------------------------------------------------------

    -- YAML LSP Configuration
    return {
        capabilities = capabilities,
        on_attach = handlers.on_attach,
        settings = {
            yaml = {
                trace = {
                    server = "debug",
                },
                validate = true,
                format = { enable = true },
                hover = true,
                completion = true,
                schemaDownload = { enable = true },
                schemaStore = {
                    enable = true,
                    url = "http://www.schemastore.org/api/json/catalog.json",
                },
                schemas = {
                    kubernetes = "/*.k8s.yaml",
                    ["http://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                    ["http://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.21.1/all.json"] = "/.*.k8s.yaml",
                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                    ["http://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.{yml,yaml}",
                },
            },
        },
    }
end

return M
