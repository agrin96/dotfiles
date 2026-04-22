require("config.options")
require("config.keymaps")
require("config.lazy")

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
	vim.api.nvim_set_hl(0, "VirtualLine" .. vl_name, { fg = color, bg = nil })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualLines" .. level, { link = vl_name })

	-- Inline error reporting is really annoying because it highlights the text
	-- making the view overwhelming visually. Remove the background here.
	local underline = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderline" .. level, link = true })
	underline.bg = nil
	vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. level, underline --[[@as vim.api.keyset.highlight]])
end

-- Make the inline diagnostic the default one
vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- Modify blink hover highlight groups
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#70708f", bg = "#21262c" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#70708f", bg = "#21262c" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#70708f", bg = "#21262c" })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = "black", bg = "#c2c9ff" })
vim.opt.winborder = "solid"

-- Enable treesitter highlighting for files and treesitter based code folds.
-- The `pcall` is necessary to silently fail for unsupported buffers.
-- Starting foldlevel to 99 means essentially all code is unfolded at start.
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldlevel = 99

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
        pcall(vim.treesitter.start)
	end,
})

-- Enable the language servers we are using. These should match what we
-- have in the lsp/ directory
vim.lsp.enable({
	"basedpyright",
	"lua_ls",
	"dockerls",
	"sqruff",
	"json-lsp",
	"nim_langserver",
	"ts_ls",
	"html",
	"css",
	"kotlin_lsp",
})

vim.lsp.config.kotlin_lsp = {
	filetypes = { "kotlin" },
	cmd = { "kotlin-lsp", "--stdio" },
	root_markers = {},
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)

		-- Direct ancestor settings.gradle (normal Gradle projects)
		local found = vim.fs.find({
			"settings.gradle",
			"settings.gradle.kts",
		}, {
			path = fname,
			upward = true,
			type = "file",
		})[1]
		if found then
			return on_dir(vim.fs.dirname(found))
		end

		-- Expo: walk up looking for a dir that has android/settings.gradle
		local dir = vim.fs.dirname(fname)
		while dir and dir ~= "/" do
			local candidate = dir .. "/android/settings.gradle"
			if vim.uv.fs_stat(candidate) then
				return on_dir(dir .. "/android")
			end
			dir = vim.fs.dirname(dir)
		end
	end,
}
