-- nvim-highlight-groups.lua
--------------------------------------------------------------------------------
-- Last updated: May 15, 2024
--------------------------------------------------------------------------------
--
--  Notes:
--  1. Overwrites loaded colorscheme
--  2. iTerm2 v3 controls the cursor color and how bold
--     fonts are displayed
--  3. Call :hi to see a full list of syntax objects
--  4. Use :Inspect and :TSNodeUnderCursor :TSCaptureUnderCursor
--
--  See also: ~/.config/nvim/bundle/nvim-treesitter/queries/<language>.scm
--

local M = {}

--------------------------------------------------------------------------------
local function hide_semantic_highlights()
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Clear LSP highlight groups",
    callback = hide_semantic_highlights,
})
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- WIP to make brighter when the mouse is hovering over the value
local function make_brighter(hex_color, amount)
    -- Ensure amount is between 0 and 1, where 1 makes the color completely white
    amount = math.min(math.max(amount, 0), 1)

    -- Remove the '#' if it's included in the hex color
    hex_color = hex_color:gsub("#", "")

    -- Extract the red, green, and blue components from the hex color
    local r = tonumber(hex_color:sub(1, 2), 16)
    local g = tonumber(hex_color:sub(3, 4), 16)
    local b = tonumber(hex_color:sub(5, 6), 16)

    -- Calculate the brighter color by moving each component towards 255 by the specified amount
    r = math.floor(r + (255 - r) * amount)
    g = math.floor(g + (255 - g) * amount)
    b = math.floor(b + (255 - b) * amount)

    -- Reassemble the components back into a hex string
    local bright_hex = string.format("#%02x%02x%02x", r, g, b)

    return bright_hex
end

local c = require("cape.core.nvim-colors")

local function link_highlight(from, to) vim.cmd(string.format("highlight! link %s %s", from, to)) end

M.match = {
    TYPE1 = c.theme_colors.Yellows.AncientGold,
    TYPE2 = c.theme_colors.Yellows.GoldenRay,
    TYPE3 = c.theme_colors.Browns.VibrantOrange,
    TYPE4 = c.theme_colors.Yellows.OliveTwist,
    TYPE5 = c.theme_colors.Purples.MutedPurple,
    IDENTIFIER1 = c.theme_colors.Yellows.GoldenRay,
    IDENTIFIER2 = c.theme_colors.Yellows.BronzeDawn,
    IDENTIFIER3 = c.theme_colors.Yellows.GoldenRay,
    IDENTIFIER4 = c.theme_colors.Browns.MutedBrown,
    IDENTIFIER5 = c.theme_colors.Purples.DeepPurple,
    -- FUNCTION1 = c.theme_colors.Greens.FreshLime,
    FUNCTION2 = c.theme_colors.Blues.Turquoise,
    FUNCTION3 = c.theme_colors.Yellows.OliveTwist,
    -- FUNCTION4 = c.theme_colors.Blues.OceanDeep,
    -- FUNCTION5 = c.theme_colors.Greens.LimeZest,
    FUNCTION = c.theme_colors.Blues.LightBlue,
    STRING1 = c.theme_colors.Greens.SpringGreen,
    STRING2 = c.theme_colors.Greens.SpringGreen,
    STRING3 = c.theme_colors.Greens.MossGreen,
    -- STRING4 = c.theme_colors.Grays.CloudDancer,
    COMMENT = c.theme_colors.Blues.Comment,
    COMMENT1 = c.theme_colors.Blues.Comment,
    -- COMMENT2 = c.theme_colors.Greens.SageGreen,
    MACRO = c.theme_colors.Reds.DarkRed,
    TRAIT = c.theme_colors.Purples.LightPurple,
    ERROR = c.theme_colors.Reds.BrightRed,
    NAMESPACE = c.theme_colors.Grays.DarkGray,
    MYLIB = c.theme_colors.Blues.DarkBlue,
    DOCUMENTATION = c.theme_colors.Greens.Army,
    ASYNC = c.theme_colors.Purples.LightPurple,
    GRAY = c.theme_colors.Grays.DarkGray,
}

for color_group, color in pairs(M.match) do
    vim.api.nvim_set_hl(0, color_group, { fg = color, bg = "NONE" })
