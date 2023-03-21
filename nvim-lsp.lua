--------------------------------------------------------------------------------
-- Lsp configuration using lua
-- Lua guide for vim https://github.com/nanotee/nvim-lua-guide
-- See also: ~/.config/nvim/lua/usermod/nvim_handlers.lua
--------------------------------------------------------------------------------
require("nvim-lsp-installer").setup({})
local lspconfig = require("lspconfig")
--------------------------------------------------------------------------------
local handlers = require("usermod.nvim_handlers")
--------------------------------------------------------------------------------

-- augment markdown
vim.g.markdown_fenced_languages = { "ts=typescript" }

-- Languages with LSP support
-- run the setup for each server
-- pass the required on_attach and capabilities for each setup {}
-- ⚠️  Avoid repeatedly running the setup for the same server (will over-write)
local servers = {
    -- "bash",
    "cssls",
    -- "denols",
    "dockerls",
    "eslint",
    -- "graphql",
    "html",
    "hls", -- haskell
    "tsserver", -- typescript
    -- "sumneko_lua", -- lua depreacted
    "lua_ls", -- lua
    -- "remark_ls", -- markdown
    -- "spectral", -- OpenAPI, json, yaml
    "vimls",
    "yamlls",
    -- "emmet_ls",
    "rust_analyzer",
    -- "clangd",
    "pyright",
    "sqlls",
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
--------------------------------------------------------------------------------
-- activate each lsp in the list
--------------------------------------------------------------------------------
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = handlers.on_attach,
        flags = { debounce_text_changes = 150 },
    })
end
--------------------------------------------------------------------------------

-- To debug, run the server and view the log
-- vim.lsp.set_log_level("debug")
-- :lua vim.cmd('e'..vim.lsp.get_log_path())
-- :LspInfo to show active and configured servers
-- :LspStop <client_id>
-- :LspStart <client_id>
-- :NullLsInfo show service using null_ls

-- Setup buffer configuration (nvim-lua source only enables in Lua filetype).
-- autocmd FileType lua lua require'cmp'.setup.buffer {
-- \   sources = {
-- \     { name = 'nvim_lua' },
-- \     { name = 'buffer' },
-- \   },
-- \ }

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
