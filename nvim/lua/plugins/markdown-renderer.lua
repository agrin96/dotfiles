return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons',
	},
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
		code = {
			position = 'right',
			width = 'block',
			right_pad = 10,
		},
		file_types = {
			'markdown',
			'blink-cmp-documentation',
			'blink-cmp-signature',
		},
		completions = {
			lsp = {
				enabled = true,
			},
			blink = {
				enabled = true,
			}
		}
	},
}
