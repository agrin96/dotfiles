return {
    "Isrothy/neominimap.nvim",
    lazy = false,
    version = "v3.*.*",
    enabled = true,
    opts = {},
    keys = {
        -- Buffer-Specific Minimap Controls
        { "<leader>mm", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
        { "<leader>mr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
        { "<leader>mt", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
    },
    init = function()
        vim.g.neominimap = {
			-- Do not enable by default because we just don't need it on a lot of files.
			-- Plus it cuases errors when opening blanks
			auto_enable = false,
            x_multiplier = 2,
            float = {
                window_border = "none",
            },
            click = {
                enabled = true,
            },
            search = {
                enabled = true
            },
            git = {
                enabled = false,
            },
        }
    end,
}
