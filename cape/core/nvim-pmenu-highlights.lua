-- nvim-pmenu-highlights
--------------------------------------------------------------------------------
-- Use this to format the pmenu
-- See also nvim-cmp for other display features.
--
-- Last updated: May 15, 2024
--------------------------------------------------------------------------------
--
-- local M = {}

local c = require("cape.core.nvim-colors")

-- Set the background color of the popup menu
vim.api.nvim_set_hl(
  0,
  "Pmenu",
  { fg = c.theme_colors.Grays.GrayCloud, bg = c.theme_colors.Grays.Black }
)
vim.api.nvim_set_hl(
  0,
  "NormalFloat",
  { fg = c.theme_colors.Grays.GrayCloud, bg = c.theme_colors.Grays.Black }
)
vim.api.nvim_set_hl(0, "FloatBorder", {
  fg = c.theme_colors.Greens.MossGreen,
  bg = c.theme_colors.Grays.Black,
})
-- Set the background color of the selected item in the popup menu
vim.api.nvim_set_hl(0, "PmenuSel", { ctermbg = "blue", bg = "#3e4451" })
-- Set the scrollbar color
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#3e4451" })
-- Set the thumb color of the scrollbar
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#5c6370" })
-- Set the kind of the item
vim.api.nvim_set_hl(0, "PmenuKind", { fg = "#c678dd", bg = "#282c34" })
-- Set the kind of the selected item
vim.api.nvim_set_hl(0, "PmenuKindSel", { fg = "#c678dd", bg = "#3e4451" })
-- Set the extra text of the item
vim.api.nvim_set_hl(0, "PmenuExtra", { fg = "#61afef", bg = "#282c34" })
-- Set the extra text of the selected item
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = "#61afef", bg = "#3e4451" })
-- Set the icon of the item
vim.api.nvim_set_hl(0, "PmenuIcon", { fg = "#e06c75", bg = "#282c34" })
-- Set the icon of the selected item
vim.api.nvim_set_hl(0, "PmenuIconSel", { fg = "#e06c75", bg = "#3e4451" })

--------------------------------------------------------------------------------
-- From the github example, Cmp has it's own highlight groups
--------------------------------------------------------------------------------
-- gray
vim.api.nvim_set_hl(
  0,
  "CmpItemAbbrDeprecated",
  { bg = "NONE", strikethrough = true, fg = "#808080" }
)
-- blue
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
-- light blue
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
-- pink
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
-- front
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

-- END
