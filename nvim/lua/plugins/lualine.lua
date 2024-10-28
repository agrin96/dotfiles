-- Makes a nice and pretty status line at the bottom of our window.
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
                lualine_b = {},
                lualine_c = {
                    {
                        "buffers",
                        icons_enabled = false,
                        mode = 0,
                        symbols = {
                            modified = " 󰝶",
                            alternative_file = ""
                        }
                    }
                },
                lualine_x = {"diagnostics"},
                lualine_y = {"location"},
                lualine_z = {"filetype"},
            }
        })
    end
}
