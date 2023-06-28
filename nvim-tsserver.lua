--------------------------------------------------------------------------------
-- tsserver
--
-- 🚧 There is a contradiction:
--    * formatter = prettier
--    * formatter is disabled ~/.config/nvim/lua/usermod/nvim_hanlders.lua
--------------------------------------------------------------------------------
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
--------------------------------------------------------------------------------
local handlers = require("usermod.nvim_handlers")
local capabilities = require("usermod.env")
--------------------------------------------------------------------------------

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        lhs,
        rhs,
        opts or { silent = true }
    )
end

-- enable self referencing
require("lspconfig").tsserver.setup({
    capabilities = capabilities,
    format = { enable = false },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    init_options = {
        disableAutomaticTypingAcquisition = false,
        hostInfo = "neovim",
    },
    root_dir = lspconfig.util.root_pattern("package.json"),
    cmd = { "typescript-language-server", "--stdio" },
    -- on_attach = on_attach,
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            eslint_enable_code_actions = true,
            enable_formatting = true,
            formatter = "prettier",
        })
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        handlers.on_attach(client, bufnr)
    end,
})
