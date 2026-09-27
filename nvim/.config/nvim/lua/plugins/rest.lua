-- Allows running rest like postman but in a special .http file. https://github.com/rest-nvim/rest.nvim?tab=readme-ov-file
--
-- [ Example ]:
-- Method Request-URI HTTP-Version
-- Header-field: Header-value
--
-- Request-Body

-- NOTE: This configuration is a workaround because lazy can't install this properly.
-- https://github.com/rest-nvim/rest.nvim/issues/559
return {
	"rest-nvim/rest.nvim",
	ft = "http",
	build = false,
	dependencies = {
		"j-hui/fidget.nvim",
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		{
			-- Lazy.nvim does not recognize this library's rocksfile, so add it
			-- to package path manually.
			"manoelcampos/xml2lua",
			config = function(plugin)
				package.path = package.path .. ";" .. plugin.dir .. "/?.lua"
			end,
		},
		"lunarmodules/lua-mimetypes",
	},
	-- Only in .http buffers. <S-CR> needs the WezTerm Shift+Enter binding.
	keys = {
		{ "<CR>", "<cmd>Rest run<CR>", ft = "http", desc = "Run request under cursor" },
		{
			"<S-CR>",
			function()
				-- Plain `:Rest last` fails with "request failed": it waits on the request outside an async task.
				-- Do the same steps as `:Rest last` (check, clear, open the pane, keep focus here), then run it inside one.
				local request = require("rest-nvim.request")
				if not request.last_request() then
					vim.notify("No last request found", vim.log.levels.WARN, { title = "rest.nvim" })
					return
				end
				local result = require("rest-nvim.ui.result")
				result.clear()
				if not result.is_open() then
					vim.cmd.wincmd("v")
					result.enter(vim.api.nvim_get_current_win())
					vim.cmd.wincmd("p")
				end
				require("nio").run(request.run_last)
			end,
			ft = "http",
			desc = "Run last request",
		},
		{ "<leader>hr", "<cmd>Rest run<CR>", ft = "http", desc = "Run request under cursor" },
		{ "<leader>ho", "<cmd>Rest open<CR>", ft = "http", desc = "Open result pane" },
		{ "<leader>he", "<cmd>Rest env select<CR>", ft = "http", desc = "Select env file" },
		{ "<leader>hc", "<cmd>Rest curl yank<CR>", ft = "http", desc = "Copy request as curl" },
		{ "<leader>hL", "<cmd>Rest logs<CR>", ft = "http", desc = "Open logs" },
	},
}
