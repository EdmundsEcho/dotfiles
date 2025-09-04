-- nvim-logging.lua
--------------------------------------------------------------------------------
-- Logging that hooks into the vim logging api.
--------------------------------------------------------------------------------

local M = {}

-- default logfile path
local logfile = vim.fn.stdpath("log") .. "/user.log"

local to_string = {
    [vim.log.levels.TRACE] = "TRACE",
    [vim.log.levels.DEBUG] = "DEBUG",
    [vim.log.levels.INFO] = "INFO",
    [vim.log.levels.WARN] = "WARN",
    [vim.log.levels.ERROR] = "ERROR",
}

-- Function to set a custom log file location
-- @param path (string) The new log file path
-- @raises Error if provided with an invalid path
function M.set_logfile(path)
    if type(path) == "string" and path ~= "" then
        logfile = path
    else
        error("Invalid path. Please provide a valid string for the log file path.")
    end
end

-- Function to get the current log file location
-- @return (string) The current log file path
function M.get_logfile() return logfile end

-- Function to log a message with a specific log level
-- @param message (string) The message to log
-- @param level (number) The log level (e.g., vim.log.levels.ERROR)
-- @raises Error if unable to open the log file for writing-
function M.log(message, level)
    level = level or vim.log.levels.INFO

    -- Get caller information
    local info = debug.getinfo(2, "Sl")
    local module = info.short_src or "unknown"
    local line = info.currentline or "unknown"

    -- Format the log message
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local formatted_message =
        string.format("[%s] [%s] [%s:%d] %s", timestamp, to_string[level], module, line, message)

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
