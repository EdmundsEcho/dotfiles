return { -- Show you pending keybinds
    "folke/which-key.nvim",
    lazy = false,
    config = function()
        local plugin = require("which-key")
        plugin.setup()
        -- Document existing key chains
        plugin.register({
            ["<leader><leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
            ["<leader><leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
            ["<leader><leader>r"] = {
                name = "[R]ename",
                _ = "which_key_ignore",
            },
            ["<leader><leader>s"] = {
                name = "[S]earch",
                _ = "which_key_ignore",
            },
            ["<leader><leader>w"] = {
                name = "[W]orkspace",
                _ = "which_key_ignore",
            },
            ["<leader><leader>t"] = {
                name = "[T]oggle",
                _ = "which_key_ignore",
            },
            ["<leader><leader>h"] = {
                name = "Git [H]unk",
                _ = "which_key_ignore",
            },
        })
        -- visual mode
        require("which-key").register({
            ["<leader><leader>h"] = { "Git [H]unk" },
        }, { mode = "v" })
    end,
}
