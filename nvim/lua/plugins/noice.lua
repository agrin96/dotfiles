return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local noice = require("noice")
        noice.setup({
            presets = {
                bottom_search = true,
                command_palette = true,
				lsp_doc_border = true,
            }
        })
    end
}
