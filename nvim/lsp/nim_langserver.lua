return {
    cmd = { 'nimlangserver' },
    filetypes = { 'nim' },
    settings = {
        nim = {
            nimsuggestPath = "~/.nimble/bin/nimsuggest"
        }
    },
	root_markers = { '.git', '*.nimble' },
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	end
}
