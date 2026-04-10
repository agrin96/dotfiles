return {
	'mason-org/mason-lspconfig.nvim',
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {},
		},
        "neovim/nvim-lspconfig",
	},
    lazy = false,
	opts = {
		ensure_installed = {
			-- Python
			"basedpyright",
            -- JS ecosytem
			"html",
			"ts_ls",
			"lua_ls",
            "svelte",
            "cssls",
			-- General
			"dockerls",
			-- TOML
			-- Javacript
			-- JSON
			"jsonls",
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
