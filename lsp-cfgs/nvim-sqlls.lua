-- sqlls
-- TODO: Not yet referenced
--
local M = {}

M.setup = function()
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
end

return M
