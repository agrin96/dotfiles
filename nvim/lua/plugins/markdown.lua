return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        local render_markdown = require("render-markdown")
        -- Parse query outside of the function to avoid doing it for each call
        render_markdown.setup({
            file_types = { "markdown", "python" },
        })
    end,
}
