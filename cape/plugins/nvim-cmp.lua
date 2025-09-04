--------------------------------------------------------------------------------
-- Auto-completion with cmp
--
-- Must be configured with lsp capabilities using cmp-nvim-lsp
-- (see nvim-capabilities)
--
-- Be sure to disable
--     require("copilot").setup({
--      suggestion = { enabled = false },
--      panel = { enabled = false },
--    })

--
--------------------------------------------------------------------------------
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim", -- vs-code like pictograms
        -- {
        --     "zbirenbaum/copilot-cmp",
        --     config = function() require("copilot_cmp").setup() end,
        -- },
    }, --
    config = function()
        -- omnifunc setup (a meta service)
        vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- underlying neovim settings
        vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
        vim.opt.pumheight = 10

        local cmp = require("cmp")
        local lspkind = require("lspkind")

        local toggle_cmp = function()
            -- read current cfg
            local cfg = cmp.get_config()
            -- record the toggled value
            local toggle = not cfg.enabled()
            -- update enable key
            cfg.enabled = function() return toggle end
            -- set cmp cfg with new value
            cmp.setup(cfg)
            -- report
            if not toggle then
                cmp.close()
                vim.notify("✗ Autocomplete disabled.", vim.log.levels.INFO)
            else
                vim.notify("✓ Autocomplete enabled", vim.log.levels.INFO)
            end --
        end

        -- make it callable from insert mode
        ---@diagnostic disable-next-line: unused-function, unused-local
        local function toggle_cmp_from_insert_mode() vim.schedule(toggle_cmp) end
        cmp.setup({
            -- Enable LSP snippets
            snippet = {
                expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    -- require("copilot_cmp.comparators").prioritize,
                    -- Note: Separate keybindings to toggle cmp
                    cmp.config.compare.offset,
                    -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            experimental = { ghost_text = false }, -- set to false when using copilot
            mapping = {
                -- NOTE: Be sure to avoid setting pumvisible dependent bindings in other
                -- keybinding settings (grep pumvisible)
                --
                -- force options to appear
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

                -- Confirm the selection
                -- Set `select` to `false` to only confirm explicitly selected items.
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-y>"] = cmp.mapping.confirm({ select = false }),

                -- navigate documentation
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

                -- navigate options when cmp.visible()
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

                -- abort and close
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                -- Toggle on or off
                ["<C-t>"] = cmp.mapping(function() toggle_cmp_from_insert_mode() end, { "i", "s" }),

                -- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
                -- ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
            },

            -- Installed sources
            sources = cmp.config.sources({
                { name = "supermaven", group_index = 2 },
                -- { name = "copilot", group_index = 2 },
                {
                    name = "nvim_lsp",
                    option = {
                        markdown_oxide = {
                            keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
                        },
                    },
                },
                { name = "nvim_lsp_signature_help" },
                { name = "path" },
                { name = "treesitter" },
                { name = "nvim_lua", keyword_length = 2 },
                { name = "vsnip", keyword_length = 2 },
                { name = "buffer", keyword_length = 2 },
                { name = "cmp_tabnine" },
                { name = "rg" },
                { name = "tmux" },
                { name = "fish" },
            }),

            -- view = "native", -- or 'native' 'wildmenu'
            -- Coordinate with pmenu highlight groups
            window = {
                documentation = cmp.config.window.bordered({
                    border = "rounded",
                    scrolloff = false,
                    col_offset = -3,
                    side_padding = 2,
                    max_width = 60,
                    scrollbar = true,
                }),
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                ellipsis_char = "…", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                format = function(entry, vim_item)
                    -- Limit the width of the completion menu
                    local max_width = 20
                    local label = vim_item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, max_width)
                    if label ~= truncated_label then vim_item.abbr = truncated_label .. "…" end
                    if vim.tbl_contains({ "path" }, entry.source.name) then
                        local icon, hl_group =
                            require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                        if icon then
                            vim_item.kind = icon
                            vim_item.kind_hl_group = hl_group
                            return vim_item
                        end
                    end
                    return lspkind.cmp_format({ with_text = false })(entry, vim_item)
                end,
            },
        })
        -- Setup Completion
        -- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
    end,
}
