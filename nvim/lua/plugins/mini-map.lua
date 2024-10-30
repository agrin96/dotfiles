return {
    "Isrothy/neominimap.nvim",
    lazy = false,
    version = "v3.*.*",
    enabled = true,
    opts = {},
    keys = {
        -- Buffer-Specific Minimap Controls
        { "<leader>nm", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
        { "<leader>nr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
    },
    init = function()
        vim.g.neominimap = {
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
