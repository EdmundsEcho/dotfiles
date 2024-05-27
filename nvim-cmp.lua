--------------------------------------------------------------------------------
-- Auto-completion with cmp
--
-- Must be configured with lsp capabilities using cmp-nvim-lsp
-- (see nvim-capabilities)
--
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
        string.format("👎 %s not found. cmp error: %s", module_name, err),
        vim.log.levels.ERROR
      )
    end
  end

  -- omnifunc setup (a meta service)
  vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- underlying neovim settings
  vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
  vim.opt.pumheight = 10

  local cmp = require("cmp")
  local lspkind = require("lspkind")

  -- Setup Completion
  -- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
  cmp.setup({
    -- Enable LSP snippets
    snippet = {
      expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        require("copilot_cmp.comparators").prioritize,
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
    experimental = { ghost_text = false },     -- this feature conflict with copilot.vim's preview.
    mapping = {

      -- for the options to appear
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

      ["<C-g>"] = cmp.mapping(
        function(fallback)
          vim.api.nvim_feedkeys(
            vim.fn["copilot#Accept"](
              vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
            ),
            "n",
            true
          )
        end
      ),

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
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    },

    -- Installed sources
    sources = cmp.config.sources({
      { name = "copilot",                group_index = 2 },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "path" },
      { name = "treesitter" },
      { name = "nvim_lua",               keyword_length = 2 },
      { name = "vsnip",                  keyword_length = 2 },
      { name = "buffer",                 keyword_length = 2 },
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
      --[[
      completion = cmp.config.window.bordered({
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        side_padding = 1,
        col_offset = -3,
        max_height = 17,
        max_width = 20,
        scrollbar = false,
      }), ]]
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
        if label ~= truncated_label then
          vim_item.abbr = truncated_label .. "…"
        end
        if vim.tbl_contains({ "path" }, entry.source.name) then
          local icon, hl_group = require("nvim-web-devicons").get_icon(
            entry:get_completion_item().label
          )
          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end
        return lspkind.cmp_format({ with_text = false })(entry, vim_item)
      end,
    },
    --[[
        formatting = {
            format = function(entry, vim_item)
                if vim.tbl_contains({ "path" }, entry.source.name) then
                    local icon, hl_group =
                        require("nvim-web-devicons").get_icon(
                            entry:get_completion_item().label
                        )
                    if icon then
                        vim_item.kind = icon
                        vim_item.kind_hl_group = hl_group
                        return vim_item
                    end
                end
                return lspkind.cmp_format({ with_text = false })(
                    entry,
                    vim_item
                )
            end,
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
        }, ]]
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
