-- nvim-formatting.lua
----------------------------------------------------------------------------
-- Formatting
-- If you have not already tweaked it in the lsp client configurations
-- this might be useful.
--
-- Also, coordinate with conform.
--
----------------------------------------------------------------------------
--
---@diagnostic disable-next-line: unused-local, unused-function
local function ormolu()
    return {
        exe = "ormolu", -- executable name, ensure it's in your PATH
        args = { "--stdin-input-file", vim.api.nvim_buf_get_name(0) }, -- arguments
        stdin = true,
    }
end

local function stylish_haskell()
    return {
        exe = "stylish-haskell",
        args = {},
        stdin = true,
    }
end

local opts = {
    ----------------------------------------------------------------------------
    -- This may not be required
    -- Many parsers ship with prettierd, including JavaScript,
    -- TypeScript, GraphQL, CSS, HTML and YAML.
    ----------------------------------------------------------------------------
    filetype = {
        javascript = {
            -- prettierd
            function()
                return {
                    exe = "prettierd",
                    args = { vim.api.nvim_buf_get_name(0) },
                    stdin = true,
                }
            end,
        },
        haskell = {
            -- Set to use stylish-haskell or ormolu
            stylish_haskell, -- Uncomment this to use stylish-haskell
            -- ormolu,        -- Uncomment this to use ormolu
        },
    },
    logging = false, -- equivalent to autoformat_verbosemode
    log_level = vim.log.levels.INFO,
}

-- Set keybindings to format your code in Neovim
vim.api.nvim_set_keymap(
    "n",
    "<leader>f",
    ":Format<CR>",
    { noremap = true, silent = true }
)

---@diagnostic disable-next-line: undefined-field
require("formatter").setup(opts)

-- END
