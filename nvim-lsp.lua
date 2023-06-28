--------------------------------------------------------------------------------
-- Lsp configuration using lua
-- Lua guide for vim https://github.com/nanotee/nvim-lua-guide
-- See also: ~/.config/nvim/lua/usermod/nvim_handlers.lua
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
--------------------------------------------------------------------------------
local handlers = require("usermod.nvim_handlers")
local capabilities = require("usermod.env")
--------------------------------------------------------------------------------

-- augment markdown
vim.g.markdown_fenced_languages = { "ts=typescript" }

-- Languages with LSP support
-- run the setup for each server
-- pass the required on_attach and capabilities for each setup {}
-- ⚠️  Avoid repeatedly running the setup for the same server (will over-write)
local servers = {
    -- "bash",
    "cssls",
    -- "denols",
    "dockerls",
    "eslint",
    -- "graphql",
    "html",
    -- "hls", -- haskell
    "tsserver", -- typescript
    -- "sumneko_lua", -- lua depreacted
    "lua_ls", -- lua
    -- "remark_ls", -- markdown
    -- "spectral", -- OpenAPI, json, yaml
    "vimls",
    "yamlls",
    -- "emmet_ls",
    -- "rust_analyzer", -- rust-tools
    -- "clangd",
    "pyright",
    "sqlls",
}

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

local eslint = {
    settings = {
        enable = true,
        format = { enable = true }, -- this will enable formatting
        packageManager = "yarn",
        autoFixOnSave = true,
        codeActionsOnSave = {
            mode = "all",
            rules = { "!debugger", "!no-only-tests/*" },
        },
        lintTask = {
            enable = true,
        },
    },
}
local sqlls = {
    settings = {
        cmd = {
            "sql-language-server",
            "up",
            "--method",
            "stdio",
            "--debug",
            "true",
        },
        filetypes = {
            "sql",
            "mysql",
        },
    },
}
local lua = {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    "vim",
                    "require",
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
local option_lookup = {
    lua_ls = lua,
    eslint = eslint,
    sqlls = sqlls,
}
--------------------------------------------------------------------------------
-- activate each lsp in the list
--------------------------------------------------------------------------------
for _, lsp in ipairs(servers) do
    local generic_opts = {
        capabilities = capabilities,
        on_attach = handlers.on_attach,
        flags = { debounce_text_changes = 150 },
    }
    local specialized_opts = option_lookup[lsp]
    if specialized_opts == nil then
        lspconfig[lsp].setup(generic_opts)
    else
        local opts = vim.tbl_deep_extend(
            "force",
            generic_opts,
            specialized_opts
        )
        lspconfig[lsp].setup(opts)
    end
end

--------------------------------------------------------------------------------

-- To debug, run the server and view the log
-- vim.lsp.set_log_level("debug")
-- :lua vim.cmd('e'..vim.lsp.get_log_path())
-- :LspInfo to show active and configured servers
-- :LspStop <client_id>
-- :LspStart <client_id>
-- :NullLsInfo show service using null_ls

-- Setup buffer configuration (nvim-lua source only enables in Lua filetype).
-- autocmd FileType lua lua require'cmp'.setup.buffer {
-- \   sources = {
-- \     { name = 'nvim_lua' },
-- \     { name = 'buffer' },
-- \   },
-- \ }

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
