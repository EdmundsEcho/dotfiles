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
--
-- log to vim that we are attaching to a client
local logger = require("nvim-logging")
logger.log("Lsp and LspAttach is being configured.", vim.log.DEBUG)

local M = {}

function M.setup()
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

    -- using <leader>k
    vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next)

    -- set the diagnostic formatting
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = false,
            update_in_insert = false,
            virtual_text = true,
        })

    -- helper
    local function sign_define(args)
        vim.fn.sign_define(args.name, {
            texthl = args.name,
            text = args.text,
            numhl = "",
        })
    end

    -- Coordinate with lualine
    local signs = {
        Error = ">>",
        Warn = " ",
        Hint = " ✓",
        Info = " ",
    }
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN] = "▲",
                [vim.diagnostic.severity.HINT] = "⚑",
                [vim.diagnostic.severity.INFO] = "»",
            },
        },
    })
    -- Configure the autocommand group for the LspAttach event
    --
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    --
    return function(lsp_attach_group)
        lsp_attach_group = lsp_attach_group or "kickstart-lsp-attach"
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
                vim.keymap.set(
                    "n",
                    keys,
                    func,
                    { buffer = event.buf, desc = "LSP: " .. desc }
                )
            end

            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-t>.
            map(
                "gd",
                require("telescope.builtin").lsp_definitions,
                "[G]oto [D]efinition"
            )

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header.
            map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

            -- Find references for the word under your cursor.
            map(
                "gr",
                require("telescope.builtin").lsp_references,
                "[G]oto [R]eferences"
            )

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            map(
                "gI",
                require("telescope.builtin").lsp_implementations,
                "[G]oto [I]mplementation"
            )

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            map(
                "<leader>D",
                require("telescope.builtin").lsp_type_definitions,
                "Type [D]efinition"
            )

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
                local highlight_augroup = vim.api.nvim_create_augroup(
                    "kickstart-lsp-highlight",
                    { clear = false }
                )
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
                    group = vim.api.nvim_create_augroup(
                        "kickstart-lsp-detach",
                        { clear = true }
                    ),
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
            if
                client
                and client.server_capabilities.inlayHintProvider
                and vim.lsp.inlay_hint
            then
                map(
                    "<leader>th",
                    function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end,
                    "[T]oggle Inlay [H]ints"
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
end

return M.setup()

-- END
--[[
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set(
            "n",
            "<space>wl",
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            opts
        )
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set(
            "n",
            "<space>f",
            function() vim.lsp.buf.format({ async = true }) end,
            opts
        )

--]]
