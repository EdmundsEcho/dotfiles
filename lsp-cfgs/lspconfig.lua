--------------------------------------------------------------------------------
-- cape.plugins.lsp.lspconfig.lua
--
-- This is the heart and center of the lspS configuration.
--
-- Recall: neovim is the client :))
--
-- This is an important module to make sure the lsp are working as expected.
-- The individual configurations depend on the usermod modules. This
-- configuration is used by lazy in the lspconfig block.
--
--
-- 💢 mutated instance of lspconfig
-- Usage: M.setup()
-- return nil
--------------------------------------------------------------------------------
local M = {}

M.setup = function()
    local required_modules = {
        "lspconfig",
        "mason-lspconfig",
        "mason-tool-installer",
        "schemastore",
        "lsp-cfgs/lsp-handler",
        "lsp-cfgs/capabilities",
        -- "nvim-tsserver",
        -- "nvim-yamlls",
        -- "nvim-lua_ls",
        -- "nvim-json_ls",
    }

    local lspattach_au_group = "lsp-attach"

    -- lsp's managed by mason (see Mason installed lsp's)
    local servers = {
        ruff_lsp = require("lsp-cfgs/nvim-ruff_lsp").setup(),
        pyright = require("lsp-cfgs/nvim-pyright").setup(),
        yamlls = require("lsp-cfgs/nvim-yamlls").setup(),
        lua_ls = require("lsp-cfgs/nvim-lua_ls").setup(),
        jsonls = require("lsp-cfgs/nvim-json_ls").setup(),
        tsserver = require("lsp-cfgs/nvim-tsserver").setup(lspattach_au_group),
    }
    --------------------------------------------------------------------------------
    -- 💢 mutate lspconfig.<lsp_name> table
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
    require("lsp-cfgs/lsp-handler").setup(lspattach_au_group)
    ----------------------------------------------------------------------------
    local capabilities = require("lsp-cfgs/capabilities").setup()
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
    require("mason-tool-installer").setup({
        -- formatters
        ensure_installed = {
            "prettierd",
            "stylua",
            "ruff_lsp",
        },
    })
end

return M

-- END
