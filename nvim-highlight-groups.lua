-- nvim-highlight-groups.lua
--
--  Notes:
--  1. Overwrites loaded colorscheme
--  2. iTerm2 v3 controls the cursor color and how bold
--     fonts are displayed
--  3. Call :hi to see a full list of syntax objects
--  4. Use :Inspect and :TSNodeUnderCursor :TSCaptureUnderCursor
--

local M = {}

local c = require("nvim-colors")

M.match = {
    TYPE1 = c.theme_colors.Yellows.AncientGold,
    TYPE2 = c.theme_colors.Yellows.GoldenRay,
    TYPE3 = c.theme_colors.Browns.VibrantOrange,
    TYPE4 = c.theme_colors.Yellows.OliveTwist,
    TYPE5 = c.theme_colors.Yellows.OliveTwist,
    IDENTIFIER1 = c.theme_colors.Yellows.GoldenRay,
    IDENTIFIER2 = c.theme_colors.Yellows.BronzeDawn,
    IDENTIFIER3 = c.theme_colors.Yellows.GoldenRay,
    IDENTIFIER4 = c.theme_colors.Greens.SpringGreen,
    FUNCTION1 = c.theme_colors.Greens.FreshLime,
    FUNCTION2 = c.theme_colors.Blues.Turquoise,
    FUNCTION3 = c.theme_colors.Yellows.OliveTwist,
    FUNCTION4 = c.theme_colors.Blues.OceanDeep,
    FUNCTION5 = c.theme_colors.Greens.LimeZest,
    FUNCTION = c.theme_colors.Blues.LightBlue,
    STRING1 = c.theme_colors.Greens.SpringGreen,
    STRING2 = c.theme_colors.Greens.SpringGreen,
    STRING3 = c.theme_colors.Greens.MossGreen,
    STRING4 = c.theme_colors.Grays.CloudDancer,
    COMMENT1 = c.theme_colors.Greens.StormySky,
    COMMENT2 = c.theme_colors.Greens.SageGreen,
    MACRO = c.theme_colors.Reds.DarkRed,
    TRAIT = c.theme_colors.Purples.LightPurple,
    TRAIT2 = c.theme_colors.Purples.LighterPurple,
    ERROR = c.theme_colors.Reds.BrightRed,
    NAMESPACE = c.theme_colors.Grays.DarkGray,
    MYLIB = c.theme_colors.Blues.DarkBlue,
    DOCUMENTATION = c.theme_colors.Greens.Army,
    ASYNC = c.theme_colors.Purples.LightPurple,
}

-- https://github.com/romgrk/barbar.nvim
local barbar = {
    active = c.theme_colors.Grays.Black,
    visible = c.theme_colors.Grays.GrayCloud,
    inactive = c.theme_colors.Browns.NearBlack,
    accent = c.theme_colors.Reds.BrightRed,
}
local white = c.theme_colors.Grays.White
local black = c.theme_colors.Grays.NearBlack

