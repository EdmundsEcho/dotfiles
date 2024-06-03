--------------------------------------------------------------------------------
-- neovim > 0.8
-- Use the Lspttach event and UserLspConfig augroup to set up keybindings
-- The handler/callback for the LspAttach triggered autocommand
--
-- Tasks
--  * turn on omni
--  * set keybindings for diagnostics
--  * set formatting and icons of the diagnostic messages
--  * set the buf + lsp specific keybindings to telescope
--  * other?
--------------------------------------------------------------------------------

local M = {}

function M.setup(lsp_attach_group)
local logger = require("cape.core.nvim-logging")
logger.log("Lsp and LspAttach is being configured.", vim.log.levels.DEBUG)
----------------------------------------------------------------------
-- Global mappings.
vim.diagnostic.config({
    virtual_text = {
        prefix = "",
        spacing = 2,
    },
})

----------------------------------------------------------------------
local signs = { Error = "✘ ", Warn = " ", Hint = "⚑ ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

    ----------------------------------------------------------------------
    -- Configure the autocommand group for the LspAttach event
    --
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    --
    ----------------------------------------------------------------------
        lsp_attach_group = lsp_attach_group or "lsp-attach"
        --
        local callback = function(event) -- LspAttach event
            -- Enable completion triggered by <c-x><c-o>
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            logger.log(
                "LspAttach event on client: " .. client.name .. " buf: " .. event.buf,
                vim.log.DEBUG
            )
            vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

            -- local utility
            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
            end

            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-t>.
            map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header.
            map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

            -- Find references for the word under your cursor.
            map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

            -- Fuzzy find all the symbols in your current document.
            --  Symbols are things like variables, functions, types, etc.
            map(
                "<leader>ds",
                require("telescope.builtin").lsp_document_symbols,
                "[D]ocument [S]ymbols"
            )

            -- Fuzzy find all the symbols in your current workspace.
            --  Similar to document symbols, except searches over your entire project.
            map(
                "<leader>ws",
                require("telescope.builtin").lsp_dynamic_workspace_symbols,
                "[W]orkspace [S]ymbols"
            )

            -- Rename the variable under your cursor.
            --  Most Language Servers support renaming across files, etc.
            map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

            -- Opens a popup that displays documentation about the word under your cursor
            --  See `:help K` for why this keymap.
            map("K", vim.lsp.buf.hover, "Hover Documentation")

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            logger.log("👉 Here is client: " .. client.name)
            if client and client.server_capabilities.documentHighlightProvider then
                local highlight_augroup =
                    vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd("LspDetach", {
                    group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                    callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds({
                            group = highlight_augroup,
                            buffer = event2.buf,
                        })
                    end,
                })
            end
            -- The following autocommand is used to enable inlay hints in your
            -- code, if the language server you are using supports them
            --
            -- This may be unwanted, since they displace some of your code
            if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                map(
                    "<leader>tih",
                    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
                    "[T]oggle [I]nlay [H]ints"
                )
            end
        end

        --------------------------------------------------------------------------------
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup(lsp_attach_group, { clear = true }),
            callback = callback,
        })
        --------------------------------------------------------------------------------
end

return M

-- END
