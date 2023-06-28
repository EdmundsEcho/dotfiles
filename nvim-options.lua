--------------------------------------------------------------------------------
-- nvim-option.lua
--------------------------------------------------------------------------------
--
-- 🚧
-- In time build this file up with options described in the nvim-other.vim
-- configuration file.
--
-- last updated Mar 12, 2023
--------------------------------------------------------------------------------
--
-- Treesitter folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = false,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
