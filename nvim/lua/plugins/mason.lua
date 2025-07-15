return {
	'mason-org/mason-lspconfig.nvim',
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {},
		},
        "neovim/nvim-lspconfig",
	},
	opts = {
		ensure_installed = {
			-- Python
			"basedpyright",
			-- Rest client
			"html",
			"ts_ls",
			"lua_ls",
			-- General
			"dockerls",
			-- JS ecosytem
			"svelte",
			"cssls",
			-- TOML
			-- Javacript
			-- JSON
			"jsonls",
			"nim_langserver",
			-- PHP
			"intelephense",
			"vimls",
			"yamlls",
			"bashls",
		}
	},
    keys = {
        {'grf', function () vim.lsp.buf.format() end, desc = 'format', mode = {'v'}}
    }
}