end
--------------------------------------------------------------------------------
-- Move this to nvim-barbar-highlights.lua
-- https://github.com/romgrk/barbar.nvim
local barbar = {
    active = c.theme_colors.Grays.Black,
    visible = c.theme_colors.Grays.GrayCloud,
    inactive = c.theme_colors.Browns.NearBlack,
    accent = c.theme_colors.Reds.BrightRed,
}
local white = c.theme_colors.Grays.White
local black = c.theme_colors.Grays.NearBlack

local fg = c.theme_colors.Grays.White
local dim = c.theme_colors.Grays.DarkGray
local dim_accent = c.theme_colors.Reds.DimPink2
-- local dim_sign = c.theme_colors.Grays.GrayCloud

local barbar_hi_cfg = {
    -- Buffer<Status><Part>
    BufferCurrent = { fg = white, bg = barbar.active, bold = true },
    BufferCurrentMod = { fg = barbar.accent, bg = barbar.active },
    BufferVisible = { fg = white, bg = barbar.visible },
    BufferVisibleMod = { fg = barbar.accent, bg = barbar.visible },

    -- Hide gaps between tabs
    BufferCurrentSign = { fg = black, bg = black },
    BufferVisibleSign = { fg = black, bg = black },
    BufferInactiveSign = { fg = black, bg = black },

    -- INFO, ERROR, HINT
    BufferVisibleINFO = { fg = dim, bg = barbar.inactive },
    BufferVisibleERROR = { fg = dim, bg = barbar.inactive },
    BufferVisibleHINT = { fg = dim, bg = barbar.inactive },

    -- Index
    BufferCurrentIndex = {
        fg = c.theme_colors.Luci.SecondaryMain,
        bg = barbar.active,
        bold = true,
    },
    BufferVisibleIndex = { fg = white, bg = barbar.visible },
    -- all state groups
    BufferScrollArrow = { fg = c.theme_colors.Luci.SecondaryMain, bg = "NONE" },
}

local inactive_grps = {
    BufferInactive = { fg = dim, bg = barbar.inactive },
    BufferInactiveIndex = { fg = dim, bg = barbar.inactive },
    BufferInactiveMod = { fg = dim_accent, bg = barbar.inactive },
    BufferInactiveTarget = { fg = fg, bg = barbar.inactive },
}

