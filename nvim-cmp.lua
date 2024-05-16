--------------------------------------------------------------------------------
-- Auto-completion with cmp
--------------------------------------------------------------------------------
local M = {}

local required_modules = {
    "cmp",
    "lspkind",
}

function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. cmp error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end
    -- vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.completeopt = { "menu", "menuone", "noinsert" }
    -- print(vim.inspect(vim.opt.completeopt:get()))

    local cmp = require("cmp")
    local lspkind = require("lspkind")

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
            -- for the options to appear
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

            -- Confirm the selection
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ["<C-y>"] = cmp.mapping.confirm({ select = false }),

            -- navigate the choices
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

            -- repond only when cmp.visible() is true
            ["<C-h>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<C-l>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),

            -- tab support
            ["<Tab>"] = cmp.mapping(
                cmp.mapping.select_next_item(),
                { "i", "s" }
            ),
            ["<S-Tab>"] = cmp.mapping(
                cmp.mapping.select_prev_item(),
                { "i", "s" }
            ),
        },

        -- Installed sources
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "path" },
            { name = "treesitter" },
            { name = "nvim_lua", keyword_length = 2 },
            { name = "vsnip", keyword_length = 2 },
            { name = "buffer", keyword_length = 2 },
            { name = "cmp_tabnine" },
            { name = "rg" },
            { name = "npm", keyword_length = 4 },
            { name = "tmux" },
            { name = "fish" },
        }),

        -- view = "native", -- or 'native' 'wildmenu'
        window = {
            documentation = cmp.config.window.bordered(),
            completion = cmp.config.window.bordered({
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 1,
                max_height = 17, -- Maximum height of the popup
                max_width = 60, -- Maximum width of the popup
            }),
        },
        formatting = {
            fields = { "menu", "abbr", "kind" },
            format = lspkind.cmp_format({
                mode = "symbol", -- show only symbol annotations
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- can also be a function to dynamically calculate max width such as
                -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                before = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = "λ",
                        vsnip = "⋗",
                        buffer = "Ω",
                        path = "◇",
                    }
                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            }),
        },
    })

    -- Use buffer source for `/` and `?`
    -- (if you enabled `native_menu`, this won't work anymore).
    --cmp.setup.cmdline({ "/", "?" }, {
    --    sources = {
    --        { name = "buffer" },
    --    },
    --})

    ---- ✅ Use cmdline & path source for ':'
    ---- 🔖  requires disabling 'native_menu`
    --cmp.setup.cmdline(":", {
    --    sources = cmp.config.sources(
    --        { { name = "path" } },
    --        { { name = "cmdline" } }
    --    ),
    --})
end

return M

-- END
