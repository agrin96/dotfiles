-- Package collection 
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Optimizes opening large files by selectivley disabling plugins.
		bigfile = {
			enabled = true,
			size = 10 * 1024 * 1024, -- 15 MB
		},
		-- Image viewer for pickers
		image = { enabled = true },
		statuscolumn = {
			enabled = true,
		},
		-- Highlights LSP references and allows jumping between them
		words = {
			enabled = true,
		},
		explorer = {
			enabled = true,
			replace_netrw = true,
			follow_file = true,
		},
		-- Allows LSP file renaming and auto integrates with the explorer picker
		rename = { enabled = true },
		-- Indent Guides. Combo of snope-indent and mini.indentscope
		indent = {
			indent = {
				enabled = true,
				char = '┊',
				hl = 'SnacksIndent',
			},
			animate = {
				enabled = true,
				style = 'out',
				easing = 'linear',
				duration = {
					step = 20,
					total = 1000,
				}
			},
			scope = {
				enabled = true,
				priority = 200,
				char = '╎',
				hl = 'SnacksIndentScope'
			},
			chunk = {
				enabled = false,
				priority = 100,
				hl = 'SnacksIndentChunk',
			}

		},
		picker = {
			enabled = true,
			layout = {
				preset = 'ivy_split',
			},
			icons = {
				diagnostics = {
					Error = " ",
					Warn  = " ",
					Hint  = "󰌶 ",
					Info  = " ",
				},
				files = {
					enabled = true, -- show file icons
					dir = " ",
					dir_open = " ",
					file = " "
				},
				tree = {
					vertical = "│ ",
					middle   = "│ ",
					last     = "└╴",
				}
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
		{ "<leader>fx", function() Snacks.picker.diagnostics_buffer() end, desc = "Show buffer diagnostics" },
		{ "<leader>fe", function() Snacks.picker.explorer() end, desc = "Show file explorer" },
		{ "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
		-- Git based finds
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		-- LSP based finds
		{ "<leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP References" },
		{ "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
		-- Other
		{ "<leader>qu", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<leader>qq", function() Snacks.picker.qflist() end, desc = "Quick fix list" },
		{ "<leader>]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    	{ "<leader>[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
	}
}
