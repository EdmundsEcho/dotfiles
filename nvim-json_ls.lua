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
    settings = {
        json = {
            schemas = schemas,
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
