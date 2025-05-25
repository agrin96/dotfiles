return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_config = require("mason-lspconfig")

        mason.setup({})
        mason_config.setup({
            ensure_installed = {
				-- Python
                "basedpyright",
				-- Rest client
                "html",
                "ts_ls",
                "lua_ls",
				-- General
				"dockerls",
				-- INSTALL MANUALLY BECAUSE IT IS NOT IN lspconfig 
				-- "sqruff",
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
            }
        })
    end
}
