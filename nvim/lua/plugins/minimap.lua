return {
    "Isrothy/neominimap.nvim",
    lazy = false,
    version = "v3.*.*",
    enabled = true,
    opts = {},
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
