local keymap = vim.keymap
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "U", "<C-R>", { desc = "Redo last change" })
keymap.set({ "n", "v" }, "$", "$h")

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<s-tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Delete without copying into register
keymap.set({ "n", "v" }, "d", '"_d')

local virtual_lines_all = function()
	vim.diagnostic.config({ virtual_lines = true })
end

local virtual_lines_current = function()
	vim.diagnostic.config({ virtual_lines = { current_line = true } })
end
local virtual_lines_off = function()
	vim.diagnostic.config({ virtual_lines = false })
end
local open_float_diagnostic = function()
	vim.diagnostic.open_float({ border = "double", focusable = true })
end
keymap.set("n", "<leader>xa", virtual_lines_all, { desc = "All diagnostics" })
keymap.set("n", "<leader>xc", virtual_lines_current, { desc = "Only Current line diagnostics" })
keymap.set("n", "<leader>xx", virtual_lines_off, { desc = "Disable diagnostics" })
keymap.set("n", "<leader>xf", open_float_diagnostic, { desc = "Show float Diagnostics" })

-- Buffer format
local conform_formatting = function()
	require("conform").format({ lsp_format = "fallback" })
end
keymap.set({ "n", "x" }, "grf", conform_formatting, { desc = "Format buffer or selection" })
