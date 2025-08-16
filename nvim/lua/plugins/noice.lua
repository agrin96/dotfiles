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
                cmdline = { scrollbar = false },
                messages = { scrollbar = false },
                configm = { scrollbar = false },
                cmdline_output = { scrollbar = false },
                notify = { scrollbar = false, },
                split = { scrollbar = false, },
                vsplit = { scrollbar = false, },
                 mini = { scrollbar = false, },
                cmdline_popup = {
                    scrollbar = false,
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
                    scrollbar = false,
                    border = {
                        style = border_style ,
                    },
                },
                popup = {
                    scrollbar = false,
                    border = {
                        style = border_style ,
                    },
                },
                hover = {
                    scrollbar = false,
                    border = {
                        style = border_style,
                        padding = {0, 0},
                    },
                }
            }
        })
    end
}
