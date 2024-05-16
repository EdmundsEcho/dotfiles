--------------------------------------------------------------------------------
-- Alternative language-specific configuration strategy (using after/ftplugin)
-- Haskell configuration that depends on haskell-tools plugin
-- TODO: Integrate with $HOME/dotfiles/nvim-haskell-extras.vim
--
-- WIP -not yet implemented
--------------------------------------------------------------------------------
local ht = require("haskell-tools")

local bufnr = vim.api.nvim_get_current_buf()
-- set buffer = bufnr in ftplugin/haskell.lua
local opts = { noremap = true, silent = true, buffer = bufnr }

-- defaults
ht.start_or_attach({
    tools = {
        -- haskell-tools options
        codeLens = {
            -- Whether to automatically display/refresh codeLenses
            -- (explicitly set to false to disable)
            autoRefresh = true,
        },
        hoogle = {
            -- 'auto': Choose a mode automatically, based on what is available.
            -- 'telescope-local': Force use of a local installation.
            -- 'telescope-web': The online version (depends on curl).
            -- 'browser': Open hoogle search in the default browser.
            mode = "auto",
        },
        hover = {
            -- Whether to disable haskell-tools hover
            -- and use the builtin lsp's default handler
            disable = false,
            -- Set to nil to disable
            border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            },
            -- Stylize markdown (the builtin lsp's default behaviour).
            -- Setting this option to false sets the file type to markdown and enables
            -- Treesitter syntax highligting for Haskell snippets
            -- if nvim-treesitter is installed
            stylize_markdown = false,
            -- Whether to automatically switch to the hover window
            auto_focus = false,
        },
        definition = {
            -- Configure vim.lsp.definition to fall back to hoogle search
            -- (does not affect vim.lsp.tagfunc)
            hoogle_signature_fallback = false,
        },
        repl = {
            -- 'builtin': Use the simple builtin repl
            -- 'toggleterm': Use akinsho/toggleterm.nvim
            handler = "builtin",
            -- Which backend to prefer if both stack and cabal files are present
            prefer = vim.fn.executable("stack") and "stack" or "cabal",
            builtin = {
                create_repl_window = function(view)
                    -- create_repl_split | create_repl_vsplit | create_repl_tabnew | create_repl_cur_win
                    return view.create_repl_split({ size = vim.o.lines / 3 })
                end,
            },
            -- Can be overriden to either `true` or `false`.
            -- The default behaviour depends on the handler.
            auto_focus = nil,
        },
        -- Set up autocmds to generate tags (using fast-tags)
        -- e.g. so that `vim.lsp.tagfunc` can fall back to Haskell tags
        tags = {
            enable = vim.fn.executable("fast-tags") == 1,
            -- Events to trigger package tag generation
            package_events = { "BufWritePost" },
        },
        dap = {
            cmd = { "haskell-debug-adapter" },
        },
    },
    hls = {
        -- LSP client options
        default_settings = {
            haskell = {
                -- haskell-language-server options
                formattingProvider = "ormolu",
                -- Setting this to true could have a performance impact on large mono repos.
                checkProject = true,
            },
        },
        -- where to find hls project settings
        settings = function(project_root)
            return ht.lsp.load_hls_settings(project_root, {
                settings_file_pattern = "hls.json",
            })
        end,
        on_attach = function(client, bufnr)
            local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
            -- haskell-language-server relies heavily on codeLenses,
            -- so auto-refresh (see advanced configuration) is enabled by default
            vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
            vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
            vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts)
        end,
    },
})

-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<leader>hr", ht.repl.toggle, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>hf", function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
vim.keymap.set("n", "<leader>hq", ht.repl.quit, opts)

-- Detect nvim-dap launch configurations
-- (requires nvim-dap and haskell-debug-adapter)
ht.dap.discover_configurations(bufnr)
