return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			markdown = { "prettier" },
			toml = { "prettier" },
			-- python = {
			-- 	"ruff_format",
			-- 	"ruff_organize_imports",
			-- },
		},
		formatters = {
			prettier = {
				prepend_args = {
					"--single-quote",
					"--jsx-single-quote=true",
					-- "--tab-width=4",
				},
			},
			-- ruff_format = {
			--     append_args = {
			--         "--line-length", "88",
			--         "--config", "format.quote-style='single'",
			--     }
			-- }
		},
	},
}
