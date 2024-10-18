-- Set additional colorschemes as lazy so we can use them on demand
-- but they are not loaded on startup. Load our default colorscheme on
-- startup.
return {
    {
        "lancewilhelm/horizon-extended.nvim",
        lazy = true,
        opts = {
            style = "beam"
        }
    },
    {
        "tiagovla/tokyodark.nvim",
        lazy = true,
        opts = {}
    },
    {
       "yorumicolors/yorumi.nvim",
        lazy = true,
        opts = {},
    },
    {
        "vague2k/vague.nvim",
        lazy = true,
        opts = {},
    },
    {
        "shawilly/ponokai",
        lazy = false,
        config = function()
            vim.g.sonokai_enable_italic = true
        end
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
    },
    {
        "lunacookies/vim-colors-xcode",
        lazy = true,
    },
    {
        "sainnhe/sonokai",
        priority = 1000,
        lazy = false,
        config = function()
            vim.g.sonokai_style = "default"
            vim.g.sonokai_enable_italic = true
            vim.g.sonokai_diagnostic_text_highlight = 1
            vim.g.sonokai_diagnostic_line_highlight = 1
            vim.g.sonokai_colors_override = {
                bg0 = {"#22252A", 235},
                blue = { "#74ADE9", 110},
                purple = { "#AD80D6" , 176}
            }
	        vim.cmd("colorscheme sonokai")
        end
    },
}

