--------------------------------------------------------------------------------
-- Lsp configuration using lua
-- Lua guide for vim https://github.com/nanotee/nvim-lua-guide
--------------------------------------------------------------------------------
-- 📖 lspconfig documentation
local nvim_lsp = require("lspconfig")

--
-- ref this only once the language server is loaded
--
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o> (may be slow)
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local opts = { noremap = true, silent = true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap(
        "n",
        "gy",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<Leader>D",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<Leader>wa",
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<Leader>wr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<Leader>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        opts
    )
    buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap('n', 'gr', ':LspRename<CR>', opts)
    buf_set_keymap(
        "n",
        "<Leader>e",
        "<cmd>lua vim.diagnostic.open_float()<CR>",
        opts
    )
    buf_set_keymap("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap(
        "n",
        "<Leader>j",
        "<cmd>lua vim.diagnostic.goto_prev()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<Leader>k",
        "<cmd>lua vim.diagnostic.goto_next()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<Leader>q",
        "<cmd>lua vim.diagnostic.setloclist()<CR>",
        opts
    )
    buf_set_keymap("n", "<Leader>a", ":LspDiagLine<CR>", opts)
    buf_set_keymap("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", opts)

    -- bind conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap(
            "n",
            "<Leader>f",
            "<cmd>lua vim.lsp.buf.formatting()<CR>",
            opts
        )
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap(
            "n",
            "<Leader>f",
            "<cmd>lua vim.lsp.buf.formatting()<CR>",
            opts
        )
    end

    -- turn off formatting where better options exist
    if client.name == "tsserver" then
        -- use Prettier + null_ls
        client.resolved_capabilities.document_formatting = false
    end
    if client.name == "html" then
        -- use prettier + null_ls
        client.resolved_capabilities.document_formatting = false
    end
    if client.name == "yamlls" then
        -- use prettier + null_ls
        client.resolved_capabilities.document_formatting = false
    end
end

-- augment markdown
vim.g.markdown_fenced_languages = { "ts=typescript" }

-- Languages with LSP support
-- run the setup for each server
-- pass the required on_attach and capabilities for each setup {}
-- ⚠️  Avoid repeatedly running the setup for the same server (will over-write)
local servers = {
    "pyright",
    "rust_analyzer",
    "eslint",
    "hls",
    "html",
    "denols",
}

-- language server plugin activation
require("cmp-npm").setup({})
-- require('cmp_nvim_lsp').on_attach()

local capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

-- activate each lsp in the list
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
    })
end

--------------------------------------------------------------------------------
-- Extra configuration for each lsp
--------------------------------------------------------------------------------
-- denols
require("lspconfig").denols.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        filetypes = {
            "html",
            "css",
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        },
        lint = true,
    },
})

-- tsserver
-- local extra helper for tsserver
local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        lhs,
        rhs,
        opts or { silent = true }
    )
end

require("lspconfig").tsserver.setup({
    capabilities = capabilities,
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    init_options = { hostInfo = "neovim" },
    cmd = { "typescript-language-server", "--stdio" },
    -- on_attach = on_attach,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            eslint_enable_code_actions = true,
            enable_formatting = true,
            formatter = "prettier",
        })
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        on_attach(client, bufnr)
    end,
})
-- yamlls
require("lspconfig").yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        yaml = {
            schemas = {
                kubernetes = "globPattern",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["../path/relative/to/file.yml"] = "/.github/workflows/*",
                ["/path/from/root/of/project"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
            },
        },
    },
})

