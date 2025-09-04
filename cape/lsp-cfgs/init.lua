vim.lsp.config.lua_ls = require("cape.lsp-cfgs.lua_ls").setup()
vim.lsp.config.json_ls = require("cape.lsp-cfgs.json_ls").setup()
vim.lsp.config.json_ls = require("cape.lsp-cfgs.ruff_ls").setup()
vim.lsp.config.json_ls = require("cape.lsp-cfgs.pyright_ls").setup()
vim.lsp.config.json_ls = require("cape.lsp-cfgs.yaml_ls").setup()
vim.lsp.config.json_ls = require("cape.lsp-cfgs.sql_ls").setup()
vim.lsp.config.json_ls = require("cape.lsp-cfgs.html_ls")
-- vim.lsp.config.json_ls = require("cape.lsp-cfgs.eslint_ls")

vim.lsp.enable({
    "lua_ls",
    "json_ls",
    "ruff_ls",
    "pyright_ls",
    "html_ls",
    "yaml_ls",
    "sql_ls",
    -- "eslint_ls",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = require("cape.lsp-cfgs.lsp-handler").setup(),
})

-- add noselect
vim.cmd("set completeopt+=noselect")

-- enable rounded borders
vim.o.winborder = "rounded"

-- END
