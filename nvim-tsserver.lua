--------------------------------------------------------------------------------
-- tsserver
--
-- 🚧 There is a contradiction:
--    * formatter = prettier
--    * formatter is disabled ~/.config/nvim/lua/usermod/nvim_hanlders.lua
--
-- TODO: configure using typescript.vim plugin that sets up tsserver in a
--       more powerful manner.
--------------------------------------------------------------------------------
local M = {}

local required_modules = {
    "lspconfig",
    "nvim-handlers",
    "nvim-capabilities",
}

--wrap the following code in a setup function associated with M
M.setup = function()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. tsserver error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end
    --------------------------------------------------------------------------------
    local lspconfig = require("lspconfig")
    --------------------------------------------------------------------------------
    local handlers = require("nvim-handlers")
    local capabilities = require("nvim-capabilities")
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
    return {
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
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
            local ts_utils = require("nvim-lsp-ts-utils")
            ts_utils.setup({
                eslint_bin = "/Users/edmund/.yarn/bin/prettier-eslint_d",
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
    }
end

return M

-- END
