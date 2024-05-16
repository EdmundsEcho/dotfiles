--------------------------------------------------------------------------------
-- Generic lsp handlers +
--------------------------------------------------------------------------------
--
-- This module is used by nvim-lsp.lua
--
-- Tasks:
-- 1. Sets the keybindings (linting, gotos, formatting)
-- 2. Configures the LSP display icons
--
-- Usage: Provides the on_attach function of a lsp configuration.
--
--------------------------------------------------------------------------------
local M = {}

local logger = require("nvim-logging")

function M.on_attach(client, bufnr)
   --
   -- log to vim that we are attaching to a client
   logger.log("Lsp handlers are attaching to " .. client.name, vim.log.DEBUG)

   local function set(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end

   -- set the diagnostic formatting
   vim.lsp.handlers["textDocument/publishDiagnostics"] =
       vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = false,
          update_in_insert = false,
          virtual_text = true,
       })

   -- Coordinate with lualine
   local signs = {
      Error = ">>",
      Warn = " ",
      Hint = " ✓",
      Info = " ",
   }
   for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
   end

   -- Mappings
   local opts = { noremap = true, silent = true }
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
   set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   set("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   set("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   set(
      "n",
      "<Leader>wa",
      "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
      opts
   )
   set(
      "n",
      "<Leader>wr",
      "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
      opts
   )
   set(
      "n",
      "<Leader>wl",
      "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
      opts
   )
   set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
   set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   -- set('n', 'gr', ':LspRename<CR>', opts)
   set("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
   set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
   set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
   set("n", "<Leader>j", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
   set("n", "<Leader>k", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
   set("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
   set("n", "<Leader>a", ":LspDiagLine<CR>", opts)
   set("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", opts)

   -- bind conditional on server capabilities
   if client.server_capabilities.document_formatting then
      set("n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
   elseif client.server_capabilities.document_range_formatting then
      set("n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
   end

   if client.server_capabilities.document_formatting then
      -- Create the augroup for LSP formatting
      local lsp_formatting_group =
          vim.api.nvim_create_augroup("LspFormatting", { clear = true })

      -- Create the autocmds for the group
      vim.api.nvim_create_autocmd("BufWritePre", {
         group = lsp_formatting_group,
         buffer = 0,
         callback = function()
            vim.cmd("sleep 300m")
         end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
         group = lsp_formatting_group,
         buffer = 0,
         callback = function()
            vim.lsp.buf.formatting_sync()
         end,
      })
   end
end

return M
