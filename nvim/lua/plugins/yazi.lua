return {
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			"folke/snacks.nvim"
		},
		keys = {
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			floating_window_scaling_factor = 0.9,
			yazi_floating_window_border = "none",
			open_for_directories = true,
			keymaps = {
				show_help = "<f1>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			-- vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{
		-- Allows adding starship prompt 
		"Rolv-Apneseth/starship.yazi",
		lazy = true,
		build = function(plugin)
			require("yazi.plugin").build_plugin(plugin)
		end,
	},
	{
		-- Color themes. You need to activate in .config/yazi/themes.toml for it to work
		"dangooddd/kanagawa.yazi",
		lazy = true,
		build = function(plugin)
			require("yazi.plugin").build_flavor(plugin)
		end,
	},
	{
		"yazi-rs/plugins",
		name = "yazi-additional-plugins",
		lazy = true,
		build = function(spec)
			require("yazi.plugin").build_plugin(spec, {
				sub_dir = "full-border.yazi"
			})
			require("yazi.plugin").build_plugin(spec, {
				sub_dir = "no-status.yazi"
			})
			require("yazi.plugin").build_plugin(spec, {
				sub_dir = "vcs-files.yazi"
			})
			require("yazi.plugin").build_plugin(spec, {
				sub_dir = "chmod.yazi"
			})
		end,
	},
}
