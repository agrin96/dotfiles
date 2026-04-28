require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.lazy")

-- Enable the language servers we are using. These should match what we
-- have in the lsp/ directory
vim.lsp.enable({
	"basedpyright",
	"lua_ls",
	"dockerls",
	"sqruff",
	"json-lsp",
	"nim_langserver",
	"ts_ls",
	"html",
	"css",
	"kotlin_lsp",
})