--------------------------------------------------------------------------------
function M.update_highlights()
    -- set hl tables
    for group, props in pairs(barbar_hi_cfg) do
        vim.api.nvim_set_hl(0, group, props)
    end
    for group, props in pairs(inactive_grps) do
        vim.api.nvim_set_hl(0, group, props)
    end

    -- move this
    vim.api.nvim_set_hl(0, "NotifyBackground", {
        bg = c.theme_colors.Grays.White,
    })
    vim.api.nvim_set_hl(0, "MatchParen", {
        fg = c.theme_colors.Grays.White,
        bg = c.theme_colors.Luci.PrimaryMainDark,
    })
    -- Special is used too generically across languages
    vim.api.nvim_set_hl(0, "Special", { fg = c.theme_colors.Grays.DarkGray, bg = "NONE" })
    vim.api.nvim_set_hl(
        0,
        "Error",
        { bg = "NONE", fg = c.theme_colors.Reds.BrightRed, bold = true }
    )
    vim.api.nvim_set_hl(0, "Normal", {
        fg = c.theme_colors.Grays.GrayCloud,
    })
    vim.api.nvim_set_hl(0, "Statement", { fg = c.theme_colors.Blues.MutedBlue, bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLine", { fg = c.theme_colors.Luci.PrimaryMain, bg = "NONE" })
    vim.api.nvim_set_hl(
        0,
        "Title",
        { fg = c.theme_colors.Purples.DeepPurple, bg = "NONE", bold = true }
    )
    vim.api.nvim_set_hl(
        0,
        "Comment",
        { fg = c.theme_colors.Blues.Comment, bg = "NONE", italic = true }
    )
    vim.api.nvim_set_hl(
        0,
        "String",
        { fg = c.theme_colors.Greens.MossGreen, bg = "NONE", italic = true }
    )
    vim.api.nvim_set_hl(0, "Constant", { fg = c.theme_colors.Reds.RusticRed, bg = "NONE" })
    vim.api.nvim_set_hl(0, "Type", { fg = c.theme_colors.Grays.WhiteYellow, bg = "NONE" })

    vim.api.nvim_set_hl(0, "@constructor.python", { fg = M.match.IDENTIFIER5, bg = "NONE" })
    vim.api.nvim_set_hl(0, "@function.builtin.python", { fg = M.match.TYPE1, bg = "NONE" })
    vim.api.nvim_set_hl(0, "@variable.builtin.python", { fg = M.match.IDENTIFIER5, bg = "NONE" })
    vim.api.nvim_set_hl(
        0,
        "@string.documentation.python",
        { fg = M.match.DOCUMENTATION, bg = "NONE" }
    )

    vim.api.nvim_set_hl(0, "@lsp.type.variable.lua", { fg = M.match.IDENTIFIER5, bg = "NONE" })
    vim.api.nvim_set_hl(0, "IDENTIFIER2", { fg = M.match.IDENTIFIER2, bg = "NONE" })
    vim.api.nvim_set_hl(0, "STRING1", { fg = M.match.STRING1, bg = "NONE", italic = true })
    vim.api.nvim_set_hl(0, "STRING2", { fg = M.match.STRING2, bg = "NONE", italic = true })
    vim.api.nvim_set_hl(0, "MACRO", { fg = M.match.MACRO, bg = "NONE" })
    vim.api.nvim_set_hl(0, "MYLIB", { fg = M.match.MYLIB, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NAMESPACE", { fg = M.match.NAMESPACE, bg = "NONE" })
    vim.api.nvim_set_hl(0, "TRAIT", { fg = M.match.TRAIT, bg = "NONE" })
    vim.api.nvim_set_hl(0, "TYPE2", { fg = M.match.TYPE2, bg = "NONE" })
    vim.api.nvim_set_hl(0, "Identifier", { fg = M.match.IDENTIFIER3, bg = "NONE" })
    vim.api.nvim_set_hl(0, "Function", { fg = M.match.FUNCTION, bg = "NONE" })
    vim.api.nvim_set_hl(0, "Visual", { fg = c.theme_colors.Blues.Visual, bg = "NONE" })
    vim.api.nvim_set_hl(0, "Delimiter", { fg = c.theme_colors.Grays.GrayCloud, bg = "NONE" })
    link_highlight("Operator", "Delimiter")

    vim.api.nvim_set_hl(0, "IDENTIFIER4", { fg = M.match.IDENTIFIER4, bg = "NONE" })
    vim.api.nvim_set_hl(0, "CurSearch", c.elements.Search.CurSearch)
    vim.api.nvim_set_hl(0, "Search", c.elements.Search.Search)
    vim.api.nvim_set_hl(0, "Fidget", c.elements.Fidget)
    vim.api.nvim_set_hl(0, "VertSplit", c.elements.VertSplit)

    vim.api.nvim_set_hl(0, "Cursor", c.elements.Cursor.Cursor)
    vim.api.nvim_set_hl(0, "lCursor", c.elements.Cursor.lCursor)
    vim.api.nvim_set_hl(0, "WinBarNC", c.elements.Cursor.LineCursor)
    vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.theme_colors.Grays.GrayCloud, bg = "NONE" })
    vim.api.nvim_set_hl(0, "LineNr", { fg = c.theme_colors.Yellows.HarvestGold, bg = "NONE" })
    link_highlight("LineNrAbove", "GRAY")
    link_highlight("LineNrBelow", "GRAY")
    vim.api.nvim_set_hl(
        0,
        "DiagnosticFloatingError",
        { fg = c.theme_colors.Grays.WhiteRed, bg = "NONE", italic = true }
    )
    ----------------------------------------------------------------------------
    -- unknown -> already defined
    --
    link_highlight("Directory", "Function")
    link_highlight("ERROR", "Error")
    link_highlight("DiagnosticError", "Error")
    link_highlight("@variable", "IDENTIFIER")
    link_highlight("@function.macro.vim", "MACRO")
    link_highlight("IDENTIFIER", "IDENTIFIER2")
    link_highlight("Function", "FUNCTION")
    link_highlight("Macro", "MACRO")
    link_highlight("LIFETIME", "STRING2")
    link_highlight("VARIANT", "TYPE2")
    link_highlight("@lsp.mod.attribute.rust", "NAMESPACE")
    link_highlight("@lsp.mod.constant.rust", "ORANGE")
    link_highlight("@lsp.type.lifetime.rust", "LIFETIME")
    link_highlight("@lsp.type.builtinType.rust", "IDENTIFIER4")
    link_highlight("@lsp.type.derive.rust", "TRAIT")
    link_highlight("@lsp.type.enumMember.rust", "VARIANT")
    link_highlight("@lsp.type.interface.rust", "TRAIT")
    link_highlight("@lsp.type.macro.rust", "MACRO")
    link_highlight("@lsp.type.namespace.rust", "NAMESPACE")
    link_highlight("@lsp.type.typeAlias.rust", "TYPE4")
    link_highlight("@lsp.type.unresolvedReference.rust", "ERROR")
    link_highlight("@lsp.typemod.namespace.declaration.rust", "MYLIB")
    link_highlight("@lsp.typemod.method.trait.rust", "TRAIT")
    link_highlight("@lsp.type.property.lspinfo", "NORMAL")

    link_highlight("@lsp.type.method.rust", "IDENTIFIER2")

    link_highlight("@type.builtin.python", "TYPE2")
    link_highlight("@type.python", "TYPE3")
    vim.api.nvim_set_hl(0, "@function.python", { fg = M.match.FUNCTION })
    vim.api.nvim_set_hl(0, "@function.call.python", { fg = M.match.FUNCTION2 })
    vim.api.nvim_set_hl(0, "@function.method.call.python", { fg = M.match.FUNCTION3 })
    vim.api.nvim_set_hl(0, "@lsp.typemod.keyword.async.rust", { fg = M.match.ASYNC })

    -- Treesitter rust
    link_highlight("@comment.rust", "COMMENT")
    link_highlight("@comment.documentation.rust", "DOCUMENTATION")
    link_highlight("@constant.rust", "ORANGE")
    link_highlight("@function.rust", "FUNCTION")
    link_highlight("@identifier.rust", "IDENTIFIER")
    link_highlight("@include.rust", "MUTED_BROWN")
    link_highlight("@namespace.rust", "MUTED_YELLOW")
    link_highlight("@punctuation.type_param.rust", "NAMESPACE")
    link_highlight("@storageclass.lifetime.rust", "LIFETIME")
    link_highlight("@function.macro.rust", "MACRO")

    -- JSX
    link_highlight("@tag.javascript", "IDENTIFIER4")
    link_highlight("@tag.builtin.javascript", "TYPE5")
    link_highlight("@comment.javascript", "COMMENT")
    link_highlight("@comment.documentation.javascript", "DOCUMENTATION")
    link_highlight("@tag.attribute.javascript", "IDENTIFIER5")
    link_highlight("jsxComponentName", "ORANGE")
    link_highlight("jsxTag", "TURQUOISE")
    link_highlight("jsxTagName", "TURQUOISE")
    link_highlight("jsxCloseString", "YELLOW")
    link_highlight("jsxCloseTag", "YELLOW")
    link_highlight("jsxDot", "Identifier")
    link_highlight("jsxEqual", "Type")
    link_highlight("jsxEscapeJs", "jsxEscapeJs")
    link_highlight("jsxNameSpace", "RED")
    link_highlight("jsxString", "String")
    link_highlight("jsxPunct", "YELLOW")

    link_highlight("TSCjsxBraces", "GREEN")
    link_highlight("jsFuncName", "GREEN")
    link_highlight("jsFunction", "MUTED_YELLOW")
    link_highlight("jsBraces", "MUTED_GREEN")

    link_highlight("jsxClass", "ORANGE")
    link_highlight("jsxCloseClass", "jsxClass")
    link_highlight("xmlTagName", "jsxClass")
    link_highlight("xmlEndTag", "jsxClass")
    link_highlight("jsClassDefinition", "jsxClass")
    link_highlight("jsObjectKey", "Identifier")
    link_highlight("xmlAttrib", "PURPLE")

    -- Treesitter JSX
    vim.api.nvim_set_hl(0, "@constructor.javascript", { link = "jsxClass" })
    vim.api.nvim_set_hl(0, "@none.javascript", { link = "STRING4" })
end

return M
