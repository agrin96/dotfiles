-- Set up completion system. The bearbones setup includes only treesitter
-- based completions. But we can also further add LSP completions.
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Source for text in buffer
        "hrsh7th/cmp-buffer",
        -- Source of file system paths
        "hrsh7th/cmp-path",
        -- Adds pictograms to autocomplete suggestions
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            -- Order of these fields determines the priority with which
            -- the completion is searched.
            sources = cmp.config.sources({
                { name = "nvim_lsp" }, -- lsp provider
                { name = "buffer" }, -- text from current buffer
                { name = "path" }, -- filesystem paths
            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipses_char = "...",
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
        })
    end
}

