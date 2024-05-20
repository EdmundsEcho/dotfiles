--------------------------------------------------------------------------------
-- rustaceanvim - Augmented lsp languages
--              - includes options sent to rust_analyzer
--------------------------------------------------------------------------------
-- Provides access to the extra information provided by the rust
--------------------------------------------------------------------------------
--
local M = {}

local required_modules = {
    "lspconfig",
    "mason-registry",
    "rustaceanvim.config",
    "nvim-lsp-handler",
    "nvim-capabilities",
}

local logger = require("nvim-logging")

function M.setup()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format("x %s not found. Rustacean error: %s", module_name, err),
                vim.log.levels.ERROR
            )
        end
    end
    ----------------------------------------------------------------------------
    -- creates autogroup that responds to LspAttach event
    require("nvim-lsp-handler")()
    ----------------------------------------------------------------------------
    local capabilities = require("nvim-capabilities")
    local util = require("lspconfig/util")
    --------------------------------------------------------------------------------
    -- New codelldb; find its path so we can send it to dap
    local mason_registry = require("mason-registry")
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = codelldb:get_install_path() .. "/extension"
    local codelldb_path = extension_path .. "/adapter/codelldb"
    local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"
    local this_os = vim.uv.os_uname().sysname
    --------------------------------------------------------------------------------
    -- The path is different on Windows
    if this_os:find("Windows") then
        codelldb_path = extension_path .. "adapter\\codelldb.exe"
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    else
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
    end

    ----------------------------------------------------------------------------
    -- 💢 mutate vim.g.rustaceanvim with cfg settings
    ----------------------------------------------------------------------------
    local cfg = require("rustaceanvim.config")
    vim.g.rustaceanvim = {
        -- use default options
        dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            initCommands = function()
                logger.log("Setting up dap codelldb commands", vim.log.level.INFO)
                -- Find out where to look for the pretty printer
                local rustc_sysroot =
                    vim.fn.trim(vim.fn.system("rustc --print sysroot"))

                local script_import = 'command script import "'
                    .. rustc_sysroot
                    .. '/lib/rustlib/etc/lldb_lookup.py"'

                local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

                local commands = {}
                local file = io.open(commands_file, "r")
                if file then
                    for line in file:lines() do
                        table.insert(commands, line)
                    end
                    file:close()
                end
                table.insert(commands, 1, script_import)

                return commands
            end,
        },
        tools = {
            -- rust-tools options
            autoSetHints = true,
            inlay_hints = {
                show_parameter_hints = true,
                parameter_hints_prefix = "",
                other_hints_prefix = "",
            },
            -- options same as lsp hover / vim.lsp.util.open_floating_preview()
            hover_actions = {
                auto_focus = true,
            },
        },
        -- all the options to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
        server = {
            capabilities = capabilities,
            filetypes = { "rust" },
            root_dir = util.root_pattern("Cargo.toml"),
            settings = {
                -- to enable rust-analyzer settings visit:
                -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                ["rust-analyzer"] = {
                    -- enable clippy on save
                    cargo = {
                        allFeatures = true,
                        -- loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    procMacro = { enable = true },
                    diagnostics = {
                        enable = true,
                        disabled = { "unresolved-proc-macro" },
                        enableExperimental = true,
                    },
                    completion = {
                        postfix = {
                            enable = false,
                        },
                    },
                    checkOnSave = {
                        command = "clippy",
                    },
                },
            },
        },
    }
end

return M

-- END
