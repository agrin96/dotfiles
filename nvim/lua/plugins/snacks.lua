-- Package collection 
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Optimizes opening large files by selectivley disabling plugins.
		bigfile = {
			enabled = true,
			size = 10 * 1024 * 1024, -- 10 MB
            line_length = 100000,
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
                preset = 'default',
			},
            layouts = {
                default = {
                    layout = {
                        box = "horizontal",
                        width = 0.8,
                        min_width = 120,
                        height = 0.8,
                        border = 'none',
                        {
                            box = "vertical",
                            border = "double",
                            title = "{title} {live} {flags}",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                        },
                        { win = "preview", title = "{preview}", border = "double", width = 0.60 },
                    }
                },
                left = {
                    layout = {
                        backdrop = false,
                        width = 45,
                        min_width = 40,
                        height = 0,
                        position = "left",
                        border = "none",
                        box = "vertical",
                        {
                            win = "input",
                            height = 1,
                            border = "double",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                        },
                        { win = "list", border = "none" },
                        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                    }
                },
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
                border = 'double',
				wo = {
					wrap = true
				}
			},
            notification_history = {
                border = 'double',
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
		{ "<leader>fn", function() Snacks.picker.notifications() end, desc = "Notification history" },
		{ "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Show todo symbols" },
		{ "<leader>fx", function() Snacks.picker.diagnostics_buffer() end, desc = "Show buffer diagnostics" },
		{ "<leader>fX", function() Snacks.picker.diagnostics() end, desc = "Show all diagnostics" },
		{ "<leader>fe", function() Snacks.picker.explorer() end, desc = "Show file explorer" },
		{ "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
		{ "<leader>fj", function() Snacks.picker.jumps() end, desc = "Jump List" },
		-- Git based finds
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		-- LSP based finds
		{ "grr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP References" },
		{ "grs", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
		-- Other
		{ "<leader>qu", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<leader>qq", function() Snacks.picker.qflist() end, desc = "Quick fix list" },
		{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    	{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
	}
}
