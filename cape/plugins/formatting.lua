--------------------------------------------------------------------------------
-- Formatting manager
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
return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    dependencies = { "nvim-lua/plenary.nvim", },
    config = function() 

        local logger = require("cape.core.nvim-logging")
        
        --------------------------------------------------------------------------------
        -- formatting configuration file location
        -- Note: Generally, useful to provide a global version as a fallback for when a
        -- project-specific configuration is not present.
        --------------------------------------------------------------------------------
        -- Build out the list of configuration files
        local stylua_cfg_file = vim.fn.expand("~/.stylua.toml")
        local rust_cfg_file = vim.fn.expand("~/.rustfmt.toml")
        local taplo_cfg_file = vim.fn.expand("~/.taplo.toml")
        -- prettierd uses PRETTIERD_DEFAULT_CONFIG
        -- jq and ruff-lsp do not have configuration files
        -- ruff configuration is set in a project. I'm not confident that specifying in
        -- call ruff will not override the project.
        
        --------------------------------------------------------------------------------
        -- A custom status report regarding the active formatter used to help identify
        -- the loaded settings.
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
        --------------------------------------------------------------------------------
        -- custom format on save that reads toggled status of the service
        local format_on_save = function(bufnr)
            -- Skip when disabled
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
            return {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            }
        end
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
                    async = false,
                    timeout_ms = 1000,
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
        end, {
            desc = "[F]ormat [c]onfig - current formatter",
            noremap = true,
            silent = true,
        })
        --------------------------------------------------------------------------------
        -- 💢 Change buffer or global formatting to on or off
        -- NOTE: Requires the format_on_save setting read the setting.
        --------------------------------------------------------------------------------
        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                ---@diagnostic disable-next-line: inject-field
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
            ---@diagnostic disable-next-line: inject-field
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })

        vim.keymap.set({ "n", "v" }, "<leader>tf", function()
            if vim.b.disable_autoformat then
                vim.cmd("FormatEnable")
            else
                vim.cmd("FormatDisable!")
            end
        end, {
            desc = "[T]oggle on-off [F]ormat on save",
            noremap = true,
            silent = true,
        })
        require("conform").setup({
            -- These options will be passed to conform.format()
            log_level = vim.log.levels.INFO,
            -- Conform will notify you when a formatter errors
            notify_on_error = true,
            format_on_save = format_on_save,
            formatters = {
                stylua = {
                    autosave = 1,
                    prepend_args = { "--config-path", stylua_cfg_file },
                },
                taplo = {
                    autosave = 1,
                    command = "taplo",
                    args = { "format", "-", "--config", taplo_cfg_file },
                },
            },
            formatters_by_ft = {
                css = { { "prettierd", "prettier" } },
                graphql = { { "prettierd", "prettier" } },
                fish = { "fish_indent" },
                haskell = { "ormolu" },
                html = { { "prettierd", "prettier" } },
                javascript = { { "prettierd", "prettier" } }, -- first available
                json = { "jq", "prettierd" },
                lua = { "stylua" },
                markdown = { { "prettierd", "prettier" } },
                python = { "ruff" }, -- in sequence
                toml = { "taplo" },
                typescript = { { "prettierd", "prettier" } },
                yaml = { { "prettierd", "prettier" } },
            },
        })

  end,
}
-- END





