return {
	'Bekaboo/dropbar.nvim',
    enabled = false,
	config = function ()
		-- Not really interested in using this fo ranything other than seeing the breadcrumbs 
		local dropbar_api = require('dropbar.api')
		vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })

		-- These highlight groups if set by a colorscheme set the bacgkround on the dropbar
		vim.api.nvim_set_hl(0, 'Winbar', { fg = 'none', bg = 'none'})
		vim.api.nvim_set_hl(0, 'WinbarNC', { fg = 'none', bg = 'none'})
	end
}
