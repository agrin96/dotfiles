return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local lualine = require("lualine")
        lualine.setup({
            options = {
                -- theme = "iceberg_dark",
                theme = "sonokai",
                globalstatus = true,
                section_separators = {
                    left = "",
                    right = "",
                },
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {"filetype"},
                lualine_c = {},
                lualine_x = {"diagnostics"},
                lualine_y = {"position"},
                lualine_z = {"filename"},
            }
        })
    end
}
