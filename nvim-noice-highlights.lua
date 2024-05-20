local c = require("nvim-colors")

vim.api.nvim_set_hl(0, "NoiceMini", { fg = c.theme_colors.Luci.PrimaryMainDark, bg = c.theme_colors.Grays.Black })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.theme_colors.Luci.SecondaryMain, bg = c.theme_colors.Grays.Black })
vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { fg = c.theme_colors.Luci.SecondaryMain, bg = c.theme_colors.Grays.Black })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",
  { fg = c.theme_colors.Luci.PrimaryMain, bg = c.theme_colors.Grays.Black })
vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline",
  { fg = c.theme_colors.Luci.PrimaryMain, bg = c.theme_colors.Grays.Black })
--[[
M.defaults = {
  Cmdline = "MsgArea",                             -- Normal for the classic cmdline area at the bottom"
  CmdlineIcon = "DiagnosticSignInfo",              -- Cmdline icon
  CmdlineIconSearch = "DiagnosticSignWarn",        -- Cmdline search icon (`/` and `?`)
  CmdlinePrompt = "Title",                         -- prompt for input()
  CmdlinePopup = "Normal",                         -- Normal for the cmdline popup
  CmdlinePopupBorder = "DiagnosticSignInfo",       -- Cmdline popup border
  CmdlinePopupTitle = "DiagnosticSignInfo",        -- Cmdline popup border
  CmdlinePopupBorderSearch = "DiagnosticSignWarn", -- Cmdline popup border for search
  Confirm = "Normal",                              -- Normal for the confirm view
  ConfirmBorder = "DiagnosticSignInfo",            -- Border for the confirm view
  Cursor = "Cursor",                               -- Fake Cursor
  Mini = "MsgArea",                                -- Normal for mini view
  Popup = "NormalFloat",                           -- Normal for popup views
  PopupBorder = "FloatBorder",                     -- Border for popup views
  Popupmenu = "Pmenu",                             -- Normal for the popupmenu
  PopupmenuBorder = "FloatBorder",                 -- Popupmenu border
  PopupmenuMatch = "Special",                      -- Part of the item that matches the input
  PopupmenuSelected = "PmenuSel",                  -- Selected item in the popupmenu
  Scrollbar = "PmenuSbar",                         -- Normal for scrollbar
  ScrollbarThumb = "PmenuThumb",                   -- Scrollbar thumb
  Split = "NormalFloat",                           -- Normal for split views
  SplitBorder = "FloatBorder",                     -- Border for split views
  VirtualText = "DiagnosticVirtualTextInfo",       -- Default hl group for virtualtext views
  FormatProgressDone = "Search",                   -- Progress bar done
  FormatProgressTodo = "CursorLine",               -- progress bar todo
  FormatEvent = "NonText",
  FormatKind = "NonText",
  FormatDate = "Special",
  FormatConfirm = "CursorLine",
  FormatConfirmDefault = "Visual",
  FormatTitle = "Title",
  FormatLevelDebug = "NonText",
  FormatLevelTrace = "NonText",
  FormatLevelOff = "NonText",
  FormatLevelInfo = "DiagnosticVirtualTextInfo",
  FormatLevelWarn = "DiagnosticVirtualTextWarn",
  FormatLevelError = "DiagnosticVirtualTextError",
  LspProgressSpinner = "Constant", -- Lsp progress spinner
  LspProgressTitle = "NonText",    -- Lsp progress title
  LspProgressClient = "Title",     -- Lsp progress client name
  CompletionItemMenu = "none",     -- Normal for the popupmenu
  CompletionItemWord = "none",     -- Normal for the popupmenu
  CompletionItemKindDefault = "Special",
  CompletionItemKindColor = "NoiceCompletionItemKindDefault",
  CompletionItemKindFunction = "NoiceCompletionItemKindDefault",
  CompletionItemKindClass = "NoiceCompletionItemKindDefault",
  CompletionItemKindMethod = "NoiceCompletionItemKindDefault",
  CompletionItemKindConstructor = "NoiceCompletionItemKindDefault",
  CompletionItemKindInterface = "NoiceCompletionItemKindDefault",
  CompletionItemKindModule = "NoiceCompletionItemKindDefault",
  CompletionItemKindStruct = "NoiceCompletionItemKindDefault",
  CompletionItemKindKeyword = "NoiceCompletionItemKindDefault",
  CompletionItemKindValue = "NoiceCompletionItemKindDefault",
  CompletionItemKindProperty = "NoiceCompletionItemKindDefault",
  CompletionItemKindConstant = "NoiceCompletionItemKindDefault",
  CompletionItemKindSnippet = "NoiceCompletionItemKindDefault",
  CompletionItemKindFolder = "NoiceCompletionItemKindDefault",
  CompletionItemKindText = "NoiceCompletionItemKindDefault",
  CompletionItemKindEnumMember = "NoiceCompletionItemKindDefault",
  CompletionItemKindUnit = "NoiceCompletionItemKindDefault",
  CompletionItemKindField = "NoiceCompletionItemKindDefault",
  CompletionItemKindFile = "NoiceCompletionItemKindDefault",
  CompletionItemKindVariable = "NoiceCompletionItemKindDefault",
  CompletionItemKindEnum = "NoiceCompletionItemKindDefault",
}

return M
]]
