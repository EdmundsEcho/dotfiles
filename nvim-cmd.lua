--------------------------------------------------------------------------------
-- Auto-completion with cmp
--------------------------------------------------------------------------------
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- print(vim.inspect(vim.opt.completeopt:get()))

local cmp = require("cmp")

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

        ["<C-y>"] = cmp.setup.enable, -- Specify `cmp.setup.disable` if you want to remove the default `<C-y>` mapping.
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
        { name = "nvim_lsp" }, -- from language server
        { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
        { name = "path" },
        { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = "vsnip", keyword_length = 2 },
        { name = "buffer", keyword_length = 2 }, -- source current buffer
        { name = "lspconfig" }, -- access to all languages
        { name = "cmp_tabnine" }, -- AI for completion
        { name = "rg" }, -- ripgrep
        { name = "nvim_lua" },
        { name = "treesitter" },
        { name = "npm", keyword_length = 4 },
        { name = "tmux" },
        { name = "fish" },
        -- cmp clippy
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = "λ",
                vsnip = "⋗",
                buffer = "Ω",
                path = "◇",
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- ✅ Use cmdline & path source for ':'
-- 🔖  requires disabling 'native_menu`
cmp.setup.cmdline(":", {
    sources = cmp.config.sources(
        { { name = "path" } },
        { { name = "cmdline" } }
    ),
})
