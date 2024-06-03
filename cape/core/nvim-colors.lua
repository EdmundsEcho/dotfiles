local M = {}

M.colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  blue = "#51afef",
  cyan = "#008080",
  dark_blue = "#4784DF",
  dark_red = "#CF745D",
  darkblue = "#081633",
  gray = "#808080",
  green = "#78b830",
  light_purple = "#A270A7",
  light_purple2 = "#ab8ac1",
  magenta = "#c678dd",
  muted_blue = "#83A8C1",
  muted_brown = "#A07A2F",
  muted_green = "#609326",
  muted_purple = "#BA5D7E",
  muted_yellow = "#A79414",
  orange = "#D4AC0D",
  purple = "#8048b0",
  -- red           = '#ec5f67',
  red = "#FF5F55",
  turquoise = "#78c0b0",
  violet = "#a9a1e1",
  -- yellow        = '#ECBE7B',
  yellow = "#D0C050",
}

M.theme_colors = {
  Blues = {
    LightBlue = "#51afef",
    Cyan = "#008080",
    DarkBlue = "#4784DF",
    NavyBlue = "#081633",
    MutedBlue = "#83A8C1",
    SkyBlue = "#4F78C2",
    Turquoise = "#64b4dc",
    Comment = "#609199",
    Visual = "#00e6e6",
  },
  Greens = {
    SpringGreen = "#78b830",
    MossGreenDark = "#609326",
    MossGreen = "#7db74d",
    Turquoise = "#78c0b0",
    String = "#72cf7b",
    Army = "#8ca375",
  },
  Purples = {
    LightPurple = "#A270A7",
    LighterPurple = "#ab8ac1",
    Magenta = "#c678dd",
    DeepPurple = "#8048b0",
    MutedPurple = "#BA5D7E",
    Violet = "#a9a1e1",
  },
  Reds = {
    DarkRed = "#CF745D",
    BrightRed = "#cc544b",
    Pink = "#ffa0a0",
    DimPink1 = "#f28b8b",
    DimPink2 = "#e67e7e",
    RusticRed = "#C06050",
  },
  Yellows = {
    SolarFlare = "#ffff00",
    LemonChiffon = "#f5e77d",
    GoldenRay = "#DBd263",
    HarvestGold = "#D0C050",
    OliveTwist = "#B9BA1E",
    BronzeDawn = "#CBAA46",
    AncientGold = "#bc990c",
    MutedYellow = "#A79414",
  },
  Browns = {
    Orange = "#D4AC0D",
    RicherOrange = "#D78A0F",
    VibrantOrange = "#DB7C0A",
    MutedBrown = "#A07A2F",
    SearchOrangeBg = "#45413B",
    SearchOrangeFg = "#ffa724",
  },
  Grays = {
    GraniteGray = "#505050",
    DarkGray = "#878787",
    GrayCloud = "#A8A8A8",
    SteelGray = "#ccdddd",
    NearBlack = "#202020",
    Black = "#212121",
    Black2 = "#121212",
    PureBlack = "#000000",
    White = "#c8c8c8",
    WhiteYellow = "#ccc1b7",
    WhiteRed = "#cc9999",
    WhiteGreen = "#aaffaa",
    PureWhite = "#ffffff",
    WindowBg = "#1c1c1c",
  },
  Luci = {
    PrimaryMain = "#52A5B8",
    PrimaryMainDark = "#19788E",
    SecondaryMain = "#FFA868",
    SecondaryMainDark = "#F17417",
  },
}

M.elements = {
  Search = {
    Search = { ctermfg = 214, ctermbg = 238, fg = "#ffa724", bg = "#45413b" },
    CurSearch = { ctermfg = 238, ctermbg = 214, fg = "#ffa724", bg = "#45413b" },
  },
  Fidget = { bg = M.theme_colors.Grays.WindowBg },
  VertSplit = {
    fg = M.theme_colors.Luci.PrimaryMain,
    bg = M.theme_colors.Grays.NearBlack,
  },
  Cursor = {
    Cursor = {
      ctermfg = 214,
      ctermbg = 238,
      bg = M.theme_colors.Luci.PrimaryMain,
      fg = M.theme_colors.Grays.White,
    },
    lCursor = {
      ctermfg = 214,
      ctermbg = 238,
      bg = M.theme_colors.Luci.PrimaryMain,
      fg = M.theme_colors.Grays.White,
    },
  },
}

M.load_colors = function()
  for _, colors in pairs(M.theme_colors) do
    for name, hex in pairs(colors) do
      vim.api.nvim_set_hl(0, name, { fg = hex })
    end
  end
end

return M

-- END
