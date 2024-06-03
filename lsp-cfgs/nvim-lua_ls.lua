--------------------------------------------------------------------------------
-- Lua
-- Used by lspconfig
-- Use setup to return opts
--
-- NOTE: This gets overwritten by neodev when working inside the VIMRUNTIME.
--------------------------------------------------------------------------------
local M = {}

M.setup = function()
local logger = require("cape.core.nvim-logging")
    logger.log("Injecting opts into lua_ls ", vim.log.levels.INFO)

    return {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = {
                        "vim",
                        "require",
                    },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                    maxPreload = 20000,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
        on_init = function(client)
            logger.log("Running on_init lua_ls " .. client.name, vim.log.levels.INFO)
        end,
    }
end

return M

-- END
