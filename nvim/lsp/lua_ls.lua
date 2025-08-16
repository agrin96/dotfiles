return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc" },
    settings = {
        Lua = {
            hint = { enable = true },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
        },
    },
    on_init = function(client)
        local join = vim.fs.joinpath
        local path = client.workspace_folders[1].name

        -- Don't do anything if there is project local config
        if vim.uv.fs_stat(join(path, '.luarc.json'))
            or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
        then
            return
        end

        local nvim_settings = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    -- Make the server aware of Neovim runtime files
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath('config'),
                    '${3rd}/luv/library',
                },
            },
        }

        client.config.settings.Lua = vim.tbl_deep_extend(
            'force',
            client.config.settings.Lua,
            nvim_settings
        )
    end,
}
