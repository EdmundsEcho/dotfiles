--------------------------------------------------------------------------------
-- conform formatting plugin manager
-- Note: custom keybindings included here.
--
-- Debugging formatter notes:
-- * formatters are stored in ~/.local/shared/nvim/mason/bin
-- * to learn where the config being used:
--      -> in the terminal stylua --verbose <some test files>
--
-- <leader>f to engage formatting
-- <leader>Fc to print out the active formatter
--
--------------------------------------------------------------------------------
local logger = require("nvim-logging")

--------------------------------------------------------------------------------
-- formatting configuration file location
-- Note: Generally, useful to provide a global version as a fallback for when a
-- project-specific configuration is not present.
--------------------------------------------------------------------------------
-- Build out the list of configuration files
local stylua_cfg_file = vim.fn.expand("~/.stylua.toml")
local rust_cfg_file = vim.fn.expand("~/.rustfmt.toml")
-- prettierd uses PRETTIERD_DEFAULT_CONFIG
-- jq and ruff-lsp do not have configuration files
-- ruff configuration is set in a project. I'm not confident that specifying in
-- call ruff will not override the project.

--------------------------------------------------------------------------------
-- local helpers
--------------------------------------------------------------------------------
local function rpt(formatter)
    if type(formatter) ~= "table" then return "Invalid formatter data provided." end

    local report = (formatter.name or "Non-name") .. "\n"
    -- Command
    report = report .. "Command: " .. (formatter.command or "N/A") .. "\n"
    -- Current Working Directory (cwd)
    report = report .. "Current Working Directory: " .. (formatter.cwd or "N/A") .. "\n"
    -- Availability
    local availability = formatter.available and "Yes" or "No"
    report = report .. "Available: " .. availability .. "\n"

    return report
end

--------------------------------------------------------------------------------
-- Start loading and configuring the plugin
--------------------------------------------------------------------------------
local ok, conform = pcall(require, "conform")
if not ok then
    local msg = "Failed to load the conform plugin."
    vim.notify(msg, vim.log.levels.ERROR)
    if logger then logger.log(msg, vim.log.levels.ERROR) end
else
    --------------------------------------------------------------------------------
    local conform_format_params = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    }
    --------------------------------------------------------------------------------
    -- run formatting on demand with  <leader>f
    -- Note: this is not a lsp-specific configuration (unlike handlers)
    --------------------------------------------------------------------------------
    vim.keymap.set(
        { "n", "v" },
        "<leader>f",
        function()
            conform.format({
                lsp_fallback = true,
                async = true,
                timeout_ms = 500,
            })
        end,
        {
            desc = "[F]ormat buffer",
            noremap = true,
            silent = true,
        }
    )
    --------------------------------------------------------------------------------
    -- List the available formatters with <leader>Fc
    --------------------------------------------------------------------------------
    vim.keymap.set({ "n" }, "<leader>Fc", function()
        local formatters = conform.list_formatters()
        local msg = "Formatters:\n"
        for i, formatter in ipairs(formatters) do
            if type(formatter) == "table" then
                msg = msg .. rpt(formatter)
            else
                -- Fallback if formatter is not a table
                msg = msg .. tostring(formatter) .. "\n"
            end
            if i < #formatters then msg = msg .. "\n" end
            if logger then logger.log(msg) end
            vim.notify(msg)
        end
    end, { noremap = true, silent = true })

    --------------------------------------------------------------------------------
    -- 💢 set opts for the plugin
    --------------------------------------------------------------------------------
    conform.setup({
        -- These options will be passed to conform.format()
        notify_on_error = false,
        format_on_save = conform_format_params,
        formatters = {
            stylua = {
                prepend_args = { "--config-path", stylua_cfg_file },
            },
            rustfmt = {
                prepend_args = { "--config-path", rust_cfg_file },
            },
        },
        formatters_by_ft = {
            javascript = { { "prettierd", "prettier" } }, -- first available
            typescript = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            json = { "jq", "prettierd" },
            graphql = { { "prettierd", "prettier" } },
            yaml = { { "prettierd", "prettier" } },
            markdown = { { "prettierd", "prettier" } },
            lua = { "stylua" },
            python = {
                "ruff-lsp", --[["isort", "black"]]
            }, -- in sequence
            haskell = {
                "ormolu", --[["stylish-haskell"]]
            },
        },
    })
end

-- END
