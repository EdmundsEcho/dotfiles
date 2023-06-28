-- sqlls
return {
    settings = {
        cmd = {
            "sql-language-server",
            "up",
            "--method",
            "stdio",
            "--debug",
            "true",
        },
        filetypes = {
            "sql",
            "mysql",
        },
    },
}
