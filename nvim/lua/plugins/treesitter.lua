return {
    "nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "master",
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            ensure_installed = {
                "python",
                "json",
                "yaml",
                "toml",
                "javascript",
                "typescript",
                "tsx",
                "html",
                "css",
                "markdown",
                "svelte",
                "bash",
                "lua",
                "dockerfile",
                "sql",
                "vim",
                "gitignore",
                "hlsl",
				"http",
				"json",
            },
        })
    end

}
