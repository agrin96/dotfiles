return {
    "gbprod/substitute.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local subs = require("substitute")
        subs.setup()

        -- Plugin does not provide default keymaps so they are required
        local keymap = vim.keymap
        vim.keymap.set("n", "s", require('substitute').operator, { desc = "Substitue line motion" })
        vim.keymap.set("n", "ss", require('substitute').line, { desc = "Substitute line" })
        vim.keymap.set("n", "S", require('substitute').eol, { desc = "Substitute to end of line" })
        vim.keymap.set("x", "s", require('substitute').visual, { desc = "Substitute in visual mode" })
    end,
}
