--------------------------------------------------------------------------------
-- nvim-lazy.lua
--------------------------------------------------------------------------------
-- Uses lazy.nvim to load plugins as needed.  This said, there are several
-- that need to be eagerly loaded.  They are those plugins with lazy = false.
--
-- The trickiest part has to do with making sure mason, mason-lspconfig and
-- lspconfig work in sequence (one after the other in that sequence).
--------------------------------------------------------------------------------
-- bootstrap lazy
-- check status of plugin
--    :Lazy
--    `?` in the menu for help
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local custom_path = vim.fn.expand("$HOME") .. "/dotfiles/lua"
vim.opt.rtp:prepend(custom_path)

require("lazy").setup({
    { import = "cape.plugins" },
    { import = "cape.plugins.lsp" },
}, {
    checker = {
        enabled = true,
        notify = false,
        frequency = 3600,
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    rtp = {
        -- 🦀 this does not work (I use a symlink instead)
        reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
        ---@type string[]
        paths = {
            vim.fn.expand("$HOME") .. "/dotfiles",
        }, -- add any custom paths here that you want to includes in the rtp
    },
})

-- END
