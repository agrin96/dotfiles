require("config.options")
require("config.keymaps")
require("config.lazy")

vim.lsp.enable({
	"basedpyright",
	"lua_ls",
})
