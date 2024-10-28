vim.g.mapleader = " "

local keymap = vim.keymap
keymap.set("n", "<leader>nh", ":nohl<CR>:", { desc = "Clear search highlights" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<tab>", "<cmd>bnext<CR>", { desc = "Next buffer"})
keymap.set("n", "<s-tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer"})

