--------------------------------------------------------------------------------
-- Lualine configuration
--------------------------------------------------------------------------------
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")
        local status_colors = require("cape.core.status-line-colors")
        local theme = require("cape.core.lualine-theme").setup()
        --------------------------------------------------------------------------------
        local function search_result()
            if vim.v.hlsearch == 0 then return "" end
            local last_search = vim.fn.getreg("/")
            if not last_search or last_search == "" or last_search == "\\<filename\\>" then
                return ""
            end
            local searchcount = vim.fn.searchcount({ maxcount = 999 })
            if searchcount.current == 0 and searchcount.total == 0 then return "" end
            return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
        end

        -- Function to return mode icon with dynamic color
        local function mode_icon()
            local icons = {
                n = "📗",
                i = "📙",
                v = "📘",
                [""] = "📘",
                [""] = "📕",
            }
            return icons[vim.fn.mode()]
        end

        -- Function to get the name of the LSP server if available
        local function lsp_server_name()
            local msg = "No Lsp"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_clients()
            if #clients == 0 then return msg end
            for _, client in ipairs(clients) do
                if vim.fn.index(client.config.filetypes, buf_ft) ~= -1 then return client.name end
            end
            return msg
        end

        lualine.setup({
            options = {
                component_separators = "",
                section_separators = "",
                theme = theme,
            },
            sections = {
                lualine_a = {
                    {
                        mode_icon,
                        padding = { left = 1, right = 0 },
                        -- TODO: how know fg takes a function?
                        color = { fg = status_colors.get_mode_color() }, -- Dynamically set color based on mode
                    },
                },
                lualine_b = { "branch" },
                lualine_c = {
                    {
                        "filename",
                        path = 1, -- 0: just filename, 1: relative path, 2: absolute path
                        shorting_target = 40, -- Shorten the path to leave space for other components
                        symbols = {
                            modified = "[+]",
                            readonly = "[-]",
                            unnamed = "[No Name]",
                        },
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = {
                            error = " ",
                            warn = " ",
                            hint = " ",
                            info = " ",
                        },
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    "encoding",
                    {
                        "fileformat",
                        symbols = {
                            unix = "", -- Linux icon
                            dos = "", -- Windows icon
                            mac = "", -- MacOS icon
                        },
                    },
                    "filetype",
                },
                lualine_y = {
                    { lsp_server_name, icon = " " },
                    { search_result },
                    {
                        "progress",
                        color = { fg = status_colors.fg, gui = "bold" },
                    },
                },
            },
            -- when the window is inactive
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}

-- END
