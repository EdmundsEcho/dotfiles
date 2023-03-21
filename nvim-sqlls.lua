-- sqlls
require("lspconfig").sqlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        cmd = {
            "sql-language-server",
            "up",
            "--method",
            "stdio",
            "--debug",
            "true",
        },
        filetypes = {
            "sql",
            "mysql",
        },
    },
})
