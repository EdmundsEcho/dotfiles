--------------------------------------------------------------------------------
-- Lua
-- Used by lspconfig
-- Use setup to return opts
--------------------------------------------------------------------------------
local M = {}

local logger = require("nvim-logging")

---
-- Function that builds the plugin opts
-- @return table opts
function M.setup()
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

return M.setup()

-- END
