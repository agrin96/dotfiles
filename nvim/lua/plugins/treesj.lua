-- Allows smart language aware splits and joins of code. Can do some crazy things
-- like changing if else to ternaries. Mostly useful for delimited formatting
-- Additional language rules can be configured, but I don't need it.
-- https://github.com/Wansmer/treesj
return {
	'Wansmer/treesj',
	keys = {
		{ 'gj', function ()	require('treesj').join() end, desc = "Activate Join" },
		{ 'gs', function ()	require('treesj').split() end, desc = "Activate Split" }
	},
	dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
	opts = {
		-- Generally this is wrong, but for working with json and stuff
		max_join_length = 1000,
	},
}
