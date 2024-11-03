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
vim.opt.wrap = true

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

-- Allow us to edit our wezterm config with events sent from nvim on
-- startup.
local autocmd = vim.api.nvim_create_autocmd
autocmd("VimEnter", {
  callback = function()
    --NVIM_ENTER=1
    vim.cmd([[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MQ==\007")]])
  end,
})

autocmd("VimLeavePre", {
  callback = function()
    --NVIM_ENTER=0
    vim.cmd([[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MA==\007")]])
  end,
})
