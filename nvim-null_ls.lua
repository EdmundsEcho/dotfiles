--------------------------------------------------------------------------------
-- Linters and formatters without a lsp interface
-- use null_ls as the interface
--------------------------------------------------------------------------------
local null_ls = require("null-ls")
--------------------------------------------------------------------------------
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
require("null-ls").setup({
    capabilities = capabilities,
    on_attach = on_attach,
    sources = {
        diagnostics.flake8, -- python
        diagnostics.jsonlint, -- json
        -- diagnostics.yamllint, -- yaml
        formatting.stylua, -- lua
        formatting.black.with({ extra_args = { "--fast" } }), -- python
        -- formatting.rustfmt, -- rust
        formatting.brittany, -- haskell
        formatting.prettier.with({
            filetypes = { "html", "css", "markdown" },
        }),
    },
})
