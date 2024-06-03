return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>s", substitute.operator, { desc = "[S]ubstitute with motion" })
    keymap.set("n", "<leader>ss", substitute.line, { desc = "[S]ubstitute line" })
    keymap.set("n", "<leader>S", substitute.eol, { desc = "[S]ubstitute to end of line" })
    keymap.set("x", "<leader>s", substitute.visual, { desc = "[S]ubstitute in visual mode" })
  end,
}
