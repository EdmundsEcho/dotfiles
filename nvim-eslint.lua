--------------------------------------------------------------------------------
-- Eslint
-- Sets global access to vim (prevents warning)
-- DEPRECATE for now
--------------------------------------------------------------------------------
return {
    settings = {
        enable = true,
        format = { enable = true }, -- this will enable formatting
        packageManager = "yarn",
        autoFixOnSave = true,
        codeActionsOnSave = {
            mode = "all",
            rules = { "!debugger", "!no-only-tests/*" },
        },
        lintTask = {
            enable = true,
        },
    },
}
