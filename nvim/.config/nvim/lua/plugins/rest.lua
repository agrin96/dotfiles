-- Allows running rest like postman but in a special .http file. https://github.com/rest-nvim/rest.nvim?tab=readme-ov-file
--
-- [ Example ]:
-- Method Request-URI HTTP-Version
-- Header-field: Header-value
--
-- Request-Body

-- NOTE: This configuration is a workaround because lazy can't install this properly.
-- https://github.com/rest-nvim/rest.nvim/issues/559
return {
	"rest-nvim/rest.nvim",
	ft = "http",
	build = false,
	dependencies = {
		"j-hui/fidget.nvim",
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		{
			-- Lazy.nvim does not recognize this library's rocksfile, so add it
			-- to package path manually.
			"manoelcampos/xml2lua",
			config = function(plugin)
				package.path = package.path .. ";" .. plugin.dir .. "/?.lua"
			end,
		},
		"lunarmodules/lua-mimetypes",
	},
}
