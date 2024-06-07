return {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
    config = function()
        -- ------------------------------------------------------------------------------
        -- 🪟 Pane resizing coordinated with tmux
        -- vim-tmux-navigator
        -- ------------------------------------------------------------------------------
        -- Pass-through from tmux (WIP)
        vim.keymap.set(
            "n",
            "<M-j>",
            ":resize -2<CR>",
            { noremap = true, silent = true, desc = "Resize pane down" }
        )
        vim.keymap.set(
            "n",
            "<M-k>",
            ":resize +2<CR>",
            { noremap = true, silent = true, desc = "Resize pane up" }
        )
        vim.keymap.set(
            "n",
            "<M-h>",
            ":vertical resize -2<CR>",
            { noremap = true, silent = true, desc = "Resize pane left" }
        )
        vim.keymap.set(
            "n",
            "<M-l>",
            ":vertical resize +2<CR>",
            { noremap = true, silent = true, desc = "Resize pane right" }
        )

        -- Split {n}vim window
        vim.keymap.set(
            "n",
            "<leader>-",
            ":sp<CR>",
            { noremap = true, silent = true, desc = "Horizontal split" }
        )
        vim.keymap.set(
            "n",
            "<leader>/",
            ":vsp<CR>",
            { noremap = true, silent = true, desc = "Vertical split" }
        )
        vim.keymap.set(
            "n",
            "<leader>\\",
            ":vsp<CR>",
            { noremap = true, silent = true, desc = "Vertical split" }
        )
        require("nvim-tmux-navigation").setup({
            disable_when_zoomed = true,
            keybindings = {
                left = "<C-h>",
                down = "<C-j>",
                up = "<C-k>",
                right = "<C-l>",
                last_active = "<C-\\>",
                next = "<C-Space>",
            },
        })
    end,
}
