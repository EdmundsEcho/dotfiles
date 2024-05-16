--------------------------------------------------------------------------------
-- Lua
-- Used by lspconfig
--------------------------------------------------------------------------------
local M = {}

local logger = require("nvim-logging")

function M.setup()
   logger.log("2. Setting custom injected opts into lua_ls ", vim.log.INFO)

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
         logger.log(
            "3. Running on_init lua_ls " .. client.name,
            vim.log.INFO
         )
      end,
   }
end

return M

-- END
