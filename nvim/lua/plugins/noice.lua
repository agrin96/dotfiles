return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local noice = require("noice")
        local border_style = 'double'
        noice.setup({
            presets = {
                bottom_search = true,
                command_palette = false,
				lsp_doc_border = false,
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = 5,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                    border = {
                        style = border_style ,
                    },
                },
                popupmenu = {
                    border = {
                        style = border_style ,
                    },
                },
                popup = {
                    border = {
                        style = border_style ,
                    },
                },
                hover = {
                    border = {
                        style = border_style,
                        padding = {0, 0},
                    },
                }
            }
        })
    end
}
