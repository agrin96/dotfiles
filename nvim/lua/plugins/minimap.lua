return {
	"Isrothy/neominimap.nvim",
	version = "v3.x.x",
	lazy = false,
	keys = {
		{ "<leader>sm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
		{ "<leader>sb", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for current buffer" },
	},
	init = function()
		-- The following options are recommended when layout == "float"
		-- vim.opt.wrap = false
		-- vim.opt.sidescrolloff = 36 -- Set a large value

		---@type Neominimap.UserConfig
		vim.g.neominimap = {
			-- We are only interested in displaying the minimap when wanted.
			auto_enable = false,
			git = {
				enabled = false,
			},
			mark = {
				enabled = true,
			}
		}
	end,
}
