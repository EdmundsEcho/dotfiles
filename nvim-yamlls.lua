--------------------------------------------------------------------------------
-- yamlls
-- Used by lspconfig
-- Return M.setup()
--------------------------------------------------------------------------------

local logger = require("nvim-logging")

local M = {}

M.setup = function()
    logger.log("Injecting opts into yamlls ", vim.log.levels.INFO)

    return {
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

return M.setup()

-- END
