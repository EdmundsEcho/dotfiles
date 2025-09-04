return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore = false,
            suppressed_dirs = {
                "~/",
                "~/Dev/",
                "~/Downloads",
                "~/Documents",
                "~/Desktop/",
            },
        })

        local keymap = vim.keymap

        keymap.set(
            "n",
            "<leader>wr",
            "<cmd>SessionRestore<CR>",
            { desc = "[W]in [R]estore session for cwd" }
        ) -- restore last workspace session for current directory
        keymap.set(
            "n",
            "<leader>ws",
            "<cmd>SessionSave<CR>",
            { desc = "[W]in [S]ave session for auto session root dir" }
        )
    end,
}
