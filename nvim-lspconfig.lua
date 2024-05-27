--------------------------------------------------------------------------------
-- This is the heart and center of the lspS configuration.
--
-- Recall: neovim is the client :))
--
-- This is an important module to make sure the lsp are working as expected.
-- The individual configurations depend on the usermod modules. This
-- configuration is used by lazy in the lspconfig block.
--
-- nvim-lspconfig.lua
--
-- 💢 mutated instance of lspconfig
--
-- Usage: M.setup()
-- @return nil
--------------------------------------------------------------------------------
local M = {}

local required_modules = {
    "lspconfig",
    "mason-lspconfig",
    "schemastore",
    "nvim-tsserver",
    "nvim-yamlls",
    "nvim-lua_ls",
    "nvim-json_ls",
    "nvim-capabilities",
    "nvim-lsp-handler",
}

local lspattach_au_group = "kickstart-lsp-attach"
local servers = {
    ruff_lsp = require("nvim-ruff_lsp"),
    pyright = require("nvim-pyright"),
    yamlls = require("nvim-yamlls"),
    lua_ls = require("nvim-lua_ls"),
    json_ls = require("nvim-json_ls"),
    tsserver = require("nvim-tsserver")(lspattach_au_group),
}

--------------------------------------------------------------------------------
-- Formatting preference - when more than one choice exists
-- turn off formatting where better options exist
--
-- @client.name is that specified by lspconfig. A complete list of names is
-- available by:
--
--      :help lspconfig-all
--
-- see also: conform plugin settings
--
-- @return client with updated document_formatting toggles
--------------------------------------------------------------------------------
---@ignore unused-local
local set_client_formatting = function(client)
    if client.name == "html" then
        -- use settings in conform
        client.server_capabilities.document_formatting = false
    end
    if client.name == "yamlls" then
        -- use settings in conform
        client.server_capabilities.document_formatting = false
    end
    if client.name == "ruff_lsp" then
        -- use pyright for hover
        client.server_capabilities.hoverProvider = false
    end
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    return client
end
--------------------------------------------------------------------------------
-- 💢 Function that mutates lspconfig.<lsp_name> table
-- @return nil
function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format("✗ %s not found. lspconfig error: %s", module_name, err),
                vim.log.levels.ERROR
            )
        end
    end

    ----------------------------------------------------------------------------
    -- creates autogroup that responds to LspAttach event
    require("nvim-lsp-handler")(lspattach_au_group)
    ----------------------------------------------------------------------------
    local capabilities = require("nvim-capabilities")
    local lspconfig = require("lspconfig")
    ----------------------------------------------------------------------------

    require("mason-lspconfig").setup_handlers({
        -- Injections
        -- ✓ capabilities
        -- ✓ instance of lspconfig
        -- ✓ client formatting toggle
        function(server_name)
            local opts = servers[server_name] or {}
            opts.capabilities =
                vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
            opts.flags = vim.tbl_deep_extend(
                "force",
                {},
                { debounce_text_changes = 150 },
                opts.capabilities or {}
            )
            lspconfig[server_name].setup(opts)
        end,
    })
end

return M.setup()

-- END
