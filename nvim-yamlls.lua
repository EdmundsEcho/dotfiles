--------------------------------------------------------------------------------
-- yamlls
--------------------------------------------------------------------------------
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
--------------------------------------------------------------------------------
local handlers = require("usermod.nvim_handlers")
local capabilities = require("usermod.env").capabilities
--------------------------------------------------------------------------------

lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = handlers.on_attach,
    settings = {
        yaml = {
            schemas = {
                kubernetes = "globPattern",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["../path/relative/to/file.yml"] = "/.github/workflows/*",
                ["/path/from/root/of/project"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
            },
        },
    },
})
