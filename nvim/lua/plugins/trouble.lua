return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    keys = {
        {
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<CR>",
			desc = "Toggle trouble list"
        },
        {
			"<leader>xd",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Open trouble buffer diagnostics"
        },
        {
			"<leader>xq",
			"<cmd>Trouble qflist toggle<CR>",
			desc = "Open trouble quickfixes"
        },
        {
			"<leader>xl",
			"<cmd>Trouble loclist toggle<CR>",
			desc = "Open trouble location list"
        },
        {
			"<leader>xt",
			"<cmd>Trouble todo toggle<CR>",
			desc = "Open todos in trouble"
        },
    },
    opts = {},
}
