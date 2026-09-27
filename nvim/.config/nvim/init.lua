require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.lazy")

-- mason-lspconfig enables every server Mason installs. Enable the ones
-- installed outside Mason here.
vim.lsp.enable({ "nim_langserver" })
