--------------------------------------------------------------------------------
-- fidgets
-- Used by lspconfig as a dependent
--------------------------------------------------------------------------------
return {
    "j-hui/fidget.nvim",
    opts = {
        window = {
            normal_hl = "Fidget",
            winblend = 1,
        },
        -- {
        --   normal_hl = "Fidget",     -- Base highlight group in the notification window
        --   winblend = 1,             -- Background color opacity in the notification window
        --   border = "none",          -- Border around the notification window
        --   zindex = 45,              -- Stacking priority of the notification window
        --   max_width = 0,            -- Maximum width of the notification window
        --   max_height = 0,           -- Maximum height of the notification window
        --   x_padding = 1,            -- Padding from right edge of window boundary
        --   y_padding = 0,            -- Padding from bottom edge of window boundary
        --   align = "bottom",         -- How to align the notification window
        --   relative = "editor",      -- What the notification window position is relative to
        -- }

        --fidget.option.notification.window = {
        --    normal_hl = "Fidget", -- Base highlight group in the notification window
        --    winblend = 10, -- Background color opacity in the notification window
        --    border = "solid", -- Border around the notification window
        --    zindex = 45, -- Stacking priority of the notification window
        --    max_width = 0, -- Maximum width of the notification window
        --    max_height = 0, -- Maximum height of the notification window
        --    x_padding = 1, -- Padding from right edge of window boundary
        --    y_padding = 0, -- Padding from bottom edge of window boundary
        --    align = "bottom", -- How to align the notification window
        --    relative = "editor", -- What the notification window position is relative to
        --}
    },
}

-- END
