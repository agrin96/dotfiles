-- For Expo react native, allows us to discover native modules.
return {
	filetypes = { "kotlin" },
	cmd = { "kotlin-lsp", "--stdio" },
	root_markers = {},
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)

		-- Direct ancestor settings.gradle (normal Gradle projects)
		local found = vim.fs.find({
			"settings.gradle",
			"settings.gradle.kts",
		}, {
			path = fname,
			upward = true,
			type = "file",
		})[1]
		if found then
			return on_dir(vim.fs.dirname(found))
		end

		-- Expo: walk up looking for a dir that has android/settings.gradle
		local dir = vim.fs.dirname(fname)
		while dir and dir ~= "/" do
			local candidate = dir .. "/android/settings.gradle"
			if vim.uv.fs_stat(candidate) then
				return on_dir(dir .. "/android")
			end
			dir = vim.fs.dirname(dir)
		end
	end,
}
