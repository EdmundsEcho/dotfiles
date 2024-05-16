--------------------------------------------------------------------------------
-- conform formatting plugin manager
--------------------------------------------------------------------------------
local status, conform = pcall(require, "conform")
if not status then
    vim.notify("Failed to load 'conform' plugin.", vim.log.levels.ERROR)
    return
end
--------------------------------------------------------------------------------
conform.setup({
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },

    formatters_by_ft = {
        javascript = { { "prettierd", "prettier" } }, -- first available
        typescript = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        json = { "jq", "prettierd" },
        graphql = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        lua = { "stylua" },
        python = { "ruff_lsp", "isort", "black" }, -- in sequence
    },
    -- trigger formating with <leader>f
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        })
    end, { desc = "Format file or range (in visual mode)" }),
})
