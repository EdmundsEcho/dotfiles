--------------------------------------------------------------------------------
-- rust-tools - Augmented lsp languages
--            - includes options sent to rust_analyzer
--------------------------------------------------------------------------------
-- Provides access to the extra information provided by the rust
-- language server (rust_analyzer)
-- tools: see https://github.com/simrat39/rust-tools.nvim#configuration
--------------------------------------------------------------------------------
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
--------------------------------------------------------------------------------
local handlers = require("usermod.nvim_handlers")
local capabilities = require("usermod.env")
--------------------------------------------------------------------------------
local util = require("lspconfig/util")

require("rust-tools").setup({
    tools = {
        -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
    -- all the options to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = handlers.on_attach, -- RHS set higher-up
        capabilities = capabilities,    -- RHS set higher-up
        filetypes = { "rust" },
        root_dir = util.root_pattern("Cargo.toml"),
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                cargo = {
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                    allFeatures = true,
                },
                procMacro = { enable = true },
                diagnostics = {
                    enable = true,
                    disabled = { "unresolved-proc-macro" },
                    enableExperimental = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})
