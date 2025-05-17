vim.g.mapleader = " "

local keymap = vim.keymap
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "U", "<C-R>", { desc = "Redo last change" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Allow easier navigation between windows.
keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Move to top window" })
keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Move to bottom window" })

keymap.set("n", "<tab>", "<cmd>bnext<CR>", { desc = "Next buffer"})
keymap.set("n", "<s-tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer"})

-- Delete without copying into register
keymap.set({'n', 'v'}, 'd', '"_d')

local virtual_lines_all = function()
	vim.diagnostic.config({virtual_lines = true })
end

local virtual_lines_current = function()
	vim.diagnostic.config({ virtual_lines = { current_line = true } })
end
local virtual_lines_off = function()
	vim.diagnostic.config({ virtual_lines = false })
end

keymap.set("n", "<leader>xa", virtual_lines_all, { desc = 'All diagnostics'})
keymap.set("n", "<leader>xc", virtual_lines_current, { desc = 'Only Current line diagnostics'})
keymap.set("n", "<leader>xx", virtual_lines_off, { desc = 'Disable diagnostics'})


