return {
    "iamcco/markdown-preview.nvim",
    event = "BufRead",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install", -- install within ~/.local/share/nvim/lazy/markdown-preview.nvim/app
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
    config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_refresh_slow = 0
        vim.g.mkdp_command_for_global = 1
        vim.g.mkdp_open_to_the_world = 0
        vim.g.mkdp_open_ip = ""
        vim.g.mkdp_browser = ""
        vim.g.mkdp_echo_preview_url = 1
    end,
}
