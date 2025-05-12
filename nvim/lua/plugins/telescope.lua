-- Note that for string searches to work you need to install ripgrep
-- maxos -> brew install ripgrep
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
		local theme_selection = "dropdown"
		telescope.setup({
			pickers = {
				find_files = {
					theme = theme_selection
				},
				registers = {
					theme = theme_selection
				},
				live_grep = {
					theme = theme_selection
				},
				grep_string = {
					theme = theme_selection
				},
				buffers = {
					theme = theme_selection
				}
			},
			extensions = {
				fzf = {}
			}
		})
        telescope.load_extension("fzf")
        -- Configure keymaps for telescope plugin. These are similar to our
        -- fzf modes setup in wezterm 
        local keymap = vim.keymap
        local builtin = require("telescope.builtin")

        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fr", builtin.registers, { desc = "Display content of registers" })
        keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "String search in cwd" })
        keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Search string under cursor" })
        keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search buffers" })
        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todo comments" })
    end,
}
