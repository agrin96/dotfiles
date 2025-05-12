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
                "svelte",
                "basedpyright",
                "html",
                "cssls",
                "ts_ls",
                "lua_ls",
                "sqlls",
                -- TOML
                -- Javacript
                -- JSON
                "harper_ls",
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
