vim.cmd("let g:netrw_liststyle = 3")

vim.opt.relativenumber = true
-- Displays the current absolute line number
vim.opt.number = true

-- Tabs & indentation
local tab_width = 4
vim.opt.tabstop = tab_width
vim.opt.shiftwidth = tab_width

vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = false

-- search settings
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
vim.opt.clipboard:append("unnamedplus")

-- Split window settings
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Make it so that semantic highlighting has priority over treesitter
vim.highlight.priorities.semantic_tokens = 101

-- Basically this can't actually render python comments as markdown

-- Override the default vim function to set a filetype
-- local original = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--     local bufnr, winnr = original(contents, syntax, opts, ...)
--     vim.api.nvim_set_option_value("signcolumn", "no", { win = winnr })
--     vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
--     return bufnr, winnr
-- end
