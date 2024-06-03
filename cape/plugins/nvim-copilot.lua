--------------------------------------------------------------------------------
-- copilot plugin using lua

    -- Copilot
    return {
        "zbirenbaum/copilot.lua",
    event = { "InsertEnter", "LspAttach" },
        cmd = "Copilot", -- To be able to call `:Copilot` if lazy loaded (optional)
        build = ":Copilot auth", -- For authentication if required
        opts = {
    fix_pairs = true,

    -- coordinate with cape.plugins.nvim-cmp.lua
    panel = { enabled = false },
    suggestion = { enabled = false },
    -- suggestion = {
    --     auto_trigger = true,
    --     debounce = 300,
    --     -- keymap that maps control-y to accept suggestion
    --     keymap = {
    --         -- <C-y>
    --         accept = "<C-y>",
    --         -- <C-f>
    --         next = "<C-n>",
    --         -- <C-b>
    --         prev = "<C-b>",
    --         -- <C-d>
    --         dismiss = "<C-d>",
    --     },
    -- },
    filetypes = {
        javascript = true,
        javascriptreact = true,
        python = true,
        perl = true,
        rust = true,
        haskell = true,
        sql = true,
        lua = true,
    },
}
}



-- END
