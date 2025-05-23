-- Allows smart language aware splits and joins of code. Can do some crazy things
-- like changing if else to ternaries. Mostly useful for delimited formatting
-- Additional language rules can be configured, but I don't need it.
-- https://github.com/Wansmer/treesj
return {
	'Wansmer/treesj',
	keys = {
		{ '<space>m', desc = "Toggle split-join" },
		{ '<space>j', desc = "Activate Join" },
		{ '<space>s', desc = "Activate Split" }
	},
	dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
	config = function()
		require('treesj').setup({})
	end,
}
