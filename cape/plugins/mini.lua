-- See snacks for another bundle of plugins
return {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        local logger = require("cape.core.nvim-logging")
        logger.log("👉 👉 Loading mini.lua", vim.log.levels.INFO)

        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        require("mini.visits").setup()
    end,
}
