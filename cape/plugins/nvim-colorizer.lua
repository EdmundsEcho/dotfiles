return {
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    opts = {
        html = {
            mode = "foreground",
        },
        lua = {
            mode = "foreground",
        },
        css = {
            mode = "foreground",
        },
        javascript = {
            mode = "foreground",
        },
        tmux = {
            mode = "foreground",
        },
        conf = {
            mode = "foreground",
        },
    },
}
