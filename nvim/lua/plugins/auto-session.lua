-- Session Management https://github.com/rmagatti/auto-session
-- Works simply enough
return {
	'rmagatti/auto-session',
	lazy = false,
	keys = {
		{ '<leader>wf', '<cmd>AutoSession search<CR>', desc = 'Session search' },
		{ '<leader>ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
		{ '<leader>wa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
		{ '<leader>wd', '<cmd>AutoSession delete<CR>', desc = 'Session Delete' },
	},
	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		root_dir = vim.fn.stdpath "state" .. "/sessions/",
		auto_restore = false,
        session_lens = {
            picker = 'snacks',
            picker_opts = {
                preset = 'default'
            }
        },
	}
}
