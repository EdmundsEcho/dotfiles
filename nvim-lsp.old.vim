let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

call sign_define("LspDiagnosticsSignError", {"text" : "🔥", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "🚧", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "👷", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "🙋", "texthl" : "LspDiagnosticsHint"})

lua << EOF
local lsp_status = require('lsp-status')
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local util = require 'vim.lsp.util'

vim.notify = require("notify")

lsp_status.config({
  kind_labels = vim.g.completion_customize_lsp_label,
  current_function = false,
  status_symbol = '💬: ',
  indicator_errors = '🔥 ',
  indicator_warnings = '🚧 ',
  indicator_info = '👷 ',
  indicator_hint = '🙋 ',
  indicator_ok = '✅',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})

lsp_status.register_progress()

function common_on_attach(client, bufnr)
  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- autocmd BufWritePre * :!{bash -c "while ![ -e $1 ]; do echo $1; sleep 0.1s; done"} %:p
  if client.server_capabilities.document_formatting then
    vim.cmd([[
    augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre * sleep 200m
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    augroup END
    ]])
  end
end

function disable_formatting(client, bufnr)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
  common_on_attach(client, bufnr)
end

function enable_formatting(client, bufnr)
  client.server_capabilities.document_formatting = true
  client.server_capabilities.document_range_formatting = true
  common_on_attach(client, bufnr)
end

local servers = {
  "angularls",
  "bash",
  "cssls",
  -- "denols",
  "dockerls",
  "eslint",
  "graphql",
  "html",
  "hls",            -- haskell
  "tsserver",       -- typescript
  "sumneko_lua",    -- lua
  "remark_ls",      -- markdown
  "spectral",       -- OpenAPI
  "vimls",
  "yamlls",
  "emmet_ls",
  "rust_analyzer",
  "clangd",
  "pyright",
}

local server_settings = {
  tsserver = {
    format = { enable = false },
  },
  eslint = {
    enable = true,
    format = { enable = true }, -- this will enable formatting
    packageManager = "npm",
    autoFixOnSave = true,
    codeActionsOnSave = {
      mode = "all",
      rules = { "!debugger", "!no-only-tests/*" },
    },
    lintTask = {
      enable = true,
    },
  }
}

-- Loop through the servers listed above.
for _, name in pairs(servers) do
  local available, server = lsp_installer_servers.get_server(name)

  if available then
    server:on_ready(function ()
      local opts = { on_attach = common_on_attach }

      -- set server-specific settings
      --
      if server_settings[server.name] then opts.settings = server_settings[server.name] end

      -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
      -- the resolved capabilities of the eslint server ourselves!
      --
      if server.name == "eslint"   then opts.on_attach = enable_formatting end

      -- Disable formatting for typescript, so that eslint can take over.
      --
      if server.name == 'tsserver' then opts.on_attach = disable_formatting end
      if server.name == 'denols'   then opts.on_attach = disable_formatting end

      server:setup(opts)
    end)

    -- Queue the server to be installed.
    if not server:is_installed() then server:install() end

  end
end

EOF