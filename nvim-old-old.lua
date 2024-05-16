--------------------------------------------------------------------------------
-- This is an important module to make sure the lsp are working as expected.
-- The individual configurations depend on the usermod modules. This
-- configuration is used by lazy in the lspconfig block.
--
-- 🔖 Mason loads servers.  Mason-lspconfig maintains lists of servers
--    and thei state. We leverage that to find servers. Once we configure them,
--    we append them to the lspconfig module. The mason-lspconfig module provides
--    the interface to access server lists and states.
--
-- nvim-lspconfig.lua
--
-- @return a function setup that when called returns a configured lspconfig
--
--------------------------------------------------------------------------------
local M = {}

local required_modules = {
    "mason",
    "mason-lspconfig",
    "lspconfig",
    "nvim-capabilities",
    "nvim-handlers",
    "nvim-tsserver",
    "nvim-yamlls",
    "nvim-lua_ls",
    "nvim-json_ls",
    "nvim-ruff",
}

-- Error handling function
local function safe_require(module_name)
    local success, module = pcall(require, module_name)
    if success then
        return module
    else
        vim.notify(
            "Error loading module '" .. module_name .. "': " .. module,
            vim.log.levels.ERROR
        )
        return nil
    end
end

-- Validate if the provided value is a table
local function validate_table(module, module_name)
    if type(module) == "table" then
        return module
    else
        vim.notify(
            "Error: Module '" .. module_name .. "' did not return a valid table",
            vim.log.levels.ERROR
        )
        return nil
    end
end
-- Function to handle table or function
local function handle_table_or_function(value, module_name)
    local value_type = type(value)
    if value_type == "table" then
        return value
    elseif value_type == "function" then
        local success, result = pcall(value)
        if success then
            if type(result) == "table" then
                return result
            else
                vim.notify(
                    "Error: Function in module '"
                        .. module_name
                        .. "' did not return a valid table",
                    vim.log.levels.ERROR
                )
                return nil
            end
        else
            vim.notify(
                "Error calling function in module '"
                    .. module_name
                    .. "': "
                    .. result,
                vim.log.levels.ERROR
            )
            return nil
        end
    else
        vim.notify(
            "Error: Module '"
                .. module_name
                .. "' did not return a table or function",
            vim.log.levels.ERROR
        )
        return nil
    end
end

function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. lspconfig error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end

    ----------------------------------------------------------------------------
    -- setup lspconfig
    ----------------------------------------------------------------------------
    local handlers = require("nvim-handlers")
    local capabilities = require("nvim-capabilities").capabilities
    local lspconfig = require("lspconfig")
    local mason_ref = require("mason-lspconfig")
    ----------------------------------------------------------------------------

    --[[
    local servers = {
        "lua_ls",
        "yamlls",
        "prettierd",
        -- "rust_analyzer",
        -- "ruff",
        -- "pyright",
        -- "tsserver",
        -- "jsonls",
    }
    -- local servers = mason_ref.get_servers()
    local server_cfgs = {}
    for _, lsp_name in ipairs(servers) do
        server_cfgs[lsp_name] = {
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },
            -- for each client, toggle features while setting
            -- keyboard handlers
            on_attach = function(client, bufnr)
                handlers.on_attach(client, bufnr)
                -- turn off formatting where better options exist
                if client.name == "html" then
                    -- use prettier + null_ls
                    client.server_capabilities.document_formatting = false
                end
                if client.name == "yamlls" then
                    -- use prettier + null_ls
                    client.server_capabilities.document_formatting = false
                end
            end,
        }
    end

    ]]
    -- rust-analyzer: see rustaceanvim.lua

    local custom_cfgs = {
        ["jsonls"] = "nvim-json_ls",
        ["lua_ls"] = "nvim-lua_ls",
        ["yamlls"] = "nvim-yamlls",
        ["tsserver"] = "nvim-tsserver",
    }
    -- 💢 mutate lspconfig
    for name, module_name in pairs(custom_cfgs) do
        local cfg = safe_require(module_name)
        if cfg then
            cfg = handle_table_or_function(cfg, module_name)
        end
        if cfg and lspconfig[name] then
            lspconfig[name].setup(cfg)
        else
            vim.notify(
                "Error: '" .. name .. "' is not defined in 'lspconfig'",
                vim.log.levels.ERROR
            )
        end
    end

    -- 💢 mutate lspconfig
    -- combine with ruff server_cfgs
    -- local cfgs =
    --     vim.tbl_extend("force", server_cfgs, require("nvim-ruff").setup())
    -- for name, cfg in pairs(cfgs) do
    --     lspconfig[name].setup(cfg())
    -- end
end

return M
