--------------------------------------------------------------------------------
-- rust-tools - Augmented lsp languages
--            - includes options sent to rust_analyzer
--------------------------------------------------------------------------------
-- Provides access to the extra information provided by the rust
-- language server (rust_analyzer)
-- tools: see https://github.com/simrat39/rust-tools.nvim#configuration
--------------------------------------------------------------------------------
require("rust-tools").setup({
    tools = { -- rust-tools options
        autoSetHints = true,
        -- hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the options to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach, -- RHS set higher-up
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                assist = {
                    importGranularity = "module",
                    importPrefix = "self",
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                procMacro = { enable = true },
                diagnostics = {
                    enable = true,
                    disabled = { "unresolved-proc-macro" },
                    enableExperimental = true,
                    virtual_text = true,
                    signs = true,
                    update_in_insert = true,
                    underline = true,
                    severity_sort = false,
                    float = {
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                },
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})
