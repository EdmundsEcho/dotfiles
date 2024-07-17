-- User-defined functions
--------------------------------------------------------------------------------
---@diagnostic disable: inject-field, undefined-field
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
    { noremap = true, silent = true, desc = "Go to the [0] char" }
)
vim.keymap.set(
    "n",
    "gg",
    ":0<CR>",
    { noremap = true, silent = true, desc = "[g]o [g]o to the top of the buffer" }
)
vim.keymap.set(
    "n",
    "G",
    "G0",
    { noremap = true, silent = true, desc = "[G]o to the end of the buffer" }
)

--------------------------------------------------------------------------------
-- Function trim_whitespace
--------------------------------------------------------------------------------
-- auto command group
local custom_fn_augroup = vim.api.nvim_create_augroup("CustomFnAuGroup", { clear = true })

local function trim_whitespace()
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
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = custom_fn_augroup,
    pattern = "*",
    callback = function()
        if vim.bo.modifiable and not vim.bo.readonly then trim_whitespace() end
    end,
})

--------------------------------------------------------------------------------
-- Function mkdir
-- Description: Automatically creates parent directories if they
--              don't exist when saving a file.
--------------------------------------------------------------------------------
local function mkdir()
    local current_file = vim.fn.expand("<afile>")
    local dir = vim.fn.fnamemodify(current_file, ":p:h")

    if vim.fn.isdirectory(dir) == 0 then
        local choice = vim.fn.confirm("Create a new directory?", "&Yes\n&No", 2)

        if choice == 1 then
            local success, err = pcall(function()
                vim.fn.mkdir(dir, "p")
                vim.notify("Created directory: " .. dir, vim.log.levels.INFO)
            end)
            if not success then
                vim.notify("Failed to create directory: " .. err, vim.log.levels.ERROR)
            end

            vim.cmd("redraw")
        end
    end
end

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    group = custom_fn_augroup,
    pattern = "*",
    callback = mkdir,
})
--------------------------------------------------------------------------------
-- Toggle to project root before returning to where started
--------------------------------------------------------------------------------
local function toggle_to_project_root()
    local original_dir = vim.fn.getcwd()
    local project_nvim = require("project_nvim.project")
    local project_root = project_nvim.get_project_root()
    if project_root == nil then project_root = vim.fn.getcwd() end

    -- Temporarily change to project root
    vim.loop.chdir(project_root)

    -- Invoke Telescope
    require("telescope.builtin").find_files()

    -- Revert back to the original directory
    vim.loop.chdir(original_dir)
end
vim.keymap.set(
    "n",
    "<C-p>",
    function() toggle_to_project_root() end,
    { noremap = true, silent = true, desc = "Ctrl-p to search files" }
)
--------------------------------------------------------------------------------
-- Execute under the cursor command in a terminal
--------------------------------------------------------------------------------
local function exec_on_term()
    local mode = vim.api.nvim_get_mode().mode
    if mode == "normal" then
        vim.cmd('normal! mk"vyip')
    else
        vim.cmd('normal! gv"vy')
    end

    -- Check if terminal exists and open a new one if not
    if not vim.g.last_terminal_chan_id then
        vim.cmd("vsplit")
        vim.cmd("terminal")
        vim.g.last_terminal_chan_id = vim.b.terminal_job_id
        vim.cmd("wincmd p")
    end

    -- Send the command to the terminal
    local command_to_send
    if vim.fn.getreg('"v') == "\n" then
        command_to_send = vim.fn.expand("%:p") .. "\n"
    else
        command_to_send = vim.fn.getreg('"')
    end

    vim.fn.chansend(vim.g.last_terminal_chan_id, command_to_send)
    vim.cmd("normal! `k")
end
-- Create commands and keybindings to increment and decrement opacity
vim.api.nvim_create_user_command("TerminalExe", function() exec_on_term() end, {})

vim.keymap.set(
    "n",
    "<leader><leader>g",
    function() exec_on_term() end,
    { noremap = true, silent = true, desc = "[G]o execute cmd under the cursor" }
)

--------------------------------------------------------------------------------
-- Change the opacity of alacritty
--------------------------------------------------------------------------------
local function update_opacity(increment)
    -- Define the path to your alacritty.toml file
    local alacritty_config_path = os.getenv("XDG_CONFIG_HOME") .. "/alacritty/alacritty.toml"
    if not alacritty_config_path then
        print("Environment variable XDG_CONFIG_HOME is not set.")
        return
    end

    -- Read the contents of the file
    local file = io.open(alacritty_config_path, "r")
    if not file then
        print("Failed to open alacritty.toml")
        return
    end

    local lines = {}
    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()

    -- Update the opacity value
    local new_opacity = nil
    for i, line in ipairs(lines) do
        if line:match("^%s*opacity%s*=%s*") then
            local current_opacity = tonumber(line:match("%d+%.?%d*"))
            if current_opacity then
                new_opacity = current_opacity + increment
                new_opacity = math.max(0, math.min(1, new_opacity)) -- Clamp between 0 and 1
                lines[i] = line:gsub("%d+%.?%d*", string.format("%.3f", new_opacity))
                print("Updated line: " .. lines[i])
            else
                print("Failed to parse current opacity value.")
            end
            break
        end
    end

    if not new_opacity then
        print("Failed to update opacity. No valid opacity value found.")
        return
    end

    -- Write the updated contents back to the file
    file = io.open(alacritty_config_path, "w")
    if not file then
        print("Failed to open alacritty.toml for writing")
        return
    end

    for _, line in ipairs(lines) do
        file:write(line, "\n")
    end
    file:close()

    print("Updated opacity to " .. string.format("%.3f", new_opacity))
end

-- Create commands and keybindings to increment and decrement opacity
vim.api.nvim_create_user_command("IncreaseOpacity", function() update_opacity(0.025) end, {})
vim.api.nvim_create_user_command("DecreaseOpacity", function() update_opacity(-0.025) end, {})

vim.keymap.set(
    "n",
    "<leader><leader>u",
    function() update_opacity(0.025) end,
    { noremap = true, silent = true, desc = "[U]p terminal opacity" }
)
vim.keymap.set(
    "n",
    "<leader><leader>i",
    function() update_opacity(-0.025) end,
    { noremap = true, silent = true, desc = "[I]ncrease terminal transparency" }
)

--------------------------------------------------------------------------------

return M
