--------------------------------------------------------------------------------
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

local log = require("nvim-logging")

local required_modules = {
   "lspconfig",
   "mason-lspconfig",
   "nvim-capabilities",
   "nvim-handlers",
   "nvim-tsserver",
   "nvim-yamlls",
   "nvim-lua_ls",
   "nvim-json_ls",
}
--------------------------------------------------------------------------------
-- Formatting preference - when more than one choice exists
-- turn off formatting where better options exist
-- @client.name is that specified by lspconfig. A complete list of names is
-- available by:
--
--      :help lspconfig-all
--
-- @return client with updated document_formatting toggles
--------------------------------------------------------------------------------
local set_client_formatting = function(client)
   if client.name == "html" then
      -- use prettier + null_ls
      client.server_capabilities.document_formatting = false
   end
   if client.name == "yamlls" then
      -- use prettier + null_ls
      client.server_capabilities.document_formatting = false
   end
   return client
end
--------------------------------------------------------------------------------

function M.setup()
   for _, module_name in ipairs(required_modules) do
      local ok, err = pcall(require, module_name)
      if not ok then
         vim.notify(
            string.format(
               "✗ %s not found. lspconfig error: %s",
               module_name,
               err
            ),
            vim.log.levels.ERROR
         )
      end
   end

   ----------------------------------------------------------------------------
   local handlers = require("nvim-handlers")
   local capabilities = require("nvim-capabilities").capabilities
   local lspconfig = require("lspconfig")
   ----------------------------------------------------------------------------

   ----------------------------------------------------------------------------
   -- hook into mason's configuration routine
   -- this will be injected into mason and lspconfig setup
   -- and called on for every server mason manages.
   --
   -- Injections
   -- ✓ handlers and capabilities
   -- ✓ inject our instance of lspconfig
   -- ✓ client formatting toggle
   --
   ----------------------------------------------------------------------------
   require("mason-lspconfig").setup_handlers({
      function(server_name)
         local opts = {
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },
            on_attach = function(client, bufnr)
               log(
                  "1. Running injected handlers into " .. client.name,
                  vim.log.INFO
               )
               client = set_client_formatting(client)
               handlers.on_attach(client, bufnr)
            end,
         }

         lspconfig[server_name].setup(opts)
      end,
   })

   -- rust-analyzer: see rustaceanvim.lua

   -- json_ls
   local json_setup = require("nvim-json_ls")
   lspconfig.jsonls.setup(json_setup)

   -- lua_ls
   local lua_setup = require("nvim-lua_ls")
   lspconfig.lua_ls.setup(lua_setup.setup())

   -- yamlls
   local yaml_setup = require("nvim-yamlls")
   lspconfig.yamlls.setup(yaml_setup)

   -- tsserver
   local tsserver_setup = require("nvim-tsserver").setup()
   lspconfig.tsserver.setup(tsserver_setup)

   -- ruff and pyright
   local cfgs = require("nvim-ruff").setup()
   for name, cfg in pairs(cfgs) do
      lspconfig[name].setup(cfg)
   end
end

return M