--------------------------------------------------------------------------------
-- Linters and formatters without a lsp interface
-- use null_ls as the interface
--------------------------------------------------------------------------------
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
require("null-ls").setup({
    capabilities = capabilities,
    on_attach = on_attach,
    sources = {
        diagnostics.flake8, -- python
        -- diagnostics.yamllint, -- yaml
        formatting.stylua, -- lua
        formatting.black.with({ extra_args = { "--fast" } }), -- python
        -- formatting.rustfmt, -- rust
        formatting.brittany, -- haskell
        formatting.prettierd.with({
            filetypes = { "html", "json", "css", "markdown", "yaml" },
        }),
    },
})
-- To debug, run the server and view the log
-- vim.lsp.set_log_level("debug")
-- :lua vim.cmd('e'..vim.lsp.get_log_path())
-- :LspInfo to show active and configured servers
-- :LspStop <client_id>
-- :LspStart <client_id>
-- :NullLsInfo show service using null_ls

--------------------------------------------------------------------------------
-- Auto-completion with cmp
--------------------------------------------------------------------------------
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- print(vim.inspect(vim.opt.completeopt:get()))

local cmp = require("cmp")

cmp.setup({
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

        ["<C-y>"] = cmp.setup.disable, -- Specify `cmp.setup.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
        }),
        -- another set
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- tab support
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    },
    -- Installed sources
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- access to all languages
        { name = "cmp_tabnine" }, -- AI for completion
        { name = "path" },
        { name = "rg" }, -- ripgrep
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "treesitter" },
        { name = "npm", keyword_length = 4 },
        { name = "tmux" },
        { name = "fish" },
        -- { name = "vsnip" },
        {
            name = "cmp-clippy", -- experimental
            options = {
                model = "EleutherAI/gpt-neo-2.7B", -- check code clippy vscode repo for options
                key = "", -- huggingface.co api key
            },
        },
    }),
})
-- Setup buffer configuration (nvim-lua source only enables in Lua filetype).
-- autocmd FileType lua lua require'cmp'.setup.buffer {
-- \   sources = {
-- \     { name = 'nvim_lua' },
-- \     { name = 'buffer' },
-- \   },
-- \ }

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- ✅ Use cmdline & path source for ':'
-- 🔖  requires disabling 'native_menu`
cmp.setup.cmdline(":", {
    sources = cmp.config.sources(
        { { name = "path" } },
        { { name = "cmdline" } }
    ),
})

--------------------------------------------------------------------------------
-- Augmented lsp languages
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Rust
-- ⬜ 🛈
-- Provides access to the extra information provided by the rust
-- language server (rust_analyzer)
-- tools: see https://github.com/simrat39/rust-tools.nvim#configuration
require("rust-tools").setup({
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
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
        on_attach = on_attach, -- RHS set higher-up
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = { command = "clippy" },
            },
        },
    },
})

--------------------------------------------------------------------------------
-- These are not lsp related
--------------------------------------------------------------------------------
-- ✅ Parsing for deep highlighting
require("nvim-treesitter.configs").setup({
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        "rust",
        "python",
        "yaml",
        "toml",
        "json",
        "javascript",
        "html",
        "css",
        "vim",
        "dockerfile",
        "tsx",
        "typescript",
        "fish",
    },
    sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    extensions = { "quickfix" },
})

-- ✅ airline substitute
require("lualine").setup({
    options = { theme = "material" },
    sections = {
        lualine_a = {
            {
                "diagnostics",
                -- table of diagnostic sources, available sources:
                -- 'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'
                -- Or a function that returns a table like
                --   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
                sources = { "nvim_diagnostic" },
                -- displays diagnostics from defined severity
                sections = { "error", "warn", "info", "hint" },
                diagnostics_color = {
                    -- Same values like general color option can be used here.
                    error = "DiagnosticError", -- changes diagnostic's error color
                    warn = "DiagnosticWarn", -- changes diagnostic's warn color
                    info = "DiagnosticInfo", -- changes diagnostic's info color
                    hint = "DiagnosticHint", -- changes diagnostic's hint color
                },
                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                colored = true, -- displays diagnostics status in color if set to true
                update_in_insert = false, -- Update diagnostics in insert mode
                always_visible = false, -- Show diagnostics even if count is 0, boolean or function returning boolean
            },
        },
    },
})
