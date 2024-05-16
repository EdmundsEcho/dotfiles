--------------------------------------------------------------------------------
-- dap
--------------------------------------------------------------------------------
local M = {}

local required_modules = {
    "neodev",
    "dap",
    "dapui",
}

--wrap the following code in a setup function associated with M
M.setup = function()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. Dap error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end

    local plugin = require("dapui")
    plugin.setup()
    --------------------------------------------------------------------------------

    -- type checking for nvim-dap-ui
    require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
    })
    --------------------------------------------------------------------------------
    local dap, dapui = require("dap"), require("dapui")
    dap.configurations.rust = {
        {
            externalConsole = true,
        },
    }
    dap.defaults.fallback.external_terminal = {
        command = "/Applications/Alacritty.app/Contents/MacOS/alacritty",
        args = { "-e" },
    }
    dap.defaults.fallback.switchbuf = "usetab,uselast"

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    vim.keymap.set(
        "n",
        "<Leader>dt",
        ":DapToggleBreakpoint<CR>",
        { noremap = true }
    )
    vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>", { noremap = true })
    vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>", { noremap = true })
    vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>", { noremap = true })
    vim.keymap.set("n", "<Leader>di", ":DapStepInto<CR>", { noremap = true })
    vim.keymap.set(
        "n",
        "<Leader>dr",
        ":lua require('dapui').open({reset = true})<CR>",
        { noremap = true }
    )
end

return M

-- END
