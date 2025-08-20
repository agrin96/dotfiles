-- Makes a nice and pretty status line at the bottom of our window.
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local lualine = require("lualine")
        local text_color = '#dcdeef'
        local section_z_background = '#2c323a'

        lualine.setup({
            options = {
                theme = "onedark",
                globalstatus = true,
                section_separators = {
                    left = "█",
                    right = "█",
                },
                component_separators = {
                    left = "█",
                    right = "█",
                }
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {"searchcount"},
                lualine_c = {},
                lualine_x = {"diff","diagnostics"},
                lualine_y = {
                    { "location", color = { fg = text_color } }
                },
                lualine_z = {
                    { "lsp_status", color = { fg = text_color, bg = section_z_background} },
                    { "filetype", color = {fg = text_color, bg = section_z_background} },
                },
            }
        })
    end

}
