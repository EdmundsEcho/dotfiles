-- nvim-lspconfig.lua
local M = {}

local required_modules = {
    "lspconfig",
    "nvim-handlers",
    "nvim-capabilities",
    "nvim-yamlls",
    "nvim-tsserver",
}

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
    local lspconfig = require("lspconfig")
    local handlers = require("nvim-handlers")
    local capabilities = require("nvim-capabilities").capabilities -- Ensure this is the correct way to access capabilities

    local option_lookup = {
        eslint = {
            settings = {
                enable = true,
                format = { enable = false },
                packageManager = "yarn",
                autoFixOnSave = true,
                codeActionsOnSave = {
                    mode = "all",
                    rules = { "!debugger", "!no-only-tests/*" },
                },
                lintTask = { enable = true },
            },
        },
        sqlls = {
            settings = {
                cmd = {
                    "sql-language-server",
                    "up",
                    "--method",
                    "stdio",
                    "--debug",
                    "true",
                },
                filetypes = { "sql", "mysql" },
            },
        },
        lua_ls = {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim", "require" } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = { enable = false },
                },
            },
        },
    }

    require("mason-lspconfig").setup_handlers({
        function(server_name)
            local generic_opts = {
                capabilities = capabilities,
                on_attach = handlers.on_attach,
                flags = { debounce_text_changes = 150 },
            }
            -- Safely get the specialized options with a fallback to an empty table if not found
            local specialized_opts = option_lookup[server_name] or {}
            -- Merge the generic options with the specialized options
            local opts =
                vim.tbl_deep_extend("force", generic_opts, specialized_opts)
            -- Setup the server with the merged options
            lspconfig[server_name].setup(opts)
        end,
    })

    -- LSP with separate configs
    local yaml_setup = require("nvim-yamlls")
    lspconfig.yamlls.setup(yaml_setup)

    -- requires nvim-tsserver to set the tsserver config
    local tsserver_setup = require("nvim-tsserver").setup()
    lspconfig.tsserver.setup(tsserver_setup)
end

return M
