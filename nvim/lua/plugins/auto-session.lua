-- Session Management https://github.com/rmagatti/auto-session
-- Works simply enough
return {
	'rmagatti/auto-session',
	lazy = false,
	keys = {
		{ '<leader>wf', '<cmd>SessionSearch<CR>', desc = 'Session search' },
		{ '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
		{ '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
		{ '<leader>wd', '<cmd>SessionDelete<CR>', desc = 'Session Delete' },
	},
	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		root_dir = vim.fn.stdpath "state" .. "/sessions/",
		auto_restore = false,
	}
}
