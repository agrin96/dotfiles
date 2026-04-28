vim.g.mapleader = " " -- Set space as the leader key for custom mappings
vim.g.maplocalleader = " " -- Set space as the local leader key for buffer-local mappings

vim.g.loaded_netrw = 1 -- Disable netrw file explorer (using a different file explorer)
vim.g.loaded_netrwPlugin = 1 -- Disable netrw plugin component

-- Displays the current absolute line number
vim.opt.relativenumber = true
vim.opt.number = true
-- Wrapped lines preserve indentation
vim.opt.breakindent = true

-- Tabs & indentation
local tab_width = 4
vim.opt.tabstop = tab_width -- Size of a tab in spaces
vim.opt.shiftwidth = tab_width -- Spaces per indentation level
vim.opt.smartindent = true -- Syntax aware indentations for new lines
vim.opt.expandtab = true -- Whether to expand a tab to spaces

vim.opt.autoindent = true
vim.opt.wrap = false

-- Search settings
-- Ignore the case when search by default, but if you mix case in your search it will be sensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Turn on termguicolors for colorschems to work
-- For colorschemes that support light and dark we choose dark
-- and we show the sign column so text doesn't shift.
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Make backspace work like expected
vim.opt.backspace = "indent,eol,start"

-- Use the system clipboard when using copy/paste
-- Persist undo history to disk between sessions
-- Directory to store undo files
-- Automatically reload files changed outside of Neovim
vim.opt.clipboard:append("unnamedplus")
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.autoread = true

-- Split window settings
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.winborder = "double"
vim.opt.winborder = "solid"

-- Enable treesitter highlighting for files and treesitter based code folds.
-- The `pcall` is necessary to silently fail for unsupported buffers.
-- Starting foldlevel to 99 means essentially all code is unfolded at start.
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldlevel = 99
-- Use nvim-treesitter for indent control
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- Make it so that semantic highlighting has priority over treesitter
vim.highlight.priorities.semantic_tokens = 101

-- Create highlight groups and select appropriate icons for our diagnostics
local symbols = { Error = "", Info = "", Hint = "󰌶", Warn = "" }
for name, icon in pairs(symbols) do
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- Make the inline diagnostic the default one
vim.diagnostic.config({ virtual_lines = { current_line = true } })
