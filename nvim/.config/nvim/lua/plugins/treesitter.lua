return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		local treesitter = require("nvim-treesitter")
		-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
		treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
		treesitter.install({
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
			"http",
			"hlsplaylist",
			"regex",
			"nim",
			"markdown",
			"kotlin",
		})
	end,
}
