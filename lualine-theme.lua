--------------------------------------------------------------------------------
-- Theme for lualine
-- Linking the colors to nvim-colors is WIP
--------------------------------------------------------------------------------

-- Custom theme based on material theme
local material = require("lualine.themes.material")
local theme = vim.deepcopy(material)

-- Change the background color of lualine_a to match lualine_b for all modes
theme.normal.a.bg = material.normal.b.bg
theme.insert.a.bg = material.insert.b.bg
theme.visual.a.bg = material.visual.b.bg
theme.replace.a.bg = material.replace.b.bg
theme.inactive.a.bg = material.inactive.b.bg

return theme

--[[

local custom_theme = {
 normal = {
   a = { bg = colors.blue, fg = colors.background, gui = 'bold' },
   b = { bg = colors.darkgray, fg = colors.foreground },
   c = { bg = colors.bg_alt, fg = colors.foreground },
 },
 insert = {
   a = { bg = colors.green, fg = colors.background, gui = 'bold' },
   b = { bg = colors.darkgray, fg = colors.foreground },
 },
 visual = {
   a = { bg = colors.purple, fg = colors.background, gui = 'bold' },
   b = { bg = colors.darkgray, fg = colors.foreground },
 },
 replace = {
   a = { bg = colors.red, fg = colors.background, gui = 'bold' },
   b = { bg = colors.darkgray, fg = colors.foreground },
 },
 command = {
   a = { bg = colors.yellow, fg = colors.background, gui = 'bold' },
   b = { bg = colors.darkgray, fg = colors.foreground },
 },
 inactive = {
   a = { bg = colors.bg_alt, fg = colors.foreground, gui = 'bold' },
   b = { bg = colors.bg_alt, fg = colors.foreground },
   c = { bg = colors.bg_alt, fg = colors.foreground },
 },


return custom_theme


 inactive = {
   a = {
     bg = "#263238",
     fg = "#eeffff",
     gui = "bold"
   },
   b = {
     bg = "#263238",
     fg = "#eeffff"
   },
   c = {
     bg = "#2E3C43",
     fg = "#eeffff"
   }
 },
 insert = {
   a = {
     bg = "#c3e88d",
     fg = "#263238",
     gui = "bold"
   },
   b = {
     bg = "#515559",
     fg = "#eeffff"
   }
 },
 normal = {
   a = {
     bg = "#82aaff",
     fg = "#263238",
     gui = "bold"
   },
   b = {
     bg = "#515559",
     fg = "#eeffff"
   },
   c = {
     bg = "#2E3C43",
     fg = "#eeffff"
   }
 },
 replace = {
   a = {
     bg = "#f07178",
     fg = "#263238",
     gui = "bold"
   },
   b = {
     bg = "#515559",
     fg = "#eeffff"
   }
 },
visual = {
    a = {
      bg = "#c792ea",
      fg = "#263238",
      gui = "bold"
    },
    b = {
      bg = "#515559",
      fg = "#eeffff"
    }
  }
}

return M
]]

-- END
