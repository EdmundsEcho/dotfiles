-- User-defined functions
--------------------------------------------------------------------------------
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
--------------------------------------------------------------------------------
-- Globally available function
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Function used in autocommands
--------------------------------------------------------------------------------
local M = {}

-- exclude these filetypes from white space function
vim.g.user_trimwhite_off = { "markdown", "pandoc" }

-- Go to the beginning of a line (without using single `0`)
function M.GoToFrontLine()
    local col_num_cursor = vim.fn.col(".")
    local row_num_cursor = vim.fn.line(".")
    local col_num_front = vim.fn.indent(vim.fn.line("."))

    if col_num_cursor ~= (1 + col_num_front) then
        vim.fn.cursor(row_num_cursor, col_num_front + 1) -- default
    else
        vim.fn.cursor(row_num_cursor, 1) -- go to the very front
    end
end

-- Line Navigation
vim.keymap.set(
    "n",
    "0",
    function() M.GoToFrontLine() end,
    { noremap = true, silent = true, desc = "G[0] to the front of the line" }
)

map("n", "gg", ":0<CR>", opts)
map("n", "G", "G0", opts)

-- Function to Remove Trailing Whitespace
function M.TrimWhitespace()
    local current_filetype = vim.bo.filetype

    -- Check if filetype should be ignored
    if vim.tbl_contains(vim.g.user_trimwhite_off, current_filetype) then
        vim.notify("Cancelled: user-defined TrimWhitespace()", vim.log.levels.INFO)
        return
    end

    -- Save and Restore Cursor Position
    local save_cursor = vim.fn.getpos(".")

    -- Try to Remove Trailing Whitespace and catch any error
    local ok, err = pcall(function() vim.cmd("%s/\\s\\+$//e") end)
    if not ok then vim.notify("Error removing whitespace: " .. err, vim.log.levels.ERROR) end

    -- Restore Cursor Position
    vim.fn.setpos(".", save_cursor)
end

-- Autocommand for the function
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function()
        if vim.bo.modifiable and not vim.bo.readonly then
            -- safe to try and trim off whitespace
            local fns = require("cape.core.nvim-lua-functions")
            if fns and fns.TrimWhitespace then
                fns.TrimWhitespace()
            else
                vim.notify("TrimWhitespace function not found", vim.log.levels.ERROR)
            end
        end
    end,
})

-- Function: MkDir
-- Description: Automatically creates parent directories if they
--              don't exist when saving a file.
function M.MkDir()
    local dir_path = vim.fn.expand("<afile>:p:h")
    if not vim.fn.isdirectory(dir_path) then
        local choice = vim.fn.confirm("Create a new directory?", "&Yes\n&No", 2)
        if choice == 1 then
            local success, err = pcall(function()
                vim.fn.mkdir(dir_path, "p")
                vim.cmd("lcd " .. dir_path)
                vim.cmd("write") -- Assuming you want to save the current file.
                vim.notify("Created and moved to new directory: " .. dir_path)
            end)

            if not success then
                vim.notify("Failed to create directory: " .. err, vim.log.levels.ERROR)
            end

            vim.cmd("redraw")
        end
    end
end

-- Autocommand for the function
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function()
        local fns = require("cape.core.nvim-lua-functions")
        if fns and fns.MkDir then
            fns.MkDir()
        else
            vim.notify("MkDir function not found", vim.log.levels.ERROR)
        end
    end,
})

return M
