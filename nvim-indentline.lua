-- nvim-lspconfig.lua
local M = {}

local required_modules = {
    "ibl",
    "ibl.hooks",
}

function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. lspconfig error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end
    local hooks = require("ibl.hooks")

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "Whitespace", { fg = "#444444", bg = "NONE" })
    end)

    hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level
    )

    local opts = {
        debounce = 300,
        indent = {
            char = "┊",
            highlight = { "Whitespace" },
            smart_indent_cap = true,
            priority = 2,
            repeat_linebreak = false,
        },
        scope = { enabled = false },
        exclude = {
            filetypes = {
                "haskell",
                "json",
                "yaml",
                "cabal",
                "markdown",
                "pandoc",
                "text",
                "txt",
                "sh",
                "vim",
                "tmux",
                "help",
            },
        },
    }
    require("ibl").setup(opts)
end

return M

-- END
