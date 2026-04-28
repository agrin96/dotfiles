-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.txt", "*.md", "*.tex" },
	callback = function()
		vim.opt.spell = true
		vim.opt.spelllang = "en"
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Resize neovim split when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- Activate treesitter on all filetypes. Fail silently.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Override highlights on ColorScheme change
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- Otherwise untracked files are barely visible
		vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", {
			fg = "#ececd5",
			bg = "none",
		})
		-- Changes the directory pickers text color.
		vim.api.nvim_set_hl(0, "SnacksPickerDirectory", {
			fg = "#c6ccd7",
			bg = "none",
		})
		-- Snacks indent highlight groups
		vim.api.nvim_set_hl(0, "SnacksIndentScope", {
			fg = "#a8a8a8",
			bg = "none",
		})
		vim.api.nvim_set_hl(0, "SnacksIndentChunk", {
			fg = "#a8a8a8",
			bg = "none",
		})

		-- Diagnostic colors used across multiple highlight groups
		local diag_colors = {
			Error = "#e06c75",
			Warn = "#E5C07B",
			Hint = "#98c379",
			Info = "#74ade9",
		}

		for level, color in pairs(diag_colors) do
			local vl_name = "VirtualLine" .. (level == "Warn" and "Warning" or level)
			vim.api.nvim_set_hl(0, "Diagnostic" .. level, { fg = color, italic = true })
			vim.api.nvim_set_hl(0, vl_name, { fg = color, bg = nil })
			vim.api.nvim_set_hl(0, "DiagnosticVirtualLines" .. level, { link = vl_name })

			-- Inline error reporting is really annoying because it highlights the text
			-- making the view overwhelming visually. Remove the background here.
			local underline = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderline" .. level, link = true })
			underline.bg = nil
			vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. level, underline --[[@as vim.api.keyset.highlight]])
		end

		-- Modify blink hover highlight groups
		vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#70708f", bg = "#21262c" })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#70708f", bg = "#21262c" })
		vim.api.nvim_set_hl(0, "Pmenu", { fg = "#70708f", bg = "#21262c" })
		vim.api.nvim_set_hl(0, "PmenuSel", { fg = "black", bg = "#c2c9ff" })
	end,
})
