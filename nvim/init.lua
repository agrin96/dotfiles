require("config.options")
require("config.keymaps")
require("config.lazy")

-- Removes the background color for virtual line diagnostics
-- I think they are too noisy
vim.cmd('highlight! link DiagnosticVirtualLinesError VirtualLineError')
vim.cmd('highlight! link DiagnosticVirtualLinesWarn VirtualLineWarning')
vim.cmd('highlight! link DiagnosticVirtualLinesHint VirtualLineHint')
vim.cmd('highlight! link DiagnosticVirtualLinesInfo VirtualLineInfo')

-- Otherwise untracked files are barely visible
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", {
	fg = '#ececd5',
	bg = 'none',
})
-- Changes the directory pickers text color. 
vim.api.nvim_set_hl(0, "SnacksPickerDirectory", {
	fg = '#c6ccd7',
	bg = 'none',
})
-- Snacks highlight group overwrites. Removes the backgrounds as
-- they are distracting.
vim.api.nvim_set_hl(0, "DiagnosticWarn", {
	fg = '#E5C07B',
	bg = 'none',
	italic = true,
})
vim.api.nvim_set_hl(0, "DiagnosticError", {
	fg = '#e06c75',
	bg = 'none',
	italic = true,
})
vim.api.nvim_set_hl(0, "DiagnosticInfo", {
	fg = '#74ade9',
	bg = 'none',
	italic = true,
})
vim.api.nvim_set_hl(0, "DiagnosticHint", {
	fg = '#98c379',
	bg = 'none',
	italic = true,
})
-- Snacks indent highlight groups
vim.api.nvim_set_hl(0, "SnacksIndentScope", {
	fg = '#a8a8a8',
	bg = 'none',
})
vim.api.nvim_set_hl(0, "SnacksIndentChunk", {
	fg = '#a8a8a8',
	bg = 'none',
})

-- Handles highlights for inline diagnostics
vim.api.nvim_set_hl(0, 'VirtualLineError', {
	fg = '#e06c75',
	bg = 'none',
})
vim.api.nvim_set_hl(0, 'VirtualLineWarning', {
	fg = '#e5c07b',
	bg = 'none',
})
vim.api.nvim_set_hl(0, 'VirtualLineHint', {
	fg = '#98c379',
	bg = 'none',
})
vim.api.nvim_set_hl(0, 'VirtualLineInfo', {
	fg = '#74ade9',
	bg = 'none',
})

-- Inline error reporting is really annoying because it highlights the text
-- making the view overwhelming visually. Remove the background here.
local inlineWarn = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderlineWarn", link = true })
inlineWarn.bg = 'none'
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', inlineWarn)

local inlineError = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderlineError", link = true })
inlineError.bg = 'none'
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', inlineError)

local inlineHint = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderlineHint", link = true })
inlineHint.bg = 'none'
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', inlineHint)

local inlineInfo = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderInfo", link = true })
inlineInfo.bg = 'none'
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', inlineInfo)

-- Make the inline diagnostic the default one
vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- Modify blink hover highlight groups
vim.api.nvim_set_hl(0, 'NormalFloat', {
    fg = '#70708f',
    bg = '#21262c'
})
vim.api.nvim_set_hl(0, 'FloatBorder', {
    fg = '#70708f',
    bg = '#21262c'
})
vim.api.nvim_set_hl(0, 'Pmenu', {
    fg = '#70708f',
    bg = '#21262c',
})
vim.api.nvim_set_hl(0, 'PmenuSel', {
    fg = 'black',
    bg = '#c2c9ff'
})
vim.opt.winborder = 'solid'

-- Enable the language servers we are using. These should match what we
-- have in the lsp/ directory
vim.lsp.enable({
	"basedpyright",
	"lua_ls",
	"dockerls",
	"sqruff",
	"json-lsp",
    "nim_langserver",
})
