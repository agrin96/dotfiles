-- Allows running rest like postman but in a special .http file. https://github.com/rest-nvim/rest.nvim?tab=readme-ov-file
--
-- [ Example ]:
-- Method Request-URI HTTP-Version
-- Header-field: Header-value
--
-- Request-Body
return {
	"rest-nvim/rest.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}
