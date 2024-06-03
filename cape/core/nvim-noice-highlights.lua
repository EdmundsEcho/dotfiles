local c = require("cape.core.nvim-colors")

vim.api.nvim_set_hl(0, "NoiceMini", { fg = c.theme_colors.Luci.PrimaryMainDark, bg = c.theme_colors.Grays.Black })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.theme_colors.Luci.SecondaryMain, bg = c.theme_colors.Grays.Black })
vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { fg = c.theme_colors.Luci.SecondaryMain, bg = c.theme_colors.Grays.Black })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",
  { fg = c.theme_colors.Luci.PrimaryMain, bg = c.theme_colors.Grays.Black })
vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline",
  { fg = c.theme_colors.Luci.PrimaryMain, bg = c.theme_colors.Grays.Black })
