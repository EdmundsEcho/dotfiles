-- yamlls
require("lspconfig").yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
