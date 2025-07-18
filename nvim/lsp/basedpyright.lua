local function set_python_path(path)
	local clients = vim.lsp.get_clients {
		bufnr = vim.api.nvim_get_current_buf(),
		name = 'basedpyright',
	}
	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
		else
			client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
		end
		client.notify('workspace/didChangeConfiguration', { settings = nil })
	end
end

return {
	cmd = { 'basedpyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_markers = {
		'pyproject.toml',
		'setup.py',
		'setup.cfg',
		'requirements.txt',
		'Pipfile',
		'pyrightconfig.json',
		'.git',
	},
	settings = {
		basedpyright = {
			typeCheckingMode = 'standard',
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'workspace',
				diagnosticSeverityOverrides = {
					reportUnusedCallResult = "none",
					reportExplicitAny = "none",
					reportImplicitOverride = "none",
				}
			},
		},
	},
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
			client:exec_cmd({
				command = 'basedpyright.organizeimports',
				arguments = { vim.uri_from_bufnr(bufnr) },
			})
		end, {
				desc = 'Organize Imports',
			})

		vim.api.nvim_buf_create_user_command(0, 'LspPyrightSetPythonPath', set_python_path, {
			desc = 'Reconfigure basedpyright with the provided python path',
			nargs = 1,
			complete = 'file',
		})
	end
}
