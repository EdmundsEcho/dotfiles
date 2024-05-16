--------------------------------------------------------------------------------
-- install Rocks
--------------------------------------------------------------------------------

local M = {}

function M.setup()
    -- Configuration for LuaRocks installation path and binary
    local rocks_config = {
        rocks_path = vim.fn.stdpath("data") .. "/rocks",
        luarocks_binary = "luarocks",
    }

    vim.g.rocks_nvim = rocks_config

    -- Setting Lua module search paths
    local luarocks_path = {
        vim.fs.joinpath(
            rocks_config.rocks_path,
            "share",
            "lua",
            "5.1",
            "?.lua"
        ),
        vim.fs.joinpath(
            rocks_config.rocks_path,
            "share",
            "lua",
            "5.1",
            "?",
            "init.lua"
        ),
    }
    package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

    -- Setting Lua C module search paths
    local luarocks_cpath = {
        vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
        vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    }
    package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

    -- Append LuaRocks package path to Neovim's runtime path
    vim.opt.runtimepath:append(
        vim.fs.joinpath(
            rocks_config.rocks_path,
            "lib",
            "luarocks",
            "rocks-5.1",
            "rocks.nvim",
            "*"
        )
    )
end

return M
