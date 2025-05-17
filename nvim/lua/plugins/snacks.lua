-- keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
-- keymap.set("n", "<leader>fr", builtin.registers, { desc = "Display content of registers" })
-- keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "String search in cwd" })
-- keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Search string under cursor" })
-- keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search buffers" })
-- keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todo comments" })
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Optimizes opening large files by selectivley disabling plugins.
		bigfile = { enabled = true },
		-- Image viewer for pickers
		image = { enabled = true },
		-- Better input command handler
		picker = {
			enabled = true,
			layout = {
				preset = 'ivy_split',
			}
		},
		-- Creates nice notification toasts
		notifier = {
			enabled = true,
			style = 'compact',
			timeout = 3000,
		},
		-- Makes scrolling ultra smooth by debouncing
		scroll = { enabled = true },
		-- Plugin styling
		styles = {
			notification = {
				wo = {
					wrap = true
				}
			}
		}
	},
	keys = {
		-- Find more keymaps here https://github.com/folke/snacks.nvim/tree/main?tab=readme-ov-file
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Show buffers" },
		{ "<leader>fs", function() Snacks.picker.grep() end, desc = "Search string in workspace" },
		{ "<leader>fc", function() Snacks.picker.grep_word() end, desc = "Search selection or word", mode = { "n", "x" } },
		{ '<leader>fr', function() Snacks.picker.registers() end, desc = "Registers" },
		{ "<leader>fh", function() Snacks.picker.notifications() end, desc = "Notification history" },
		{ "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Show todo symbols" },
		{ "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, desc = "Show buffer diagnostics" },
		-- Git based finds
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		-- LSP based finds
		{ "<leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP References" },
		{ "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		-- Other
		{ "<leader>fu", function() Snacks.picker.undo() end, desc = "Undo History" },
	}
}
