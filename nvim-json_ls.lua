--------------------------------------------------------------------------------
-- json ls configuration
-- Utilized by nvim-lspconfig
-- ref setup to get opts table
--------------------------------------------------------------------------------
local M = {}

local required_modules = {
    "lspconfig",
    "nvim-handlers",
    "nvim-capabilities",
}

M.setup = function()
    for _, module_name in ipairs(required_modules) do
        local ok, err = pcall(require, module_name)
        if not ok then
            vim.notify(
                string.format(
                    "👎 %s not found. json_ls error: %s",
                    module_name,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end

    local handlers = require("nvim-handlers")
    local capabilities = require("nvim-capabilities").capabilities

    local schemas = {
        {
            description = "TypeScript compiler configuration file",
            fileMatch = {
                "tsconfig.json",
                "tsconfig.*.json",
            },
            url = "https://json.schemastore.org/tsconfig.json",
        },
        {
            title = "Alacritty Configuration",
            description =
            "Configuration schema for [Alacritty](https://github.com/alacritty/alacritty), the GPU enhanced terminal emulator",
            fileMatch = {
                "alacritty.yml",
                "alacritty.yaml",
                ".alacritty.yml",
                ".alacritty.yaml",
            },
            url = "https://raw.githubusercontent.com/distinction-dev/alacritty-schema/main/alacritty/reference.json",
        },
        {
            description = "JSON schema for ESLint configuration files",
            fileMatch = {
                ".eslintrc",
                ".eslintrc.json",
            },
            url = "https://json.schemastore.org/eslintrc.json",
        },
        {
            description = "JSON schema for Prettier configuration files",
            fileMatch = {
                ".prettierrc",
                ".prettierrc.json",
            },
            url = "https://json.schemastore.org/prettierrc.json",
        },
        {
            description = "JSON schema for NPM package.json files",
            fileMatch = {
                "package.json",
            },
            url = "https://json.schemastore.org/package.json",
        },
    }

    local opts = {
        capabilities = capabilities,
        on_attach = handlers.on_attach,
        settings = {
            json = {
                schemas = schemas,
                validate = { enable = true },
            },
        },
        setup = {
            commands = {
                Format = {
                    function()
                        vim.lsp.buf.range_formatting(
                            {},
                            { 0, 0 },
                            { vim.fn.line("$"), 0 }
                        )
                    end,
                },
            },
        },
    }
    return opts
end

return M.setup()

-- END
