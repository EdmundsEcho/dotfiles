local c = require("cape.core.nvim-colors")
vim.api.nvim_set_hl(
    0,
    "NeoTreeTitleBar",
    { fg = c.theme_colors.Grays.White, bg = c.theme_colors.Luci.PrimaryMainDark }
)
vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.theme_colors.Luci.PrimaryMainDark })

-- NeoTreeNormal  xxx links to Normal
-- NeoTreeNormalNC xxx links to NormalNC
-- NeoTreeSignColumn xxx links to SignColumn
-- NeoTreeStatusLine xxx links to StatusLine
-- NeoTreeStatusLineNC xxx links to StatusLineNC
-- NeoTreeVertSplit xxx links to VertSplit
-- NeoTreeWinSeparator xxx links to WinSeparator
-- NeoTreeEndOfBuffer xxx links to EndOfBuffer
-- NeoTreeFloatBorder xxx links to FloatBorder
-- NeoTreeFloatNormal xxx links to NormalFloat
-- NeoTreeFloatTitle xxx guifg=#a8a8a8 guibg=#212121
-- NeoTreeTitleBar xxx guibg=#7db74d
