
        eslint = {
            settings = {
                enable = true,
                format = { enable = false },
                packageManager = "yarn",
                autoFixOnSave = true,
                codeActionsOnSave = {
                    mode = "all",
                    rules = { "!debugger", "!no-only-tests/*" },
                },
                lintTask = { enable = true },
            },
        },
        sqlls = {
            settings = {
                cmd = {
                    "sql-language-server",
                    "up",
                    "--method",
                    "stdio",
                    "--debug",
                    "true",
                },
                filetypes = { "sql", "mysql" },
            },
        },
