-- Displays navigation hints inline so I can learn nvim faster
return {
	'tris203/precognition.nvim',
	opts = {
		highlightColor = { link = "Comment" },
	},
	config = function()
		local package = require('precognition')
        local keymap = vim.keymap
        keymap.set("n", "<leader>hp", package.toggle, { desc = 'Toggle precognition display'})
	end
}
