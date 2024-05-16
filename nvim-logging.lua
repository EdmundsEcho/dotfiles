-- nvim-logging.lua
--------------------------------------------------------------------------------
-- Logging that hooks into the vim logging api.
--------------------------------------------------------------------------------

local M = {}

local to_string = {
    [vim.log.levels.TRACE] = "TRACE",
    [vim.log.levels.DEBUG] = "DEBUG",
    [vim.log.levels.INFO] = "INFO",
    [vim.log.levels.WARN] = "WARN",
    [vim.log.levels.ERROR] = "ERROR",
}

-- Function to log a message
function M.log(message, level)
    level = level or vim.log.levels.INFO
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local formatted_message =
        string.format("[%s] [%s] %s", timestamp, to_string[level], message)

    -- grab the location of the current log file
    local logfile = vim.fn.stdpath("log") .. "/custom.log"
    if logfile then
        -- Open logfile in append mode
        local file, err = io.open(logfile, "a")
        if not file then
            -- Handle the error
            vim.api.nvim_echo({
                {
                    "🚫 Failed to open logfile: " .. (err or "Unknown error"),
                },
            }, true, {})
            return -- Exit the function
        end
        file:write(formatted_message .. "\n")
        file:close()
    else
        -- Otherwise just echo to the message area
        vim.api.nvim_echo({ { formatted_message } }, true, {})
    end
end

return M
