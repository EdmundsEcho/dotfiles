--------------------------------------------------------------------------------
-- Linters and formatters without a lsp interface
-- use null_ls as the interface
--------------------------------------------------------------------------------
local M = {}

local logger = require("nvim-logging")

local required_modules = {
    "null-ls",
    "null-ls.utils",
    "telescope.builtin",
    "nvim-capabilities",
    "nvim-handlers",
}

function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. null-ls error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end
    -- vim.opt.completeopt = { "menu", "menuone", "noselect" }
    -- vim.opt.completeopt = { "menu", "menuone", "noinsert" }

    --------------------------------------------------------------------------------
    local nls = require("null-ls")
    --------------------------------------------------------------------------------
    local handlers = require("nvim-handlers")
    local capabilities = require("nvim-capabilities")
    --------------------------------------------------------------------------------
    -- set opts, then call nls.setup(opts)
    local opts = {
        root_dir = require("null-ls.utils").root_pattern(
            ".null-ls-root",
            ".neoconf.json",
            "package.json",
            "Makefile",
            ".git"
        ),
        sources = {
            -- "non-ls.METHOD.TOOL"
            require("none-ls.formatting.jq"),
            require("none-ls.formatting.eslint_d"),
            require("none-ls.code_actions.eslint_d"),
            require("none-ls.diagnostics.eslint_d").with({
                filter = function(diagnostic)
                    return diagnostic.code ~= "prettier/prettier"
                end,
            }),
            -- Make sure mason installs the formatters
            nls.builtins.formatting.sqlfluff.with({
                extra_args = { "--dialect", "postgres" },
            }),
            nls.builtins.diagnostics.sqlfluff.with({
                extra_args = { "--dialect", "postgres" },
            }),
            nls.builtins.formatting.stylua,
            nls.builtins.completion.spell,
            nls.builtins.formatting.prettierd.with({
                env = {
                    PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
                        "~/.config/nvim/utils/linter-config/.prettierrc.json"
                    ),
                },
            }),
        },

        capabilities = capabilities,

        on_attach = function(client, bufnr)
            logger.log(
                "3.🚨 Attaching to " .. client.name,
                vim.log.levels.TRACE
            )
            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end
            local opts = { noremap = true, silent = true }

            -- Keybinding to show code actions
            buf_set_keymap(
                "n",
                "<leader>ca",
                "<cmd>lua vim.lsp.buf.code_action()<CR>",
                opts
            )
            -- fire up the shared-default
            handlers.on_attach(client, bufnr)
        end,
    }
    -- ignore redundant parameter
    ---@diagnostic disable-next-line: redundant-parameter
    nls.setup(opts)
end

return M

-- END
