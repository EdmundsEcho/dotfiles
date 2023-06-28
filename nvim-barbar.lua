--------------------------------------------------------------------------------
-- barbar tab
--------------------------------------------------------------------------------
local plugin = require("barbar")
--------------------------------------------------------------------------------
plugin.setup({
    icons = {
        -- Configure the base icons on the bufferline.
        -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
        buffer_index = false,
        buffer_number = false,
        button = "×",
        -- Enables / disables diagnostic symbols
        separator = { left = "|", right = "" },
        inactive = { button = "×" },

        -- Configure the icons on the bufferline based on the visibility of a buffer.
        -- Supports all the base icon options, plus `modified` and `pinned`.
        alternate = { filetype = { enabled = false } },
        current = { buffer_index = true },
        visible = { modified = { buffer_number = false } },
    },
})
