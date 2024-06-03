--------------------------------------------------------------------------------
-- tsserver
-- Used by lspconfig
-- Return M.setup()
--------------------------------------------------------------------------------
-- TODO: configure using typescript.vim plugin that sets up tsserver in a
--       more powerful manner.
--------------------------------------------------------------------------------

local M = {}

M.setup = function(lspattach_au_group)
    local logger = require("cape.core.nvim-logging")
        logger.log("Injecting opts into tsserver ", vim.log.levels.INFO)

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        --
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup(lspattach_au_group, { clear = true }),
            callback = function(event)
                --local helper
                local map = function(keys, func, desc)
                    vim.keymap.set(
                        "n",
                        keys,
                        func,
                        { buffer = event.buf, desc = "LSP: " .. desc }
                    )
                end
                map("ro", ":TSLspOrganize<CR>", "[R]e [O]rganize ")
                map("ga", ":TSLspImportAll<CR>", "[G]o import [A]ll ")
            end,
        })
        -- enable self referencing

        return {
            format = { enable = false },
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
            init_options = {
                disableAutomaticTypingAcquisition = false,
                hostInfo = "neovim",
            },
            root_dir = require("lspconfig.util").root_pattern("package.json"),
            cmd = { "typescript-language-server", "--stdio" },
            on_init = function(client)
                logger.log(
                    "Running on_init tsserver " .. client.name,
                    vim.log.levels.INFO
                )
            end,
        }
end

return M

-- END
