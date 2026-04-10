return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    config = function ()
        local whichkey = require('which-key')
        whichkey.setup({preset = 'helix'})
        whichkey.add({
            {'<leader>g', group = 'git operations'},
            {'<leader>f', group = 'pickers'},
            {'<leader>w', group = 'manage workspace sessions'},
            {'gr', group = 'code actions'}
        })
    end
}
