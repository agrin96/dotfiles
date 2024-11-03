return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        -- For installing linters and formatters as needed.
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_config = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

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
        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",
                "eslint_d",
            }
        })
    end
}
