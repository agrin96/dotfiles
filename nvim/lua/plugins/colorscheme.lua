-- Set additional colorschemes as lazy so we can use them on demand
-- but they are not loaded on startup. Load our default colorscheme on
-- startup.
return {
	{
		"lancewilhelm/horizon-extended.nvim",
		lazy = true,
		opts = {
			style = "beam"
		},
		config = function ()
			vim.api.nvim_create_autocmd('ColorScheme', {
				group = vim.api.nvim_create_augroup('custom_highlights_horizon', {}),
				pattern = 'horizon-extended',
				callback = function()
					vim.api.nvim_set_hl(0, '@lsp.type.variable', {
						fg = '#bfbdb8',
						italic = true,
					})
					vim.api.nvim_set_hl(0, 'normal', {
						fg = '#d3d5de',
						bg = '#1d1f27'
					})
				end
			})
		end
	},
	{
		"tiagovla/tokyodark.nvim",
		lazy = true,
		opts = {},
		config = function()
			local colors = require("tokyodark.palette")
			colors.bg0 = "#22252A"
		end
	},
	{
		"shawilly/ponokai",
		lazy = true,
		config = function()
			vim.g.ponokai_style = "default"
			vim.g.ponokai_enable_italic = true
			vim.g.ponokai_colors_override = {
				-- bg0 = {"#22252A", 235 },
				bg0 = {"#20201e", 235 },
			}
		end
	},
	{
		"lunacookies/vim-colors-xcode",
		lazy = true,
	},
	{
		"sainnhe/sonokai",
		priority = 1000,
		lazy = false,
		config = function()
			vim.g.sonokai_style = "default"
			vim.g.sonokai_enable_italic = 0
			vim.g.sonokai_diagnostic_text_highlight = 1
			vim.g.sonokai_diagnostic_line_highlight = 1
			vim.g.sonokai_colors_override = {
				-- bg0 = {"#1e2025", 235},
				-- bg0 = {"#1d1f25", 235},
				-- bg0 = {"#191b1f", 235},
				bg0 = {"#1c2025", 235},
				blue = { "#74ADE9", 110},
				green = { "#98c379", 107},
				yellow = { '#e5c07b', 179},
				purple = { '#b57edc' , 176},
				red = { '#e06c75', 203}
			}

			vim.api.nvim_create_autocmd('ColorScheme', {
				group = vim.api.nvim_create_augroup('custom_highlights_sonokai', {}),
				pattern = 'sonokai',
				callback = function()
					local config = vim.fn['sonokai#get_configuration']()
					local palette = vim.fn['sonokai#get_palette'](config.style, config.colors_override)
					local set_hl = vim.fn['sonokai#highlight']

					set_hl('Function', palette.purple, palette.none)
					set_hl('Number', palette.blue, palette.none)

					vim.cmd('highlight! link @lsp.type.function.python Purple')
					vim.cmd('highlight! link @lsp.type.method.python Purple')
					vim.cmd('highlight! link @lsp.type.method.python Purple')
					vim.cmd('highlight! link @string.python Green')
					vim.cmd('highlight! link @lsp.type.class.python Yellow')
					vim.cmd('highlight! link @lsp.type.decorator.python Purple')
					vim.api.nvim_set_hl(0, '@number.python', {
						fg = '#56b6c2',
						italic = true,
					})
					vim.api.nvim_set_hl(0, '@lsp.type.variable.python', {
						fg = '#c6c5b1',
						italic = true,
					})
				end
			})

			vim.cmd("colorscheme sonokai")
		end
	},
	{
		"sainnhe/edge",
		lazy = true,
		config = function()
			vim.g.edge_style = "default"
			vim.g.edge_dim_foreground = 0
			vim.g.edge_disable_italic_comment = 0
			vim.g.edge_enable_italic = 1
			vim.g.edge_float_style = "dim"
			vim.g.edge_colors_override = {
				bg0 = {"#212429", 234},
			}
		end
	},
	{
		'AlexvZyl/nordic.nvim',
		lazy = true,
		config = function()
			require('nordic').setup({
				on_palette = function(palette)
					palette.gray0 = '#1b1c20'
					palette.blue2 = '#7aaab8'
					-- palette.white0_reduce_blue = '#e4e7ed'
				end
			})
			require('nordic').load()
		end
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	{
		-- Includes 5 themes, material, material-deep-ocean, material-darker, material-palenight, material-lighter
		"marko-cerovac/material.nvim",
		lazy = true,
	},
	{
		-- Includes dracula and dracula-soft (which looks like ponokai)
		"Mofiqul/dracula.nvim",
		lazy = true,
	},
	{
		-- Includes vaporwave, onedark, onelight, onedark_vivid, onedark_dark
		"olimorris/onedarkpro.nvim",
		lazy = true,
	},
	{
		-- Includes vulgaris (default), multiplex, lighter
		"ribru17/bamboo.nvim",
		lazy = true,
	},
	{
		-- Includes onenord and light
		"rmehri01/onenord.nvim",
		lazy = true,
		config = function ()
			require("onenord").setup({
				custom_colors = {
					dark = {
						bg = "#212429",
					},
				},
			})
		end
	},
	{
		-- One dark theme only
		"dgox16/oldworld.nvim",
		lazy = true,
	},
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = true,
		config = function()
			require('kanagawa-paper').setup({
				color_offset = {
					ink = {
						brightness = 0.9,
						saturation = 0
					}
				}
			})
		end
	},
	{
		-- Includes oh-lucy, oh-lucy-evening, 
		"Yazeed1s/oh-lucy.nvim",
		lazy = true,
	},
	{
		-- Include light and dark sweetie
		"NTBBloodbath/sweetie.nvim",
		lazy = true,
	},
	{
		-- Includes mellow only
		"mellow-theme/mellow.nvim",
		lazy = true,
	},
	{
		-- Includes one_monokai only. Top contender
		"cpea2506/one_monokai.nvim",
		lazy = true,
		config = function()
			require('one_monokai').setup({
				colors = {
					bg = '#212429',
					aqua = '#5192c8'
				},
				highlights = function(colors)
					return {
						Keyword = { link = '@keyword.function'},
						['@lsp.type.namespace.python'] = { link = 'Type'}
					}
				end
			})
		end
	},
	{
		-- Incldues minimal and minimal-base16, not a bad choice but a bit too bright?
		"Yazeed1s/minimal.nvim",
		lazy = true,
		config = function ()
			vim.api.nvim_create_autocmd('ColorScheme', {
				group = vim.api.nvim_create_augroup('custom_highlights_minimal', {}),
				pattern = 'minimal',
				callback = function()
					vim.api.nvim_set_hl(0, 'normal', {
						fg = '#dfe0ea',
						bg = '#212429'
					})
				end
			})
		end
	},
	{
		"alexmozaidze/palenight.nvim",
		lazy = true,
		-- init = function()
		-- 	local groups = r:wequire "palenight/groups"
		-- 	groups["Normal"].bg = "#212429"
		-- end
	}
}

