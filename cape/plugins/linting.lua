-- Lint manager
return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            python = { "pylint" },
        }
        local lint_augroup = vim.api.nvim_create_augroup("lint_augroup", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function() lint.try_lint() end,
        })
        require("lint").linters.pylint.args = {
            "-m",
            "pylint",
            "-f",
            "json",
        }
        -- Set pylint to work in virtualenv
        -- require("lint").linters.pylint.cmd = "python"
        -- require("lint").linters.pylint.args = { "-m", "pylint", "-f", "json" }

        vim.keymap.set(
            "n",
            "<leader>l",
            function() lint.try_lint() end,
            { desc = "[L]int the current buffer", noremap = true, silent = true }
        )
    end,
}
