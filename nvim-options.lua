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
