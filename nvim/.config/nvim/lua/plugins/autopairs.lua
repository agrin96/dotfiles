return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function ()
        local npairs = require('nvim-autopairs')
        npairs.setup({
            check_ts = true, -- Enable Treesitter if available
            fast_wrap = {},
        })
    end,
}