local barbar_hi_cfg = {
    BufferCurrent = { fg = white, bg = barbar.active, bold = true },
    BufferCurrentMod = { fg = barbar.accent, bg = barbar.active },
    BufferVisible = { fg = white, bg = barbar.visible },
    BufferVisibleMod = { fg = barbar.accent, bg = barbar.visible },

    -- Hide gaps between tabs
    BufferCurrentSign = { fg = black, bg = black },
    BufferVisibleSign = { fg = black, bg = black },
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

local fg = c.theme_colors.Grays.White
local dim = c.theme_colors.Grays.DarkGray
local dim_accent = c.theme_colors.Reds.DimPink2
-- local dim_sign = c.theme_colors.Grays.GrayCloud

local inactive_grps = {
    BufferInactive = { fg = dim, bg = barbar.inactive },
    BufferInactiveIndex = { fg = dim, bg = barbar.inactive },
    BufferInactiveMod = { fg = dim_accent, bg = barbar.inactive },
    BufferInactiveSign = { fg = black, bg = black },
    BufferInactiveTarget = { fg = fg, bg = barbar.inactive },
}

function M.update_highlights()
    -- set hl tables
    for group, props in pairs(barbar_hi_cfg) do
        vim.api.nvim_set_hl(0, group, props)
    end
    for group, props in pairs(inactive_grps) do
        vim.api.nvim_set_hl(0, group, props)
    end

    vim.api.nvim_set_hl(0, "MatchParen", {
        fg = c.theme_colors.Grays.White,
        bg = c.theme_colors.Luci.PrimaryMainDark,
    })
    vim.api.nvim_set_hl(
        0,
        "Statement",
        { fg = c.theme_colors.Blues.MutedBlue, bg = "NONE" }
    )
    vim.api.nvim_set_hl(
        0,
        "StatusLine",
        { fg = c.theme_colors.Luci.PrimaryMain, bg = "NONE" }
    )
    vim.api.nvim_set_hl(
        0,
        "Title",
        { fg = c.theme_colors.Purples.DeepPurple, bg = "NONE", bold = true }
    )
    vim.api.nvim_set_hl(
        0,
        "Constant",
        { fg = c.theme_colors.Reds.RusticRed, bg = "NONE" }
    )
    vim.api.nvim_set_hl(
        0,
        "Special",
        { fg = c.theme_colors.Grays.DarkGray, bg = "NONE" }
    )
    vim.api.nvim_set_hl(
        0,
        "IDENTIFIER2",
        { fg = M.match.IDENTIFIER2, bg = "NONE" }
    )
    vim.api.nvim_set_hl(
        0,
        "STRING1",
        { fg = M.match.STRING1, bg = "NONE", italic = true }
    )
    vim.api.nvim_set_hl(
        0,
        "STRING2",
        { fg = M.match.STRING2, bg = "NONE", italic = true }
    )
    vim.api.nvim_set_hl(0, "MACRO", { fg = M.match.MACRO, bg = "NONE" })
    vim.api.nvim_set_hl(0, "MYLIB", { fg = M.match.MYLIB, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NAMESPACE", { fg = M.match.NAMESPACE, bg = "NONE" })
    vim.api.nvim_set_hl(0, "TRAIT", { fg = M.match.TRAIT, bg = "NONE" })
    vim.api.nvim_set_hl(0, "TYPE2", { fg = M.match.TYPE2, bg = "NONE" })
    vim.api.nvim_set_hl(0, "ERROR", { fg = M.match.ERROR, bg = "NONE" })
    --
    local function link_highlight(from, to)
        vim.cmd(string.format("highlight! link %s %s", from, to))
    end

    -- unknown -> already defined
    link_highlight("IDENTIFIER", "IDENTIFIER2")
    link_highlight("Function", "FUNCTION")
    link_highlight("Macro", "MACRO")
    link_highlight("LIFETIME", "STRING2")
    link_highlight("VARIANT", "TYPE2")
    link_highlight("@lsp.mod.attribute.rust", "NAMESPACE")
    link_highlight("@lsp.mod.constant.rust", "ORANGE")
    link_highlight("@lsp.type.derive.rust", "TRAIT")
    link_highlight("@lsp.type.enumMember.rust", "VARIANT")
    link_highlight("@lsp.type.interface.rust", "TRAIT")
    link_highlight("@lsp.type.macro.rust", "MACRO")
    link_highlight("@lsp.type.namespace.rust", "NAMESPACE")
    link_highlight("@lsp.type.typeAlias.rust", "TYPE2")
    link_highlight("@lsp.type.unresolvedReference.rust", "ERROR")
    link_highlight("@lsp.typemod.namespace.declaration.rust", "MYLIB")
    link_highlight("@lsp.typemod.method.trait.rust", "TRAIT2")

    link_highlight("@type.builtin.python", "TYPE2")
    link_highlight("@type.python", "TYPE3")
    vim.api.nvim_set_hl(0, "@function.python", { fg = M.match.FUNCTION })
    vim.api.nvim_set_hl(0, "@function.call.python", { fg = M.match.FUNCTION2 })
    vim.api.nvim_set_hl(
        0,
        "@function.method.call.python",
        { fg = M.match.FUNCTION3 }
    )
    vim.api.nvim_set_hl(
        0,
        "@lsp.typemod.keyword.async.rust",
        { fg = M.match.ASYNC }
    )

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
end

return M
